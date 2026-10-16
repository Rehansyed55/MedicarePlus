table 50009 "Application Lic. Detail"
{

    fields
    {
        field(10; "PL No."; Code[20])
        {
            TableRelation = "Product License"."PL No.";
        }
        field(11; "Stock code"; Code[20])
        {
            Caption = 'Stock Code';
        }
        field(12; "Line No."; Integer)
        {
        }
        field(19; "Activity Type"; Option)
        {
            OptionCaption = 'Application,Variant Application,TM Samples';
            OptionMembers = Application,"Variant Application","TM Samples";
        }
        field(20; Activity; Code[100])
        {
            TableRelation = "Application Activity Type".Activity WHERE("Activity Type" = FIELD("Activity Type"));
        }
        field(30; "Activity Date"; Date)
        {
        }
        field(40; "ECMA No."; Code[50])
        {
        }
        field(90; Comments; Text[250])
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
            Description = '// changed length from 23 to 50';
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
        field(153; "Version No."; Code[20])
        {
        }
        field(154; Assessor; Code[20])
        {
        }
        field(156; "ATS Code"; Code[20])
        {
        }
        field(157; "CD/TS"; Code[20])
        {
        }
        field(159; Fees; Decimal)
        {
        }
        field(160; "TM Company"; Code[20])
        {
        }
        field(161; "Record Delivery Number"; Code[20])
        {
        }
        field(162; "Brand Name/Generic Name"; Code[50])
        {
        }
        field(163; "Rebox Likely"; Boolean)
        {
        }
        field(164; "Invoice No."; Code[20])
        {
        }
        field(165; Reason; Text[50])
        {
        }
        field(50000; "Pack Size"; Code[30])
        {
            Description = 'CHEM-473';
        }
        field(50001; "Batch No"; Code[30])
        {
            Description = 'CHEM-473';
        }
        field(50002; "Member State Of Origin"; Code[30])
        {
            Description = 'CHEM-473';
        }
        field(50003; "Sample Dispatch Date"; Date)
        {
            Description = 'CHEM-473';

            trigger OnValidate()
            begin
                //Chem-473
                IF "Sample Dispatch Date" <> 0D THEN
                    "Dispatched By" := USERID;
                //Chem-473
            end;
        }
        field(50004; "Reply Due Date"; Date)
        {
            Description = 'CHEM-473';
        }
        field(50005; "TM time finished"; Date)
        {
            Description = 'CHEM-473';
        }
        field(50006; "Approval Pending"; Boolean)
        {
            Description = 'CHEM-473';
        }
        field(50007; "MHRA Status"; Option)
        {
            Description = 'CHEM-473';
            OptionCaption = ' ,VALIDATE,ASSESMENT,RFI';
            OptionMembers = " ",VALIDATE,ASSESMENT,RFI;
        }
        field(50008; "Receipt Of Submission Date"; Date)
        {
            Description = 'CHEM-473';

            trigger OnValidate()
            begin
                IF "Receipt Of Submission Date" <> 0D THEN BEGIN
                    "Tentative grant date" := CALCDATE('3M', "Receipt Of Submission Date");
                END
                ELSE BEGIN
                    IF xRec."Receipt Of Submission Date" <> 0D THEN BEGIN
                        xRec."Tentative grant date" := 0D;
                    END;
                END;
            end;
        }
        field(50009; "Tentative grant date"; Date)
        {
            Description = 'CHEM-473';
        }
        field(50010; "Granted Date"; Date)
        {
            Description = 'CHEM-473';
        }
        field(50011; "In Packs By Date"; Date)
        {
            Description = 'CHEM-473';
        }
        field(50012; "Variation Status"; Option)
        {
            Description = 'CHEM-473';
            OptionCaption = ' ,OK,STOP';
            OptionMembers = " ",OK,STOP;
        }
        field(50013; "RFI Date Of Receipt"; Date)
        {
            Description = 'CHEM-473';
        }
        field(50014; "RFeI Last Date to submit"; Date)
        {
            Description = 'CHEM-473';
        }
        field(50015; "RFI Date Of Submission"; Date)
        {
            Description = 'CHEM-473';

            trigger OnValidate()
            begin
                //Chem-473
                IF "RFI Date Of Submission" <> 0D THEN
                    "RFI Submitted By" := USERID;
                //Chem-473
            end;
        }
        field(50016; "RFI Submitted By"; Code[50])
        {
            Description = 'CHEM-473';
        }
        field(50017; "Dispatched By"; Code[50])
        {
        }
    }

    keys
    {
        key(Key1; "PL No.", "Stock code", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        "Crated by" := USERID;
        "Created Date" := WORKDATE;
        "Created time" := TIME;
        RecAppLicDet.SETRANGE(RecAppLicDet."PL No.", "PL No.");
        RecAppLicDet.SETRANGE(RecAppLicDet."Stock code", "Stock code");
        IF RecAppLicDet.FINDLAST THEN
            "Line No." := RecAppLicDet."Line No." + 10000;
    end;

    trigger OnModify()
    begin

        "Last Date Modify" := WORKDATE;
        "Last Date Modify time" := TIME;
        "Last Modify By" := USERID;
    end;

    var
        ProdLicHeader: Record 50008;
        RecAppLicDet: Record 50009;
}

