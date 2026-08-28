table 50076 "Web Customer Contact_Old"
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
        field(3; Address; Text[50])
        {
        }
        field(4; Address2; Text[50])
        {
        }
        field(5; City; Text[30])
        {
        }
        field(6; "Phone No."; Text[30])
        {
        }
        field(7; "Post Code"; Code[10])
        {
        }
        field(8; "Country/Region Code"; Code[10])
        {
        }
        field(9; "E-Mail"; Text[80])
        {
        }
        field(10; "Company No."; Code[10])
        {
        }
        field(11; "Company Name"; Text[100])
        {
        }
        field(12; "Contact Status"; Option)
        {
            OptionCaption = 'Not Approved,Approved';
            OptionMembers = "Not Approved",Approved;
        }
        field(13; Password; Text[20])
        {
        }
        field(14; "Ship Code"; Code[10])
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

