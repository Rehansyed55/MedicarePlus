tableextension 50024 "Inventory Setup Ext" extends "Inventory Setup"
{
    fields
    {
        field(50000; "Inward Gate Entry Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'Add by rajesh for Gate Entry //Upgradation Nav13';
            TableRelation = "No. Series";
        }
        field(50001; "Outward Gate Entry Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'Add by rajesh for Gate Entry //Upgradation Nav13';
            TableRelation = "No. Series";
        }
    }
}
