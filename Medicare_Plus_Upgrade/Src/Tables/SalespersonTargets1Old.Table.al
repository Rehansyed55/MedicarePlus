table 50051 "Salesperson-Targets1_Old"
{

    fields
    {
        field(1; "Salesperson code"; Code[30])
        {
            TableRelation = "Salesperson/Purchaser";

            trigger OnValidate()
            begin
                "Serial no." := FORMAT(TODAY, 0, '<Day,2><Month,2><Year,2>')
                              + FORMAT(TIME, 0, '<Hours24><Minutes,2><Seconds,2>');
            end;
        }
        field(2; "Start date"; Date)
        {
        }
        field(3; "End date"; Date)
        {
        }
        field(4; "Target Amount"; Decimal)
        {
        }
        field(5; "Gross Profit %"; Decimal)
        {
        }
        field(6; "Serial no."; Code[50])
        {
        }
        field(7; "Total Working day"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Serial no.", "Salesperson code")
        {
            Clustered = true;
        }
        key(Key2; "Salesperson code")
        {
        }
    }

    fieldgroups
    {
    }
}

