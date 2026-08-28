table 50017 "IMS item relation1"
{

    fields
    {
        field(1; "IMS Code"; Code[220])
        {
        }
        field(2; "Item Code"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "IMS Code", "Item Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Imsdata: Record 50022;
}

