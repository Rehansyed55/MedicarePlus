page 50110 "Outward Gate Entry"
{
    // version NAVIN5.00.01

    Caption = 'Gate Entry - Outward';
    PageType = Card;
    SourceTable = "Gate Entry Header 1";
    SourceTableView = sorting("Entry Type", "No.")
                      order(ascending)
                      where("Entry Type" = const(Outward));
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                    trigger OnAssistEdit()
                    begin
                        IF rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                        /*
                            GateEntryLocSetup.GET("Entry Type","Location Code");
                          GateEntryLocSetup.TESTFIELD("Posting No. Series");
                          IF NoSeriesMgt.SelectSeries(GateEntryLocSetup."Posting No. Series","No.","No. Series") THEN
                             NoSeriesMgt.SetSeries("No.");
                        */

                    end;
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
                }
                field("LR/RR Date"; rec."LR/RR Date")
                {
                    ApplicationArea = all;
                }
                field("Vehicle No."; rec."Vehicle No.")
                {
                    ApplicationArea = all;
                }
                field("Carrier/Courier"; Rec."Carrier/Courier")
                {
                    ApplicationArea = all;
                }
            }
            part(lines; 50109)
            {
                ApplicationArea = all;
                SubPageLink =
        "Entry Type" = field("Entry Type"),
        "Gate Entry No." = field("No.");
                SubPageView = SORTING("Entry Type", "Gate Entry No.", "Line No.");
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
        area(processing)
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
            }
        }
    }

    var
    // GateEntryLocSetup: Record "50002";
    // NoSeriesMgt: Codeunit "396";
}

