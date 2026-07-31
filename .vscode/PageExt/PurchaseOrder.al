pageextension 60031 purchaseOrder extends "Purchase Order"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addlast(Reporting)
        {
            action(PurchaseProfit)
            {
                ApplicationArea = All;
                Caption = 'Purchase Profit Analysis';
                Image = Print;
                Promoted = true;
                PromotedCategory = Report;

                trigger OnAction()
                var
                    PurchaseHeader: Record "Purchase Header";
                begin
                    PurchaseHeader.Copy(Rec);
                    PurchaseHeader.SetRecFilter();
                    Report.RunModal(Report::"Purchase Order Analysis(PDN)", true, true, PurchaseHeader);
                end;
            }
        }
    }

    var
        myInt: Integer;
}