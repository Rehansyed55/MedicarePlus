pageextension 60035 Postwarereceipt extends "Posted Whse. Receipt"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter("&Print")
        {
            action(Goodsreceivenotes)
            {
                ApplicationArea = All;
                Caption = 'Goods Received Notes';
                Image = Notes;
                Promoted = true;
                PromotedCategory = Report;
                trigger OnAction()

                begin
                    IF COMPANYNAME = 'Medicareplus International' THEN BEGIN
                        CLEAR(GoodsReceivedNoteMedicare);
                        recPostedWhseReceiptLine.RESET;
                        recPostedWhseReceiptLine.SETRANGE("No.", rec."No.");
                        GoodsReceivedNoteMedicare.SETTABLEVIEW(recPostedWhseReceiptLine);
                        GoodsReceivedNoteMedicare.RUNMODAL;
                    END
                    ELSE BEGIN
                        CLEAR(GRN);
                        recPostedWhseReceiptLine.RESET;
                        recPostedWhseReceiptLine.SETRANGE(recPostedWhseReceiptLine."No.", rec."No.");
                        GRN.SETTABLEVIEW(recPostedWhseReceiptLine);
                        GRN.RUNMODAL;
                    END;
                end;
            }
        }

    }

    var
        myInt: Integer;
        recPostedWhseReceiptLine: Record "Posted Whse. Receipt Line";
        GoodsReceivedNoteMedicare: report "Goods Received Note Medicare";
        GRN: report "Goods Received Note Medicare";
}