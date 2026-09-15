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
        addafter(Reopen)
        {
            action("Close Order")
            {
                ApplicationArea = Suite;
                Caption = 'Cl&ose Order';
                Image = Close;
                ToolTip = 'This will close the Blanket Purchase Order and will be removed from the Quantity on Blanket Order';
                Promoted = true;
                PromotedCategory = Category7;

                trigger OnAction()
                var
                    ReleasePurchDoc: Codeunit "Release Purchase Document";
                    PurchaseLine: Record "Purchase Line";
                begin
                    IF rec.Status <> rec.Status::Released THEN
                        ERROR(TEXT50000);

                    rec.Status := rec.Status::Closed;
                    CurrPage.UPDATE(TRUE);


                    PurchaseLine.RESET;
                    PurchaseLine.SETRANGE("Document Type", Rec."Document Type");
                    PurchaseLine.SETRANGE("Document No.", Rec."No.");
                    //PurchaseLine.SETRANGE(Type,PurchaseLine.Type::Item);
                    IF PurchaseLine.FINDSET THEN BEGIN
                        REPEAT
                            PurchaseLine.Status := Rec.Status;
                            PurchaseLine.MODIFY;
                        UNTIL PurchaseLine.NEXT = 0;
                    END;

                end;
            }
        }
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
        TEXT50000: Label 'Status of the Order must be Released';
}