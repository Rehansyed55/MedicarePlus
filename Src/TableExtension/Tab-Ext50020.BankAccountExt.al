tableextension 50020 "Bank Account Ext" extends "Bank Account"
{
    fields
    {
        field(50000; "Default Bank For Print"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = '//Upgradation Nav13';
        }
    }
}
