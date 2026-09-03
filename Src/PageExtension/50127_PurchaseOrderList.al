pageextension 50127 POListExt extends "Purchase Order List"
{
    layout
    {
        modify("Your Reference")
        {
            applicationArea = all;
            visible = true;

        }
        moveafter("No."; "Your Reference")
        addafter("Your Reference")
        {
            field("Expected Receipt Date"; Rec."Expected Receipt Date")
            {
                ApplicationArea = all;
            }
            field("Forwarder Name"; Rec."Forwarder Name")
            {
                ApplicationArea = all;
            }
            field("WhseRcptHeader No."; Rec."WhseRcptHeader No.")
            {
                ApplicationArea = all;
                caption = 'Warehouse Receipt Header No.';
            }
        }
        modify("Document Date")
        {
            applicationArea = all;
            visible = true;
        }
        addbefore("Document Date")
        {
            field("Order Date"; Rec."Order Date")
            {
                ApplicationArea = all;
            }
        }
        modify(Status)
        {
            applicationArea = all;
            visible = true;
        }
        addbefore(Status)
        {
            field("Vendor Invoice No."; Rec."Vendor Invoice No.")
            {
                ApplicationArea = all;
            }
        }
        modify(Amount)
        {
            applicationArea = all;
            visible = true;
        }
        moveafter(Status; Amount)
        modify("Buy-from Vendor No.")
        {
            applicationArea = all;
            visible = true;
        }
        moveafter(Amount; "Buy-from Vendor No.")
        modify("Buy-from Vendor Name")
        {
            applicationArea = all;
            visible = true;
        }
        moveafter("Buy-from Vendor No."; "Buy-from Vendor Name")
        modify("Location Code")
        {
            visible = false;
        }
        modify("Assigned User ID")
        {
            visible = false;
        }
        modify("Amount Including VAT")
        {
            visible = false;
        }
        modify("Vendor Authorization No.")
        {
            visible = false;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}
