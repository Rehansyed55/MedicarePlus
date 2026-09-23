pageextension 60036 BankAccReconCard extends "Bank Acc. Reconciliation"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter(PostAndPrint)
        {
            action("Bank Acc. Recon. Statement")
            {
                Caption = 'Bank Acc. Recon. Statement';
                Image = BankAccount;
                promoted = true;
                promotedCategory = Process;
                applicationArea = All;


                trigger OnAction()
                var
                    BankAccReconStatement: report "Bank Acc. Recon. Statement";
                begin
                    Rec.Find();
                    BankAccReconStatement.SetStmt(Rec);
                    BankAccReconStatement.RUNMODAL;
                    CLEAR(BankAccReconStatement);
                end;
            }
        }
    }

    var
        myInt: Integer;
}