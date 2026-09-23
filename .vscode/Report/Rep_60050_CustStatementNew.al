report 60050 "Customer Statement New"
{
    // version vaibhav

    DefaultLayout = RDLC;
    RDLCLayout = './Customer Statement New.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    dataset
    {
        dataitem(customer; customer)
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = false;
            RequestFilterFields = "No.", "Date Filter", "Currency Filter";
            column(Customer_No_; "No.")
            {
            }
            column(Customer_Date_Filter; "Date Filter")
            {
            }
            column(CompanyinfoPicture; CompanyInfo.Picture)
            {
            }
            column(CompanyinfoName; CompanyInfo.Name)
            {
            }
            column(Cust_PaymentTremCode; Customer."Payment Terms Code")
            {
            }
            column(PageNo; CurrReport.PAGENO)
            {
            }
            column(AccountNo; AccountNo)
            {
            }
            column(SortCode; SortCode)
            {
            }
            column(BankName; BankName)
            {
            }
            column(FinalVAT0; FinalVAT0)
            {
            }
            column(FinalBase0; FinalBase0)
            {
            }
            column(FinalVAT5; FinalVAT5)
            {
            }
            column(FinalBase5; FinalBase5)
            {
            }
            column(FinalVAT20; FinalVAT20)
            {
            }
            column(FinalBase20; FinalBase20)
            {
            }
            dataitem(copyloop; Integer)
            {
                DataItemTableView = SORTING(Number);
                column(NoOfLoops; NoOfLoops)
                {
                }
                column(Number; copyloop.Number)
                {
                }
                dataitem(pageloop; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(StartBalance; StartBalance)
                    {
                    }
                    column(Customer__Last_Statement_No__; Customer."Last Statement No.")
                    {
                        //DecimalPlaces = 0:0;
                    }
                    column(EndDate; EndDate)
                    {
                    }
                    column(StartDate; StartDate)
                    {
                    }
                    column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
                    {
                    }
                    column(CustAddr_8_; CustAddr[8])
                    {
                    }
                    column(CustAddr_7_; CustAddr[7])
                    {
                    }
                    column(CustAddr_6_; CustAddr[6])
                    {
                    }
                    column(CustAddr_5_; CustAddr[5])
                    {
                    }
                    column(Customer__No__; Customer."No.")
                    {
                    }
                    column(CompanyInfo__VAT_Registration_No__; CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(CustAddr_4_; CustAddr[4])
                    {
                    }
                    column(CompanyInfo__Fax_No__; CompanyInfo."Fax No.")
                    {
                    }
                    column(CustAddr_2_; CustAddr[2])
                    {
                    }
                    column(CustAddr_3_; CustAddr[3])
                    {
                    }
                    column(CompanyInfo__Phone_No__; CompanyInfo."Phone No.")
                    {
                    }
                    column(CustAddr_1_; CustAddr[1])
                    {
                    }
                    column(CompanyAddr_8_; CompanyAddr[8])
                    {
                    }
                    column(CompanyAddr_7_; CompanyAddr[7])
                    {
                    }
                    column(CompanyAddr_4_; CompanyAddr[4])
                    {
                    }
                    column(CompanyAddr_3_; CompanyAddr[3])
                    {
                    }
                    column(CompanyAddr_2_; CompanyAddr[2])
                    {
                    }
                    column(CompanyAddr_1_; CompanyAddr[1])
                    {
                    }
                    column(CompanyInfo_Picture; CompanyInfo.Picture)
                    {
                    }
                    column(STRSUBSTNO_Text000_FORMAT_CurrReport_PAGENO__; STRSUBSTNO(Text000, FORMAT(CurrReport.PAGENO)))
                    {
                    }
                    column(Sourcetext; Sourcetext)
                    {
                    }
                    column(CompanyInfo__Post_Code_; CompanyInfo."Post Code")
                    {
                    }
                    column(Today; FORMAT(TODAY, 0, 4))
                    {
                    }
                    column(Balance_O_S_Caption; Balance_O_S_CaptionLbl)
                    {
                    }
                    column(BalanceCaption; BalanceCaptionLbl)
                    {
                    }
                    column(Inv_AmountCaption; Inv_AmountCaptionLbl)
                    {
                    }
                    column(Over_Due_ByCaption; Over_Due_ByCaptionLbl)
                    {
                    }
                    column(Due_DateCaption; Due_DateCaptionLbl)
                    {
                    }
                    column(t; Customer__Last_Statement_No__CaptionLbl)
                    {
                    }
                    column(EndDateCaption; EndDateCaptionLbl)
                    {
                    }
                    column(DescriptionCaption; DescriptionCaptionLbl)
                    {
                    }
                    column(StartDateCaption; StartDateCaptionLbl)
                    {
                    }
                    column(TypeCaption; TypeCaptionLbl)
                    {
                    }
                    column(Customer__No__Caption; Customer__No__CaptionLbl)
                    {
                    }
                    column(CompanyInfo__VAT_Registration_No__Caption; CompanyInfo__VAT_Registration_No__CaptionLbl)
                    {
                    }
                    column(CompanyInfo__Fax_No__Caption; CompanyInfo__Fax_No__CaptionLbl)
                    {
                    }
                    column(CompanyInfo__Phone_No__Caption; CompanyInfo__Phone_No__CaptionLbl)
                    {
                    }
                    column(Doc__No_Caption; Doc__No_CaptionLbl)
                    {
                    }
                    column(DateCaption; DateCaptionLbl)
                    {
                    }
                    column(CummulativeCaption; CummulativeCaptionLbl)
                    {
                    }
                    column(pageloop_Number; Number)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        /*IF pageloop.Number=1 THEN BEGIN
                           Sourcetext:='';
                         END ELSE IF pageloop.Number=2 THEN BEGIN
                              Sourcetext:='Receipt';
                         END;
                        */

                    end;

                    trigger OnPreDataItem()
                    begin
                        AgingBandBuf.DELETEALL;
                    end;
                }
                dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
                {
                    DataItemLink = "Customer No." = FIELD("No."),
                                   "Posting Date" = FIELD("Date Filter");
                    DataItemLinkReference = Customer;
                    DataItemTableView = SORTING("Customer No.", "Posting Date", "Currency Code")
                                        WHERE("Remaining Amount" = FILTER(<> 0),
                                              Open = FILTER(true));
                    PrintOnlyIfDetail = false;
                    RequestFilterFields = "Document Type", "Posting Date";
                    column(StartBalance_Control1000000018; StartBalance)
                    {
                    }
                    column(Customer__Last_Statement_No___Control1000000019; Customer."Last Statement No.")
                    {
                        //DecimalPlaces = 0:0;
                    }
                    column(FORMAT_TODAY_0_4__Control1000000021; FORMAT(TODAY, 0, 4))
                    {
                    }
                    column(CompanyInfo__VAT_Registration_No___Control1000000023; CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(CompanyName; CompanyInfo.Name)
                    {
                    }
                    column(CompanyInfo__Fax_No___Control1000000024; CompanyInfo."Fax No.")
                    {
                    }
                    column(CompanyInfo__Phone_No___Control1000000025; CompanyInfo."Phone No.")
                    {
                    }
                    column(CompanyAddr_8__Control1000000026; CompanyAddr[8])
                    {
                    }
                    column(CompanyAddr_7__Control1000000027; CompanyAddr[7])
                    {
                    }
                    column(CompanyAddr_4__Control1000000028; CompanyAddr[4])
                    {
                    }
                    column(CompanyAddr_3__Control1000000032; CompanyAddr[3])
                    {
                    }
                    column(CompanyAddr_2__Control1000000033; CompanyAddr[2])
                    {
                    }
                    column(CompanyAddr_1__Control1000000034; CompanyAddr[1])
                    {
                    }
                    column(STRSUBSTNO_Text000_FORMAT_CurrReport_PAGENO___Control1000000035; STRSUBSTNO(Text000, FORMAT(CurrReport.PAGENO)))
                    {
                    }
                    column(EndDate_Control1000000038; EndDate)
                    {
                    }
                    column(StartDate_Control1000000039; StartDate)
                    {
                    }
                    column(CompanyInfo_Picture_Control1000000043; CompanyInfo.Picture)
                    {
                    }
                    column(CustAddr_8__Control1000000044; CustAddr[8])
                    {
                    }
                    column(CustAddr_7__Control1000000045; CustAddr[7])
                    {
                    }
                    column(CustAddr_6__Control1000000046; CustAddr[6])
                    {
                    }
                    column(CustAddr_5__Control1000000047; CustAddr[5])
                    {
                    }
                    column(CustAddr_4__Control1000000048; CustAddr[4])
                    {
                    }
                    column(CustAddr_2__Control1000000049; CustAddr[2])
                    {
                    }
                    column(CustAddr_3__Control1000000050; CustAddr[3])
                    {
                    }
                    column(CustAddr_1__Control1000000051; CustAddr[1])
                    {
                    }
                    column(Customer__No___Control1000000053; Customer."No.")
                    {
                    }
                    column(Sourcetext_Control1000000057; Sourcetext)
                    {
                    }
                    column(Cust__Ledger_Entry__Cust__Ledger_Entry___Remaining_Amount_; "Cust. Ledger Entry"."Remaining Amount")
                    {
                    }
                    column(CustBalance; CustBalance)
                    {
                    }
                    column(Cust__Ledger_Entry__Cust__Ledger_Entry__Amount; "Cust. Ledger Entry".Amount)
                    {
                    }
                    column(OverDueBy; OverDueBy)
                    {
                        DecimalPlaces = 0 : 0;
                    }
                    column(Cust__Ledger_Entry__Cust__Ledger_Entry___Due_Date_; "Cust. Ledger Entry"."Due Date")
                    {
                    }
                    column(Cust__Ledger_Entry__Cust__Ledger_Entry__Description; "Cust. Ledger Entry".Description)
                    {
                    }
                    column(Cust__Ledger_Entry__Cust__Ledger_Entry___Document_Type_; "Cust. Ledger Entry"."Document Type")
                    {
                    }
                    column(Cust__Ledger_Entry__Cust__Ledger_Entry___Document_No__; "Cust. Ledger Entry"."Document No.")
                    {
                    }
                    column(Cust__Ledger_Entry__Cust__Ledger_Entry___Posting_Date_; "Cust. Ledger Entry"."Posting Date")
                    {
                    }
                    column(var_; var1)
                    {
                    }
                    column(Cust__Ledger_Entry__Cust__Ledger_Entry___Posting_Date__Control1040001; "Cust. Ledger Entry"."Posting Date")
                    {
                    }
                    column(Cust__Ledger_Entry__Cust__Ledger_Entry___Document_No___Control1040002; "Cust. Ledger Entry"."Document No.")
                    {
                    }
                    column(Cust__Ledger_Entry__Cust__Ledger_Entry___Document_Type__Control1040003; "Cust. Ledger Entry"."Document Type")
                    {
                    }
                    column(Cust__Ledger_Entry__Cust__Ledger_Entry__Description_Control1040004; "Cust. Ledger Entry".Description)
                    {
                    }
                    column(Cust__Ledger_Entry__Cust__Ledger_Entry___Due_Date__Control1040005; "Cust. Ledger Entry"."Due Date")
                    {
                    }
                    column(Cust__Ledger_Entry__Cust__Ledger_Entry__Amount_Control1040006; "Cust. Ledger Entry".Amount)
                    {
                    }
                    column(Cust__Ledger_Entry__Cust__Ledger_Entry___Remaining_Amount__Control1040007; "Cust. Ledger Entry"."Remaining Amount")
                    {
                    }
                    column(CustBalance_Control1040008; CustBalance)
                    {
                    }
                    column(OverDueBy_Control1040015; OverDueBy)
                    {
                        DecimalPlaces = 0 : 0;
                    }
                    column(var__Control1000000074; var1)
                    {
                    }
                    column(Total_in______CurrencyCode________; 'Total in ' + CurrencyCode + ' : ')
                    {
                    }
                    column(Cust__Ledger_Entry__Cust__Ledger_Entry__Amount_Control1040031; "Cust. Ledger Entry".Amount)
                    {
                    }
                    column(Cust__Ledger_Entry__Cust__Ledger_Entry___Remaining_Amount__Control1040032; "Cust. Ledger Entry"."Remaining Amount")
                    {
                    }
                    column(Cust__Ledger_Entry__Cust__Ledger_Entry__Amount_Control1040033; "Cust. Ledger Entry".Amount)
                    {
                    }
                    column(Cust__Ledger_Entry__Cust__Ledger_Entry___Remaining_Amount__Control1040034; "Cust. Ledger Entry"."Remaining Amount")
                    {
                    }
                    column(Balance_O_S_Caption_Control1000000016; Balance_O_S_Caption_Control1000000016Lbl)
                    {
                    }
                    column(BalanceCaption_Control1000000017; BalanceCaption_Control1000000017Lbl)
                    {
                    }
                    column(Inv_AmountCaption_Control1000000020; Inv_AmountCaption_Control1000000020Lbl)
                    {
                    }
                    column(Customer__Last_Statement_No___Control1000000019Caption; Customer__Last_Statement_No___Control1000000019CaptionLbl)
                    {
                    }
                    column(CompanyInfo__VAT_Registration_No___Control1000000023Caption; CompanyInfo__VAT_Registration_No___Control1000000023CaptionLbl)
                    {
                    }
                    column(CompanyInfo__Fax_No___Control1000000024Caption; CompanyInfo__Fax_No___Control1000000024CaptionLbl)
                    {
                    }
                    column(CompanyInfo__Phone_No___Control1000000025Caption; CompanyInfo__Phone_No___Control1000000025CaptionLbl)
                    {
                    }
                    column(Over_Due_ByCaption_Control1000000036; Over_Due_ByCaption_Control1000000036Lbl)
                    {
                    }
                    column(Due_DateCaption_Control1000000037; Due_DateCaption_Control1000000037Lbl)
                    {
                    }
                    column(DescriptionCaption_Control1000000040; DescriptionCaption_Control1000000040Lbl)
                    {
                    }
                    column(EndDate_Control1000000038Caption; EndDate_Control1000000038CaptionLbl)
                    {
                    }
                    column(StartDate_Control1000000039Caption; StartDate_Control1000000039CaptionLbl)
                    {
                    }
                    column(TypeCaption_Control1000000052; TypeCaption_Control1000000052Lbl)
                    {
                    }
                    column(Doc__No_Caption_Control1000000054; Doc__No_Caption_Control1000000054Lbl)
                    {
                    }
                    column(Customer__No___Control1000000053Caption; Customer__No___Control1000000053CaptionLbl)
                    {
                    }
                    column(DateCaption_Control1000000056; DateCaption_Control1000000056Lbl)
                    {
                    }
                    column(CummulativeCaption_Control1000000071; CummulativeCaption_Control1000000071Lbl)
                    {
                    }
                    column(ContinuedCaption; ContinuedCaptionLbl)
                    {
                    }
                    column(Cust__Ledger_Entry_Entry_No_; "Entry No.")
                    {
                    }
                    column(Cust__Ledger_Entry_Customer_No_; "Customer No.")
                    {
                    }
                    column(ExternalDocumentNo_CustLedgerEntry; "Cust. Ledger Entry"."External Document No.")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        CustBalance := CustBalance + "Cust. Ledger Entry".Amount;

                        TotalAmount := TotalAmount + "Cust. Ledger Entry".Amount;

                        "Cust. Ledger Entry".CALCFIELDS("Cust. Ledger Entry"."Remaining Amount");
                        TotalRemaingAmount := TotalRemaingAmount + "Cust. Ledger Entry"."Remaining Amount";

                        OverDueBy := WORKDATE - "Cust. Ledger Entry"."Due Date";
                        //IF IncludeAgingBand AND ("Posting Date" <= EndDate) THEN
                        UpdateBuffer(Currency2.Code, "Due Date", "Remaining Amount");




                        var1 := var1 + "Cust. Ledger Entry"."Remaining Amount";



                        IF PrintToExcel THEN BEGIN
                            MakeExcelDataBody;
                        END;
                    end;

                    trigger OnPostDataItem()
                    begin
                        CustBalance := CustBalance;
                    end;

                    trigger OnPreDataItem()
                    begin
                        CustBalance := 0;
                        Cust2 := Customer;
                        Cust2.SETRANGE("Date Filter", 0D, StartDate - 1);
                        Cust2.CALCFIELDS("Net Change");
                        StartBalance := Cust2."Net Change";
                        CustBalance := StartBalance;
                        TotalAmount := 0;
                        TotalRemaingAmount := 0;
                        var1 := 0;
                    end;
                }
                dataitem(AgingBandLoop; Integer)
                {
                    DataItemLinkReference = Customer;
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = FILTER(1 ..));
                    column(STRSUBSTNO_Text011_AgingBandEndingDate_PeriodLength_SELECTSTR_DateChoice___1_Text013__; STRSUBSTNO(Text011, AgingBandEndingDate, PeriodLength, SELECTSTR(DateChoice + 1, Text013)))
                    {
                    }
                    column(Total_in______CurrencyCode_________Control1000000007; 'Total in ' + CurrencyCode + ' : ')
                    {
                    }
                    column(AgingBandBuf__Column_1_Amt__; AgingBandBuf."Column 1 Amt.")
                    {
                        AutoFormatExpression = AgingBandBuf."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(AgingBandBuf__Column_2_Amt__; AgingBandBuf."Column 2 Amt.")
                    {
                        AutoFormatExpression = AgingBandBuf."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(AgingBandBuf__Column_3_Amt__; AgingBandBuf."Column 3 Amt.")
                    {
                        AutoFormatExpression = AgingBandBuf."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(AgingBandBuf__Column_5_Amt__; AgingBandBuf."Column 5 Amt.")
                    {
                        AutoFormatExpression = AgingBandBuf."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(AgingBandBuf__Column_4_Amt__; AgingBandBuf."Column 4 Amt.")
                    {
                        AutoFormatExpression = AgingBandBuf."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(Cust__Ledger_Entry___Remaining_Amount_; "Cust. Ledger Entry"."Remaining Amount")
                    {
                    }
                    column(Not_DueCaption; Not_DueCaptionLbl)
                    {
                    }
                    column(V0_30_DaysCaption; V0_30_DaysCaptionLbl)
                    {
                    }
                    column(V30_60_DaysCaption; V30_60_DaysCaptionLbl)
                    {
                    }
                    column(V60_90_DaysCaption; V60_90_DaysCaptionLbl)
                    {
                    }
                    column(V90__DaysCaption; V90__DaysCaptionLbl)
                    {
                    }
                    column(V0_30_DaysCaption_Control1000000076; V0_30_DaysCaption_Control1000000076Lbl)
                    {
                    }
                    column(V30_60_DaysCaption_Control1000000077; V30_60_DaysCaption_Control1000000077Lbl)
                    {
                    }
                    column(V60_90_DaysCaption_Control1000000078; V60_90_DaysCaption_Control1000000078Lbl)
                    {
                    }
                    column(V90__DaysCaption_Control1000000079; V90__DaysCaption_Control1000000079Lbl)
                    {
                    }
                    column(AgingBandLoop_Number; Number)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        IF Number = 1 THEN BEGIN
                            IF NOT AgingBandBuf.FIND('-') THEN
                                CurrReport.BREAK;
                        END ELSE
                            IF AgingBandBuf.NEXT = 0 THEN
                                CurrReport.BREAK;
                        AgingBandCurrencyCode := AgingBandBuf."Currency Code";
                        IF AgingBandCurrencyCode = '' THEN
                            AgingBandCurrencyCode := GLSetup."LCY Code";
                    end;
                }
                dataitem(Customer1; 18)
                {
                    DataItemLink = "No." = FIELD("No.");
                    DataItemLinkReference = Customer;
                    DataItemTableView = SORTING("No.");
                    column(SWIFT_CODE__________BankAcc_Rec__SWIFT_Code_____IBAN_________BankAcc_Rec_IBAN; 'SWIFT CODE :    ' + BankAcc_Rec."SWIFT Code" + '  IBAN :   ' + BankAcc_Rec.IBAN)
                    {
                    }
                    column(SORT_CODE___________BankAcc_Rec__Bank_Branch_No_______ACCOUNT_NUMBER__________BankAcc_Rec__Bank_Account_No__; 'SORT CODE :    ' + BankAcc_Rec."Bank Branch No." + '   ACCOUNT NUMBER :    ' + BankAcc_Rec."Bank Account No.")
                    {
                    }
                    column(THE_WELLSPRINGS_BOLTON_BL1_1BY_; 'THE WELLSPRINGS,BOLTON BL1 1BY')
                    {
                    }
                    column(For_and_on_behalf_of____COMPANYNAME; 'For and on behalf of ' + COMPANYNAME)
                    {
                    }
                    column(Terms____Customer__Payment_Terms_Code_______from__Document_Date_; 'Terms ' + Customer."Payment Terms Code" + '  from  Document Date')
                    {
                    }
                    column(Fax____CompanyInfo__Fax_No__; 'Fax: ' + CompanyInfo."Fax No.")
                    {
                    }
                    column(Statement_please_telephone_____CompanyInfo__Phone_No__; 'Statement please telephone ' + CompanyInfo."Phone No.")
                    {
                    }
                    column(Yours_Sincerely__; 'Yours Sincerely,')
                    {
                    }
                    column(Accounts_Department_; 'Accounts Department')
                    {
                    }
                    column(Credit_Control_Manager_; 'Credit Control Manager')
                    {
                    }
                    column(BARCLAYS_BANK_PLC_THE_WELLSPRINGS_; 'BARCLAYS BANK PLC,THE WELLSPRINGS')
                    {
                    }
                    column(If_you_have_any_queries_concerning_thisCaption; If_you_have_any_queries_concerning_thisCaptionLbl)
                    {
                    }
                    column(Please_pay_all_due_invoices_todayCaption; Please_pay_all_due_invoices_todayCaptionLbl)
                    {
                    }
                    column(Customer1_No_; "No.")
                    {
                    }
                    column(Paymenttermcode; Customer."Payment Terms Code")
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin

                    IF Number > 1 THEN
                        CopyText := Text003;
                    CurrReport.PAGENO := 1;
                    IF copyloop.Number = 1 THEN BEGIN
                        Sourcetext := 'Statement';
                    END ELSE IF (copyloop.Number = 2)
                         AND (FORMAT("Cust. Ledger Entry"."Document Type") <> 'Invoice') THEN BEGIN
                        Sourcetext := 'Remittance';
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    //NoOfLoops := ABS(2); //+ Cust."Invoice Copies" + 1;

                    IF NoOfLoops <= 0 THEN
                        NoOfLoops := 1;
                    //CopyText := '';

                    SETRANGE(Number, 1, NoOfLoops);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CurrReport.Language := LanguageMgt.GetLanguageIdOrDefault("Language Code");
                //CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");
                PrintLine := FALSE;
                Cust2 := Customer;
                //COPYFILTER("Currency Filter",Currency2.Code);
                FormatAddr.Customer(CustAddr, Customer);
                CurrReport.PAGENO := 1;

                IF NOT CurrReport.PREVIEW THEN BEGIN
                    Customer.LOCKTABLE;
                    Customer.FIND;
                    Customer."Last Statement No." := Customer."Last Statement No." + 1;
                    Customer.MODIFY;
                    COMMIT;
                END ELSE
                    Customer."Last Statement No." := Customer."Last Statement No." + 1;

                CurrencyCode := "Currency Code";
                IF CurrencyCode = '' THEN BEGIN
                    CurrencyCode := 'GBP';
                END;

                BankAcc_Rec.SETRANGE(BankAcc_Rec."Currency Code", "Currency Code");
                BankAcc_Rec.SETRANGE(BankAcc_Rec."Default Bank For Print", TRUE);
                IF BankAcc_Rec.FINDFIRST THEN;
                AgingBandBuf.DELETEALL;

                CompanyInfo.GET;
                CompanyInfo.CALCFIELDS(CompanyInfo.Picture);

                //Sofyan++
                CLEAR(AccountNo);
                CLEAR(SortCode);
                CLEAR(BankName);
                AccountNo := CompanyInfo."Bank Account No.";
                SortCode := CompanyInfo."Bank Branch No.";
                BankName := CompanyInfo."Bank Name";



                CustLedgerEntry.RESET;
                CustLedgerEntry.SETRANGE("Customer No.", Customer."No.");
                CustLedgerEntry.SETFILTER("Remaining Amount", '<>%1', 0);
                CustLedgerEntry.SETFILTER(Open, '%1', TRUE);
                CustLedgerEntry.SETFILTER("Posting Date", Customer.GETFILTER("Date Filter"));
                IF CustLedgerEntry.FINDSET THEN BEGIN
                    REPEAT
                        VATEntry.RESET;
                        VATEntry.SETRANGE("Document No.", CustLedgerEntry."Document No.");
                        VATEntry.SETRANGE("Posting Date", CustLedgerEntry."Posting Date");
                        IF VATEntry.FINDSET THEN BEGIN
                            REPEAT
                                VATPostingSetup.RESET;
                                VATPostingSetup.SETRANGE("VAT Bus. Posting Group", VATEntry."VAT Bus. Posting Group");
                                VATPostingSetup.SETRANGE("VAT Prod. Posting Group", VATEntry."VAT Prod. Posting Group");
                                IF VATPostingSetup.FINDFIRST THEN BEGIN
                                    IF VATPostingSetup."VAT %" = 0 THEN BEGIN
                                        VatAmt0 += VATEntry.Amount;
                                        VatBase0 += VATEntry.Base;
                                    END ELSE
                                        IF VATPostingSetup."VAT %" = 5 THEN BEGIN
                                            VatAmt5 += VATEntry.Amount;
                                            VatBase5 += VATEntry.Base;
                                        END ELSE
                                            IF VATPostingSetup."VAT %" = 20 THEN BEGIN
                                                VatAmt20 += VATEntry.Amount;
                                                VatBase20 += VATEntry.Base;
                                            END
                                END;
                            UNTIL VATEntry.NEXT = 0;
                        END;
                    UNTIL CustLedgerEntry.NEXT = 0;
                END;

                //Sofyan--
                FinalVAT0 := 0;
                FinalBase0 := 0;
                FinalVAT5 := 0;
                FinalBase5 := 0;
                FinalVAT20 := 0;
                FinalBase20 := 0;
                IF VatAmt0 <> 0 THEN
                    FinalVAT0 := VatAmt0;

                IF VatBase0 <> 0 THEN
                    FinalBase0 := VatBase0;

                IF VatAmt20 <> 0 THEN
                    FinalVAT20 := VatAmt20;

                IF VatBase20 <> 0 THEN
                    FinalBase20 := VatBase20;

                IF VatAmt5 <> 0 THEN
                    FinalVAT5 := VatAmt5;

                IF VatBase5 <> 0 THEN
                    FinalBase5 := VatBase5;

                //Sofyan --
            end;

            trigger OnPreDataItem()
            begin
                IF Customer.GETFILTER("Date Filter") = '' THEN BEGIN
                    StartDate := DMY2DATE(1, 5, 2000);
                    EndDate := WORKDATE;
                END ELSE BEGIN
                    StartDate := GETRANGEMIN("Date Filter");
                    EndDate := GETRANGEMAX("Date Filter");
                END;
                AgingBandEndingDate := EndDate;
                CompanyInfo.GET;
                CompanyInfo.CALCFIELDS(CompanyInfo.Picture);
                FormatAddr.Company(CompanyAddr, CompanyInfo);
                Currency2.Code := '';
                Currency2.INSERT;
                COPYFILTER("Currency Filter", Currency.Code);
                IF Currency.FIND('-') THEN
                    REPEAT
                        Currency2 := Currency;
                        Currency2.INSERT;
                    UNTIL Currency.NEXT = 0;

                CalcAgingBandDates;
                //AgingBandBuf.DELETEALL;
                //Sofyan ++
                CLEAR(VatAmt0);
                CLEAR(VatBase0);
                CLEAR(VatAmt5);
                CLEAR(VatBase5);
                CLEAR(VatAmt20);
                CLEAR(VatBase20);
                //Sofyan --
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Option)
                {
                    Caption = 'Option';
                    field(NoOfLoops; NoOfLoops)
                    {
                        Caption = 'No Of Copies';
                    }
                    field(PrintToExcel; PrintToExcel)
                    {
                        Caption = 'Print To Excel';
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

    trigger OnInitReport()
    begin
        GLSetup.GET;
    end;

    trigger OnPostReport()
    begin
        IF PrintToExcel THEN
            CreateExcelbook;
    end;

    trigger OnPreReport()
    begin

        IF PrintToExcel THEN BEGIN
            ExcelBuf.DELETEALL;
            MakeExcelInfo;
        END;

        EVALUATE(PeriodLength, '<1M+CM>');
    end;

    var
        GLSetup: Record 98;
        CompanyInfo: Record 79;
        Cust2: Record 18;
        cust3: Record 18;
        Currency: Record 4;
        Currency2: Record 4 temporary;
        //Language: Record 8;
        DtldCustLedgEntries2: Record 379;
        AgingBandBuf: Record 47 temporary;
        PrintAllHavingEntry: Boolean;
        PrintAllHavingBal: Boolean;
        PrintEntriesDue: Boolean;
        PrintUnappliedEntries: Boolean;
        PrintReversedEntries: Boolean;
        PrintLine: Boolean;
        LogInteraction: Boolean;
        EntriesExists: Boolean;
        StartDate: Date;
        EndDate: Date;
        "Due Date": Date;
        CustAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        Description: Text[50];
        StartBalance: Decimal;
        CustBalance: Decimal;
        "Remaining Amount": Decimal;
        FormatAddr: Codeunit 365;
        SegManagement: Codeunit 5051;
        CurrencyCode3: Code[10];
        PeriodLength: DateFormula;
        PeriodLength2: DateFormula;
        DateChoice: Option "Due Date","Posting Date";
        AgingDate: array[5] of Date;
        AgingBandEndingDate: Date;
        IncludeAgingBand: Boolean;
        AgingBandCurrencyCode: Code[10];
        DocType: Option " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        TotalAmount: Decimal;
        TotalRemaingAmount: Decimal;
        OverDueBy: Decimal;
        CurrencyCode: Code[20];
        BankAcc_Rec: Record 270;
        PrintToExcel: Boolean;
        ExcelBuf: Record 370;
        NoOfLoops: Integer;
        CopyText: Text[30];
        Sourcetext: Text[30];
        var1: Decimal;
        Text000: Label 'Page %1';
        Text001: Label 'Entries %1';
        Text002: Label 'Overdue Entries %1';
        Text003: Label 'Statement ';
        Text005: Label 'Multicurrency Application';
        Text006: Label 'Payment Discount';
        Text007: Label 'Rounding';
        Text008: Label 'You must specify the Aging Band Period Length.';
        Text010: Label 'You must specify Aging Band Ending Date.';
        Text011: Label 'Aged Summary by %1 (%2 by %3)';
        Text012: Label 'Period Length is out of range.';
        Text013: Label 'Due Date,Posting Date';
        Text014: Label 'Application Writeoffs';
        Balance_O_S_CaptionLbl: Label 'Balance O/S.';
        BalanceCaptionLbl: Label 'Balance';
        Inv_AmountCaptionLbl: Label 'Inv Amount';
        Over_Due_ByCaptionLbl: Label 'Over Due By';
        Due_DateCaptionLbl: Label 'Due Date';
        Customer__Last_Statement_No__CaptionLbl: Label 'Statement No.';
        EndDateCaptionLbl: Label 'Ending Date';
        DescriptionCaptionLbl: Label 'Description';
        StartDateCaptionLbl: Label 'Starting Date';
        TypeCaptionLbl: Label 'Type';
        Customer__No__CaptionLbl: Label 'Customer No.';
        CompanyInfo__VAT_Registration_No__CaptionLbl: Label 'VAT Reg. No.';
        CompanyInfo__Fax_No__CaptionLbl: Label 'Fax No.';
        CompanyInfo__Phone_No__CaptionLbl: Label 'Phone No.';
        Doc__No_CaptionLbl: Label 'Doc. No.';
        DateCaptionLbl: Label 'Date';
        CummulativeCaptionLbl: Label 'Cummulative';
        Balance_O_S_Caption_Control1000000016Lbl: Label 'Balance O/S.';
        BalanceCaption_Control1000000017Lbl: Label 'Balance';
        Inv_AmountCaption_Control1000000020Lbl: Label 'Inv Amount';
        Customer__Last_Statement_No___Control1000000019CaptionLbl: Label 'Statement No.';
        CompanyInfo__VAT_Registration_No___Control1000000023CaptionLbl: Label 'VAT Reg. No.';
        CompanyInfo__Fax_No___Control1000000024CaptionLbl: Label 'Fax No.';
        CompanyInfo__Phone_No___Control1000000025CaptionLbl: Label 'Phone No.';
        Over_Due_ByCaption_Control1000000036Lbl: Label 'Over Due By';
        Due_DateCaption_Control1000000037Lbl: Label 'Due Date';
        DescriptionCaption_Control1000000040Lbl: Label 'Description';
        EndDate_Control1000000038CaptionLbl: Label 'Ending Date';
        StartDate_Control1000000039CaptionLbl: Label 'Starting Date';
        TypeCaption_Control1000000052Lbl: Label 'Type';
        Doc__No_Caption_Control1000000054Lbl: Label 'Doc. No.';
        Customer__No___Control1000000053CaptionLbl: Label 'Customer No.';
        DateCaption_Control1000000056Lbl: Label 'Date';
        CummulativeCaption_Control1000000071Lbl: Label 'Cummulative';
        ContinuedCaptionLbl: Label 'Continued';
        Not_DueCaptionLbl: Label 'Not Due';
        V0_30_DaysCaptionLbl: Label '0-30 Days';
        V30_60_DaysCaptionLbl: Label '30-60 Days';
        V60_90_DaysCaptionLbl: Label '60-90 Days';
        V90__DaysCaptionLbl: Label '90+ Days';
        V0_30_DaysCaption_Control1000000076Lbl: Label ' 0-30 Days';
        V30_60_DaysCaption_Control1000000077Lbl: Label '30-60 Days';
        V60_90_DaysCaption_Control1000000078Lbl: Label ' 60-90 Days';
        V90__DaysCaption_Control1000000079Lbl: Label '90+ Days';
        If_you_have_any_queries_concerning_thisCaptionLbl: Label 'If you have any queries concerning this';
        Please_pay_all_due_invoices_todayCaptionLbl: Label 'Please pay all due invoices today';
        AccountNo: Code[30];
        SortCode: Code[30];
        BankName: Text[30];
        VATEntry: Record 254;
        VatAmt0: Decimal;
        VatBase0: Decimal;
        CustLedgerEntry: Record 21;
        FinalVAT0: Decimal;
        FinalBase0: Decimal;
        VatAmt5: Decimal;
        VatBase5: Decimal;
        FinalVAT5: Decimal;
        FinalBase5: Decimal;
        VatAmt20: Decimal;
        VatBase20: Decimal;
        FinalVAT20: Decimal;
        FinalBase20: Decimal;
        VATPostingSetup: Record 325;
        LanguageMgt: Codeunit Language;

    local procedure GetDate(PostingDate: Date; DueDate: Date): Date
    begin
    end;

    local procedure CalcAgingBandDates()
    begin
        //IF NOT IncludeAgingBand THEN
        //EXIT;
        IF AgingBandEndingDate = 0D THEN
            ERROR(Text010);
        IF FORMAT(PeriodLength) = '' THEN
            ERROR(Text008);
        EVALUATE(PeriodLength2, '-' + FORMAT(PeriodLength));
        AgingDate[5] := AgingBandEndingDate;
        AgingDate[4] := CALCDATE(PeriodLength2, AgingDate[5]);
        AgingDate[3] := CALCDATE(PeriodLength2, AgingDate[4]);
        AgingDate[2] := CALCDATE(PeriodLength2, AgingDate[3]);
        AgingDate[1] := CALCDATE(PeriodLength2, AgingDate[2]);
        IF AgingDate[2] <= AgingDate[1] THEN
            ERROR(Text012);
    end;

    local procedure UpdateBuffer(CurrencyCode: Code[10]; Date: Date; Amount: Decimal)
    var
        I: Integer;
        GoOn: Boolean;
    begin
        AgingBandBuf.INIT;
        AgingBandBuf."Currency Code" := CurrencyCode;
        IF NOT AgingBandBuf.FIND THEN
            AgingBandBuf.INSERT;
        I := 1;
        GoOn := TRUE;
        WHILE (I <= 5) AND GoOn DO BEGIN
            OverDueBy := WORKDATE - "Cust. Ledger Entry"."Due Date";
            IF OverDueBy < 0 THEN
                IF I = 1 THEN BEGIN
                    AgingBandBuf."Column 1 Amt." := AgingBandBuf."Column 1 Amt." + Amount;
                    GoOn := FALSE;
                END;
            IF (OverDueBy > 90) THEN
                IF I = 2 THEN BEGIN
                    AgingBandBuf."Column 2 Amt." := AgingBandBuf."Column 2 Amt." + Amount;
                    GoOn := FALSE;
                END;
            IF (OverDueBy > 60) AND (OverDueBy <= 90) THEN
                IF I = 3 THEN BEGIN
                    AgingBandBuf."Column 3 Amt." := AgingBandBuf."Column 3 Amt." + Amount;
                    GoOn := FALSE;
                END;
            IF (OverDueBy > 30) AND (OverDueBy <= 60) THEN
                IF I = 4 THEN BEGIN
                    AgingBandBuf."Column 4 Amt." := AgingBandBuf."Column 4 Amt." + Amount;
                    GoOn := FALSE;
                END;
            IF (OverDueBy >= 0) AND (OverDueBy <= 30) THEN
                IF I = 5 THEN BEGIN
                    AgingBandBuf."Column 5 Amt." := AgingBandBuf."Column 5 Amt." + Amount;
                    GoOn := FALSE;
                END;
            I := I + 1;
        END;
        AgingBandBuf.MODIFY;
    end;

    procedure SkipReversedUnapplied(var DtldCustLedgEntries: Record 379): Boolean
    var
        CustLedgEntry: Record 21;
    begin
    end;

    procedure MakeExcelInfo()
    begin

        ExcelBuf.SetUseInfoSheet;
        ExcelBuf.AddInfoColumn('Company Name', FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(COMPANYNAME, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn('Report Name', FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn('Customer Statement OUTS.', FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn('Reprot No', FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(50050, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn('User id', FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(USERID, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn('Date', FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(TODAY, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn('Customer Filter', FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(Customer.GETFILTERS, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn('Customer Ledger Entry Filter', FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn("Cust. Ledger Entry".GETFILTERS, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.ClearNewRow;
        MakeExcelDataHeader;
    end;

    local procedure MakeExcelDataHeader()
    begin

        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(Customer.FIELDCAPTION("No."), FALSE, '', TRUE, FALSE, TRUE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Customer.FIELDCAPTION(Name), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Cust. Ledger Entry".FIELDCAPTION("Posting Date"), FALSE, '', TRUE, FALSE, TRUE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Cust. Ledger Entry".FIELDCAPTION("Document No."), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Cust. Ledger Entry".FIELDCAPTION(Description), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Cust. Ledger Entry".FIELDCAPTION("Due Date"), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Over Due By', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Cust. Ledger Entry".FIELDCAPTION(Amount), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Cust. Ledger Entry".FIELDCAPTION("Remaining Amount"), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
    end;

    procedure MakeExcelDataBody()
    begin

        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(Customer."No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Customer.Name, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Cust. Ledger Entry"."Posting Date", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Cust. Ledger Entry"."Document No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Cust. Ledger Entry".Description, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Cust. Ledger Entry"."Due Date", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(OverDueBy, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Cust. Ledger Entry".Amount, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Cust. Ledger Entry"."Remaining Amount", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
    end;

    // procedure CreateExcelbook()
    // begin
    //     /*
    // ExcelBuf.CreateBook;
    // ExcelBuf.CreateSheet(Text001,Text002,COMPANYNAME,USERID);
    // ExcelBuf.GiveUserControl;
    // ERROR('');
    //      */

    //     ExcelBuf.CreateBookAndOpenExcel('', Text001, Text002, COMPANYNAME, USERID);
    //     ERROR('');

    // end;

    procedure CreateExcelbook()
    begin
        ExcelBuf.CreateNewBook(text001);
        ExcelBuf.WriteSheet(text001, CompanyName, UserId);
        ExcelBuf.CloseBook();
        ExcelBuf.SetFriendlyFilename(StrSubstNo(text001, CurrentDateTime, UserId));
        ExcelBuf.OpenExcel();
    end;
}

