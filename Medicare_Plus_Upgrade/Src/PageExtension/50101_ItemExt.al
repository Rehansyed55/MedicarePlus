pageextension 50101 itemCard_Ext extends "Item Card"
{
    layout
    {
        // Add changes to page layout here

        // Reorder to match legacy NAV Item Card field sequence (NAV placed
        // Manufacturer Code after Common Item No.; BC places it earlier).
        moveafter("Manufacturer Code"; "Common Item No.")

        addlast(Item)
        {
            field(Status; Rec.Status)
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
        myInt: integer;
}