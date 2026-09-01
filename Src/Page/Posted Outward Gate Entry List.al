page 50115 "Posted Outward Gate Entry List"
{
    // version NAVIN5.00.01

    Caption = 'Posted Outward Gate Entry List';
    CardPageID = "Posted Outward Gate Entry";
    PageType = List;
    SourceTable = "Posted Gate Entry Header 1";
    UsageCategory = History;
    ApplicationArea = all;
    SourceTableView = sorting("Entry Type", "No.")
                      order(ascending)
                      where("Entry Type" = const(Outward));

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

