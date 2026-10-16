tableextension 50011 "Purchase Lines Ext" extends "Purchase Line"
{
    fields
    {
        modify("No.")
        {
            trigger OnAfterValidate()
            var
            begin
                //after upgrade
                //Vendors price in blanket order

                IF "Document Type" = "Document Type"::"Blanket Order" THEN BEGIN
                    PurchasePriceNew.RESET;
                    PurchasePriceNew.SETRANGE(PurchasePriceNew."Item No.", "No.");
                    PurchasePriceNew.SETRANGE(PurchasePriceNew."Vendor No.", "Buy-from Vendor No.");
                    PurchasePriceNew.SETRANGE(PurchasePriceNew."Unit of Measure Code", "Unit of Measure Code");
                    // IF PurchasePriceNew.FINDFIRST THEN
                    IF PurchasePriceNew.FINDLAST THEN
                        "Direct Unit Cost" := PurchasePriceNew."Direct Unit Cost";
                END;

                //after upgrade
            end;
        }

        modify("Expected Receipt Date")
        {
            trigger OnAfterValidate()
            begin
                //Getting the Correct  Order date  from the header to the lines
                PurchHeaderRec.RESET;
                PurchHeaderRec.SETRANGE(PurchHeaderRec."No.", "Document No.");
                PurchHeaderRec.SETFILTER(PurchHeaderRec."Document Type", '%1|%2', PurchHeaderRec."Document Type"::Order,
                PurchHeaderRec."Document Type"::"Blanket Order");
                IF PurchHeaderRec.FINDFIRST THEN
                    "Order Date" := PurchHeaderRec."Order Date";
            end;
        }
        modify("Qty. to Receive")
        {
            trigger OnAfterValidate()
            var
                PDN: Decimal;
            begin
                //alok
                PDN := 0;
                Purchaseline.SETRANGE(Purchaseline."Document Type", Purchaseline."Document Type"::Order);
                Purchaseline.SETRANGE(Purchaseline."Blanket Order No.", "Document No.");
                Purchaseline.SETRANGE(Purchaseline."No.", "No.");
                Purchaseline.SETRANGE(Purchaseline."Blanket Order Line No.", "Line No.");
                IF Purchaseline.FINDFIRST THEN BEGIN
                    REPEAT
                        PDN := PDN + Purchaseline.Quantity;
                    UNTIL Purchaseline.NEXT = 0;
                END;
                "PDN Quantity" := PDN;
                //Alok for Qty on Blanket order
                IF "Document Type" = "Document Type"::"Blanket Order" THEN BEGIN
                    "Qty. on Blanket Order(Actual)" := Quantity - "PDN Quantity";

                    "Qty. on Blanket Order(Actual)" := "Qty. on Blanket Order(Actual)" * "Qty. per Unit of Measure";
                END;
            end;
        }

        field(50000; "PL No."; Code[20])
        {
            Description = 'Upgrade frm Nav5';
            TableRelation = "Product License"."PL No." WHERE("Stock Code" = FIELD("No."),
                                                              Blocked = CONST(false));

            trigger OnValidate()
            begin
                //alok for validate Forign name and ECMA no on change on PL no. - krupesh uncommented

                ProdVarLic_REc.SETRANGE(ProdVarLic_REc."PL No.", "PL No.");
                //ProdVarLic_REc.ASCENDING(TRUE);
                ProdVarLic_REc.SETRANGE(ProdVarLic_REc."Stock Code", "No.");
                //kd ProdVarLic_REc.SETRANGE(ProdVarLic_REc.Status,ProdVarLic_REc.Status::Certified);
                ProdVarLic_REc.SETFILTER(ProdVarLic_REc.Status, '%1|%2', ProdVarLic_REc.Status::Certified, ProdVarLic_REc.Status::New);
                IF ProdVarLic_REc.FINDLAST THEN BEGIN
                    "ECMA No." := ProdVarLic_REc."ECMA No.";
                END;


                IF Prodlicens.GET(ProdVarLic_REc."PL No.", "No.") THEN BEGIN
                    "Foreign Name" := Prodlicens."Foreign Name";
                    "Foreign Pack Size" := Prodlicens."Foreign Pack size";
                END;

                //alok finish - krupesh uncommented
            end;
        }
        field(50001; "ECMA No."; Code[100])
        {
            Description = 'Upgrade frm Nav5';
            TableRelation = "Variant Product license line"."ECMA No." WHERE("PL No." = FIELD("PL No."),
                                                                             "Stock Code" = FIELD("No."),
                                                                             Status = FILTER('Certified' | 'New'),
                                                                             Blocked = CONST(false));
        }
        field(50002; "Rebox/Overlabel"; Option)
        {
            Description = 'Upgrade frm Nav5';
            OptionCaption = ' ,Rebox,Overlabel';
            OptionMembers = " ",Rebox,Overlabel;
        }
        field(50003; "Foreign Name"; Code[50])
        {
            Description = 'Upgrade frm Nav5';
        }
        field(50004; "PDN Quantity"; Decimal)
        {
            Caption = 'PDN Qty.';
            DecimalPlaces = 0 : 0;
            Description = 'Upgrade frm Nav5';
            Editable = false;
        }
        field(50005; Status; Option)
        {
            Description = 'Upgrade frm Nav5';
            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment,Closed';
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment",Closed;
        }
        field(50006; "Foreign Pack Size"; Code[20])
        {
            Description = 'Upgrade frm Nav5';
        }
        field(50007; "Qty. on Blanket Order(Actual)"; Decimal)
        {
            Description = 'Upgrade frm Nav5';
        }
        field(50008; "Buy From Country Code"; Code[20])
        {
            CalcFormula = Lookup("Purchase Header"."Buy-from Country/Region Code" WHERE("Document Type" = FIELD("Document Type"),
                                                                                         "No." = FIELD("Document No."),
                                                                                         "Buy-from Vendor No." = FIELD("Buy-from Vendor No.")));
            Description = 'chem-222';
            FieldClass = FlowField;
        }
        field(50009; "Your Reference"; Text[35])
        {
            CalcFormula = Lookup("Purchase Header"."Your Reference" WHERE("Document Type" = FIELD("Document Type"),
                                                                           "No." = FIELD("Document No.")));
            Caption = 'Your Reference';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50012; "Original Ordered Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key50; "Document Type", "Buy-from Vendor No.")
        {
        }
        key(Key51; "Document Type", "Job No.", "Job Task No.", "Document No.")
        {
            SumIndexFields = "Outstanding Amt. Ex. VAT (LCY)", "A. Rcd. Not Inv. Ex. VAT (LCY)";
        }
        key(Key52; "Document Type", "Document No.", Type, "No.")
        {
        }
        key(Key53; "Expected Receipt Date", "Document No.")
        {
        }
        key(Key54; Type, "No.")
        {
            SumIndexFields = "Outstanding Quantity", Quantity;
        }
        key(Key55; Type, "No.", "Location Code")
        {
            SumIndexFields = "Outstanding Quantity";
        }
        // key(Key56; "No.", Type, "Document Type", Status)
        // {
        //     SumIndexFields = "Outstanding Qty. (Base)", "Qty. on Blanket Order(Actual)";
        // }
        // key(Key57; "Document Type", "No.", Type, Status, "Expected Receipt Date")
        // {
        //     SumIndexFields = "Qty. on Blanket Order(Actual)", "Outstanding Qty. (Base)";
        // }
    }

    var
        ProdVarLic_REc: Record 50010;
        Prodlicens: Record 50008;
        PurchLine: Record 39;
        PDN: Decimal;
        Liences: Record 50008;
        Vendor: Record 23;
        Purchaseline: Record 39;
        PurchasePriceNew: Record 7012;
        PurchHeaderRec: Record 38;
}
