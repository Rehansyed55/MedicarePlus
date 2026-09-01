pageextension 50119 "PostedPurch.Inv Subform_Ext" extends "Posted Purch. Invoice Subform"
{
    layout
    {
        // Add changes to page layout here
        addafter("Deferral Code")
        {
            field("Prod. Order No."; Rec."Prod. Order No.")
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
        myInt: page "Subcontracting Worksheet";

}