table 50028 "Bin Search"
{

    fields
    {
        field(1; "Bin Code"; Code[30])
        {
        }
        field(2; "User ID"; Code[100])
        {
        }
        field(3; "Item No"; Code[30])
        {
        }
        field(4; Quantity; Decimal)
        {
        }
        field(5; "Line No"; Integer)
        {
        }
        field(6; "Variant Code"; Code[10])
        {
        }
        field(7; "unit Of Measure Code"; Code[10])
        {
        }
        field(8; "Lot No."; Code[30])
        {
        }
    }

    keys
    {
        key(Key1; "User ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

