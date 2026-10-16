pageextension 50129 ProdOrdRoutingExt extends "Prod. Order Routing"
{
    layout
    {

        modify("Unit Cost per")
        {
            ApplicationArea = all;
            Caption = 'Unit Cost per';
            visible = true;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}