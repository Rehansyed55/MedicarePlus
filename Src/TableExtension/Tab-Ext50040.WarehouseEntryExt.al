tableextension 50040 "Warehouse Entry Ext" extends "Warehouse Entry"
{
    fields
    {
        field(50001; "Posting Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {

        key(Key15; "Location Code")
        {
            MaintainSIFTIndex = false;
            MaintainSQLIndex = false;
            SumIndexFields = "Qty. (Base)";
        }
        key(Key14; "Item No.", "Lot No.")
        {
        }
        key(Key10; "Location Code", "Bin Code", "Item No.", "Zone Code")
        {
            SumIndexFields = Quantity;
        }
        key(Key11; "Bin Code", "Lot No.")
        {
        }
        key(Key12; "Item No.", "Source No.", "Source Document")
        {
        }
        key(Key13; "Location Code", "Bin Code", Description)
        {
        }
    }
}
