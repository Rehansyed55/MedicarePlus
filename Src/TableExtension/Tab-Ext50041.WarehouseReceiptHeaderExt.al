tableextension 50041 "Warehouse Receipt Header Ext" extends "Warehouse Receipt Header"
{
    fields
    {
        field(50001; "Select All"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Upgrade frm Nav5';
        }
        field(50002; "Gate Entry No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Upgrade frm Nav5';
        }
    }
}
