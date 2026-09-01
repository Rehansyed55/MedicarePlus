page 50112 "Posted Inward Gate Entry List"
{
    // version NAVIN5.00.01

    Caption = 'Posted Inward Gate Entry List';
    CardPageID = "Posted Inward Gate Entry";
    PageType = List;
    SourceTable = "Posted Gate Entry Header 1";
    UsageCategory = History;
    ApplicationArea = all;
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
                field("Gate Entry No."; rec."Gate Entry No.")
                {
                    ApplicationArea = all;
                }
                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                }
                field("User ID"; rec."User ID")
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
                field("Station From/To"; rec."Station From/To")
                {
                    ApplicationArea = all;
                }
                field("Supplier Code"; rec."Supplier Code")
                {
                    ApplicationArea = all;
                }
                field("Supplier Name"; rec."Supplier Name")
                {
                    ApplicationArea = all;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Carrier/Courier"; rec."Carrier/Courier")
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


}

