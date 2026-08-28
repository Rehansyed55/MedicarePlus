tableextension 50031 "Item Category Ext" extends "Item Category"
{
    fields
    {
        field(50001; "Barcode Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'Upgrade frm Nav5';
            OptionCaption = ' ,Bin Code,Item Code';
            OptionMembers = " ","Bin Code","Item Code","Batch No.";
        }
        field(50002; "Selling Price"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'B2B';
            TableRelation = "Customer Price Group".Code WHERE(Web = FILTER(true));
        }
        field(50003; "Trading Price"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'B2B';
            TableRelation = "Customer Price Group".Code WHERE(Web = FILTER(true));
        }
        field(50004; "Display On B2B"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'B2B';
        }
    }
}
