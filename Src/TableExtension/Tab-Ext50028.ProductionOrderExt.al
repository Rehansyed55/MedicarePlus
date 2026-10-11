tableextension 50028 "Production Order Ext" extends "Production Order"
{
    fields
    {
        modify("Source No.")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                //Upgraded Code from NAV 5.0

                ProdLicRec.RESET;
                ProdLicRec.SETRANGE(ProdLicRec."Stock Code", "Source No.");
                IF ProdLicRec.FINDFIRST THEN BEGIN
                    "PLPI Item Code" := TRUE;
                END;
            end;
        }

        modify(Quantity)
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                "Total No. of Actions" := ROUND(Quantity * "No.of Actions"); //Nikhil_11/02/2021_(CAS-23877-S6C5N4)
            end;
        }

        modify("Routing No.")
        {
            trigger OnAfterValidate()
            var
                ProdOrderLine: Record "Prod. Order Line";
            begin
                // Header Routing No. is not pushed to existing lines/routing lines until the order is refreshed
                if "Routing No." = xRec."Routing No." then
                    exit;
                ProdOrderLine.SetRange(Status, Status);
                ProdOrderLine.SetRange("Prod. Order No.", "No.");
                if not ProdOrderLine.IsEmpty() then
                    Message(RefreshForRoutingMsg, FieldCaption("Routing No."));
            end;
        }
        field(50000; "ECMA No."; Code[100])
        {
            Description = 'Upgrade frm Nav5';
            TableRelation = IF ("Source Type" = FILTER("Prod. Order Source Type"::item)) "Variant Product license line"."ECMA No." WHERE("Stock Code" = FIELD("Source No."),
                                                                                                           Status = FILTER(Certified));
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                //add by hiren
                VarProductLicLine2.RESET;
                VarProductLicLine2.SETRANGE("Stock Code", "Source No.");
                VarProductLicLine2.SETRANGE(VarProductLicLine2."ECMA No.", "ECMA No.");
                VarProductLicLine2.SETRANGE(VarProductLicLine2.Status, VarProductLicLine2.Status::Certified);
                IF VarProductLicLine2.FINDFIRST THEN BEGIN
                    "Production BOM No." := VarProductLicLine2."Production BOM No.";
                    "Production BOM Version No." := VarProductLicLine2."Production BOM Version No.";
                    "Routing No." := VarProductLicLine2."Routing No.";
                    "PLPI No." := VarProductLicLine2."PL No.";
                    "BPR Version No." := VarProductLicLine2."BPR Version No.";
                END;
            end;
        }
        field(50001; "Production BOM No."; Code[20])
        {
            Description = 'Upgrade frm Nav5';
            TableRelation = "Production BOM Header"."No.";
        }
        field(50002; "Production BOM Version No."; Code[20])
        {
            Description = 'Upgrade frm Nav5';
            TableRelation = "Production BOM Version"."Version Code" WHERE("Production BOM No." = FIELD("Production BOM No."));
        }
        field(50003; WMSReceiptNo; Code[20])
        {
            Description = 'Upgrade frm Nav5';
        }
        field(50004; "BPR Version No."; Code[20])
        {
            Description = 'Upgrade frm Nav5';
            TableRelation = IF ("Source Type" = FILTER(Item)) "Variant Product license line"."BPR Version No." WHERE("Stock Code" = FIELD("Source No."),
                                                                                                                  "ECMA No." = FIELD("ECMA No."),
                                                                                                                  Blocked = CONST(false));

            trigger OnValidate()
            begin
                //Add by hiren
                VarProductLicLine.RESET;
                VarProductLicLine.SETRANGE("Stock Code", "Source No.");
                VarProductLicLine.SETRANGE(VarProductLicLine."ECMA No.", "ECMA No.");
                VarProductLicLine.SETRANGE(VarProductLicLine."BPR Version No.", "BPR Version No.");
                IF VarProductLicLine.FINDFIRST THEN BEGIN
                    "Production BOM No." := VarProductLicLine."Production BOM No.";
                    "Production BOM Version No." := VarProductLicLine."Production BOM Version No.";
                    "Routing No." := VarProductLicLine."Routing No.";
                    "PLPI No." := VarProductLicLine."PL No.";
                END;
            end;
        }
        field(50005; "PLPI No."; Code[20])
        {
            Description = 'Upgrade frm Nav5';
        }
        field(50006; "Lot No."; Code[30])
        {
            Description = 'Upgrade frm Nav5';
        }
        field(50007; "Purchase order"; Code[20])
        {
            Description = 'Upgrade frm Nav5';

            trigger OnValidate()
            begin
                //alok for fetch suppiler code
                purchaseheader.SETRANGE(purchaseheader."No.", "Purchase order");
                IF purchaseheader.FINDFIRST THEN
                    "Suppiler Code" := purchaseheader."Buy-from Vendor No.";
                //alok finish
            end;
        }
        field(50008; "Expiry Date"; Date)
        {
            Description = 'Upgrade frm Nav5';
        }
        field(50009; "Posted Warehouse Receipt No."; Code[20])
        {
            Description = 'Upgrade frm Nav5';
        }
        field(50010; "Posted Receipt No."; Code[20])
        {
            Description = 'Upgrade frm Nav5';
        }
        field(50011; "PLPI Item Code"; Boolean)
        {
            Description = 'Upgrade frm Nav5';
        }
        field(50012; "Rebox/Overlabel"; Option)
        {
            Description = 'Upgrade frm Nav5';
            OptionCaption = ' ,Rebox,Overlabel';
            OptionMembers = " ",Rebox,Overlabel;
        }
        field(50013; "On Sales Order"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Line"."Outstanding Quantity" WHERE("Document Type" = FILTER(Order),
                                                                         Type = FILTER(Item),
                                                                         "No." = FIELD("Source No.")));
            Description = 'Upgrade frm Nav5';
        }
        field(50014; "Outstanding Order Qty"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Purchase Line"."Outstanding Quantity" WHERE(Type = FILTER(Item),
                                                                            "No." = FIELD("Source No."),
                                                                            "Location Code" = FIELD("Location Code")));
            Description = 'Upgrade frm Nav5';
        }
        field(50015; "Checked Zone"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Warehouse Entry".Quantity WHERE("Item No." = FIELD("Source No."),
                                                                "Bin Code" = FILTER('CHECKED')));
            Caption = 'Checked Bin';
            Description = 'Upgrade frm Nav5';
        }
        field(50016; "Production Bin"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Warehouse Entry".Quantity WHERE("Bin Code" = FILTER('PROD'),
                                                                "Item No." = FIELD("Source No.")));
            Caption = 'Production Bin';
            Description = 'Upgrade frm Nav5';
        }
        field(50017; "Room No."; Code[20])
        {
            Description = 'Upgrade frm Nav5';

            trigger OnValidate()
            begin
                defaultsetup.GET;
                compname := COMPANYNAME;
                IF compname = defaultsetup."Company name" THEN BEGIN
                    IF xRec."Room No." <> '' THEN BEGIN
                        "Room No." := xRec."Room No.";
                    END;
                    IF "Room No." <> '' THEN BEGIN
                        IF "Job Start Date" = 0D THEN BEGIN
                            "Job Start Date" := WORKDATE;
                            "Job Start Time" := TIME;
                        END;
                    END;
                END;
            end;
        }
        field(50018; "Priority Of Production Order"; Integer)
        {
            Description = 'Upgrade frm Nav5';
        }
        field(50019; "Production Start Time"; Time)
        {
            Description = 'Upgrade frm Nav5';
        }
        field(50020; "Prodcution End Time"; Time)
        {
            Description = 'Upgrade frm Nav5';
        }
        field(50021; "Lable Issue"; Boolean)
        {
            Description = 'Upgrade frm Nav5';
        }
        field(50022; "Component Issue"; Boolean)
        {
            Description = 'Upgrade frm Nav5';
        }
        field(50023; "No.of Actions"; Integer)
        {
            Description = 'Upgrade frm Nav5';
        }
        field(50024; "Your Reference"; Text[30])
        {
            Description = 'Upgrade frm Nav5';
        }
        field(50025; "Suppiler Code"; Code[30])
        {
            Description = 'Upgrade frm Nav5';
        }
        field(50026; "Free Location Quantity"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Warehouse Entry".Quantity WHERE("Location Code" = FILTER('FREE'),
                                                                "Item No." = FIELD("Source No.")));
            Caption = 'Free Bin Quantity';
            Description = 'Upgrade frm Nav5';
            Editable = false;
        }
        field(50027; "Total No. of Actions"; Decimal)
        {
            Description = 'Upgrade frm Nav5';
        }
        field(50028; "Production Jnl posted"; Boolean)
        {
            Description = 'Upgrade frm Nav5';
        }
        field(50029; "Componented Putaway created"; Boolean)
        {
            Description = 'Upgrade frm Nav5';
            Editable = false;
        }
        field(50031; "Item Checked"; Boolean)
        {
            Caption = 'BPR Checked';
            Description = 'Upgrade frm Nav5';
        }
        field(50032; "PIP Code"; Code[20])
        {
            Description = 'Upgrade frm Nav5';
        }
        field(50033; "Posted Prod. Jnl Date"; Date)
        {
            Description = 'Upgrade frm Nav5';
            Editable = false;
        }
        field(50034; "Finished Time"; Time)
        {
            Description = 'Upgrade frm Nav5';
        }
        field(50035; "Finished By"; Code[50])
        {
            Description = 'Upgrade frm Nav5';
        }
        field(50036; "Job Start Date/Time"; DateTime)
        {
            Description = 'Upgrade frm Nav5';
            Editable = false;
        }
        field(50037; "Job Finish Date/Time"; DateTime)
        {
            Description = 'Upgrade frm Nav5';
            Editable = false;
        }
        field(50038; "Total No. of Hours"; Integer)
        {
            Description = 'Upgrade frm Nav5';
        }
        field(50039; "Checked Put away Posted"; Boolean)
        {
            Description = 'Upgrade frm Nav5';
        }
        field(50040; "QC Checked"; Boolean)
        {
            Description = 'Upgrade frm Nav5';
        }
        field(50041; "Total No. of People"; Integer)
        {
            Description = 'Upgrade frm Nav5';
        }
        field(50042; "Scan For End Time"; Code[20])
        {
            Description = 'Upgrade frm Nav5';

            trigger OnValidate()
            begin
                IF "Room No." = '' THEN BEGIN
                    "Scan For End Time" := '';
                END;

                IF "Room No." <> '' THEN BEGIN
                    IF "Total No. of People" <> 0 THEN BEGIN
                        IF xRec."Scan For End Time" <> '' THEN BEGIN
                            "Scan For End Time" := xRec."Scan For End Time";
                        END;
                    END
                    ELSE BEGIN
                        IF "Total No. of People" = 0 THEN BEGIN
                            "Scan For End Time" := '';
                            MODIFY(FALSE);
                            MESSAGE('Please enter total no.of people..');
                        END;

                    END;
                END;
                IF "Total No. of People" <> 0 THEN BEGIN
                    IF ("Job End Date" = 0D) AND ("Job Start Date" <> 0D) THEN BEGIN
                        "Job End Date" := WORKDATE;
                        "Job End Time" := TIME;
                        CalculateTimeOL;
                    END;
                END;
                /*
                IF "Room No."='' THEN BEGIN
                 "Scan For End Time":='';
                END;
                
                IF "Room No."<>'' THEN BEGIN
                IF xRec."Scan For End Time"<>'' THEN BEGIN
                   "Scan For End Time":=xRec."Scan For End Time";
                END;
                END;
                IF ("Job End Date"=0D) AND ("Job Start Date"<>0D) THEN BEGIN
                 "Job End Date":=WORKDATE;
                 "Job End Time":=TIME;
                 CalculateTime;
                END;
                */

            end;
        }
        field(50043; "Job Start Date"; Date)
        {
            Description = 'Upgrade frm Nav5';
        }
        field(50044; "Job Start Time"; Time)
        {
            Description = 'Upgrade frm Nav5';
        }
        field(50045; "Job End Date"; Date)
        {
            Description = 'Upgrade frm Nav5';
            Editable = false;
        }
        field(50046; "Job End Time"; Time)
        {
            Description = 'Upgrade frm Nav5';
            Editable = false;
        }
        field(50047; "Total No of Mintue"; Decimal)
        {
            Description = 'Upgrade frm Nav5';
            Editable = false;
        }
        field(50048; Combined; Option)
        {
            Description = 'CAS-00659-V7Q6S0';
            OptionCaption = 'No,Yes';
            OptionMembers = No,Yes;

            trigger OnValidate()
            begin

                //CAS-00659-V7Q6S0 Start
                "Combined By" := USERID;
                "Combined Date" := WORKDATE;
                //CAS-00659-V7Q6S0 End
            end;
        }
        field(50049; "Combined By"; Code[50])
        {
            Description = 'CAS-00659-V7Q6S0';
        }
        field(50050; "Combined Date"; Date)
        {
            Description = 'CAS-00659-V7Q6S0';
        }
        field(50051; Comments; Text[40])
        {
            Description = 'CAS-00659-V7Q6S0';
        }

        field(50052; "BPR Checked"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(50053; "Technical Agreement No."; Code[50])
        {
            Caption = 'Technical Agreement No.';
            TableRelation = "Dimension Value".Code
                WHERE("Dimension Code" = CONST('TA REFERENCE'),
                      Blocked = CONST(false));
        }
        field(50054; "Supplier Code"; Code[30])
        {
            DataClassification = ToBeClassified;
        }

    }

    trigger OnInsert()
    var
        myInt: Integer;
    begin
        //vik++
        IF Rec."No." <> '' THEN BEGIN
            Rec."Assigned User ID" := USERID;
            //Rec.MODIFY(TRUE);
            //COMMIT();
        END;
        //vik--
    end;


    local procedure CalculateTimeOL()
    begin
        BEGIN
            MfgSetup.GET();
            Startday := DATE2DMY("Job Start Date", 1);
            Endday := DATE2DMY("Job End Date", 1);
            EndDate.RESET;
            EndDate.SETRANGE(EndDate."Period Type", EndDate."Period Type"::Date);
            EndDate.SETRANGE(EndDate."Period Start", "Job End Date");
            IF EndDate.FINDFIRST THEN;
            StartDate.RESET;
            StartDate.SETRANGE(StartDate."Period Type", StartDate."Period Type"::Date);
            StartDate.SETRANGE(StartDate."Period Start", "Job Start Date");
            IF StartDate.FINDFIRST THEN;

            DateSet.RESET;
            DateSet.SETRANGE(DateSet."Period Type", DateSet."Period Type"::Date);
            DateSet.SETFILTER(DateSet."Period Start", '%1..%2', "Job Start Date", "Job End Date");
            IF DateSet.FINDSET THEN;
            REPEAT
                i := i + 1;
            UNTIL DateSet.NEXT = 0;
            NoofPeople := "Total No. of People";
            IF ((EndDate."Period No." - StartDate."Period No.") = 0) AND (i = 1) THEN BEGIN
                IF "Job Start Time" <= 100000T THEN BEGIN
                    IF "Job End Time" <= 100000T THEN
                        "Total No of Mintue" := (NoofPeople * ("Job End Time" - "Job Start Time")) / 60000
                    ELSE IF ("Job End Time" > 100000T) AND ("Job End Time" <= 123000T) THEN
                        "Total No of Mintue" := ((NoofPeople * ("Job End Time" - "Job Start Time")) - (NoofPeople * 900000)) / 60000
                    ELSE
                        "Total No of Mintue" := ((NoofPeople * ("Job End Time" - "Job Start Time")) - (NoofPeople * 2700000)) / 60000;
                END
                ELSE BEGIN
                    IF ("Job Start Time" > 100000T) AND ("Job Start Time" <= 123000T) THEN BEGIN
                        IF ("Job End Time" > 100000T) AND ("Job End Time" <= 123000T) THEN
                            "Total No of Mintue" := (NoofPeople * ("Job End Time" - "Job Start Time")) / 60000
                        ELSE
                            "Total No of Mintue" := ((NoofPeople * ("Job End Time" - "Job Start Time")) - (NoofPeople * 1800000)) / 60000
                    END;
                    IF ("Job Start Time" >= 130000T) AND ("Job Start Time" < 163000T) THEN BEGIN
                        IF ("Job End Time" > 130000T) AND ("Job End Time" <= 163000T) THEN
                            "Total No of Mintue" := (NoofPeople * ("Job End Time" - "Job Start Time")) / 60000
                        ELSE
                            "Total No of Mintue" := (NoofPeople * (163000T - "Job Start Time")) / 60000
                    END
                END

                //MODIFY(FALSE);
            END ELSE BEGIN
                IF (EndDate."Period No." - StartDate."Period No.") = 1 THEN BEGIN
                    IF "Job End Time" <= 100000T THEN
                        "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") +
                         ("Job End Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * 2700000)) / 60000
                    ELSE IF ("Job End Time" > 100000T) AND ("Job End Time" <= 123000T) THEN
                        "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") +
                         ("Job End Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * 3600000)) / 60000
                    ELSE
                        "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") +
                         ("Job End Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * 5400000)) / 60000;

                    //"Result Time":=000000T+(MfgSetup."Normal Ending Time"-"Start Time")+("End TIme"-MfgSetup."Normal Starting Time");
                END;
            END;
            IF ((EndDate."Period No." - StartDate."Period No.") = 0) AND (i > 1) THEN BEGIN
                IF "Job Start Time" <= 100000T THEN BEGIN
                    IF "Job End Time" <= 100000T THEN
                        "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") - (2 * 30600000) + ((i - 2) * 30600000)
                         + ("Job End Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * (2700000 + ((i - 4) * 2700000)))) / 60000
                    ELSE IF ("Job End Time" > 100000T) AND ("Job End Time" <= 123000T) THEN
                        "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") - (2 * 30600000) + ((i - 2) * 30600000)
                         + ("Job End Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * (3600000 + ((i - 4) * 2700000)))) / 60000
                    ELSE
                        "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") - (2 * 30600000) + ((i - 2) * 30600000)
                         + ("Job End Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * (5400000 + ((i - 4) * 2700000)))) / 60000;
                END
                ELSE BEGIN
                    IF ("Job Start Time" > 100000T) AND ("Job Start Time" <= 123000T) THEN BEGIN
                        IF "Job End Time" <= 100000T THEN
                            "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") - (2 * 30600000) + ((i - 2) * 30600000)
                             + ("Job End Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * (1800000 + ((i - 4) * 2700000)))) / 60000
                        ELSE IF ("Job End Time" > 100000T) AND ("Job End Time" <= 123000T) THEN
                            "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") - (2 * 30600000) + ((i - 2) * 30600000)
                             + ("Job End Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * (2700000 + ((i - 4) * 2700000)))) / 60000
                        ELSE
                            "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") - (2 * 30600000) + ((i - 2) * 30600000)
                             + ("Job End Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * (3600000 + ((i - 4) * 2700000)))) / 60000
                    END;
                    IF ("Job Start Time" >= 130000T) AND ("Job Start Time" < 163000T) THEN BEGIN
                        IF "Job End Time" <= 100000T THEN
                            "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") - (2 * 30600000) + ((i - 2) * 30600000)
                             + ("Job End Time" - MfgSetup."Normal Starting Time"))) - ((i - 4) * 2700000)) / 60000
                        ELSE IF ("Job End Time" > 100000T) AND ("Job End Time" <= 123000T) THEN
                            "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") - (2 * 30600000) + ((i - 2) * 30600000)
                             + ("Job End Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * (900000 + ((i - 4) * 2700000)))) / 60000
                        ELSE BEGIN
                            IF ("Job End Time" > 130000T) AND ("Job End Time" <= 163000T) THEN
                                "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") - (2 * 30600000) + ((i - 2) * 30600000)
                                + ("Job End Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * (2700000 + ((i - 4) * 2700000)))) / 60000
                            ELSE
                                "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") - (2 * 30600000) + ((i - 2) * 30600000)
                                + (MfgSetup."Normal Ending Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * (2700000 + ((i - 4) * 2700000)))) / 60000

                        END
                    END

                END;
            END;

            IF ((EndDate."Period No." - StartDate."Period No.") <> 1) AND ((EndDate."Period No." - StartDate."Period No.") <> 0) THEN BEGIN
                IF StartDate."Period No." > EndDate."Period No." THEN BEGIN
                    IF "Job Start Time" <= 100000T THEN BEGIN
                        IF "Job End Time" <= 100000T THEN
                            "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") - (2 * 30600000) + ((i - 2) * 30600000)
                             + ("Job End Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * (2700000 + ((i - 4) * 2700000)))) / 60000
                        ELSE IF ("Job End Time" > 100000T) AND ("Job End Time" <= 123000T) THEN
                            "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") - (2 * 30600000) + ((i - 2) * 30600000)
                             + ("Job End Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * (3600000 + ((i - 4) * 2700000)))) / 60000
                        ELSE
                            "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") - (2 * 30600000) + ((i - 2) * 30600000)
                             + ("Job End Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * (5400000 + ((i - 4) * 2700000)))) / 60000;
                    END
                    ELSE BEGIN
                        IF ("Job Start Time" > 100000T) AND ("Job Start Time" <= 123000T) THEN BEGIN
                            IF "Job End Time" <= 100000T THEN
                                "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") - (2 * 30600000) + ((i - 2) * 30600000)
                                 + ("Job End Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * (1800000 + ((i - 4) * 2700000)))) / 60000
                            ELSE IF ("Job End Time" > 100000T) AND ("Job End Time" <= 123000T) THEN
                                "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") - (2 * 30600000) + ((i - 2) * 30600000)
                                 + ("Job End Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * (2700000 + ((i - 4) * 2700000)))) / 60000
                            ELSE
                                "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") - (2 * 30600000) + ((i - 2) * 30600000)
                                 + ("Job End Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * (3600000 + ((i - 4) * 2700000)))) / 60000
                        END;
                        IF ("Job Start Time" >= 130000T) AND ("Job Start Time" < 163000T) THEN BEGIN
                            IF "Job End Time" <= 100000T THEN
                                "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") - (2 * 30600000) + ((i - 2) * 30600000)
                                 + ("Job End Time" - MfgSetup."Normal Starting Time"))) - ((i - 4) * 2700000)) / 60000
                            ELSE IF ("Job End Time" > 100000T) AND ("Job End Time" <= 123000T) THEN
                                "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") - (2 * 30600000) + ((i - 2) * 30600000)
                                 + ("Job End Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * (900000 + ((i - 4) * 2700000)))) / 60000
                            ELSE BEGIN
                                IF ("Job End Time" > 130000T) AND ("Job End Time" <= 163000T) THEN
                                    "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") - (2 * 30600000) + ((i - 2) * 30600000)
                                    + ("Job End Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * (2700000 + ((i - 4) * 2700000)))) / 60000
                                ELSE
                                    "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") - (2 * 30600000) + ((i - 2) * 30600000)
                                    + (MfgSetup."Normal Ending Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * (2700000 + ((i - 4) * 2700000)))) / 60000
                            END
                        END

                    END

                    //"Total No of Mintue":=((MfgSetup."Normal Ending Time"-"Job Start Time")-(2*30600000)+((i-2)*30600000)
                    //  +("Job End Time"-MfgSetup."Normal Starting Time"))/60000;
                    //"Result Time":=000000T+((MfgSetup."Normal Ending Time"-"Start Time")
                    // +("End TIme"-MfgSetup."Normal Starting Time"));
                    //i:=i-2;
                    //REPEAT
                    //"Result Time":="Result Time"+30600000;
                    //i:=i-1;
                    //UNTIL i=0;
                    //"Result Time":="Result Time"-(2*30600000);
                END ELSE BEGIN
                    IF "Job Start Time" <= 100000T THEN BEGIN
                        IF "Job End Time" <= 100000T THEN
                            "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") + ((i - 2) * 30600000)
                             + ("Job End Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * (2700000 + ((i - 2) * 2700000)))) / 60000
                        ELSE IF ("Job End Time" > 100000T) AND ("Job End Time" <= 123000T) THEN
                            "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") + ((i - 2) * 30600000)
                             + ("Job End Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * (3600000 + ((i - 2) * 2700000)))) / 60000
                        ELSE
                            "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") + ((i - 2) * 30600000)
                             + ("Job End Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * (5400000 + ((i - 2) * 2700000)))) / 60000;
                    END
                    ELSE BEGIN
                        IF ("Job Start Time" > 100000T) AND ("Job Start Time" <= 123000T) THEN BEGIN
                            IF "Job End Time" <= 100000T THEN
                                "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") + ((i - 2) * 30600000)
                                 + ("Job End Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * (1800000 + ((i - 2) * 2700000)))) / 60000
                            ELSE IF ("Job End Time" > 100000T) AND ("Job End Time" <= 123000T) THEN
                                "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") + ((i - 2) * 30600000)
                                 + ("Job End Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * (2700000 + ((i - 2) * 2700000)))) / 60000
                            ELSE
                                "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") + ((i - 2) * 30600000)
                                 + ("Job End Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * (3600000 + ((i - 2) * 2700000)))) / 60000
                        END;
                        IF ("Job Start Time" >= 130000T) AND ("Job Start Time" < 163000T) THEN BEGIN
                            IF "Job End Time" <= 100000T THEN
                                "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") + ((i - 2) * 30600000)
                                 + ("Job End Time" - MfgSetup."Normal Starting Time"))) - ((i - 4) * 2700000)) / 60000
                            ELSE IF ("Job End Time" > 100000T) AND ("Job End Time" <= 123000T) THEN
                                "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") + ((i - 2) * 30600000)
                                 + ("Job End Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * (900000 + ((i - 2) * 2700000)))) / 60000
                            ELSE BEGIN
                                IF ("Job End Time" > 130000T) AND ("Job End Time" <= 163000T) THEN
                                    "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") + ((i - 2) * 30600000)
                                    + ("Job End Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * (2700000 + ((i - 2) * 2700000)))) / 60000
                                ELSE
                                    "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") - (2 * 30600000) + ((i - 2) * 30600000)
                                    + (MfgSetup."Normal Ending Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * (2700000 + ((i - 4) * 2700000)))) / 60000

                            END
                        END


                    END
                    //"Total No of Mintue":=((MfgSetup."Normal Ending Time"-"Job Start Time")+((i-2)*30600000)
                    // +("Job End Time"-MfgSetup."Normal Starting Time"))/60000;
                    //"Result Time":=000000T+((MfgSetup."Normal Ending Time"-"Start Time")
                    //+("End TIme"-MfgSetup."Normal Starting Time"));
                    //i:=i-2;
                    //REPEAT
                    //"Result Time":="Result Time"+30600000;
                    //i:=i-1;
                    //UNTIL i=0;
                END;
            END;
        END;
    end;


    local procedure CalculateTime()
    begin
        BEGIN
            MfgSetup.GET();
            Startday := DATE2DMY("Job Start Date", 1);
            Endday := DATE2DMY("Job End Date", 1);
            EndDate.RESET;
            EndDate.SETRANGE(EndDate."Period Type", EndDate."Period Type"::Date);
            EndDate.SETRANGE(EndDate."Period Start", "Job End Date");
            IF EndDate.FINDFIRST THEN;
            StartDate.RESET;
            StartDate.SETRANGE(StartDate."Period Type", StartDate."Period Type"::Date);
            StartDate.SETRANGE(StartDate."Period Start", "Job Start Date");
            IF StartDate.FINDFIRST THEN;

            DateSet.RESET;
            DateSet.SETRANGE(DateSet."Period Type", DateSet."Period Type"::Date);
            DateSet.SETFILTER(DateSet."Period Start", '%1..%2', "Job Start Date", "Job End Date");
            IF DateSet.FINDSET THEN;
            REPEAT
                i := i + 1;
            UNTIL DateSet.NEXT = 0;
            NoofPeople := "Total No. of People";
            IF ((EndDate."Period No." - StartDate."Period No.") = 0) AND (i = 1) THEN BEGIN
                IF "Job Start Time" <= 100000T THEN BEGIN
                    IF "Job End Time" <= 100000T THEN
                        "Total No of Mintue" := (NoofPeople * ("Job End Time" - "Job Start Time")) / 60000
                    ELSE IF ("Job End Time" > 100000T) AND ("Job End Time" <= 123000T) THEN
                        "Total No of Mintue" := ((NoofPeople * ("Job End Time" - "Job Start Time")) - (NoofPeople * 900000)) / 60000
                    ELSE
                        "Total No of Mintue" := ((NoofPeople * ("Job End Time" - "Job Start Time")) - (NoofPeople * 2700000)) / 60000;
                END
                ELSE BEGIN
                    IF ("Job Start Time" > 100000T) AND ("Job Start Time" <= 123000T) THEN BEGIN
                        IF ("Job End Time" > 100000T) AND ("Job End Time" <= 123000T) THEN
                            "Total No of Mintue" := (NoofPeople * ("Job End Time" - "Job Start Time")) / 60000
                        ELSE
                            "Total No of Mintue" := ((NoofPeople * ("Job End Time" - "Job Start Time")) - (NoofPeople * 1800000)) / 60000
                    END;
                    IF ("Job Start Time" >= 130000T) AND ("Job Start Time" < 163000T) THEN BEGIN
                        IF ("Job End Time" > 130000T) AND ("Job End Time" <= 163000T) THEN
                            "Total No of Mintue" := (NoofPeople * ("Job End Time" - "Job Start Time")) / 60000
                        ELSE
                            "Total No of Mintue" := (NoofPeople * (163000T - "Job Start Time")) / 60000
                    END
                END

                //MODIFY(FALSE);
            END ELSE BEGIN
                IF (EndDate."Period No." - StartDate."Period No.") = 1 THEN BEGIN
                    IF "Job Start Time" <= 100000T THEN BEGIN
                        IF "Job End Time" <= 100000T THEN
                            "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") +
                             ("Job End Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * 2700000)) / 60000
                        ELSE IF ("Job End Time" > 100000T) AND ("Job End Time" <= 123000T) THEN
                            "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") +
                             ("Job End Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * 3600000)) / 60000
                        ELSE
                            "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") +
                             ("Job End Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * 5400000)) / 60000;
                    END
                    ELSE BEGIN
                        IF ("Job Start Time" > 100000T) AND ("Job Start Time" <= 123000T) THEN BEGIN
                            IF "Job End Time" <= 100000T THEN
                                "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") +
                                 ("Job End Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * 1800000)) / 60000
                            ELSE IF ("Job End Time" > 100000T) AND ("Job End Time" <= 123000T) THEN
                                "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") +
                                 ("Job End Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * 2700000)) / 60000
                            ELSE
                                "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") +
                                 ("Job End Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * 4500000)) / 60000;
                        END;
                        IF ("Job Start Time" >= 130000T) AND ("Job Start Time" <= 163000T) THEN BEGIN
                            IF "Job End Time" <= 100000T THEN
                                "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") +
                                 ("Job End Time" - MfgSetup."Normal Starting Time")))) / 60000
                            ELSE IF ("Job End Time" > 100000T) AND ("Job End Time" <= 123000T) THEN
                                "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") +
                                 ("Job End Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * 900000)) / 60000
                            ELSE BEGIN
                                IF ("Job End Time" > 130000T) AND ("Job End Time" <= 163000T) THEN
                                    "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") +
                                     ("Job End Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * 2700000)) / 60000
                                ELSE
                                    "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") +
                                     ("Job End Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * 2700000)) / 60000
                            END;
                        END;
                    END;
                    //"Result Time":=000000T+(MfgSetup."Normal Ending Time"-"Start Time")+("End TIme"-MfgSetup."Normal Starting Time");
                END;
            END;
            IF ((EndDate."Period No." - StartDate."Period No.") = 0) AND (i > 1) THEN BEGIN
                IF "Job Start Time" <= 100000T THEN BEGIN
                    IF "Job End Time" <= 100000T THEN
                        "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") - (2 * 30600000) + ((i - 2) * 30600000)
                         + ("Job End Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * (2700000 + ((i - 4) * 2700000)))) / 60000
                    ELSE IF ("Job End Time" > 100000T) AND ("Job End Time" <= 123000T) THEN
                        "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") - (2 * 30600000) + ((i - 2) * 30600000)
                         + ("Job End Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * (3600000 + ((i - 4) * 2700000)))) / 60000
                    ELSE
                        "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") - (2 * 30600000) + ((i - 2) * 30600000)
                         + ("Job End Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * (5400000 + ((i - 4) * 2700000)))) / 60000;
                END
                ELSE BEGIN
                    IF ("Job Start Time" > 100000T) AND ("Job Start Time" <= 123000T) THEN BEGIN
                        IF "Job End Time" <= 100000T THEN
                            "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") - (2 * 30600000) + ((i - 2) * 30600000)
                             + ("Job End Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * (1800000 + ((i - 4) * 2700000)))) / 60000
                        ELSE IF ("Job End Time" > 100000T) AND ("Job End Time" <= 123000T) THEN
                            "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") - (2 * 30600000) + ((i - 2) * 30600000)
                             + ("Job End Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * (2700000 + ((i - 4) * 2700000)))) / 60000
                        ELSE
                            "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") - (2 * 30600000) + ((i - 2) * 30600000)
                             + ("Job End Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * (3600000 + ((i - 4) * 2700000)))) / 60000
                    END;
                    IF ("Job Start Time" >= 130000T) AND ("Job Start Time" < 163000T) THEN BEGIN
                        IF "Job End Time" <= 100000T THEN
                            "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") - (2 * 30600000) + ((i - 2) * 30600000)
                             + ("Job End Time" - MfgSetup."Normal Starting Time"))) - ((i - 4) * 2700000)) / 60000
                        ELSE IF ("Job End Time" > 100000T) AND ("Job End Time" <= 123000T) THEN
                            "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") - (2 * 30600000) + ((i - 2) * 30600000)
                             + ("Job End Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * (900000 + ((i - 4) * 2700000)))) / 60000
                        ELSE BEGIN
                            IF ("Job End Time" > 130000T) AND ("Job End Time" <= 163000T) THEN
                                "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") - (2 * 30600000) + ((i - 2) * 30600000)
                                + ("Job End Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * (2700000 + ((i - 4) * 2700000)))) / 60000
                            ELSE
                                "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") - (2 * 30600000) + ((i - 2) * 30600000)
                                + (MfgSetup."Normal Ending Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * (2700000 + ((i - 4) * 2700000)))) / 60000

                        END
                    END

                END;
            END;

            IF ((EndDate."Period No." - StartDate."Period No.") <> 1) AND ((EndDate."Period No." - StartDate."Period No.") <> 0) THEN BEGIN
                IF StartDate."Period No." > EndDate."Period No." THEN BEGIN
                    IF "Job Start Time" <= 100000T THEN BEGIN
                        IF "Job End Time" <= 100000T THEN
                            "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") - (2 * 30600000) + ((i - 2) * 30600000)
                             + ("Job End Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * (2700000 + ((i - 4) * 2700000)))) / 60000
                        ELSE IF ("Job End Time" > 100000T) AND ("Job End Time" <= 123000T) THEN
                            "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") - (2 * 30600000) + ((i - 2) * 30600000)
                             + ("Job End Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * (3600000 + ((i - 4) * 2700000)))) / 60000
                        ELSE
                            "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") - (2 * 30600000) + ((i - 2) * 30600000)
                             + ("Job End Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * (5400000 + ((i - 4) * 2700000)))) / 60000;
                    END
                    ELSE BEGIN
                        IF ("Job Start Time" > 100000T) AND ("Job Start Time" <= 123000T) THEN BEGIN
                            IF "Job End Time" <= 100000T THEN
                                "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") - (2 * 30600000) + ((i - 2) * 30600000)
                                 + ("Job End Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * (1800000 + ((i - 4) * 2700000)))) / 60000
                            ELSE IF ("Job End Time" > 100000T) AND ("Job End Time" <= 123000T) THEN
                                "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") - (2 * 30600000) + ((i - 2) * 30600000)
                                 + ("Job End Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * (2700000 + ((i - 4) * 2700000)))) / 60000
                            ELSE
                                "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") - (2 * 30600000) + ((i - 2) * 30600000)
                                 + ("Job End Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * (3600000 + ((i - 4) * 2700000)))) / 60000
                        END;
                        IF ("Job Start Time" >= 130000T) AND ("Job Start Time" < 163000T) THEN BEGIN
                            IF "Job End Time" <= 100000T THEN
                                "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") - (2 * 30600000) + ((i - 2) * 30600000)
                                 + ("Job End Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * ((i - 4) * 2700000))) / 60000
                            ELSE IF ("Job End Time" > 100000T) AND ("Job End Time" <= 123000T) THEN
                                "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") - (2 * 30600000) + ((i - 2) * 30600000)
                                 + ("Job End Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * (900000 + ((i - 4) * 2700000)))) / 60000
                            ELSE BEGIN
                                IF ("Job End Time" > 130000T) AND ("Job End Time" <= 163000T) THEN
                                    "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") - (2 * 30600000) + ((i - 2) * 30600000)
                                    + ("Job End Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * (2700000 + ((i - 4) * 2700000)))) / 60000
                                ELSE
                                    "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") - (2 * 30600000) + ((i - 2) * 30600000)
                                    + (MfgSetup."Normal Ending Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * (2700000 + ((i - 4) * 2700000)))) / 60000
                            END
                        END

                    END

                    //"Total No of Mintue":=((MfgSetup."Normal Ending Time"-"Job Start Time")-(2*30600000)+((i-2)*30600000)
                    //  +("Job End Time"-MfgSetup."Normal Starting Time"))/60000;
                    //"Result Time":=000000T+((MfgSetup."Normal Ending Time"-"Start Time")
                    // +("End TIme"-MfgSetup."Normal Starting Time"));
                    //i:=i-2;
                    //REPEAT
                    //"Result Time":="Result Time"+30600000;
                    //i:=i-1;
                    //UNTIL i=0;
                    //"Result Time":="Result Time"-(2*30600000);
                END ELSE BEGIN
                    IF "Job Start Time" <= 100000T THEN BEGIN
                        IF "Job End Time" <= 100000T THEN
                            "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") + ((i - 2) * 30600000)
                             + ("Job End Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * (2700000 + ((i - 2) * 2700000)))) / 60000
                        ELSE IF ("Job End Time" > 100000T) AND ("Job End Time" <= 123000T) THEN
                            "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") + ((i - 2) * 30600000)
                             + ("Job End Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * (3600000 + ((i - 2) * 2700000)))) / 60000
                        ELSE
                            "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") + ((i - 2) * 30600000)
                             + ("Job End Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * (5400000 + ((i - 2) * 2700000)))) / 60000;
                    END
                    ELSE BEGIN
                        IF ("Job Start Time" > 100000T) AND ("Job Start Time" <= 123000T) THEN BEGIN
                            IF "Job End Time" <= 100000T THEN
                                "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") + ((i - 2) * 30600000)
                                 + ("Job End Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * (1800000 + ((i - 2) * 2700000)))) / 60000
                            ELSE IF ("Job End Time" > 100000T) AND ("Job End Time" <= 123000T) THEN
                                "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") + ((i - 2) * 30600000)
                                 + ("Job End Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * (2700000 + ((i - 2) * 2700000)))) / 60000
                            ELSE
                                "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") + ((i - 2) * 30600000)
                                 + ("Job End Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * (3600000 + ((i - 2) * 2700000)))) / 60000
                        END;
                        IF ("Job Start Time" >= 130000T) AND ("Job Start Time" < 163000T) THEN BEGIN
                            IF "Job End Time" <= 100000T THEN
                                "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") + ((i - 2) * 30600000)
                                 + ("Job End Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * ((i - 2) * 2700000))) / 60000
                            ELSE IF ("Job End Time" > 100000T) AND ("Job End Time" <= 123000T) THEN
                                "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") + ((i - 2) * 30600000)
                                 + ("Job End Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * (900000 + ((i - 2) * 2700000)))) / 60000
                            ELSE BEGIN
                                IF ("Job End Time" > 130000T) AND ("Job End Time" <= 163000T) THEN
                                    "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") + ((i - 2) * 30600000)
                                    + ("Job End Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * (2700000 + ((i - 2) * 2700000)))) / 60000
                                ELSE
                                    "Total No of Mintue" := ((NoofPeople * ((MfgSetup."Normal Ending Time" - "Job Start Time") - (2 * 30600000) + ((i - 2) * 30600000)
                                    + (MfgSetup."Normal Ending Time" - MfgSetup."Normal Starting Time"))) - (NoofPeople * (2700000 + ((i - 2) * 2700000)))) / 60000

                            END
                        END


                    END
                    //"Total No of Mintue":=((MfgSetup."Normal Ending Time"-"Job Start Time")+((i-2)*30600000)
                    // +("Job End Time"-MfgSetup."Normal Starting Time"))/60000;
                    //"Result Time":=000000T+((MfgSetup."Normal Ending Time"-"Start Time")
                    //+("End TIme"-MfgSetup."Normal Starting Time"));
                    //i:=i-2;
                    //REPEAT
                    //"Result Time":="Result Time"+30600000;
                    //i:=i-1;
                    //UNTIL i=0;
                END;
            END;
        END;
    end;

    var
        VarProductLicLine: Record 50010;
        VarProductLicLine2: Record 50010;
        ProdLicRec: Record 50008;
        purchaseheader: Record 38;
        compname: Text[50];
        defaultsetup: Record 50012;
        Startday: Integer;
        Endday: Integer;
        EndDate: Record 2000000007;
        i: Integer;
        StartDate: Record 2000000007;
        DateSet: Record 2000000007;
        NoofPeople: Integer;
        MfgSetup: Record "Manufacturing Setup";
        RefreshForRoutingMsg: Label '%1 has been changed. Run Refresh Production Order to apply the new routing to the lines before running Calculate Subcontracts.', Comment = '%1 = Routing No. field caption';

}
