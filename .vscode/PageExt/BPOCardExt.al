pageextension 60037 MyExtension extends "Blanket Purchase Order"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter(Print)
        {
            action("Purchase Order Analysis")
            {
                ApplicationArea = Suite;
                Caption = 'Purchase Order (POR) Analysis';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.';

                trigger OnAction()
                begin
                    PurchaseHeader.RESET;
                    PurchaseHeader.SETRANGE("No.", rec."No.");
                    IF PurchaseHeader.FINDFIRST THEN BEGIN
                        CLEAR(PurchaseOrderAnalysis);
                        PurchaseOrderAnalysis.SETTABLEVIEW(PurchaseHeader);
                        PurchaseOrderAnalysis.RUN;
                    END;
                end;
            }
        }
    }

    var
        PurchaseHeader: record "Purchase Header";
        PurchaseOrderAnalysis: report "Purchase Order Analysis";
}