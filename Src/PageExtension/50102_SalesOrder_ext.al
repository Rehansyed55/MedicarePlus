pageextension 50102 "Sales Order Ext" extends "Sales Order"
{
    layout
    {
        // Add changes to page layout here
        // Reorder "Sell-to Contact No." to match the old NAV form layout, where it
        // appeared after "Sell-to E-Mail" within the Sell-to address group
        // (BC's default order places it before "Sell-to Phone No.").
        moveafter("Sell-to Contact No."; "Sell-to E-Mail")

        addafter(Status)
        {
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