table 50080 "ILE-WE"
{

    fields
    {
        field(10; "Entry No."; Integer)
        {
        }
        field(20; "Item No."; Code[20])
        {
        }
        field(30; "Lot No."; Code[20])
        {
        }
        field(40; "ILE Expiration Date"; Date)
        {
        }
        field(50; "WE Expiration Date"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

