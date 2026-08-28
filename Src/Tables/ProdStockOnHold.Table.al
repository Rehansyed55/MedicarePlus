table 50014 "Prod.Stock On Hold"
{
    // DrillDownPageID = 50027;
    // LookupPageID = 50027;

    fields
    {
        field(1; "PL No."; Code[20])
        {
        }
        field(2; "Stock Code"; Code[20])
        {
        }
        field(3; "ECMA No."; Code[20])
        {
        }
        field(4; "Purchase Order No."; Code[20])
        {
        }
        field(5; "Supplier Name"; Text[100])
        {
        }
        field(6; "Warehouse Receipt Line No."; Integer)
        {
        }
        field(8; "Warehouse Receipt No."; Code[20])
        {
        }
        field(9; Status; Option)
        {
            OptionCaption = 'Stock on Hold,Release For Supplier Return,Release For Production';
            OptionMembers = "Stock on Hold","Release For Supplier Return","Release For Production";

            trigger OnValidate()
            begin
                //Commented Below code as Codeunit 8000 Nussiness Notification Management is Missing from 2013
                /*
                  IF Status =2 THEN
                    BEGIN
                        NewReleaseForProdFrom.SETTABLEVIEW(Rec);
                        NewReleaseForProdFrom.RUN;
                        //CreateProductionOrder(Rec);
                    END;
                  IF Status =1 THEN
                  BEGIN
                  NewReleaseForSupplierFrom.SETTABLEVIEW(Rec);
                  NewReleaseForSupplierFrom.RUN;
                  DefaultSetup.GET;
                  IF DefaultSetup."Stock On Hold BN" = TRUE THEN
                    BNManagement.SendStockOnHoldToBN(Rec);
                END;
                */

            end;
        }
        field(10; "Batch No."; Code[30])
        {
        }
        field(11; "Serial No."; Code[20])
        {
        }
        field(12; "Location Code"; Code[20])
        {
        }
        field(13; "Zone Code"; Code[20])
        {
        }
        field(14; "Bin Code"; Code[20])
        {
        }
        field(15; Quantity; Decimal)
        {
            CalcFormula = Sum("Warehouse Entry".Quantity WHERE("Location Code" = FIELD("Location Code"),
                                                                "Zone Code" = FIELD("Zone Code"),
                                                                "Bin Code" = FIELD("Bin Code"),
                                                                "Item No." = FIELD("Stock Code"),
                                                                "Lot No." = FIELD("Batch No.")));
            FieldClass = FlowField;
        }
        field(16; "Warehouse Entry No."; Integer)
        {
        }
        field(17; "Source Line No."; Integer)
        {
        }
        field(18; Reason; Text[250])
        {
        }
        field(19; "Reason 1"; Text[250])
        {
        }
        field(20; "BPR Version No"; Code[20])
        {
            TableRelation = "Variant Product license line"."BPR Version No." WHERE("PL No." = FIELD("PL No."),
                                                                                    "Stock Code" = FIELD("Stock Code"),
                                                                                    "ECMA No." = FIELD("ECMA No."));
        }
        field(21; "Posted Purchse Recipt No"; Code[20])
        {
        }
        field(22; Activity; Option)
        {
            OptionCaption = ' ,New App In Process,BPR Identification';
            OptionMembers = " ","New App In Process","BPR Identification";
        }
        field(23; Comment; Text[150])
        {
        }
        field(24; "Comment 1"; Text[150])
        {
        }
        field(25; "Production Order No."; Code[20])
        {
        }
        field(26; "Posting Date"; Date)
        {
        }
        field(27; "Expiration Date"; Date)
        {
        }
        field(28; "Prod Comment"; Text[150])
        {
        }
        field(29; "Prod Comment 1"; Text[150])
        {
        }
        field(30; "Rebox/Overlabel"; Option)
        {
            OptionCaption = ' ,Rebox,Overlabel';
            OptionMembers = " ",Rebox,Overlabel;
        }
    }

    keys
    {
        key(Key1; "PL No.", "Stock Code", "ECMA No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        // NewReleaseForSupplierFrom: Page 50029;
        // NewReleaseForProdFrom: Page 50030;
        DefaultSetup: Record 50012;

    procedure CreateProductionOrder(ProdStockHoldRec: Record 50014) TFlag: Boolean
    var
        Prodorder: Record 5405;
        Qty: Decimal;
    begin
        //Commented so as to Upgradation of Production Order Table is Pending
        /*
        IF ProdStockHoldRec."Production Order No." ='' THEN
        BEGIN
        Prodorder.SETRANGE(Prodorder.WMSReceiptNo,ProdStockHoldRec."Warehouse Receipt No.");
        Prodorder.SETRANGE(Prodorder."Source Type",Prodorder."Source Type"::Item);
        Prodorder.SETRANGE(Prodorder."Source No.",ProdStockHoldRec."Stock Code");
        Prodorder.SETRANGE(Prodorder."Lot No.",ProdStockHoldRec."Batch No.");
        Prodorder.SETRANGE(Prodorder."Purchase order",ProdStockHoldRec."Purchase Order No.");
        IF NOT Prodorder.FINDFIRST THEN
        BEGIN
              Prodorder.INIT;
              Prodorder.VALIDATE(Prodorder.Status,2);
              Prodorder.VALIDATE(Prodorder."No.",'');
              Prodorder.VALIDATE(Prodorder."Source Type",Prodorder."Source Type"::Item);
              Prodorder.VALIDATE(Prodorder."Source No.",ProdStockHoldRec."Stock Code");
              ProdStockHoldRec.CALCFIELDS(ProdStockHoldRec.Quantity);
              Qty:=ProdStockHoldRec.Quantity;
              Prodorder.VALIDATE(Prodorder.Quantity,Qty);
              Prodorder.VALIDATE(Prodorder."ECMA No.",ProdStockHoldRec."ECMA No.");
              Prodorder.VALIDATE(Prodorder.WMSReceiptNo,ProdStockHoldRec."Warehouse Receipt No.");
              Prodorder.VALIDATE(Prodorder."Location Code",ProdStockHoldRec."Location Code");
              Prodorder.VALIDATE(Prodorder."Lot No.",ProdStockHoldRec."Batch No.");
              Prodorder.VALIDATE(Prodorder."Purchase order",ProdStockHoldRec."Purchase Order No.");
              Prodorder.VALIDATE(Prodorder."Expriy Date",ProdStockHoldRec."Expiration Date");
              Prodorder.VALIDATE(Prodorder."Posted Warehouse Receipt No.",'');
              Prodorder.VALIDATE(Prodorder."Posted Receipt No.",ProdStockHoldRec."Posted Purchse Recipt No");
              Prodorder.VALIDATE(Prodorder."Rebox/Overlabel",ProdStockHoldRec."Rebox/Overlabel");
              Prodorder.INSERT(TRUE);
              MESSAGE('Firmed Planned Production Orders Created Successfully for item : ' + ProdStockHoldRec."Stock Code" );
              ProdStockHoldRec."Production Order No.":= Prodorder."No.";
              ProdStockHoldRec.MODIFY(TRUE);
              TFlag:=TRUE;
        END
        END ELSE
        BEGIN
            TFlag:=FALSE;
            ERROR('Order Already Created !');
        
        END;
        */

    end;
}

