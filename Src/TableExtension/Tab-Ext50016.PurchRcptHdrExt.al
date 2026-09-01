tableextension 50016 "Purch. Rcpt. Hdr Ext" extends "Purch. Rcpt. Header"
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
        field(50003; "Posted Whse Rcp Header"; Code[20])
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
