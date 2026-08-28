tableextension 50046 "Miniform Header Ext" extends "Miniform Header"
{
    fields
    {
        field(50000; "Previous Minform"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = '//ADCS';
            TableRelation = "Miniform Header";
        }
    }
    var
}