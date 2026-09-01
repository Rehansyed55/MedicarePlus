page 50118 "Posted Gate Attachment List"
{
    // version NAVIN5.00.01

    Caption = 'Posted Gate Attachment List';
    Editable = false;
    PageType = List;
    SourceTable = "Posted Gate Entry Attachment1";
    UsageCategory = History;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field("Source Type"; rec."Source Type")
                {
                    ApplicationArea = all;
                }
                field("Source No."; rec."Source No.")
                {
                    ApplicationArea = all;
                }
                field("Entry Type"; rec."Entry Type")
                {
                    ApplicationArea = all;
                }
                field("Gate Entry No."; rec."Gate Entry No.")
                {
                    ApplicationArea = all;
                }
                field("Receipt No."; rec."Receipt No.")
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

