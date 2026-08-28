table 50036 "Drug License-Line"
{
    // Case ID : CAS-02139-C3D4Q0
    // Author  : Alok Kulshreshtha
    // Date    : 06/06/2016
    // Description : Field "Warning type" added which will use to define how system will work with license
    // ****************************************************************************************************


    fields
    {
        field(1; "Company No"; Code[20])
        {
        }
        field(2; "License No"; Text[100])
        {
        }
        field(3; Type; Option)
        {
            OptionCaption = ' ,Legal Status,Controlled Drug';
            OptionMembers = " ","Legal Status","Controlled Drug";

            trigger OnValidate()
            begin
                CLEAR("Class Type");
            end;
        }
        field(6; "Line no"; Integer)
        {
            AutoIncrement = true;
        }
        field(7; "Class Type"; Code[20])
        {
            TableRelation = IF (Type = CONST("Legal Status")) "Dimension Value".Code WHERE("Dimension Code" = CONST('GENRAL DRUG'))
            ELSE IF (Type = CONST("Controlled Drug")) "Dimension Value".Code WHERE("Dimension Code" = CONST('CONTROLLED DRUG'));
        }
        field(8; Name; Text[50])
        {
        }
        field(9; "Company Type"; Option)
        {
            OptionCaption = ' ,Customer,Supplier';
            OptionMembers = " ",Customer,Supplier;
        }
        field(10; "Grant Date"; Date)
        {
            CalcFormula = Lookup("Drug License-Header"."Grant Date" WHERE("License No" = FIELD("License No"),
                                                                           "Company No" = FIELD("Company No"),
                                                                           "Company Type" = FIELD("Company Type")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(11; "Expiry Date"; Date)
        {
            CalcFormula = Lookup("Drug License-Header"."Expiry Date" WHERE("License No" = FIELD("License No"),
                                                                            "Company Type" = FIELD("Company Type"),
                                                                            "Company No" = FIELD("Company No")));
            FieldClass = FlowField;
        }
        field(12; "Post Code"; Code[20])
        {
            CalcFormula = Lookup("Drug License-Header"."Post Code" WHERE("License No" = FIELD("License No"),
                                                                          "Company Type" = FIELD("Company Type"),
                                                                          "Company No" = FIELD("Company No")));
            FieldClass = FlowField;
        }
        field(13; "License Notification Type"; Option)
        {
            CalcFormula = Lookup("Drug License-Header"."License Notification Type" WHERE("License No" = FIELD("License No"),
                                                                                          "Company Type" = FIELD("Company Type"),
                                                                                          "Company No" = FIELD("Company No")));
            Caption = 'License Category';
            Description = 'CAS-05452-Z2R2X7';
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = 'Error,Warning';
            OptionMembers = Error,Warning;
        }
        field(14; "License Status"; Option)
        {
            CalcFormula = Lookup("Drug License-Header"."License Status" WHERE("License No" = FIELD("License No"),
                                                                               "Company Type" = FIELD("Company Type"),
                                                                               "Company No" = FIELD("Company No")));
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = 'Open,Released';
            OptionMembers = Open,Released;
        }
    }

    keys
    {
        key(Key1; "License No", "Company Type", "Company No", "Line no")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnRename()
    begin
        ERROR(Text003, TABLECAPTION);//alok for bug fix
    end;

    var
        RecLicenseHeader: Record 50035;
        Text003: Label 'You cannot rename a %1.';
}

