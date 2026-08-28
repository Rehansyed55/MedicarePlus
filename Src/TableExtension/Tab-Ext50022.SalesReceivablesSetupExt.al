tableextension 50022 "Sales & Receivables Setup Ext" extends "Sales & Receivables Setup"
{
    fields
    {

        field(50001; "Validate Country Rel.with Item"; Boolean)
        {
            Caption = 'Validate Country Rel.with Item';
            DataClassification = ToBeClassified;
        }
        field(50011; "Enable WDA License"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "WDA License Notification"; Option)
        {
            Caption = 'WDA License Notification';
            DataClassification = ToBeClassified;
            OptionCaption = 'Error,Warning';
            OptionMembers = Error,Warning;
        }
    }
}
