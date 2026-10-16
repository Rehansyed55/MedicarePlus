tableextension 50037 "Purchase Price Ext" extends "Purchase Price"
{
    fields
    {
        modify("Item No.")
        {
            trigger OnAfterValidate()
            begin
                //after upgrade


                // IF Vend.GET("Vendor No.") THEN
                // "Currency Code" := Vend."Currency Code";
                // "Vendor Name" := Vend.Name;
                //alok for vendor information

                IF Vendor.GET("Vendor No.") THEN begin
                    Country := Vendor."Country/Region Code";
                    "Currency Code" := Vendor."Currency Code";
                    "Vendor Name" := Vendor.Name;
                end;
                //alok finish

                //alok for find product license
                IF "Vendor No." <> '' THEN BEGIN
                    IF Country <> '' THEN BEGIN
                        PL.RESET;
                        PL.SETRANGE(PL."Stock Code", "Item No.");
                        PL.SETRANGE(PL.Country, Country);
                        PL.SETRANGE(PL.Blocked, false);
                        IF PL.FINDFIRST THEN BEGIN
                            License := TRUE;
                            //"Purchase Price".MODIFY(TRUE);
                        END
                        ELSE BEGIN
                            License := FALSE;
                            //"Purchase Price".MODIFY(TRUE);
                        END;
                    END;
                END;
                //alok finish


                //alok for find out item Description
                IF Item.GET("Item No.") THEN
                    "Item Description" := Item.Description;
                "Unit of Measure Code" := Item."Base Unit of Measure";
                //alok finish
                //alok
                IF "Vendor No." <> '' THEN BEGIN
                    IF Country <> '' THEN BEGIN
                        PL.RESET;
                        PL.SETRANGE(PL."Stock Code", "Item No.");
                        PL.SETRANGE(PL.Country, Country);
                        PL.SETRANGE(PL.Blocked, false);
                        IF PL.FINDLAST THEN
                            "PL No." := PL."PL No.";
                        "Foreign Name" := PL."Foreign Name"
                    END;
                END;


                //alok for pL
                PL.RESET;
                IF "PL No." = '' THEN BEGIN
                    IF "Vendor No." <> '' THEN BEGIN
                        IF Country <> '' THEN BEGIN
                            PL.SETRANGE(PL."Stock Code", "Item No.");
                            PL.SETRANGE(PL.Blocked, false);
                            IF PL.FINDLAST THEN
                                "PL No." := PL."PL No.";
                            "Foreign Name" := PL."Foreign Name"
                        END;
                    END;
                END;
                //finish

                //after upgrade
            end;
        }

        modify("Vendor No.")
        {
            trigger OnAfterValidate()
            var
            begin
                //alok for vendor information
                IF Vendor.GET("Vendor No.") THEN
                    Country := Vendor."Country/Region Code";
                "Vendor Name" := Vendor.Name;
                //alok finish

                //alok for find product license
                IF "Vendor No." <> '' THEN BEGIN
                    IF Country <> '' THEN BEGIN
                        PL.RESET;
                        PL.SETRANGE(PL."Stock Code", "Item No.");
                        PL.SETRANGE(PL.Country, Country);
                        PL.SETRANGE(PL.Blocked, false);
                        IF PL.FINDFIRST THEN BEGIN
                            License := TRUE;
                            //"Purchase Price".MODIFY(TRUE);
                        END
                        ELSE BEGIN
                            License := FALSE;
                            //"Purchase Price".MODIFY(TRUE);
                        END;
                    END;
                END;
                //alok finish


                //alok for find out item Description
                IF Item.GET("Item No.") THEN
                    "Item Description" := Item.Description;
                "Unit of Measure Code" := Item."Base Unit of Measure";
                //alok finish
                //alok

                //VB++ on 150514
                IF ("Vendor No." <> '') AND ("Item No." <> '') THEN BEGIN
                    //VB-- on 150514
                    IF Country <> '' THEN BEGIN
                        PL.RESET;
                        PL.SETRANGE(PL."Stock Code", "Item No.");
                        PL.SETRANGE(PL.Country, Country);
                        PL.SETRANGE(PL.Blocked, false);
                        IF PL.FINDLAST THEN
                            "PL No." := PL."PL No.";
                        "Foreign Name" := PL."Foreign Name"
                    END;
                END;
                //FINISH

                //alok for pL
                PL.RESET;
                IF "PL No." = '' THEN BEGIN
                    //VB++ on 150514
                    IF ("Vendor No." <> '') AND ("Item No." <> '') THEN BEGIN
                        //VB-- on 150514
                        IF Country <> '' THEN BEGIN
                            PL.SETRANGE(PL."Stock Code", "Item No.");
                            PL.SETRANGE(PL.Blocked, false);
                            IF PL.FINDLAST THEN
                                "PL No." := PL."PL No.";
                            "Foreign Name" := PL."Foreign Name"
                        END;
                    END;
                END;
                //finish
            end;
        }

        modify("Direct Unit Cost")
        {
            trigger OnBeforeValidate()
            begin

                //alok for set unit price for item
                "Unit Price" := "Direct Unit Cost";
                //alok finish


                DirectUnitCostOnValidate();


                CRP := 0;
                "Percentage of Profit" := 0;
                Salesprice.RESET;
                Salesprice.SETCURRENTKEY(Salesprice."Item No.", Salesprice."Sales Type");
                Salesprice.SETRANGE(Salesprice."Item No.", "Item No.");
                Salesprice.SETRANGE(Salesprice."Sales Type", Salesprice."Sales Type"::"Customer Price Group");
                IF Salesprice.FINDFIRST THEN BEGIN
                    REPEAT
                        IF Salesprice."Sales Code" = 'A' THEN
                            CRP := Salesprice."Unit Price";

                    UNTIL Salesprice.NEXT = 0;
                END;

                IF "Currency Code" = 'EUR' THEN BEGIN
                    IF CRP <> 0 THEN
                        "Percentage of Profit" := ((CRP - ("Direct Unit Cost" / 1.06)) / CRP) * 100;
                END ELSE
                    IF "Currency Code" = 'PLN' THEN BEGIN
                        IF CRP <> 0 THEN
                            "Percentage of Profit" := ((CRP - ("Direct Unit Cost" / 4.3)) / CRP) * 100;
                    END;
            end;
        }

        field(50000; "Vendor Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Description = 'Upgrade frm Nav5';
        }
        field(50001; Country; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'Upgrade frm Nav5';
            TableRelation = "Country/Region".Code;
        }
        field(50002; License; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Upgrade frm Nav5';
        }
        field(50003; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Upgrade frm Nav5';
        }
        field(50004; LatestDate; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'Upgrade frm Nav5';
        }
        field(50005; "Ordered Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Upgrade frm Nav5';
            Editable = false;
        }
        field(50006; Isprint; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Upgrade frm Nav5';
        }
        field(50007; "Unit Price"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Upgrade frm Nav5';
        }
        field(50008; "Item Description"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'Upgrade frm Nav5';
        }
        field(50009; "Total purchase qty"; Decimal)
        {
            CalcFormula = Sum("Value Entry"."Valued Quantity" WHERE("Item No." = FIELD("Item No."),
                                                                     "Source No." = FIELD("Vendor No."),
                                                                     "Item Ledger Entry Type" = CONST("Item Ledger Entry Type"::Purchase),
                                                                     "Document Type" = CONST("Item Ledger Document Type"::"Purchase Invoice")));
            Description = 'Upgrade frm Nav5';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50010; "Total Purchase Amount"; Decimal)
        {
            CalcFormula = Sum("Value Entry"."Cost Amount (Actual)" WHERE("Item No." = FIELD("Item No."),
                                                                          "Source No." = FIELD("Vendor No."),
                                                                          "Item Ledger Entry Type" = CONST("Item Ledger Entry Type"::Purchase),
                                                                          "Document Type" = CONST("Item Ledger Document Type"::"Purchase Invoice")));
            Description = 'Upgrade frm Nav5';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50011; "PL No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Upgrade frm Nav5';
            TableRelation = "Product License"."PL No." WHERE("Stock Code" = FIELD("Item No."),
                                                              Blocked = CONST(False));

            trigger OnValidate()
            begin
                PL.RESET;
                PL.SETRANGE(PL."PL No.", "PL No.");
                PL.SETRANGE(PL."Stock Code", "Item No.");
                IF PL.FINDFIRST THEN BEGIN
                    Status := PL.Status;
                    "Foreign Name" := PL."Foreign Name";
                    //"Foreign Pack Size1":=PL."Foreign Pack size";
                END;
                IF "Vendor No." <> '' THEN BEGIN

                    PL.RESET;
                    PL.SETRANGE(PL."Stock Code", "Item No.");
                    PL.SETRANGE(PL."PL No.", "PL No.");
                    //PL.SETRANGE(PL.Country,Country);
                    //PL.SETRANGE(PL.Blocked,false);


                    //alok for validate Forign name and ECMA no on change on PL no.
                    ProdVarLic_REc.SETRANGE(ProdVarLic_REc."PL No.", "PL No.");
                    //ProdVarLic_REc.ASCENDING(TRUE);
                    ProdVarLic_REc.SETRANGE(ProdVarLic_REc."Stock Code", "Item No.");
                    ProdVarLic_REc.SETRANGE(ProdVarLic_REc.Status, ProdVarLic_REc.Status::Certified);
                    IF ProdVarLic_REc.FINDLAST THEN BEGIN
                        //"ECMA No.":=ProdVarLic_REc."ECMA No.";//Blocked by anikEt
                    END;
                    IF Prodlicens.GET(ProdVarLic_REc."PL No.", "Item No.") THEN BEGIN
                        "Foreign Name" := Prodlicens."Foreign Name";
                        "Foreign Pack Size1" := Prodlicens."Foreign Pack size";
                    END;

                    //alok finish


                    IF PL.FINDFIRST THEN
                        IF PL."Company Name" <> 'Chemilines Limited' THEN
                            TPL := TRUE
                        ELSE
                            TPL := FALSE;

                END;
            end;
        }
        field(50012; "Foreign Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Description = 'Upgrade frm Nav5';
        }
        field(50013; Status; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'Upgrade frm Nav5';
            OptionCaption = ' ,Active,Inactive';
            OptionMembers = " ",Active,Inactive;
        }
        field(50014; "Foreign Pack Size"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Upgrade frm Nav5';
        }
        field(50015; "Percentage of Profit"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Upgrade frm Nav5';
        }
        field(50016; TPL; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Upgrade frm Nav5';
        }
        field(50017; European; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Upgrade frm Nav5';
        }
        field(50018; "Foreign Pack Size1"; Code[20])
        {
            CalcFormula = Lookup("Product License"."Foreign Pack size" WHERE("PL No." = FIELD("PL No."),
                                                                              "Stock Code" = FIELD("Item No.")));
            Description = 'Upgrade frm Nav5';
            FieldClass = FlowField;
        }
        field(50019; Comments; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'Upgrade frm Nav5';
        }
        field(50020; "Item Description2"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'Upgrade frm Nav5';
        }
        field(50021; "ECMA No."; Code[100])
        {
            DataClassification = ToBeClassified;
            Description = 'Upgrade frm Nav5';
            TableRelation = "Variant Product license line"."ECMA No." WHERE("PL No." = FIELD("PL No."),
                                                                             "Stock Code" = FIELD("Item No."),
                                                                             Status = FILTER('Certified' | 'New'),
                                                                             Blocked = CONST(false));
        }
        field(50022; "Paid Price"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'chem-222';
            Editable = false;
        }
        field(50023; "Requested Price"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'chem-222';
        }
        field(50024; "Direct Unit Cost in Packs"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'CAS-04066-J1Y1Q2';
        }

    }
    keys
    {
        key(Key3; "Ending Date")
        {
        }
        key(Key4; "Item No.", "Vendor No.", "Ending Date")
        {
        }
        key(Key5; "Unit Price")
        {
        }
        // key(Key6;"Item No.","Starting Date","Unit Price")
        // {
        // }
        // key(Key7;"Item No.","Vendor No.","Starting Date","Unit Price")
        // {
        // }
        key(Key8; "Direct Unit Cost")
        {
        }
        // key(Key9;"Item No.","Vendor No.",Country,"Currency Code",Status,"Starting Date")
        // {
        // }
        key(Key10; "Starting Date")
        {
        }
        key(Key11; "Direct Unit Cost in Packs")
        {
        }
    }
    var
        PL: Record 50008;
        PurchasePrice1: Record 7012;
        Item: Record 27;
        VendorName: Text[50];
        CRP: Decimal;
        Salesprice: Record 7002;
        ProdVarLic_REc: Record 50010;
        Prodlicens: Record 50008;
        recIUOM: Record 5404;
        Vendor: Record 23;

    procedure DirectUnitCostOnValidate()
    begin
        // CAS-04066-J1Y1Q2
        recIUOM.RESET;
        recIUOM.SETRANGE(recIUOM."Item No.", "Item No.");
        recIUOM.SETRANGE(recIUOM.Code, "Unit of Measure Code");
        IF recIUOM.FINDFIRST THEN BEGIN
            IF recIUOM."Qty. per Unit of Measure" <> 0 THEN
                "Direct Unit Cost in Packs" := "Direct Unit Cost" / recIUOM."Qty. per Unit of Measure"
            ELSE
                "Direct Unit Cost in Packs" := "Direct Unit Cost";
        END;
        // CAS-04066-J1Y1Q2
    end;
}
