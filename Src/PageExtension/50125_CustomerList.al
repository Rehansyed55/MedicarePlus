pageextension 50125 "Customer List Ext" extends "Customer List"
{
    layout
    {
        // Make hidden standard fields visible to match NAV order/visibility
        modify("Salesperson Code")
        {
            Visible = true;
        }
        modify("Credit Limit (LCY)")
        {
            Visible = true;
        }
        modify("Payment Terms Code")
        {
            Visible = true;
        }
        modify("VAT Bus. Posting Group")
        {
            Visible = true;
        }
        modify(Blocked)
        {
            Visible = true;
        }
        modify("Country/Region Code")
        {
            Visible = true;
        }
        modify("Post Code")
        {
            Visible = true;
        }
        modify("Customer Price Group")
        {
            Visible = true;
        }

        // Reorder existing base-page fields to match NAV order first, so newly added
        // fields below can be inserted directly into their final position via addafter
        // (AL does not allow moveafter/movebefore on a field added in this same extension).
        // Target order: No. -> Name -> Salesperson Code -> Credit Limit (LCY) -> Payment Terms Code ->
        // Balance (LCY) -> VAT Bus. Posting Group -> Blocked -> Country/Region Code -> Address -> Address 2 ->
        // Post Code -> City -> County -> E-Mail -> Payment Method Code -> Customer Price Group -> Sales (LCY) ->
        // Contact -> Profit (LCY) -> Responsibility Center -> Location Code -> Phone No. -> Balance Due (LCY) ->
        // Payments (LCY) -> WDL No -> GPHC No. -> WDA Date -> CD Date -> CD No.
        moveafter("Salesperson Code"; Name)
        moveafter("Credit Limit (LCY)"; "Salesperson Code")
        moveafter("Payment Terms Code"; "Credit Limit (LCY)")
        moveafter("Balance (LCY)"; "Payment Terms Code")
        moveafter("VAT Bus. Posting Group"; "Balance (LCY)")
        moveafter(Blocked; "VAT Bus. Posting Group")
        moveafter("Country/Region Code"; Blocked)
        moveafter("Customer Price Group"; "Post Code")
        moveafter("Sales (LCY)"; "Customer Price Group")
        moveafter(Contact; "Sales (LCY)")
        moveafter("Responsibility Center"; Contact)
        moveafter("Location Code"; "Responsibility Center")
        moveafter("Phone No."; "Location Code")
        moveafter("Balance Due (LCY)"; "Phone No.")
        moveafter("Payments (LCY)"; "Balance Due (LCY)")

        // Add NAV columns missing from the standard BC page, directly in final position
        addafter("Country/Region Code")
        {
            field(Address; Rec.Address)
            {
                ApplicationArea = All;
            }
            field("Address 2"; Rec."Address 2")
            {
                ApplicationArea = All;
            }
        }
        addafter("Post Code")
        {
            field(City; Rec.City)
            {
                ApplicationArea = All;
            }
            field(County; Rec.County)
            {
                ApplicationArea = All;
            }
            field("E-Mail"; Rec."E-Mail")
            {
                ApplicationArea = All;
            }
            field("Payment Method Code"; Rec."Payment Method Code")
            {
                ApplicationArea = All;
            }
        }
        addafter(Contact)
        {
            field("Profit (LCY)"; Rec."Profit (LCY)")
            {
                ApplicationArea = All;
            }
        }
        addafter("Payments (LCY)")
        {
            field("WDL No"; Rec."WDL No")
            {
                ApplicationArea = All;
            }
            field("GPHC No."; Rec."GPHC No.")
            {
                ApplicationArea = All;
            }
            field("WDA Date"; Rec."WDA Date")
            {
                ApplicationArea = All;
            }
            field("CD Date"; Rec."CD Date")
            {
                ApplicationArea = All;
            }
            field("CD No."; Rec."CD No.")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
}
