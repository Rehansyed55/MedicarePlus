pageextension 50128 BlanketPOListExt extends "Blanket Purchase Orders"
{
    layout
    {
        addafter("No.")
        {
            field("Your Reference"; Rec."Your Reference")
            {
                ApplicationArea = all;
            }
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
        addafter(Status)
        {
            field("Document Date"; Rec."Document Date")
            {
                ApplicationArea = all;
            }
            field("Vendor Invoice No."; Rec."Vendor Invoice No.")
            {
                ApplicationArea = all;
            }
            field(Amount; Rec.Amount)
            {
                ApplicationArea = all;
            }
        }
        modify("Buy-from Vendor No.")
        {
            applicationArea = all;
            visible = true;
        }
        modify("Buy-from Vendor Name")
        {
            applicationArea = all;
            visible = true;
        }
        moveafter("Buy-from Vendor No."; "Buy-from Vendor Name")
        modify("Vendor Authorization No.")
        {
            visible = false;
        }
        modify("Location Code")
        {
            visible = false;
        }
        modify("Assigned User ID")
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
