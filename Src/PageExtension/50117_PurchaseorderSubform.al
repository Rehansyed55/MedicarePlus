pageextension 50117 "Purchase Order Subform Ext" extends "Purchase Order Subform"
{
    layout
    {
        // Add changes to page layout here
        addafter("Bin Code")
        {
            field("Release Prod. Order No."; Rec."Prod. Order No.")
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