table 50030 "Web Customer Contact"
{

    fields
    {
        field(1; "No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; Name; Text[100])
        {
        }
        field(3; Address; Text[150])
        {
        }
        field(4; Address2; Text[150])
        {
        }
        field(5; City; Text[50])
        {
        }
        field(6; "Phone No."; Text[50])
        {
        }
        field(7; "Post Code"; Code[50])
        {
        }
        field(8; "Country/Region Code"; Code[50])
        {
        }
        field(9; "E-Mail"; Text[80])
        {
        }
        field(10; "Company No."; Code[20])
        {
        }
        field(11; "Company Name"; Text[150])
        {
        }
        field(12; "Contact Status"; Option)
        {
            OptionCaption = 'Not Approved,Approved';
            OptionMembers = "Not Approved",Approved;
        }
        field(13; Password; Text[50])
        {
        }
        field(14; "Ship Code"; Code[50])
        {
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

