tableextension 50023 "Purchases & Payables Setup Ext" extends "Purchases & Payables Setup"
{
    fields
    {
        field(50000; "License Notification Type"; Option)
        {
            Caption = 'License Category';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Error,Warning';
            OptionMembers = " ",Error,Warning;
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
