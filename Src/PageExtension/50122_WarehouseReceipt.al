pageextension 50122 "Whse. Receipt Ext" extends "Warehouse Receipt"
{
    layout
    {
        addafter("Bin Code")
        {
            field("Gate Entry No."; Rec."Gate Entry No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Posted Inward Gate Entry this receipt relates to.';
                trigger OnValidate()
                var
                    myInt: Integer;
                begin

                    "Posted Gate Entry Line".RESET;
                    "Posted Gate Entry Line".SETRANGE("Posted Gate Entry Line"."Gate Entry No.", rec."Gate Entry No.");
                    IF "Posted Gate Entry Line".FINDFIRST THEN BEGIN
                        REPEAT
                            WhseRqst.RESET;
                            WhseRqst.FILTERGROUP(2);
                            WhseRqst.SETRANGE(Type, WhseRqst.Type::Inbound);
                            WhseRqst.SETRANGE("Location Code", rec."Location Code");
                            WhseRqst.FILTERGROUP(0);
                            whseRqst.SetRange("Document Status", WhseRqst."Document Status"::Released);
                            //WhseRqst.SETRANGE("Completely Handled", FALSE);
                            WhseRqst.SETRANGE(WhseRqst."Source No.", "Posted Gate Entry Line"."Doc. Source No.");
                            IF WhseRqst.FINDFIRST THEN BEGIN
                                GetSourceDocuments.SetOneCreatedReceiptHeader(Rec);
                                GetSourceDocuments.USEREQUESTPAGE(FALSE);
                                GetSourceDocuments.SETTABLEVIEW(WhseRqst);
                                GetSourceDocuments.RUNMODAL;
                                CLEAR(GetSourceDocuments);
                            END ELSE
                                MESSAGE('No open Warehouse Request found for Location %1 / Source No. %2 (Gate Entry line %3). Check that the linked document is Released and not fully received/shipped yet.',
                                    rec."Location Code", "Posted Gate Entry Line"."Doc. Source No.", "Posted Gate Entry Line"."Line No.");
                        UNTIL "Posted Gate Entry Line".NEXT = 0;
                    END;
                    Rec."Document Status" := rec.GetHeaderStatus(0);
                    rec.MODIFY;
                    "Warehouse Receipt Line".RESET;
                    "Warehouse Receipt Line".SETRANGE("Warehouse Receipt Line"."No.", rec."No.");
                    IF "Warehouse Receipt Line".FINDFIRST THEN BEGIN
                        REPEAT
                            "Warehouse Receipt Line".VALIDATE("Warehouse Receipt Line"."Qty. to Receive", 0);
                            "Warehouse Receipt Line".MODIFY(TRUE);
                        UNTIL "Warehouse Receipt Line".NEXT = 0;
                    END;
                END;

            }
            field("Select All"; Rec."Select All")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Fetches all inbound lines (Purchase Order / Sales Return Order / Transfer Receipt) from the linked Gate Entry.';
                trigger OnValidate()
                var
                    warehousereceiptline: Record "Warehouse Receipt Line";
                begin
                    warehousereceiptline.RESET; //chem-493
                    warehousereceiptline.SETRANGE(warehousereceiptline."No.", Rec."No."); //chem-493
                    IF warehousereceiptline.FIND('-') THEN //chem-493
                        REPEAT
                            warehousereceiptline."Create Production Order" := Rec."Select All";
                            warehousereceiptline.MODIFY;
                        UNTIL warehousereceiptline.NEXT = 0;
                end;

            }
            // field("Gate Entry No."; rec."Gate Entry No.")
            // {
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the Posted Inward Gate Entry this receipt relates to.';
            //     trigger OnValidate()
            //     var
            //         "Posted Gate Entry Line": Record "Gate Entry Line 1";
            //         WhseRqst: Record 5765;
            //         GetSourceDocuments: Report 5753;
            //         "Warehouse Receipt Line": Record 7317;
            //     begin
            //         //kd - while testing
            //         //Compname:=COMPANYNAME;
            //         //Defaultsetup.GET();
            //         //IF Defaultsetup."Company name"=Compname THEN BEGIN
            //         "Posted Gate Entry Line".RESET;
            //         "Posted Gate Entry Line".SETRANGE("Posted Gate Entry Line"."Gate Entry No.", rec."Gate Entry No.");
            //         IF "Posted Gate Entry Line".FINDFIRST THEN BEGIN
            //             REPEAT
            //                 WhseRqst.FILTERGROUP(2);
            //                 WhseRqst.SETRANGE(Type, WhseRqst.Type::Inbound);
            //                 WhseRqst.SETRANGE("Location Code", rec."Location Code");
            //                 WhseRqst.FILTERGROUP(0);
            //                 WhseRqst.SETRANGE("Document Status", WhseRqst."Document Status"::Released);
            //                 WhseRqst.SETRANGE("Completely Handled", FALSE);
            //                 WhseRqst.SETRANGE(WhseRqst."Source No.", "Posted Gate Entry Line"."Doc. Source No.");
            //                 IF WhseRqst.FINDFIRST THEN;
            //                 GetSourceDocuments.SetOneCreatedReceiptHeader(Rec);
            //                 WhseRqst.MARKEDONLY(TRUE);
            //                 IF NOT WhseRqst.FIND('-') THEN BEGIN
            //                     WhseRqst.MARKEDONLY(FALSE);
            //                     WhseRqst.SETRECFILTER;
            //                 END;
            //                 GetSourceDocuments.USEREQUESTPAGE(FALSE);
            //                 GetSourceDocuments.SETTABLEVIEW(WhseRqst);
            //                 GetSourceDocuments.RUNMODAL;
            //                 CLEAR(GetSourceDocuments);
            //             UNTIL "Posted Gate Entry Line".NEXT = 0;
            //         END;
            //         Rec."Document Status" := rec.GetHeaderStatus(0);
            //         rec.MODIFY;
            //         "Warehouse Receipt Line".RESET;
            //         "Warehouse Receipt Line".SETRANGE("Warehouse Receipt Line"."No.", rec."No.");
            //         IF "Warehouse Receipt Line".FINDFIRST THEN BEGIN
            //             REPEAT
            //                 "Warehouse Receipt Line".VALIDATE("Warehouse Receipt Line"."Qty. to Receive", 0);
            //                 "Warehouse Receipt Line".MODIFY(TRUE);
            //             UNTIL "Warehouse Receipt Line".NEXT = 0;
            //         END;
            //         //END;
            //         //kd - while testing
            //     end;
            // }
            // field("Select All"; rec."Select All")
            // {
            //     ApplicationArea = All;
            //     Visible = true;
            //     ToolTip = 'Fetches all inbound lines (Purchase Order / Sales Return Order / Transfer Receipt) from the linked Gate Entry.';
            //     trigger OnValidate()
            //     begin
            //         //"lineno." := 10000; //chem-493
            //         warehousereceiptline.RESET;  //chem-493
            //         warehousereceiptline.SETRANGE(warehousereceiptline."No.", rec."No.");//chem-493
            //         IF warehousereceiptline.FIND('-') THEN //chem-493
            //             REPEAT
            //                 //IF warehousereceiptline.GET("No.","lineno.") THEN  //chem-493
            //                 //BEGIN      //chem-493
            //                 IF (rec."Select All" = TRUE) AND (warehousereceiptline."Create Production Order" = FALSE) THEN BEGIN
            //                     warehousereceiptline."Create Production Order" := TRUE;
            //                     warehousereceiptline.MODIFY;
            //                 END
            //                 ELSE IF (rec."Select All" = TRUE) AND (warehousereceiptline."Create Production Order" = TRUE) THEN BEGIN
            //                     warehousereceiptline."Create Production Order" := TRUE;
            //                     warehousereceiptline.MODIFY;
            //                 END
            //                 ELSE IF (rec."Select All" = FALSE) AND (warehousereceiptline."Create Production Order" = TRUE) THEN BEGIN
            //                     warehousereceiptline."Create Production Order" := FALSE;//TRUE
            //                     warehousereceiptline.MODIFY;
            //                 END
            //                 ELSE IF (rec."Select All" = FALSE) AND (warehousereceiptline."Create Production Order" = FALSE) THEN BEGIN
            //                     warehousereceiptline."Create Production Order" := FALSE;
            //                     warehousereceiptline.MODIFY;
            //                 END;
            //             //END;//chem-493
            //             //"lineno." := "lineno."+10000; //chem-493
            //             UNTIL warehousereceiptline.NEXT = 0;
            //     end;
            // }

        }
        modify("Location Code")
        {
            Editable = Rec."Gate Entry No." = '';

            trigger OnAfterValidate()
            begin
                if Rec."Gate Entry No." <> '' then
                    Rec.Validate("Gate Entry No.", '');
            end;
        }
        modify("Bin Code")
        {
            Editable = Rec."Gate Entry No." = '';

            trigger OnAfterValidate()
            begin
                if Rec."Gate Entry No." <> '' then
                    Rec.Validate("Gate Entry No.", '');
            end;
        }
    }
    var
        WhseDocPrint: Codeunit "Warehouse Document-Print";
        TEstrec: Record "Tracking Specification";
        warehousereceiptline: Record "Warehouse Receipt Line";
        "lineno.": Integer;
        uncheck1: Boolean;
        PostedGateEntryLine1_Rec: Record "Posted Gate Entry Line 1";
        WarehouseReceiptLine_Rec: Record "Warehouse Receipt Line";
        Compname: Text[250];

        "Posted Gate Entry Line": Record "Posted Gate Entry Line 1";
        WhseRqst: Record "Warehouse Request";
        GetSourceDocuments: Report "Get Source Documents";
        "Warehouse Receipt Line": Record "Warehouse Receipt Line";
    // Defaultsetup: Record "Default Setup";
}
