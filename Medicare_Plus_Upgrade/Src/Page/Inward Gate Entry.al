page 50106 "Inward Gate Entry"
{
    // version NAVIN5.00.01

    Caption = 'Gate Entry - Inward';
    PageType = Card;
    SourceTable = "Gate Entry Header 1";
    SourceTableView = sorting("Entry Type", "No.")
                      order(ascending)
                      where("Entry Type" = const(Inward));
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; rec."No.")
                {
                    ApplicationArea = all;

                }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field("Bin Code"; rec."Bin Code")
                {
                    ApplicationArea = all;
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ApplicationArea = all;
                    Editable = false;
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

                field("Carrier/Courier"; rec."Carrier/Courier")
                {
                    ApplicationArea = all;
                }
                field("Supplier Code"; rec."Supplier Code")
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
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Posting Time"; rec."Posting Time")
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
                field("Supplier Name"; rec."Supplier Name")
                {
                    ApplicationArea = all;
                }
            }
            part(InwardGateEntryline; 50105)
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
        area(Navigation)
        {
            group("P&osting")
            {
                Caption = 'P&osting';

                action("P&ost")
                {
                    Caption = 'P&ost';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        GateEntryPostYesNo: Codeunit "Gate Entry-Post (Yes/No)";
                    begin
                        GateEntryPostYesNo.RUN(Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Post and &Print")
                {
                    Caption = 'Post and &Print';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Codeunit 50103;
                    ShortCutKey = 'Shift+F9';
                    applicationArea = All;
                }


            }

            group("&Gate Entry")
            {
                Caption = '&Gate Entry';

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

    var
        GateEntryLocSetup: Record "Gate Entry Location Setup 1";
    //NoSeriesMgt: Codeunit "396";
}

