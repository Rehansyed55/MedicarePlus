report 60046 "Bank Acc. Recon. Statement"
{
    // version NAVGB7.00

    // <changelog>
    //   <add id="GB0001" dev="TMARTI" date="2006-01-25" area="UKGEN" feature="PSCORS102"
    //     releaseversion="GB5.00">New Bank Acc. Recon. Statement</add>
    //   <remove id="GB0002" dev="TMARTI" date="2007-06-14" area="UKGEN"  request="UK-START-51"
    //     baseversion="GB4.00" releaseversion="GB6.00">C/Track cleanup</remove>
    //   <add id="GB0003" dev="TMARTI" date="2007-06-14" area="BANKRECON"  request="UK-START-51"
    //     releaseversion="GB6.00">Bank Acc. Recon.</add>
    //   <change id="GB0004" dev="AUGMENTUM" date="2007-08-31" area="BANKRECON" feature="PSCORS1177"
    //     baseversion="GB6.00" releaseversion="GB6.00">Report Transformation - local Report Layout</change>
    //   <change id="GB0005" dev="TMARTI" date="2009-01-08" area="BANKRECON" feature="NAVCORS32719"
    //     baseversion="GB6.00" releaseversion="GB6.00.01">Date filter is not working on R10555 for Cash Book Balance
    //     </change>
    //   <change id="AL0001" dev="RSYED" date="2026-09-22" area="BANKRECON">
    //     CAL to AL migration for BC Cloud: removed BACS integration (tables 10550/10551 and
    //     codeunit 10551 are obsolete/removed from current BC), removed obsolete "Type" field
    //     usage on Bank Acc. Reconciliation Line, converted legacy CAL statements to modern AL syntax.</change>
    // </changelog>
    DefaultLayout = RDLC;
    RDLCLayout = './Bank Acc. Recon. Statement.rdl';

    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Bank Acc. Recon. Statement';

    dataset
    {
        dataitem("Bank Account"; "Bank Account")
        {
            DataItemTableView = sorting("No.");
            column(STRSUBSTNO__Text001_Name_FORMAT_EndDate__; StrSubstNo(Text001, Name, Format(EndDate)))
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(USERID; UserId)
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(STRSUBSTNO__Text001_Name____; StrSubstNo(Text001, Name, ''))
            {
            }
            column(EndDate; EndDate)
            {
            }
            column(Bank_Account_No_; "No.")
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            dataitem(Integer; Integer)
            {
                DataItemTableView = sorting(Number);
                MaxIteration = 1;
                column(STRSUBSTNO__Text003_FORMAT_EndDate__; StrSubstNo(Text003, Format(EndDate)))
                {
                }
                column(BankAccRecon__Balance_Last_Statement____BankAccReconLine3__Statement_Amount_; BankAccRecon."Balance Last Statement" + BankAccReconLine3."Statement Amount")
                {
                }
                column(Integer_Number; Number)
                {
                }
                column(STRSUBSTNO__Text003____; StrSubstNo(Text003, ''))
                {
                }
                column(Bank_Account__Balance; "Bank Account"."Balance at Date")
                {
                }
                column(BankAccReconLine2__Transaction_Date_Caption; BankAccReconLine2__Transaction_Date_CaptionLbl)
                {
                }
                column(BankAccReconLine2__Document_No__Caption; BankAccReconLine2__Document_No__CaptionLbl)
                {
                }
                column(BankAccReconLine2__Check_No__Caption; BankAccReconLine2__Check_No__CaptionLbl)
                {
                }
                column(BankAccReconLine2_DescriptionCaption; BankAccReconLine2_DescriptionCaptionLbl)
                {
                }
                column(BankAccReconLine2__Statement_Amount_Caption; BankAccReconLine2__Statement_Amount_CaptionLbl)
                {
                }
                column(BankAccReconLine2__Statement_Amount__Control1040018Caption; BankAccReconLine2__Statement_Amount__Control1040018CaptionLbl)
                {
                }
                column(Cash_Book_Balance_as_per_General_Ledger_AccountCaption; Cash_Book_Balance_as_per_General_Ledger_AccountCaptionLbl)
                {
                }
                column(BalanceTotal; BalanceTotal)
                {
                }
                dataitem(Integer2; Integer)
                {
                    DataItemTableView = sorting(Number);
                    column(Integer2_Number; Number)
                    {
                    }
                    column(BankAccReconLine2__Transaction_Date_; Format(BankAccReconLine2."Transaction Date"))
                    {
                    }
                    column(BankAccReconLine2__Document_No__; BankAccReconLine2."Document No.")
                    {
                    }
                    column(BankAccReconLine2__Check_No__; BankAccReconLine2."Check No.")
                    {
                    }
                    column(BankAccReconLine2_Description; BankAccReconLine2.Description)
                    {
                    }
                    column(BankAccReconLine2__Statement_Amount_; BankAccReconLine2."Statement Amount")
                    {
                    }
                    column(BankAccReconLine2__Statement_Amount__Control1040018; BankAccReconLine2."Statement Amount")
                    {
                    }
                    column(Less_Outstanding_Cheques_and_PaymentsCaption; Less_Outstanding_Cheques_and_PaymentsCaptionLbl)
                    {
                    }
                    column(Total_Outstanding_Cheques_and_PaymentsCaption; Total_Outstanding_Cheques_and_PaymentsCaptionLbl)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        BankAccReconLine2 := BankAccReconLine;
                        BankAccReconLine.Next();
                    end;

                    trigger OnPreDataItem()
                    begin
                        Clear(BankAccReconLine);
                        CurrReport.CreateTotals(BankAccReconLine2."Statement Amount");
                        if NoOfChecks > 0 then
                            SetRange(Number, 1, NoOfChecks)
                        else
                            SetRange(Number, 1, 1);
                        BankAccReconLine.SetFilter("Statement Amount", '<0');
                        if BankAccReconLine.FindSet() then;
                    end;
                }
                dataitem(Integer3; Integer)
                {
                    DataItemTableView = sorting(Number);
                    column(Integer3_Number; Number)
                    {
                    }
                    column(BankAccReconLine2__Statement_Amount__Control1040024; BankAccReconLine2."Statement Amount")
                    {
                    }
                    column(BankAccReconLine2_Description_Control1040025; BankAccReconLine2.Description)
                    {
                    }
                    column(BankAccReconLine2__Check_No___Control1040026; BankAccReconLine2."Check No.")
                    {
                    }
                    column(BankAccReconLine2__Document_No___Control1040027; BankAccReconLine2."Document No.")
                    {
                    }
                    column(BankAccReconLine2__Transaction_Date__Control1040028; Format(BankAccReconLine2."Transaction Date"))
                    {
                    }
                    column(BankAccReconLine2__Statement_Amount__Control1040031; BankAccReconLine2."Statement Amount")
                    {
                    }
                    column(Add_Outstanding_Deposits__not_yet_cleared_by_the_bank_Caption; Add_Outstanding_Deposits__not_yet_cleared_by_the_bank_CaptionLbl)
                    {
                    }
                    column(Total_Outstanding_Deposits__not_yet_cleared_by_the_bank_Caption; Total_Outstanding_Deposits__not_yet_cleared_by_the_bank_CaptionLbl)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        BankAccReconLine2 := BankAccReconLine;
                        BankAccReconLine.Next();
                    end;

                    trigger OnPreDataItem()
                    begin
                        Clear(BankAccReconLine);
                        CurrReport.CreateTotals(BankAccReconLine2."Statement Amount");
                        if NoOfDeposits > 0 then
                            SetRange(Number, 1, NoOfDeposits)
                        else
                            SetRange(Number, 1, 1);
                        BankAccReconLine.SetFilter("Statement Amount", '>0');
                        if BankAccReconLine.FindSet() then;
                    end;
                }
            }

            trigger OnAfterGetRecord()
            begin
                CalcFields("Balance at Date");
                BalanceTotal += "Balance at Date";

                EOFBankAccLedgEntries := true;
                EOFCheckLedgEntries := true;

                BankAccLedgEntry.Reset();
                BankAccLedgEntry.SetCurrentKey("Bank Account No.", "Posting Date");
                BankAccLedgEntry.SetRange("Bank Account No.", "No.");
                BankAccLedgEntry.SetRange("Posting Date", StartDate, EndDate);
                BankAccLedgEntry.SetRange(Open, true);
                BankAccLedgEntry.SetRange("Statement Status", BankAccLedgEntry."Statement Status"::Open);
                EOFBankAccLedgEntries := not BankAccLedgEntry.FindSet();

                if IncludeChecks then begin
                    CheckLedgEntry.Reset();
                    CheckLedgEntry.SetCurrentKey("Bank Account No.", "Check Date");
                    CheckLedgEntry.SetRange("Bank Account No.", "No.");
                    CheckLedgEntry.SetRange("Check Date", StartDate, EndDate);
                    CheckLedgEntry.SetFilter(
                      "Entry Status", '%1|%2', CheckLedgEntry."Entry Status"::Posted,
                      CheckLedgEntry."Entry Status"::"Financially Voided");
                    CheckLedgEntry.SetRange(Open, true);
                    CheckLedgEntry.SetRange("Statement Status", BankAccLedgEntry."Statement Status"::Open);
                    EOFCheckLedgEntries := not CheckLedgEntry.FindSet();
                end;

                while (not EOFBankAccLedgEntries) or (IncludeChecks and (not EOFCheckLedgEntries))
                do
                    case true of
                        not IncludeChecks:
                            begin
                                EnterBankAccLine(BankAccLedgEntry);
                                EOFBankAccLedgEntries := BankAccLedgEntry.Next() = 0;
                            end;
                        (not EOFBankAccLedgEntries) and (not EOFCheckLedgEntries) and
                        (BankAccLedgEntry."Posting Date" <= CheckLedgEntry."Check Date"):
                            begin
                                CheckLedgEntry2.Reset();
                                CheckLedgEntry2.SetCurrentKey("Bank Account Ledger Entry No.");
                                CheckLedgEntry2.SetRange("Bank Account Ledger Entry No.", BankAccLedgEntry."Entry No.");
                                CheckLedgEntry2.SetRange(Open, true);

                                if not CheckLedgEntry2.FindFirst() then
                                    EnterBankAccLine(BankAccLedgEntry);

                                EOFBankAccLedgEntries := BankAccLedgEntry.Next() = 0;
                            end;
                        (not EOFBankAccLedgEntries) and (not EOFCheckLedgEntries) and
                        (BankAccLedgEntry."Posting Date" > CheckLedgEntry."Check Date"):
                            begin
                                EnterCheckLine(CheckLedgEntry);
                                EOFCheckLedgEntries := CheckLedgEntry.Next() = 0;
                            end;
                        (not EOFBankAccLedgEntries) and EOFCheckLedgEntries:
                            begin
                                CheckLedgEntry2.Reset();
                                CheckLedgEntry2.SetCurrentKey("Bank Account Ledger Entry No.");
                                CheckLedgEntry2.SetRange("Bank Account Ledger Entry No.", BankAccLedgEntry."Entry No.");
                                CheckLedgEntry2.SetRange(Open, true);

                                if not CheckLedgEntry2.FindFirst() then
                                    EnterBankAccLine(BankAccLedgEntry);

                                EOFBankAccLedgEntries := BankAccLedgEntry.Next() = 0;
                            end;
                        EOFBankAccLedgEntries and (not EOFCheckLedgEntries):
                            begin
                                EnterCheckLine(CheckLedgEntry);
                                EOFCheckLedgEntries := CheckLedgEntry.Next() = 0;
                            end;
                    end;
            end;

            trigger OnPreDataItem()
            begin
                if EndDate = 0D then
                    Error(Text000);

                BankAccRecon.Get(ReqStatementType, ReqBankAccountNo, ReqStatementNo);

                BankAccReconLine3.SetRange("Statement Type", BankAccRecon."Statement Type");
                BankAccReconLine3.SetRange("Bank Account No.", BankAccRecon."Bank Account No.");
                BankAccReconLine3.SetRange("Statement No.", BankAccRecon."Statement No.");
                BankAccReconLine3.CalcSums("Statement Amount");
                SetRange("No.", BankAccRecon."Bank Account No.");
                NoOfChecks := 0;
                NoOfDeposits := 0;
                SetRange("Date Filter", StartDate, EndDate);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    group("Statement Period")
                    {
                        Caption = 'Statement Period';
                        field(StartDate; StartDate)
                        {
                            Caption = 'Starting Date';
                        }
                        field(EndDate; EndDate)
                        {
                            Caption = 'Ending Date';
                        }
                    }
                    field(IncludeChecksReq; IncludeChecks)
                    {
                        Caption = 'Include Checks';
                    }
                    field(ReqBankAccountNoField; ReqBankAccountNo)
                    {
                        Visible = false;
                        Editable = false;
                    }
                    field(ReqStatementNoField; ReqStatementNo)
                    {
                        Visible = false;
                        Editable = false;
                    }
                    field(ReqStatementTypeField; ReqStatementType)
                    {
                        Visible = false;
                        Editable = false;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Text000: Label 'Please enter the Ending Date.';
        BankAccLedgEntry: Record "Bank Account Ledger Entry";
        CheckLedgEntry: Record "Check Ledger Entry";
        CheckLedgEntry2: Record "Check Ledger Entry";
        BankAccRecon: Record "Bank Acc. Reconciliation";
        ReqStatementType: Enum "Bank Acc. Rec. Stmt. Type";
        ReqBankAccountNo: Code[20];
        ReqStatementNo: Code[20];
        BankAccReconLine: Record "Bank Acc. Reconciliation Line" temporary;
        BankAccReconLine2: Record "Bank Acc. Reconciliation Line" temporary;
        BankAccReconLine3: Record "Bank Acc. Reconciliation Line";
        StartDate: Date;
        EndDate: Date;
        IncludeChecks: Boolean;
        EOFBankAccLedgEntries: Boolean;
        EOFCheckLedgEntries: Boolean;
        NoOfChecks: Integer;
        Text001: Label 'Bank Reconciliation Statement for %1 as of %2';
        Text003: Label 'Balance as per Ending Balance Statement as of %1';
        NoOfDeposits: Integer;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        BankAccReconLine2__Transaction_Date_CaptionLbl: Label 'Transaction Date';
        BankAccReconLine2__Document_No__CaptionLbl: Label 'Document No.';
        BankAccReconLine2__Check_No__CaptionLbl: Label 'Check No.';
        BankAccReconLine2_DescriptionCaptionLbl: Label 'Description';
        BankAccReconLine2__Statement_Amount_CaptionLbl: Label 'Sub Total';
        BankAccReconLine2__Statement_Amount__Control1040018CaptionLbl: Label 'Amount';
        Cash_Book_Balance_as_per_General_Ledger_AccountCaptionLbl: Label 'Cash Book Balance as per General Ledger Account';
        Less_Outstanding_Cheques_and_PaymentsCaptionLbl: Label 'Less Outstanding Cheques and Payments';
        Total_Outstanding_Cheques_and_PaymentsCaptionLbl: Label 'Total Outstanding Cheques and Payments';
        Add_Outstanding_Deposits__not_yet_cleared_by_the_bank_CaptionLbl: Label 'Add Outstanding Deposits (not yet cleared by the bank)';
        Total_Outstanding_Deposits__not_yet_cleared_by_the_bank_CaptionLbl: Label 'Total Outstanding Deposits (not yet cleared by the bank)';
        BalanceTotal: Decimal;

    procedure SetStmt(var BankAccRecon2: Record "Bank Acc. Reconciliation")
    begin
        ReqStatementType := BankAccRecon2."Statement Type";
        ReqBankAccountNo := BankAccRecon2."Bank Account No.";
        ReqStatementNo := BankAccRecon2."Statement No.";
        EndDate := BankAccRecon2."Statement Date";
    end;

    local procedure EnterBankAccLine(var BankAccLedgEntry2: Record "Bank Account Ledger Entry")
    begin
        BankAccReconLine.Init();
        BankAccReconLine."Statement Line No." := BankAccReconLine."Statement Line No." + 10000;
        BankAccReconLine."Transaction Date" := BankAccLedgEntry2."Posting Date";
        BankAccReconLine.Description := BankAccLedgEntry2.Description;
        BankAccReconLine."Document No." := BankAccLedgEntry2."Document No.";
        BankAccReconLine."Statement Amount" := BankAccLedgEntry2."Remaining Amount";
        BankAccReconLine."Applied Amount" := BankAccReconLine."Statement Amount";
        BankAccReconLine."Applied Entries" := 1;
        BankAccReconLine.Insert();

        if BankAccReconLine."Statement Amount" < 0 then
            NoOfChecks := NoOfChecks + 1
        else
            NoOfDeposits := NoOfDeposits + 1
    end;

    local procedure EnterCheckLine(var CheckLedgEntry3: Record "Check Ledger Entry")
    begin
        BankAccReconLine.Init();
        BankAccReconLine."Statement Line No." := BankAccReconLine."Statement Line No." + 10000;
        BankAccReconLine."Transaction Date" := CheckLedgEntry3."Check Date";
        BankAccReconLine.Description := CheckLedgEntry3.Description;
        BankAccReconLine."Statement Amount" := -CheckLedgEntry3.Amount;
        BankAccReconLine."Applied Amount" := BankAccReconLine."Statement Amount";
        BankAccReconLine."Check No." := CheckLedgEntry3."Check No.";
        BankAccReconLine."Applied Entries" := 1;
        BankAccReconLine.Insert();

        if BankAccReconLine."Statement Amount" < 0 then
            NoOfChecks := NoOfChecks + 1
        else
            NoOfDeposits := NoOfDeposits + 1
    end;

    procedure InitializeRequest(NewStartDate: Date; NewEndDate: Date; NewIncludeChecks: Boolean)
    begin
        StartDate := NewStartDate;
        EndDate := NewEndDate;
        IncludeChecks := NewIncludeChecks;
    end;
}
