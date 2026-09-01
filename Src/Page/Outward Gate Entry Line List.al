page 50107 "Outward Gate Entry Line List"
{
    // version NAVIN5.00.01

    Caption = 'Outward Gate Entry Line List';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Posted Gate Entry Line 1";

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field("Gate Entry No."; rec."Gate Entry No.")
                {
                    ApplicationArea = all;
                }
                field("Doc. Source Type"; rec."Doc. Source Type")
                {
                    ApplicationArea = all;
                }
                field("Doc. Source No."; rec."Doc. Source No.")
                {
                    ApplicationArea = all;
                }
                field("Source Name"; rec."Source Name")
                {
                    ApplicationArea = all;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Supplier Delivery Note"; rec."Supplier Delivery Note")
                {
                    ApplicationArea = all;
                }
                field(Date; rec."Supplier Delivery Date")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

