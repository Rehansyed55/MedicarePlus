table 50008 "Product License"
{
    // JIRA : CHEM-474
    // Name : vaibhav
    // date : 19/01/2015
    // description : reminder date and expiry date will populate based on renewal date and granted date

    // DrillDownPageID = 50023;
    // LookupPageID = 50023;

    fields
    {
        field(10; "PL No."; Code[20])
        {
            NotBlank = true;

            trigger OnValidate()
            begin

                //IF DefaultSetup.GET() THEN
                //BEGIN
                //    "PL No.":=DefaultSetup."Default Company Code"+'/'+"PL No.";
                //END;

                //IF Compinfo.GET() THEN
                //BEGIN
                //"Company Name":=Compinfo.Name;
                //END;
            end;
        }
        field(20; "Stock Code"; Code[20])
        {
            Caption = 'Stock Code';
            TableRelation = Item."No.";

            trigger OnValidate()
            var
                ItemRec: Record 27;
            begin
                IF ItemRec.GET("Stock Code") THEN BEGIN
                    "Item Description" := ItemRec.Description;
                    "Item Description 2" := ItemRec."Description 2";
                END;

                "Retail Price" := 0;
                salesprice.RESET;
                salesprice.SETCURRENTKEY(salesprice."Item No.", salesprice."Sales Type");
                salesprice.SETRANGE(salesprice."Item No.", "Stock Code");
                salesprice.SETRANGE(salesprice."Sales Type", salesprice."Sales Type"::"Customer Price Group");
                IF salesprice.FINDFIRST THEN BEGIN
                    REPEAT
                        IF salesprice."Sales Code" = 'A' THEN
                            "Retail Price" := salesprice."Unit Price";
                    UNTIL salesprice.NEXT = 0;
                END;
            end;
        }
        field(30; "Item Description"; Text[50])
        {
            Editable = true;
        }
        field(40; "Item Description 2"; Text[50])
        {
        }
        field(50; "Generic Name"; Text[100])
        {
        }
        field(60; "UK Trade"; Text[100])
        {
        }
        field(70; "EU Trade"; Text[100])
        {
        }
        field(80; "Manufacture Name"; Text[100])
        {
        }
        field(90; "UK Company"; Text[250])
        {
            Caption = 'Other Manufacturer Names';
        }
        field(110; Country; Code[20])
        {
            TableRelation = "Country/Region".Code;
        }
        field(120; "Company Name"; Text[100])
        {
        }
        field(130; Strength; Text[100])
        {
        }
        field(140; "Pack Size"; Text[100])
        {
        }
        field(141; "Submitted Date"; Date)
        {
        }
        field(142; "Granted Date"; Date)
        {

            trigger OnValidate()
            begin
                //CHEM-474 +++
                IF "Renewal Date" = 0D THEN BEGIN
                    IF "Granted Date" <> 0D THEN BEGIN
                        IF COPYSTR("PL No.", 1, 2) <> 'EU' THEN BEGIN
                            "Reminder Date" := CALCDATE('4Y+6M', "Granted Date");
                            "Expire Date" := CALCDATE('5Y-1D', "Granted Date");
                        END
                        ELSE BEGIN
                            "Reminder Date" := CALCDATE('1Y-1M', "Granted Date");
                            "Expire Date" := CALCDATE('1Y', "Granted Date");
                        END;
                    END
                    ELSE BEGIN
                        IF xRec."Granted Date" <> 0D THEN BEGIN
                            "Reminder Date" := 0D;
                            "Expire Date" := 0D;
                        END;
                    END;
                END;

                //CHEM-474---
            end;
        }
        field(143; "Renewal Date"; Date)
        {

            trigger OnValidate()
            begin
                //CHEM-474 +++
                IF "Renewal Date" <> 0D THEN BEGIN
                    IF COPYSTR("PL No.", 1, 2) <> 'EU' THEN BEGIN
                        "Reminder Date" := CALCDATE('4Y+6M', "Renewal Date");
                        "Expire Date" := CALCDATE('5Y-1D', "Renewal Date");
                    END
                    ELSE BEGIN
                        "Reminder Date" := CALCDATE('-CM-1M', "Renewal Date");
                        "Expire Date" := CALCDATE('CM', "Renewal Date");
                    END;
                END
                ELSE BEGIN
                    IF xRec."Renewal Date" <> 0D THEN BEGIN
                        "Reminder Date" := 0D;
                        "Expire Date" := 0D;
                        //VALIDATE("Granted Date");
                    END;
                END;

                //CHEM-474 ---
            end;
        }
        field(144; "Expire Date"; Date)
        {
        }
        field(145; "Time Taken"; Date)
        {
        }
        field(147; "Last Date Modify"; Date)
        {
        }
        field(148; "Last Date Modify time"; Time)
        {
        }
        field(149; "Last Modify By"; Code[50])
        {
        }
        field(150; "Crated by"; Code[50])
        {
        }
        field(151; "Created Date"; Date)
        {
        }
        field(152; "Created time"; Time)
        {
        }
        field(153; "Rebox Likely"; Boolean)
        {
        }
        field(154; "Foreign Pack size"; Code[20])
        {
        }
        field(155; "TM Notified Date"; Date)
        {
            Caption = 'TM Notified Date';
        }
        field(156; "TM Sample Date 1"; Date)
        {
            Caption = 'TM Sample Date 1';
        }
        field(157; Assessor; Code[30])
        {
        }
        field(159; "Foreign Name"; Text[100])
        {
        }
        field(160; "ECMA No."; Code[100])
        {
            Description = 'For internal Use';
        }
        field(161; "Withdrawn Date"; Date)
        {
        }
        field(162; "Refusal Date"; Date)
        {
        }
        field(50001; Blocked; Boolean)
        {

            trigger OnValidate()
            begin
                //alok for block Functionallity
                IF Blocked = TRUE THEN BEGIN
                    IF NOT CONFIRM(Text001, FALSE, "PL No.") THEN BEGIN
                        Blocked := FALSE;
                        EXIT;
                    END ELSE
                        Blocked := TRUE
                END
                ELSE BEGIN
                    IF NOT CONFIRM(Text002, FALSE, "PL No.") THEN BEGIN
                        Blocked := TRUE;
                        EXIT;
                    END ELSE
                        Blocked := FALSE;
                END;
                VarProdLic.SETRANGE(VarProdLic."PL No.", "PL No.");
                VarProdLic.SETRANGE(VarProdLic."Stock Code", "Stock Code");
                IF VarProdLic.FINDFIRST THEN BEGIN
                    VarProdLic.Blocked := Blocked;
                    VarProdLic.MODIFY;
                END;
            end;
        }
        field(50002; Status; Option)
        {
            OptionCaption = ' ,OK,STOP,Not Granted';
            OptionMembers = " ",OK,STOP,"Not Granted";

            trigger OnValidate()
            begin
                //Chem-474++
                // CLEAR(PGLicLog);
                // PGLicLog.License("PL No.", "Stock Code");
                // PGLicLog.RUN;
                //Chem-474
            end;
        }
        field(50003; Approved; Boolean)
        {
        }
        field(50004; "Retail Price"; Decimal)
        {
            Editable = false;
        }
        field(50005; "Storage Location"; Option)
        {
            Description = 'CHEM-473';
            OptionCaption = ' ,Cold chain,CD,Ambient';
            OptionMembers = " ","Cold Chain",CD,Ambient;
        }
        field(50006; "Reminder Date"; Date)
        {
            Description = 'CHEM-474';
        }
        field(50007; "Qty On Purchase Order"; Decimal)
        {
            CalcFormula = Sum("Purchase Line"."Outstanding Quantity" WHERE("Document Type" = FILTER(Order),
                                                                            Type = FILTER(Item),
                                                                            "PL No." = FIELD("PL No."),
                                                                            "No." = FIELD("Stock Code")));
            Description = 'CHEM-487';
            FieldClass = FlowField;
        }
        field(50008; Open; Boolean)
        {
            CalcFormula = Exist("Variant Product license line" WHERE("PL No." = FIELD("PL No."),
                                                                      "Stock Code" = FIELD("Stock Code"),
                                                                      Status = FILTER(Certified)));
            Description = 'CHEM-487';
            FieldClass = FlowField;
        }
        field(50009; "Submited Date Variation"; Date)
        {
            Description = 'CHEM-474';
        }
        field(50010; "In Packs By Date"; Date)
        {
            Description = 'CHEM-474';
        }
        field(50011; "Tentative Grant Date"; Date)
        {
            Description = 'CHEM-474';
        }
        field(50012; "Submitted Date/Initial"; Date)
        {
            Description = 'CHEM-474';

            trigger OnValidate()
            begin
                //CHEM-474 +++
                IF "Submitted Date/Initial" <> 0D THEN BEGIN
                    "Tentative Grant Date" := CALCDATE('5M', "Submitted Date/Initial");
                END
                ELSE BEGIN
                    IF xRec."Submitted Date/Initial" <> 0D THEN BEGIN
                        "Tentative Grant Date" := 0D;
                    END;
                END;
                //CHEM-474 ---
            end;
        }
        field(50013; "License Position"; Option)
        {
            Description = 'Chem-474';
            OptionCaption = ' ,Initial,Active,Surrender';
            OptionMembers = " ",Initial,Active,Surrender;
        }
        field(50014; "Storage Condition"; Text[250])
        {
        }
        field(50015; "Status Of Updated PIL"; Option)
        {
            OptionCaption = ' ,In line with UK PIL, Not in line with UK PIL';
            OptionMembers = " ","In line with UK PIL"," Not in line with UK PIL";
        }
        field(50016; "UK PIL Revision date"; Date)
        {
        }
        field(50017; "Chem.PIL against UK PIL Date"; Date)
        {
        }
        field(50018; "UK PL No"; Code[30])
        {
        }
        field(50019; "UK MA Holder"; Text[250])
        {
        }
        field(50020; "Member State(s) Of Origin"; Text[250])
        {
        }
        field(50021; "Member State(s) Of Destination"; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "PL No.", "Stock Code")
        {
            Clustered = true;
        }
        key(Key2; "Stock Code")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "PL No.", "Stock Code", Country, "ECMA No.", "EU Trade")
        {
        }
    }

    trigger OnDelete()
    begin
        //==================================================================
        VarProdLic.RESET;
        VarProdLic.SETRANGE(VarProdLic."PL No.", "PL No.");
        VarProdLic.SETRANGE(VarProdLic."Stock Code", "Stock Code");
        IF VarProdLic.FINDFIRST THEN BEGIN
            VarProdLic.DELETEALL;
        END;
        //===================================================================
        Varapplication.RESET;
        Varapplication.SETRANGE(Varapplication."PL No.", "PL No.");
        Varapplication.SETRANGE(Varapplication."Stock code", "Stock Code");
        IF Varapplication.FINDFIRST THEN BEGIN
            Varapplication.DELETEALL;
        END;

        ProdStockonHold.RESET;
        ProdStockonHold.SETRANGE(ProdStockonHold."PL No.", "PL No.");
        ProdStockonHold.SETRANGE(ProdStockonHold."Stock Code", "Stock Code");
        IF ProdStockonHold.FINDFIRST THEN BEGIN
            ProdStockonHold.DELETEALL;
        END;
        //===================================================================
    end;

    trigger OnInsert()
    begin
        "Crated by" := USERID;
        "Created Date" := WORKDATE;
        "Created time" := TIME;
    end;

    trigger OnModify()
    begin

        "Last Date Modify" := WORKDATE;
        "Last Date Modify time" := TIME;
        "Last Modify By" := USERID;
    end;

    var
        Compinfo: Record 79;
        DefaultSetup: Record 50012;
        VarProdLic: Record 50010;
        Varapplication: Record 50009;
        ProdStockonHold: Record 50014;
        Text001: Label 'Do you want to Block Product License No. %1 ?';
        // Lienscescard: Page 50019;
        Text002: Label 'Do you want to Unblock Product License No. %1 ?';
        salesprice: Record 7002;
    // PGLicLog: Page 50079;

    procedure ProdlicLinesExist(): Boolean
    var
        ProdLicLineCard: Record 50010;
    begin
        ProdLicLineCard.RESET;
        ProdLicLineCard.SETRANGE(ProdLicLineCard."PL No.", "PL No.");
        ProdLicLineCard.SETRANGE(ProdLicLineCard."Stock Code", "Stock Code");
        EXIT(ProdLicLineCard.FINDFIRST);
    end;
}

