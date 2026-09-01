tableextension 50033 "Warehouse Activity Line Ext" extends "Warehouse Activity Line"
{
    fields
    {
        field(50000; Barcode; Code[50])
        {
            Description = 'Upgrade frm Nav5/ADCS';

            trigger OnValidate()
            begin

                Compname := COMPANYNAME;
                Defaultsetup.GET();
                IF Compname = Defaultsetup."Company name" THEN BEGIN

                    IF "Activity Type" = "Activity Type"::"Put-away" THEN BEGIN
                        IF "Bin Code" = '' THEN BEGIN
                            "Bin Code" := Barcode;
                        END;

                        // barcode is Job No.
                        IF "Bin Code" <> Barcode THEN BEGIN
                            Barcode := '';
                        END;
                    END;



                    //alok start code when barcode is location or bin
                    IF "Activity Type" = "Activity Type"::"Invt. Pick" THEN BEGIN
                        IF "Bin Code" <> Barcode THEN BEGIN
                            Barcode := '';
                        END;
                    END;




                    //alok finish
                END;
            end;
        }
        field(50001; "ECMA No."; Code[100])
        {
            Description = 'Upgrade frm Nav5';
        }
        field(50002; "Stock On Hold"; Boolean)
        {
            Description = 'Upgrade frm Nav5';
        }
        field(50003; "Process Status"; Boolean)
        {
            Description = 'Upgrade frm Nav5';
            trigger OnValidate()
            var
                WarehouseActivityHeader: Record "Warehouse Activity Header";
            begin
                if "Process Status" then
                    "Picked By User" := UserId
                else
                    "Picked By User" := '';

                if WarehouseActivityHeader.Get("Activity Type", "No.") then begin
                    WarehouseActivityHeader."Process Status" := "Process Status";
                    WarehouseActivityHeader."Picked By User" := "Picked By User";
                    WarehouseActivityHeader.Modify();
                end;
            end;
        }
        field(50005; "Put away Ceated From"; Option)
        {
            Description = 'Upgrade frm Nav5';
            OptionCaption = ',For Component,From FIrm Plan,From Prod. jnl,From Release';
            OptionMembers = ,"For Component","From FIrm Plan","From Prod. jnl","From Release","From Goods IN";
        }
        field(50006; "Scan Time"; Time)
        {
            Description = 'Upgrade frm Nav5';
        }
        field(50007; "Barcode 1"; Code[20])
        {
            Description = 'Upgrade frm Nav5/ADCS';

            trigger OnValidate()
            var
                Position: Integer;
                Barlen: Integer;
                Batch: Code[20];
                Itemcategorey: Record 5722;
                i: Integer;
            begin

                Compname := COMPANYNAME;
                Defaultsetup.GET();
                Batch := '';
                IF NOT (STRPOS("Barcode 1", '/O') = 0) THEN
                    i := STRPOS("Barcode 1", '/O');
                IF i <> 0 THEN
                    "Barcode 1" := DELSTR("Barcode 1", i + 1, 1);

                IF Compname = Defaultsetup."Company name" THEN BEGIN
                    IF "Activity Type" = "Activity Type"::"Put-away" THEN BEGIN
                        IF STRPOS("Lot No.", '-P') <> 0 THEN BEGIN
                            Barlen := STRLEN("Lot No.");
                            Batch := COPYSTR("Lot No.", 1, (Barlen - 2));
                        END ELSE
                            Batch := "Lot No.";
                        IF Item.GET("Item No.") THEN;
                        IF Itemcategorey.GET(Item."Item Category Code") THEN;

                        IF Itemcategorey."Barcode Type" = Itemcategorey."Barcode Type"::"Batch No." THEN BEGIN
                            IF Batch <> "Barcode 1" THEN BEGIN
                                "Barcode 1" := '';
                            END;
                        END ELSE IF Itemcategorey."Barcode Type" = Itemcategorey."Barcode Type"::"Item Code" THEN BEGIN
                            IF Item.Barcode = '' THEN BEGIN
                                Item.Barcode := "Barcode 1";
                                Item.MODIFY(TRUE);
                            END;
                            IF Item.Barcode <> "Barcode 1" THEN BEGIN
                                "Barcode 1" := '';
                            END;
                        END;

                    END;

                    IF "Activity Type" = "Activity Type"::"Put-away" THEN BEGIN
                        IF (Barcode <> '') AND ("Barcode 1" <> '') THEN BEGIN
                            "Process Status" := TRUE;
                            "Scan Time" := TIME;
                        END;
                    END;
                    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    IF "Activity Type" = "Activity Type"::"Invt. Pick" THEN BEGIN
                        IF Item.GET("Item No.") THEN BEGIN
                            IF Itemcategorey.GET(Item."Item Category Code") THEN BEGIN
                                IF Itemcategorey."Barcode Type" = Itemcategorey."Barcode Type"::"Batch No." THEN BEGIN
                                    IF STRPOS("Lot No.", '-P') <> 0 THEN BEGIN
                                        Barlen := STRLEN("Lot No.");
                                        Batch := COPYSTR("Lot No.", 1, (Barlen - 2));
                                    END ELSE
                                        Batch := "Lot No.";
                                    IF Batch <> "Barcode 1" THEN BEGIN
                                        "Barcode 1" := '';
                                    END;
                                END ELSE IF Itemcategorey."Barcode Type" = Itemcategorey."Barcode Type"::"Item Code" THEN BEGIN
                                    IF Item.Barcode = '' THEN BEGIN
                                        Item.Barcode := "Barcode 1";
                                        Item.MODIFY(TRUE);
                                    END;

                                    IF Item.Barcode <> "Barcode 1" THEN BEGIN
                                        "Barcode 1" := '';
                                    END;
                                END;
                            END;
                        END;
                    END;
                    IF "Activity Type" = "Activity Type"::"Invt. Pick" THEN BEGIN
                        IF (Barcode <> '') AND ("Barcode 1" <> '') THEN BEGIN
                            "Process Status" := TRUE;
                            "Scan Time" := TIME;
                            AutofillQtyToHandle_ADCS(Rec);
                        END;
                    END;



                END;
            end;
        }
        field(50008; Checked; Boolean)
        {
            Description = 'Upgrade frm Nav5';

            trigger OnValidate()
            var
                WarehouseActivityHeader: Record "Warehouse Activity Header";
            begin
                "Activity header".RESET;
                "Activity header".SETRANGE("Activity header".Type, "Activity Type");
                "Activity header".SETRANGE("Activity header"."No.", "No.");
                IF "Activity header".FINDFIRST THEN BEGIN
                    "Activity header"."Checking Status" := "Activity header"."Checking Status"::"In Process";
                    "Activity header".MODIFY(TRUE);
                END;

                IF xRec.Checked = TRUE THEN BEGIN
                    Checked := TRUE;
                    "Activity header".RESET;
                    "Activity header".SETRANGE("Activity header".Type, "Activity Type");
                    "Activity header".SETRANGE("Activity header"."No.", "No.");
                    IF "Activity header".FINDFIRST THEN BEGIN
                        "Activity header"."Checking Status" := "Activity header"."Checking Status"::"In Process";
                        "Activity header".MODIFY(TRUE);
                    END;
                END;
                IF "Checked By" = '' THEN
                    VALIDATE("Checked By", USERID);

                // User must pick the item before checking it
                if "Checked" and not "Process Status" then
                    Error('You cannot check this item before picking it. Please select Process Status first.');

                // The user who picked the item cannot check it
                if "Checked" and ("Picked By User" = UserId) then
                    Error('You cannot check items that you have picked. Please use a different user ID.');

                // Set Checked By user
                if "Checked" then
                    "Checked By" := UserId
                else
                    "Checked By" := '';

                if WarehouseActivityHeader.Get("Activity Type", "No.") then begin
                    WarehouseActivityHeader."Checked By" := rec.Checked;
                    WarehouseActivityHeader."Checked By User" := Rec."Checked By";

                    WarehouseActivityHeader.Modify();
                end;
            end;
        }
        field(50009; "Checked By"; Code[50])
        {
            Description = 'Upgrade frm Nav5';
            Editable = false;
        }
        field(50010; "Box Number"; Code[20])
        {
            Description = 'Upgrade frm Nav5';
        }
        field(50011; "No. of Box"; Decimal)
        {
            Description = 'Upgrade frm Nav5';
        }
        field(50012; "Pallet Number"; Integer)
        {
            Description = 'Upgrade frm Nav5';
        }
        field(50013; "Total Unit/Box"; Decimal)
        {
            Description = 'Upgrade frm Nav5';
        }
        field(50014; "Units Sub Total"; Decimal)
        {
            Description = 'Upgrade frm Nav5';
        }
        field(50015; "Gross Weight"; Decimal)
        {
            Description = 'Upgrade frm Nav5';
        }
        field(50016; "Consolidated Quantity"; Decimal)
        {
            CalcFormula = Sum("Warehouse Activity Line"."Qty. to Handle" WHERE("Activity Type" = FIELD("Activity Type"),
                                                                                "No." = FIELD("No."),
                                                                                "Item No." = FIELD("Item No.")));
            DecimalPlaces = 0 : 2;
            Description = 'CHEM-128';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50106; "Picked By User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
    }
    procedure SetHideValidationDialog(NewHideValidationDialog: Boolean)
    begin
        HideValidationDialog := NewHideValidationDialog;
    end;

    procedure AutofillQtyToHandle_ADCS(var WhseActivLine: Record 5767)
    var
        NotEnough: Boolean;
    begin
        WITH WhseActivLine DO BEGIN
            NotEnough := FALSE;
            SetHideValidationDialog(TRUE);
            //IF FIND('-') THEN BEGIN
            //REPEAT
            VALIDATE("Qty. to Handle", "Qty. Outstanding");
            MODIFY;
            IF NOT NotEnough THEN
                IF "Qty. to Handle" < "Qty. Outstanding" THEN
                    NotEnough := TRUE;
            //UNTIL NEXT = 0;
            //END;
            SetHideValidationDialog(FALSE);
            IF NotEnough THEN
                MESSAGE(Text008);
        END;
    end;

    var
        HideValidationDialog: Boolean;
        Activity_rec: Record 5767;
        "Activity header": Record 5766;
        Activity_rec1: Record 5767;
        Compname: Text[250];
        Defaultsetup: Record 50012;
        Productionorder: Record 5405;
        Item: Record 27;
        Text008: Label 'Quantity available to pick is not enough to fill in all the lines.';

}
