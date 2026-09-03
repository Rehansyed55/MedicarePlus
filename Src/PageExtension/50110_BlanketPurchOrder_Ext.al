pageextension 50110 "Blanket Purchase Order" extends "Blanket Purchase Order"
{
    layout
    {
        // Add changes to page layout here

        // Reorder fields to match the legacy NAV "Blanket Purchase Order" form layout.
        // NOTE: NAV's "Expected Receipt Date" (General section, after Order Date) lives in
        // the BC "Invoice Details" FastTab, and NAV's Payment Method Code (after Pay-to Contact)
        // lives in BC's "Invoice Details" FastTab as well. Both are cross-FastTab-group moves,
        // left as-is (not moved) to avoid restructuring group membership - flagged here rather
        // than guessed.

        // Buy-from address block: NAV order is Address, Address 2, County, Post Code, City, Contact No.
        movebefore("Buy-from County"; "Buy-from City")
        movebefore("Buy-from Post Code"; "Buy-from City")

        // Ship-to address block: NAV order is Name, Address, Address 2, County, Post Code, City, Contact
        movebefore("Ship-to County"; "Ship-to City")
        movebefore("Ship-to Post Code"; "Ship-to City")

        // Pay-to address block: NAV order is Name, Address, Address 2, County, Post Code, City, Contact No., Contact
        movebefore("Pay-to County"; "Pay-to City")
        movebefore("Pay-to Post Code"; "Pay-to City")

        addafter(Status)
        {
            field("Your Reference"; Rec."Your Reference")
            {
                ApplicationArea = all;
            }
            field("Technical Agreement No."; Rec."Technical Agreement No.")
            {
                ApplicationArea = all;
            }
            field(SystemCreatedAt; Rec.SystemCreatedAt)
            {
                ApplicationArea = all;
                Caption = 'Created At';
                Editable = false;
            }
            field(CreatedBy; GetUserNameFromSecurityId(Rec.SystemCreatedBy))
            {
                Caption = 'Created By';
                ApplicationArea = All;
                Editable = false;
            }
            field(SystemModifiedAt; Rec.SystemModifiedAt)
            {
                ApplicationArea = all;
                Caption = 'Modified At';
                Editable = false;
            }
            field(ModifyBy; GetUserNameFromSecurityId(Rec.SystemModifiedBy))
            {
                Caption = 'Modified By';
                ApplicationArea = All;
                Editable = false;
            }

        }
    }

    actions
    {
        // Add changes to page actions here
    }
    Procedure GetUserNameFromSecurityId(UserSecurityID: Guid): Code[50]
    var
        User: Record User;
    begin
        If User.Get(UserSecurityID) then
            exit(User."User Name");
    end;


    var
        myInt: Integer;
}