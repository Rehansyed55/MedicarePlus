table 50024 "Bin creation"
{

    fields
    {
        field(1; "Bin code"; Code[10])
        {
        }
        field(2; "Bin Description"; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Bin code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

