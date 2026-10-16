pageextension 50121 InventorySetup extends "Inventory Setup"
{
    layout
    {
        // Add changes to page layout here
        addafter("Inbound Whse. Handling Time")
        {
            field("Inward Gate Entry Nos."; Rec."Inward Gate Entry Nos.")
            {
                ApplicationArea = all;
                TableRelation = "No. Series";
            }
            field("Outward Gate Entry Nos."; Rec."Outward Gate Entry Nos.")
            {
                ApplicationArea = all;
                TableRelation = "No. Series";
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}