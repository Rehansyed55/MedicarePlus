page 50111 "Posted Gate Entry Line List"
{
    // version NAVIN5.00.01

    Caption = 'Posted Gate Entry Line List';
    Editable = false;
    PageType = List;
    SourceTable = "Posted Gate Entry Line 1";
    UsageCategory = History;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field("Entry Type"; rec."Entry Type")
                {
                    ApplicationArea = all;
                }
                field("Gate Entry No."; rec."Gate Entry No.")
                {
                    ApplicationArea = all;
                }
                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = all;
                }
                field("Doc. Source Type"; rec."Doc. Source Type")
                {
                    ApplicationArea = all;
                }
                field("Doc. Source No."; rec."Doc. Source No.")
                {
                    ApplicationArea = all;
                }
                field("Source Name"; rec."Source Name")
                {
                    ApplicationArea = all;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Supplier Delivery Note"; rec."Supplier Delivery Note")
                {
                    ApplicationArea = all;
                }
                field(Date; rec."Supplier Delivery Date")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        // FILTERGROUP(2);
        // MARKEDONLY(TRUE);
        // FILTERGROUP(0);
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        IF CloseAction = ACTION::LookupOK THEN
            LookupOKOnPush;
    end;

    var
        DocumentType: Option ,"Sales Order","Sales Return Order","Purchase Order","Purchase Return Order","Transfer Receipt","Transfer Shipment","Purchase Invoice","Sales Credit Memo";
        WRecptLine: Record 7317;
        PurchHeader: Record 38;
        SalesHeader: Record 36;
        TransHeader: Record 5740;
        WRecptNo: Code[20];
        PostedGELine: Record "Posted Gate Entry Line 1";
        DocumentNo: Code[20];

    procedure GetDocType(DocType: Option ,"Sales Order","Sales Return Order","Purchase Order","Purchase Return Order","Transfer Receipt","Transfer Shipment","Purchase Invoice","Sales Credit Memo")
    begin
        DocumentType := DocType;
    end;

    procedure GetWHReceiptNo(RecptNo: Code[20])
    begin
        WRecptNo := RecptNo;
    end;

    procedure GetDocumentNo(DocNo: Code[20])
    begin
        DocumentNo := DocNo;
    end;

    local procedure LookupOKOnPush()
    var
        WhseRqst: Record 5765;
        SourceDocSelection: Page 5793;
        GetSourceDocuments: Report 5753;
    begin
        //Pending Due to Upgradation
        /*IF WRecptNo <> '' THEN
           BEGIN
            CurrPage.SETSELECTIONFILTER(PostedGELine);
            WRecptLine.FillGateEntryLines(PostedGELine,WRecptNo);
           END
        ELSE BEGIN
           CASE DocumentType OF
             DocumentType::"Purchase Order",DocumentType::"Purchase Invoice":
              BEGIN
                CurrPage.SETSELECTIONFILTER(Rec);
                PurchHeader.FillGateEntryLines(Rec,DocumentNo);
              END;
             DocumentType::"Sales Return Order",DocumentType::"Sales Credit Memo":
              BEGIN
                CurrPage.SETSELECTIONFILTER(Rec);
                SalesHeader.FillGateEntryLines(Rec,DocumentNo);
              END;
             DocumentType::"Transfer Receipt":
              BEGIN
                CurrPage.SETSELECTIONFILTER(Rec);
                //TransHeader.FillGateEntryLines(Rec);
              END;
           END;
        END;
        */

    end;
}

