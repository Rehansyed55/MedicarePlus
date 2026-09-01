page 50113 "Posted Inward Gate Entry"
{
    // version NAVIN5.00.01

    Caption = 'Posted Gate Entry - Inward';
    Editable = false;
    PageType = Card;
    SourceTable = "Posted Gate Entry Header 1";
    SourceTableView = sorting("Entry Type", "No.")
                      order(ascending)
                      where("Entry Type" = const(Inward));
    UsageCategory = Documents;
    // ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; rec."No.")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field("Station From/To"; rec."Station From/To")
                {
                    Caption = 'Station From';
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
                field("Bin Code"; rec."Bin Code")
                {
                    ApplicationArea = all;
                }
                field("Carrier/Courier"; rec."Carrier/Courier")
                {
                    ApplicationArea = all;
                }
                field("User ID"; rec."User ID")
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Posting Time"; rec."Posting Time")
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
                field("LR/RR No."; rec."LR/RR No.")
                {
                    ApplicationArea = all;
                }
                field("LR/RR Date"; rec."LR/RR Date")
                {
                    ApplicationArea = all;
                }
                field("Vehicle No."; rec."Vehicle No.")
                {
                    ApplicationArea = all;
                }
                field("Gate Entry No."; rec."Gate Entry No.")
                {
                    ApplicationArea = all;
                }
            }
            part(InwardGateEntryline; "Posted Inward Gate SubForm")
            {
                ApplicationArea = all;
                SubPageLink =
        "Entry Type" = field("Entry Type"),
        "Gate Entry No." = field("No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {

            group("&Gate Entry")
            {
                Caption = '&Gate Entry';
                action(List)
                {
                    Caption = 'List';
                    RunObject = Page 50108;
                    ShortCutKey = 'Shift+Ctrl+L';
                    ApplicationArea = all;
                }
                action(Comments)
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        GateEntryCommentLine: Record "Gate Entry Comment Line1";
                        GateEntryCommentSheet: Page "Gate Entry Comment Sheet";
                    begin
                        GateEntryCommentLine.SETRANGE("Gate Entry Type", Rec."Entry Type");
                        GateEntryCommentLine.SETRANGE("No.", Rec."No.");
                        GateEntryCommentSheet.SETTABLEVIEW(GateEntryCommentLine);
                        GateEntryCommentSheet.RUNMODAL();
                    end;
                }
                action(Attachments)
                {
                    Caption = 'Attachments';
                    Image = Attach;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        GateEntryAttachment: Record "Gate Entry Attachment1";
                        GateEntryAttachList: Page "Gate Entry Attachment List";
                    begin
                        GateEntryAttachment.SETRANGE("Entry Type", Rec."Entry Type");
                        GateEntryAttachment.SETRANGE("Gate Entry No.", Rec."No.");
                        GateEntryAttachList.SETTABLEVIEW(GateEntryAttachment);
                        GateEntryAttachList.RUNMODAL();
                    end;
                }
            }
        }
        area(Processing)
        {
            action("Posted Goods Inward Note")
            {
                ApplicationArea = All;
                Caption = 'Posted Goods Inward Note';
                Image = Print;
                Promoted = true;
                PromotedCategory = Report;
                ToolTip = 'Print the Goods Inward Note.';

                trigger OnAction()
                var
                    PostedGateEntryHeader: Record "Posted Gate Entry Header 1";
                begin
                    PostedGateEntryHeader.Reset();
                    PostedGateEntryHeader.SetRange("Entry Type", Rec."Entry Type");
                    PostedGateEntryHeader.SetRange("No.", Rec."No.");

                    Report.RunModal(
                        Report::"Goods Inward Note",
                        true,
                        true,
                        PostedGateEntryHeader);
                end;
            }
        }
    }

    var
    // PostedGEHeader: Record "50003";
    // GoodsIn: Report "50010";
    //              GateEntry: Page "50007";
}

