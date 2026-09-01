table 50003 "Posted Gate Entry Header 1"
{
    Caption = 'Posted Gate Entry Header';
    // LookupPageID = 50002;

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
        }
        field(5; "Document Time"; Time)
        {
            Caption = 'Document Time';
        }
        field(7; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location;
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
            CalcFormula = Exist("Gate Entry Comment Line1" WHERE("Gate Entry Type" = FIELD("Entry Type"),
                                                                  "No." = FIELD("No.")));
            Caption = 'Comment';
            FieldClass = FlowField;
        }
        field(17; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(18; "Posting Time"; Time)
        {
            Caption = 'Posting Time';
        }
        field(19; "Gate Entry No."; Code[20])
        {
            Caption = 'Gate Entry No.';
        }
        field(20; "User ID"; Code[50])
        {
            Caption = 'User ID';
            TableRelation = User;
        }
        field(21; Zone; Code[20])
        {
            TableRelation = Zone.Code WHERE("Location Code" = FIELD("Location Code"));
        }
        field(22; "Carrier/Courier"; Text[100])
        {
        }
        field(23; "Supplier Code"; Code[20])
        {
            Caption = 'Supplier Code';
            TableRelation = Vendor;
        }
        field(24; "Supplier Name"; Text[50])
        {
        }
        field(50118; "Bin Code"; Code[20])
        {
            TableRelation = Bin.Code where(
        "Location Code" = field("Location Code")
    );
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
}

