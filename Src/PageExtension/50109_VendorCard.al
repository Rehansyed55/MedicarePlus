pageextension 50109 Vendor extends "Vendor Card"
{
    layout
    {
        addafter("Purchaser Code")
        {
            field(Status; Rec.Status)
            {
                ApplicationArea = all;
            }
        }

        // Reorder fields on the Address & Contact FastTab to match the old NAV
        // Vendor Card form layout (NAV order: Address, Address 2, City, County,
        // Post Code, Country/Region Code, then Primary Contact No., Contact,
        // Phone No., E-Mail, Fax No., Home Page, Our Account No., Language Code).
        // NOTE: "Country/Region Code" is moved to sit after "Post Code" (NAV had
        // it last within the Address block, BC has it right after "Address 2").
        movebefore("Country/Region Code"; ShowMap)

        // NAV field "Contact" is rendered on the BC base page via a field control
        // literally named Control16 (SourceExpr = Rec.Contact); "Contact" is not a
        // valid anchor name on this base page version. Primary Contact No. and
        // Contact are moved from the nested "Contact" group to sit before
        // "Phone No.", matching the NAV order.
        movebefore("Primary Contact No."; "Phone No.")
        movebefore(Control16; "Phone No.")

        addlast(General)
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