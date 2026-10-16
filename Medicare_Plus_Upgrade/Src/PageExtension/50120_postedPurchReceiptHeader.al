pageextension 50120 "Posted Purchase Receipt Ext" extends "Posted Purchase Receipt"
{
    layout
    {
        // Add changes to page layout here
        addafter("Vendor Shipment No.")
        {
            field("Technical Agreement No."; Rec."Technical Agreement No.")
            {
                ApplicationArea = all;
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