pageextension 60034 ItemListExt extends "Item List"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter("Inventory by Location")
        {
            action("Inventory bin valuation")
            {
                Caption = 'Inventory bin valuation';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                applicationarea = All;

                trigger OnAction()
                begin
                    recBinContent.RESET;
                    recBinContent.SETRANGE(recBinContent."Item No.", rec."No.");
                    IF recBinContent.FINDFIRST THEN
                        REPORT.RUNMODAL(60043, TRUE, TRUE, recBinContent);
                end;
            }
        }
    }

    var
        myInt: Integer;
        recBinContent: Record 7302;
}