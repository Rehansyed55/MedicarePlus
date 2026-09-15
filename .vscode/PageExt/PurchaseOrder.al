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
        addafter(Reopen)
        {
            action("Close Order")
            {
                ApplicationArea = Suite;
                Caption = 'Cl&ose Order';
                Image = Close;
                ToolTip = 'This will close the Blanket Purchase Order and will be removed from the Quantity on Blanket Order';
                promoted = true;
                PromotedCategory = Category5;
                trigger OnAction()
                var
                    ReleasePurchDoc: Codeunit "Release Purchase Document";
                    PurchaseLine: Record "Purchase Line";
                begin
                    IF Rec.Status <> Rec.Status::Released THEN
                        ERROR(TEXT50000);
                    /*
                    Status := Status::Closed;
                    CurrPage.UPDATE(TRUE);
                    */
                    //Sofyan++
                    Rec.Status := Rec.Status::Closed;
                    CurrPage.UPDATE(TRUE);

                    PurchaseLine.RESET;
                    PurchaseLine.SETRANGE("Document Type", Rec."Document Type");
                    PurchaseLine.SETRANGE("Document No.", Rec."No.");
                    //PurchaseLine.SETRANGE(Type,PurchaseLine.Type::Item);
                    IF PurchaseLine.FINDSET THEN BEGIN
                        REPEAT
                            PurchaseLine."Original Ordered Quantity" := PurchaseLine.Quantity;
                            PurchaseLine.Quantity := PurchaseLine."Quantity Received";
                            PurchaseLine."Outstanding Qty. (Base)" := 0;
                            PurchaseLine."Outstanding Quantity" := 0;
                            PurchaseLine.Status := Rec.Status;
                            /*//kd
                            PurchaseLine.VALIDATE("Original Ordered Quantity",PurchaseLine.Quantity);
                            PurchaseLine.VALIDATE(Quantity,PurchaseLine."Quantity Received");
                            //kd*/
                            PurchaseLine.MODIFY;
                        UNTIL PurchaseLine.NEXT = 0;
                    END;
                    //Sofyan--

                end;
            }
        }
    }

    var
        myInt: Integer;
        TEXT50000: Label 'Status of the Order must be Released';
}