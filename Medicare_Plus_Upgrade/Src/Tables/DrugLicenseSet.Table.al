table 50037 "Drug License-Set"
{
    // Case ID : CAS-02139-C3D4Q0
    // Author  : Alok Kulshreshtha
    // Date    : 06/06/2016
    // Description : Field "Warning type" added which will use to define how system will work with license
    // ****************************************************************************************************


    fields
    {
        field(1; "Company Type"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('COMPANY TYPE'));
        }
        field(2; Type; Option)
        {
            Caption = 'License Name';
            OptionCaption = ' ,Legal Status,Controlled Drug';
            OptionMembers = " ","Legal Status","Controlled Drug";

            trigger OnValidate()
            begin
                CLEAR(Class);
            end;
        }
        field(3; Class; Code[20])
        {
            TableRelation = IF (Type = FILTER("Controlled Drug")) "Dimension Value".Code WHERE("Dimension Code" = FILTER('CONTROLLED DRUG'))
            ELSE IF (Type = FILTER("Legal Status")) "Dimension Value".Code WHERE("Dimension Code" = FILTER('GENRAL DRUG'));
        }
        field(4; "Class Description"; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; "Company Type", Type, Class)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

