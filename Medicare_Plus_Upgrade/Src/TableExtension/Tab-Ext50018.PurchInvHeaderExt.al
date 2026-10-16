tableextension 50018 "Purch. Inv. Header Ext" extends "Purch. Inv. Header"
{
    fields
    {
        field(50000; "WhseRcptHeader No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = '//Upgradation Nav13';
        }
        field(50001; "Freight Company"; Text[100])
        {
            DataClassification = ToBeClassified;
            Description = '//Upgradation Nav13';
        }
        field(50100; "Technical Agreement No."; Code[50])
        {
            Caption = 'Technical Agreement No.';
        }
    }
}
