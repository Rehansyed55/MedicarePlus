table 50052 "IMS Data1_Old"
{

    fields
    {
        field(1; "IMS Code"; Code[220])
        {
        }
        field(3; Type; Option)
        {
            OptionCaption = 'Generic,Branded';
            OptionMembers = Generic,Branded;
        }
        field(4; Month1; Decimal)
        {
        }
        field(5; Month2; Decimal)
        {
        }
        field(6; Month3; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "IMS Code", Type)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

