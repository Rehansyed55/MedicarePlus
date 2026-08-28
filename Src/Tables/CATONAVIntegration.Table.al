table 50109 "CATO NAV Integration"
{

    fields
    {
        field(1; "CATO Medication ID"; Code[20])
        {
        }
        field(2; "NAV Order No."; Code[20])
        {
        }
        field(3; "Customer No."; Code[20])
        {
        }
        field(4; "Prod Date and Time"; DateTime)
        {
        }
        field(5; UID; Code[20])
        {
            Description = 'Item Number';
        }
        field(6; "Batch No."; Code[20])
        {
        }
        field(7; Quantity; Decimal)
        {
        }
        field(8; Status; Option)
        {
            OptionCaption = 'New,Consumed';
            OptionMembers = New,Consumed;
        }
    }

    keys
    {
        key(Key1; "CATO Medication ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

