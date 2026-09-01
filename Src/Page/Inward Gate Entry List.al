page 50104 "Inward Gate Entry List"
{
    // version NAVIN5.00.01

    Caption = 'Inward Gate Entry List';
    CardPageID = "Inward Gate Entry";
    PageType = List;
    SourceTable = "Gate Entry Header 1";
    UsageCategory = Lists;
    ApplicationArea = all;
    Editable = true;
    SourceTableView = sorting("Entry Type", "No.")
                      order(ascending)
                      where("Entry Type" = const(Inward));
    layout
    {
        area(content)
        {
            repeater(general)
            {
                Editable = false;
                field("Entry Type"; rec."Entry Type")
                {
                    ApplicationArea = all;
                }
                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                }
                field("Document Date"; rec."Document Date")
                {
                    ApplicationArea = all;
                }
                field("Document Time"; rec."Document Time")
                {
                    ApplicationArea = all;
                }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field("Supplier Code"; rec."Supplier Code")
                {
                    Caption = 'Supplier Code';
                    ApplicationArea = all;
                }
                field("Station From/To"; rec."Station From/To")
                {
                    ApplicationArea = all;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Item Description"; rec."Item Description")
                {
                    ApplicationArea = all;
                }
                field("LR/RR No."; rec."LR/RR No.")
                {
                    ApplicationArea = all;
                }
                field("LR/RR Date"; rec."LR/RR Date")
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

