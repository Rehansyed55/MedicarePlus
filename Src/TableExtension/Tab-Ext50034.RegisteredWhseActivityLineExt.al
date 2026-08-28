tableextension 50034 "RegisteredWhseActivityLine Ext" extends "Registered Whse. Activity Line"
{
    fields
    {
        field(50000; Barcode; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Upgrade frm Nav5';
        }
        field(50005; "Put away Ceated From"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'Upgrade frm Nav5';
            OptionCaption = ',For Component,From FIrm Plan,From Prod. jnl,From Release';
            OptionMembers = ,"For Component","From FIrm Plan","From Prod. jnl","From Release";
        }
        field(50006; "Scan Time"; Time)
        {
            DataClassification = ToBeClassified;
            Description = 'Upgrade frm Nav5';
        }
    }
}
