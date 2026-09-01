pageextension 50118 "Posted Purchase Invoice Ext" extends "Posted Purchase Invoice"
{
    layout
    {
        // Add changes to page layout here
        addafter("Vendor Order No.")
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