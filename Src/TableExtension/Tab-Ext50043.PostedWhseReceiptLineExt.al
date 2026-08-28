tableextension 50043 "Posted Whse. Receipt Line Ext" extends "Posted Whse. Receipt Line"
{
    fields
    {
        field(50001; "Foreign Name"; Code[100])
        {
            DataClassification = ToBeClassified;
            Description = 'Upgrade frm Nav5';
        }
        field(50004; Subcontracting; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = '//kd - added field for subcontracting';
        }
    }
}
