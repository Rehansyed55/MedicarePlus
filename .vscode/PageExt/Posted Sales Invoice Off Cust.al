pageextension 60038 "Posted Sales Invoice Off Cust" extends "Posted Sales Invoice"
{
    actions
    {
        addafter(Print)
        {
            action("Office Copy")
            {
                ApplicationArea = All;
                Caption = 'Office Copy';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Print the office copy of this posted sales invoice.';

                trigger OnAction()
                var
                    SalesInvHeader: Record "Sales Invoice Header";
                begin
                    SalesInvHeader.Copy(Rec);
                    SalesInvHeader.SetRecFilter();
                    Report.RunModal(Report::"Sales - Invoice (Office Copy)", true, true, SalesInvHeader);
                end;
            }
            action("Customer Copy")
            {
                ApplicationArea = All;
                Caption = 'Customer Copy';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Print the customer copy of this posted sales invoice.';

                trigger OnAction()
                var
                    SalesInvHeader: Record "Sales Invoice Header";
                begin
                    SalesInvHeader.Copy(Rec);
                    SalesInvHeader.SetRecFilter();
                    Report.RunModal(Report::"Sales - Inv (Customer Copy)", true, true, SalesInvHeader);
                end;
            }
        }
    }
}
