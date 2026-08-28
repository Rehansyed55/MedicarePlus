table 50019 "Production Order Detail"
{

    fields
    {
        field(1; "Production Order No."; Code[20])
        {
        }
        field(2; "Batch no"; Code[30])
        {
        }
        field(3; "Expire Date"; Date)
        {
        }
        field(4; "ECMA No."; Code[50])
        {
        }
        field(5; Quantity; Decimal)
        {
        }
        field(6; "Serial no"; Code[50])
        {
        }
    }

    keys
    {
        key(Key1; "Production Order No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

