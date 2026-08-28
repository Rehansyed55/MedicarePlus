table 50011 "Application Activity Type"
{
    // DrillDownPageID = 50022;
    // LookupPageID = 50022;

    fields
    {
        field(10; "Activity Type"; Option)
        {
            OptionCaption = 'Application,Variant Application,TM Samples';
            OptionMembers = Application,"Variant Application","TM Samples";
        }
        field(11; Activity; Code[100])
        {
        }
        field(12; "sorting ID"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Activity Type", Activity)
        {
            Clustered = true;
        }
        key(Key2; "sorting ID")
        {
        }
    }

    fieldgroups
    {
    }
}

