page 50116 "Posted Outward Gate Entry"
{
    // version NAVIN5.00.01

    Caption = 'Posted Gate Entry - Outward';
    Editable = false;
    PageType = Card;
    SourceTable = "Posted Gate Entry Header 1";
    SourceTableView = sorting("Entry Type", "No.")
                      order(ascending)
                      where("Entry Type" = const(Outward));

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
                    Caption = 'Station To';
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
                field("Carrier/Courier"; Rec."Carrier/Courier")
                {
                    ApplicationArea = all;
                }
            }
            part(gateentryline; "Posted Outward Gate SubForm")
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
    }
}

