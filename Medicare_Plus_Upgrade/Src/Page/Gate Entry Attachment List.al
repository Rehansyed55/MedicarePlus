page 50100 "Gate Entry Attachment List"
{
    // version NAVIN5.00.01

    Caption = 'Gate Entry Attachment List';
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Gate Entry Attachment1";
    ApplicationArea = all;
    UsageCategory = Lists;


    layout
    {
        area(content)
        {
            repeater(general)
            {
                field("Source Type"; rec."Source Type")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Source No."; rec."Source No.")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Entry Type"; rec."Entry Type")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Gate Entry No."; rec."Gate Entry No.")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Line No."; rec."Line No.")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

