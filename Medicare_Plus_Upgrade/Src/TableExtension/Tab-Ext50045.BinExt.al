tableextension 50045 "Bin Ext" extends Bin
{
    fields
    {
        field(50000; "Warehouse Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = '//Upgradation Nav13';
        }
        field(50001; "Print Bin"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = '//Upgradation Nav13';
        }
    }
}