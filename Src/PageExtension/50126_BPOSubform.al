pageextension 50126 BPOSubformExt extends "Blanket Purchase Order Subform"
{
    layout
    {
        modify("VAT Prod. Posting Group")
        {
            applicationArea = all;
            visible = true;
        }
        addafter("Line Amount")
        {
            field("Qty. on Blanket Order(Actual)"; Rec."Qty. on Blanket Order(Actual)")
            {
                ApplicationArea = all;
                visible = true;
            }
            field("PDN Quantity"; Rec."PDN Quantity")
            {
                ApplicationArea = all;
                caption = 'QTY DELIVERED';
                visible = true;
            }
            field("Outstanding Quantity"; Rec."Outstanding Quantity")
            {
                ApplicationArea = all;
                visible = true;
            }
            field("Blanket Order No."; Rec."Blanket Order No.")
            {
                ApplicationArea = all;
                visible = true;
            }
        }
        addfirst(Control1)
        {
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = all;
                visible = true;
            }
            field("Order Date"; Rec."Order Date")
            {
                ApplicationArea = all;
                visible = true;
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