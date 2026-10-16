pageextension 50107 "Purchase Order Ext" extends "Purchase Order"
{
    layout
    {
        // Add changes to page layout here
        // Reorder "Your Reference" to match the old NAV form layout, where it appeared
        // right after the Buy-from address block and before the Contact field.
        movebefore("Your Reference"; "Buy-from Contact")

        addafter(Status)
        {
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