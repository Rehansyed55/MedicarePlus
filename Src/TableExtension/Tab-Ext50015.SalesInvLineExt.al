tableextension 50015 "Sales Inv. Line Ext" extends "Sales Invoice Line"
{
    fields
    {
        field(50000; "Sales Original Qty"; Decimal)
        {
            Description = '//Upgradation Nav13';
        }
    }
}
