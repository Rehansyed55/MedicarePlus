tableextension 50002 "Salesperson/Purchaser Ext" extends "Salesperson/Purchaser"
{
    fields
    {
        field(50000; "Target Account"; Integer)
        {
            DataClassification = ToBeClassified;
            Description = '//Parag 07/05/2014 for Sales Person Wise Dashboard Report';
        }
        field(50001; "Target Sales"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = '//Parag 07/05/2014 for Sales Person Wise Dashboard Report';
        }
        field(50002; "Target Margin"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = '//Parag 07/05/2014 for Sales Person Wise Dashboard Report';
        }
    }
}
