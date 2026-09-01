table 50000 "Gate Entry Header 1"
{
    Caption = 'Gate Entry Header';
    // LookupPageID = 50011;

    fields
    {
        field(1; "Entry Type"; Option)
        {
            Caption = 'Entry Type';
            OptionCaption = 'Inward,Outward';
            OptionMembers = Inward,Outward;
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(3; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(4; "Document Date"; Date)
        {
            Caption = 'Document Date';

            trigger OnValidate()
            begin
                "Posting Date" := "Document Date";
            end;
        }
        field(5; "Document Time"; Time)
        {
            Caption = 'Document Time';

            trigger OnValidate()
            begin
                "Posting Time" := "Document Time";
            end;
        }
        field(7; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location;

            trigger OnValidate()
            begin
                CASE "Entry Type" OF
                    "Entry Type"::Inward:
                        IF GateEntryLocSetup.GET("Entry Type", "Location Code") THEN
                            IF ("No. Series" <> '') AND (InventSetup."Inward Gate Entry Nos." = GateEntryLocSetup."Posting No. Series") THEN
                                "Posting No. Series" := "No. Series"
                            ELSE
                                SetDefaultSeries("Posting No. Series", GateEntryLocSetup."Posting No. Series");
                    "Entry Type"::Outward:
                        IF GateEntryLocSetup.GET("Entry Type", "Location Code") THEN
                            IF ("No. Series" <> '') AND (InventSetup."Inward Gate Entry Nos." = GateEntryLocSetup."Posting No. Series") THEN
                                "Posting No. Series" := "No. Series"
                            ELSE
                                SetDefaultSeries("Posting No. Series", GateEntryLocSetup."Posting No. Series");
                END;
            end;
        }
        field(8; Description; Text[120])
        {
            Caption = 'Description';
        }
        field(9; "Item Description"; Text[120])
        {
            Caption = 'Item Description';
        }
        field(10; "LR/RR No."; Code[20])
        {
            Caption = 'LR/RR No.';
        }
        field(11; "LR/RR Date"; Date)
        {
            Caption = 'LR/RR Date';
        }
        field(12; "Vehicle No."; Code[20])
        {
            Caption = 'Vehicle No.';
        }
        field(13; "Station From/To"; Code[20])
        {
            Caption = 'Station From/To';
        }
        field(15; Comment; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Exist("Gate Entry Comment Line1" WHERE("Gate Entry Type" = FIELD("Entry Type"),
                                                                  "No." = FIELD("No.")));
            Caption = 'Comment';
        }
        field(16; "Posting No. Series"; Code[20])
        {
            Caption = 'Posting No. Series';
            TableRelation = "No. Series";
        }
        field(17; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(18; "Posting Time"; Time)
        {
            Caption = 'Posting Time';
        }
        field(19; "Posting No."; Code[20])
        {
            Caption = 'Posting No.';
        }
        field(20; "User ID"; Code[50])
        {
            Caption = 'User ID';
            TableRelation = User;
        }
        field(21; "Bin Code"; Code[50])
        {
            Caption = 'Bin Code';
            TableRelation = Bin.Code WHERE("Location Code" = FIELD("Location Code"));
        }
        field(22; "Carrier/Courier"; Text[100])
        {
        }
        field(23; "Supplier Code"; Code[20])
        {
            TableRelation = Vendor;

            trigger OnValidate()
            begin
                Vendor.RESET;
                Vendor.GET("Supplier Code");
                "Supplier Name" := Vendor.Name;
            end;
        }
        field(24; "Supplier Name"; Text[50])
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Entry Type", "No.")
        {
            Clustered = true;
        }
        key(Key2; "Location Code", "Posting Date", "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        GateEntryLine.RESET;
        GateEntryLine.SETRANGE("Entry Type", "Entry Type");
        GateEntryLine.SETRANGE("Gate Entry No.", "No.");
        GateEntryLine.DELETEALL;

        GateEntryCommentLine.SETRANGE("Gate Entry Type", "Entry Type");
        GateEntryCommentLine.SETRANGE("No.", "No.");
        GateEntryCommentLine.DELETEALL;
    end;

    trigger OnInsert()
    begin
        "Document Date" := WORKDATE;
        "Document Time" := TIME;
        "Posting Date" := WORKDATE;
        "Posting Time" := TIME;
        "User ID" := USERID;
        InventSetup.GET;

        CASE "Entry Type" OF
            "Entry Type"::Inward:
                IF "No." = '' THEN BEGIN
                    InventSetup.TESTFIELD(InventSetup."Inward Gate Entry Nos.");

                    if NoSeries.AreRelated("No. Series", xRec."No. Series") then
                        "No. Series" := xRec."No. Series";
                    "No." := NoSeries.GetNextNo("No. Series", WorkDate());
                END;
            "Entry Type"::Outward:
                IF "No." = '' THEN BEGIN
                    InventSetup.TESTFIELD(InventSetup."Outward Gate Entry Nos.");
                    if NoSeries.AreRelated("No. Series", xRec."No. Series") then
                        "No. Series" := xRec."No. Series";
                    "No." := NoSeries.GetNextNo("No. Series", WorkDate());
                END;
        END;

        //Add by hiren
        IF DefaultSetup.GET() THEN BEGIN
            VALIDATE("Location Code", DefaultSetup."Gate Inward Location");
            VALIDATE("Bin Code", DefaultSetup."Gate Inward Bin");
        END;

        "Posting No." := "No.";//anikEt
    end;

    var
        GateEntryLine: Record 50001;
        InventSetup: Record 313;
        GateEntryLocSetup: Record 50002;
        GateEntryCommentLine: Record 50007;
        NoSeries: codeunit "No. Series";
        DefaultSetup: Record 50012;
        Vendor: Record 23;
        GlobalNoSeries: Record "No. Series";

    procedure AssistEdit(OldGateEntryHeader: Record 50000): Boolean
    begin
        InventSetup.GET;
        CASE "Entry Type" OF
            "Entry Type"::Inward:
                BEGIN
                    InventSetup.TESTFIELD("Inward Gate Entry Nos.");
                    IF NoSeries.LookupRelatedNoSeries(InventSetup."Inward Gate Entry Nos.", OldGateEntryHeader."No. Series", "No. Series") THEN BEGIN
                        InventSetup.GET;
                        InventSetup.TESTFIELD("Inward Gate Entry Nos.");
                        "No." := NoSeries.GetNextNo("No. Series", WorkDate());
                        EXIT(TRUE);
                    END;
                END;
            "Entry Type"::Outward:
                BEGIN
                    InventSetup.TESTFIELD("Outward Gate Entry Nos.");
                    IF NoSeries.LookupRelatedNoSeries(InventSetup."Outward Gate Entry Nos.", OldGateEntryHeader."No. Series", "No. Series") THEN BEGIN
                        InventSetup.GET;
                        InventSetup.TESTFIELD("Outward Gate Entry Nos.");
                        "No." := NoSeries.GetNextNo("No. Series", WorkDate());
                        EXIT(TRUE);
                    END;
                END;
        END;
    end;

    local procedure SetDefaultSeries(var NewNoSeriesCode: Code[20]; NoSeriesCode: Code[20])
    var
        myInt: Integer;
    begin
        if NoSeriesCode <> '' then begin
            GlobalNoSeries.Get(NoSeriesCode);
            if GlobalNoSeries."Default Nos." then
                NewNoSeriesCode := GlobalNoSeries.Code;
        end;

    end;
}

