table 60000 TestDataMigration
{

    fields
    {
        field(1; No; Integer)
        {
        }
        field(2; Name; Code[30])
        {
        }
        field(3; Address; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

