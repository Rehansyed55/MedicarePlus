pageextension 50108 CustomerCard extends "Customer Card"
{
    layout
    {
        addafter("Salesperson Code")
        {
            field(Status; Rec.Status)
            {
                ApplicationArea = all;
            }
        }
        // Reorder fields on the Address & Contact FastTab to match the old NAV
        // Customer Card form layout (NAV order: Address, Address 2, City, County,
        // Post Code, Country/Region Code, then Primary Contact No., Contact Name,
        // Phone No., E-Mail, Fax No., Home Page, Language Code).
        // "Country/Region Code" is moved to sit after "Post Code" (NAV had it last
        // within the Address block, BC has it right after "Address 2").
        moveafter("Country/Region Code"; "Post Code")

        // In BC, "Primary Contact No." and "Contact Name" (control ContactName) sit
        // in a separate ContactDetails group placed AFTER Phone No./E-Mail/Fax No./
        // Home Page/Language Code. NAV had them first, immediately before Phone No.
        // Move both fields to sit before "Phone No." to match the NAV order.
        movebefore("Primary Contact No."; "Phone No.")
        movebefore(ContactName; "Phone No.")
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