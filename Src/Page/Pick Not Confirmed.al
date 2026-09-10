page 50120 "Picks Not Confirmed"
{
    CardPageID = "Inventory Pick";
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = all;
    SourceTable = "Warehouse Activity Header";
    SourceTableView = where(Type = const("Invt. Pick"),
                            "Pick Confirmed" = const(false),
                            "Source Document" = const("Sales Order"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                }
                field("Destination No."; rec."Destination No.")
                {
                    ApplicationArea = all;
                }
                field("Customer Name"; WMSMgt.GetDestinationEntityName(Rec."Destination Type", Rec."Destination No."))
                {
                    ApplicationArea = all;
                    Caption = 'Customer Name';
                }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field("Assigned User ID"; rec."Assigned User ID")
                {
                    ApplicationArea = all;
                }
                field("Assignment Date"; rec."Assignment Date")
                {
                    ApplicationArea = all;
                }
                field("Assignment Time"; rec."Assignment Time")
                {
                    ApplicationArea = all;
                }
                field("No. of Lines"; rec."No. of Lines")
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Checking Status"; rec."Checking Status")
                {
                    ApplicationArea = all;
                }
                field("Source No."; rec."Source No.")
                {
                    ApplicationArea = all;
                }
                field("No. Printed"; rec."No. Printed")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Show Document")
            {
                ApplicationArea = all;
                Caption = 'Show Document';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Page.Run(Page::"Warehouse Activity List", Rec);
                end;
            }
        }
    }

    var
        WMSMgt: Codeunit 7302;
}

