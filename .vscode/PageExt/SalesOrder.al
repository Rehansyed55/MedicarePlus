pageextension 60030 salesorder extends "Sales Order"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addlast(Reporting)
        {
            action(SalesProfit)
            {
                ApplicationArea = All;
                Caption = 'Sales Profit Analysis';
                Image = Print;
                Promoted = true;
                PromotedCategory = Report;

                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                begin
                    SalesHeader.Copy(Rec);
                    SalesHeader.SetRecFilter();
                    Report.RunModal(Report::"Sales Order Line Wise", true, true, SalesHeader);
                end;
            }
        }
    }

    var
        myInt: Integer;
}