report 60042 "Customer By Area"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Customer By Area.rdlc';

    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Customer By Area';
    ProcessingOnly = true;
    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = false;
            RequestFilterFields = "No.";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            // Deprecated since 1.0 - report has no active layout (ProcessingOnly = true, no .rdlc present); unreferenced
            //column(CurrReport_PAGENO; CurrReport.PAGENO)
            //{
            //}
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(USERID; USERID)
            {
            }
            column(Customer_TABLECAPTION__________SalespersonFilter; Customer.TABLECAPTION + ': ' + SalespersonFilter)
            {
            }
            column(BilltoCust; BilltoCust)
            {
            }
            column(BilltoCustdesc; BilltoCustdesc)
            {
            }
            column(Customer_Customer_Name; Customer.Name)
            {
            }
            column(GroupSale; GroupSale)
            {
            }
            column(GroupProfit; GroupProfit)
            {
            }
            column(G__Margin___; "G. Margin %")
            {
            }
            column(Gross_YTD_; "Gross YTD")
            {
            }
            column(GrossMarginYTD; GrossMarginYTD)
            {
            }
            column(G__Marg____; "G. Marg. %")
            {
            }
            column(Total_Sales_Profit_; "Total Sales Profit")
            {
            }
            column(Total_Profit_; "Total Profit")
            {
            }
            column(Total_G__Margin___; "Total G. Margin %")
            {
            }
            column(Total_G__Marg____; "Total G. Marg. %")
            {
            }
            column(Total_GrossMarginYTD_; "Total GrossMarginYTD")
            {
            }
            column(Total_Gross_YTD_; "Total Gross YTD")
            {
            }
            column(Sales_by_SalespersonCaption; Sales_by_SalespersonCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(All_amounts_are_in_LCYCaption; All_amounts_are_in_LCYCaptionLbl)
            {
            }
            column(Customer_No_Caption; Customer_No_CaptionLbl)
            {
            }
            column(Sales_LCYCaption; Sales_LCYCaptionLbl)
            {
            }
            column(Customer_NameCaption; Customer_NameCaptionLbl)
            {
            }
            column(MarginCaption; MarginCaptionLbl)
            {
            }
            column(Margin__Caption; Margin__CaptionLbl)
            {
            }
            column(SalespersonCaption; SalespersonCaptionLbl)
            {
            }
            column(Gross_YTDCaption; Gross_YTDCaptionLbl)
            {
            }
            column(MarginCaption_Control1000000014; MarginCaption_Control1000000014Lbl)
            {
            }
            column(Margin__Caption_Control1000000015; Margin__Caption_Control1000000015Lbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(Customer_No_; "No.")
            {
            }
            column(GMArg; "G. Marg. %")
            {
            }
            column(GMargin; "G. Margin %")
            {
            }

            trigger OnAfterGetRecord()
            begin
                AgingBandBuf1 := 0;
                AgingBandBuf2 := 0;
                AgingBandBuf3 := 0;
                AgingBandBuf4 := 0;
                AgingBandBuf5 := 0;
                Profit := 0;
                "M%" := 0;
                IF AgingBandBuf.FINDFIRST THEN BEGIN
                    REPEAT
                        AgingBandBuf."Currency Code" := '';
                        AgingBandBuf."Column 1 Amt." := 0;
                        AgingBandBuf."Column 2 Amt." := 0;
                        AgingBandBuf."Column 3 Amt." := 0;
                        AgingBandBuf."Column 4 Amt." := 0;
                        AgingBandBuf."Column 5 Amt." := 0;
                        AgingBandBuf.MODIFY;
                    UNTIL AgingBandBuf.NEXT = 0;
                END;
                valueentry.SETRANGE(valueentry."Source No.", Customer."No.");
                valueentry.SETRANGE(valueentry."Item Ledger Entry Type", valueentry."Item Ledger Entry Type"::Sale);

                IF valueentry.FINDFIRST THEN
                    REPEAT
                        IF NOT AgingBandBuf.FIND THEN
                            AgingBandBuf.INSERT;
                        i := 1;
                        GoOn := TRUE;
                        WHILE (i <= 5) AND GoOn DO BEGIN
                            IF valueentry."Posting Date" <= AgingDate[i] THEN
                                IF i = 1 THEN BEGIN
                                    AgingBandBuf."Column 1 Amt." := AgingBandBuf."Column 1 Amt." + valueentry."Sales Amount (Actual)";
                                    GoOn := FALSE;
                                END;
                            IF valueentry."Posting Date" <= AgingDate[i] THEN
                                IF i = 2 THEN BEGIN
                                    AgingBandBuf."Column 2 Amt." := AgingBandBuf."Column 2 Amt." + valueentry."Sales Amount (Actual)";
                                    GoOn := FALSE;
                                END;
                            IF valueentry."Posting Date" <= AgingDate[i] THEN
                                IF i = 3 THEN BEGIN
                                    AgingBandBuf."Column 3 Amt." := AgingBandBuf."Column 3 Amt." + valueentry."Sales Amount (Actual)";
                                    GoOn := FALSE;
                                END;
                            IF valueentry."Posting Date" <= AgingDate[i] THEN
                                IF i = 4 THEN BEGIN
                                    AgingBandBuf."Column 4 Amt." := AgingBandBuf."Column 4 Amt." + valueentry."Sales Amount (Actual)";
                                    GoOn := FALSE;
                                END;
                            IF valueentry."Posting Date" <= AgingDate[i] THEN
                                IF i = 5 THEN BEGIN
                                    AgingBandBuf."Column 5 Amt." := AgingBandBuf."Column 5 Amt." + valueentry."Sales Amount (Actual)";
                                    GoOn := FALSE;
                                END;
                            i := i + 1;
                        END;
                        AgingBandBuf.MODIFY;
                    UNTIL valueentry.NEXT = 0;
                calculatesalesvalue;
                IF Printtoexcel THEN
                    MakeExcelDataBody;
            end;

            trigger OnPreDataItem()
            begin
                IF "To Date" = 0D THEN BEGIN
                    StartDate := DMY2DATE(1, 5, 2000);
                    EndDate := WORKDATE;
                END ELSE BEGIN
                    StartDate := "To Date";
                    EndDate := "To Date";
                END;
                AgingBandEndingDate := EndDate;
                //cnt:=1;
                AgingBandBuf.DELETEALL;
                GroupSale := 0;
                GroupProfit := 0;
                "Net Cur.Mth." := 0;
                Disc := 0;
                CalcAgingBandDates;
                IF Printtoexcel THEN
                    MakeExcelDataHeader;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(option)
                {
                    field("To Date"; "To Date")
                    {
                    }
                    field(Printtoexcel; Printtoexcel)
                    {
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

    trigger OnPostReport()
    begin
        //IF CurrReport.PREVIEW THEN
        IF Printtoexcel THEN
            CreateExcelbook;
    end;

    trigger OnPreReport()
    begin
        IF "To Date" = 0D THEN
            ERROR('You must enter the To Date !');
        //IF "From Date" = 0D THEN
        // ERROR('You must enter the From Date !');
        EVALUATE(PeriodLength, '<1M+CM>');
        IF Printtoexcel THEN
            MakeExcelInfo;
    end;

    var
        SalespersonFilter: Text[250];
        CustLedgEntryFilter: Text[250];
        PeriodText: Text[30];
        AdjProfit: Decimal;
        ProfitCommissionAmt: Decimal;
        AdjProfitCommissionAmt: Decimal;
        SalesCommissionAmt: Decimal;
        PrintOnlyOnePerPage: Boolean;
        PageGroupNo: Integer;
        SalesAmount: Decimal;
        "To Date": Date;
        Bln: Boolean;
        "Cust. Name": Text[50];
        "Cust.": Record 18;
        Territory: Text[30];
        "G. Margin %": Decimal;
        "Net Cur.Mth.": Decimal;
        "N. Margin %": Decimal;
        "Total Sales Profit": Decimal;
        "Total Profit": Decimal;
        //"Accounting Period GB": Record 10560;
        "Gross YTD": Decimal;
        SDay: Integer;
        SMonth: Integer;
        SYear: Integer;
        PeriodStart: Date;
        EDay: Integer;
        EMonth: Integer;
        EYear: Integer;
        CDay: Integer;
        CMonth: Integer;
        CYear: Integer;
        "Value Entry Rec": Record 5802;
        GrossMarginYTD: Decimal;
        Disc: Decimal;
        "Disc YTD": Decimal;
        "Net YTD": Decimal;
        "G. Marg. %": Decimal;
        "Gross N. Margin": Decimal;
        "Gross N. Margin %": Decimal;
        "Total G. Margin %": Decimal;
        "Total Disc": Decimal;
        "Total Net Cur.Mth.": Decimal;
        "Net Margin": Decimal;
        "Total Net Margin": Decimal;
        "Total N. Margin %": Decimal;
        "Total Gross YTD": Decimal;
        "Total GrossMarginYTD": Decimal;
        "Total G. Marg. %": Decimal;
        "Total Disc YTD": Decimal;
        "Total Net YTD": Decimal;
        "Total Gross N. Margin": Decimal;
        "Total Gross N. Margin %": Decimal;
        GroupSale: Decimal;
        GroupProfit: Decimal;
        Printtoexcel: Boolean;
        ExcelBuf: Record 370 temporary;
        "Sales Invoice Line Rec": Record 113;
        Profit: Decimal;
        Custledgerentry: Record 21;
        BilltoCust: Code[20];
        BilltoCustdesc: Text[50];
        CustBillto: Record 18;
        Custno: Code[20];
        "From Date": Date;
        FromMonth: Integer;
        ToMonth: Integer;
        TotalPeriodLength: Integer;
        PeriodLength: DateFormula;
        StartDate: Date;
        EndDate: Date;
        AgingBandEndingDate: Date;
        AgingBandBuf: Record 47 temporary;
        PeriodLength2: DateFormula;
        AgingDate: array[5] of Date;
        valueentry: Record 5802;
        i: Integer;
        Salesvalue: array[5] of Decimal;
        GoOn: Boolean;
        AgingBandBuf1: Decimal;
        AgingBandBuf2: Decimal;
        AgingBandBuf3: Decimal;
        AgingBandBuf4: Decimal;
        AgingBandBuf5: Decimal;
        month: Integer;
        monthtext: Text[50];
        month1: Integer;
        month2: Integer;
        month3: Integer;
        "M%": Decimal;
        Text000: Label 'Period: %1';
        Text001: Label 'DATA';
        Text002: Label 'Customer By Area';
        Sales_by_SalespersonCaptionLbl: Label 'Sales by Salesperson';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        All_amounts_are_in_LCYCaptionLbl: Label 'All amounts are in LCY';
        Customer_No_CaptionLbl: Label 'Customer No.';
        Sales_LCYCaptionLbl: Label 'Sales LCY';
        Customer_NameCaptionLbl: Label 'Customer Name';
        MarginCaptionLbl: Label 'Margin';
        Margin__CaptionLbl: Label 'Margin %';
        SalespersonCaptionLbl: Label 'Salesperson';
        Gross_YTDCaptionLbl: Label 'Gross YTD';
        MarginCaption_Control1000000014Lbl: Label 'Margin';
        Margin__Caption_Control1000000015Lbl: Label 'Margin %';
        TotalCaptionLbl: Label 'Total';

    procedure MakeExcelInfo()
    begin
        ExcelBuf.SetUseInfoSheet;
        ExcelBuf.AddInfoColumn('Company Name', FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(COMPANYNAME, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn('Report Name', FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(FORMAT(Text002), FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn('Report No', FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(50063, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn('User Id', FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(USERID, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn('Date', FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(TODAY, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Date);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn('Filter', FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(Customer.GETFILTERS, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.ClearNewRow;
        //MakeExcelDataHeader;
    end;

    procedure MakeExcelDataHeader()
    begin
        FindMonth;
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(monthtext, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);

        FindMonth1;
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(monthtext, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);

        FindMonth2;
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(monthtext, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);

        FindMonth3;
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(monthtext, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Customer No', FALSE, '', TRUE, FALSE, TRUE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Customer Name', FALSE, '', TRUE, FALSE, TRUE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Salesperson Code', FALSE, '', TRUE, FALSE, TRUE, '@', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn('Sales LCY', FALSE, '', TRUE, FALSE, TRUE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Margin', FALSE, '', TRUE, FALSE, TRUE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Margin %', FALSE, '', TRUE, FALSE, TRUE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Sales LCY', FALSE, '', TRUE, FALSE, TRUE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Margin', FALSE, '', TRUE, FALSE, TRUE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Margin %', FALSE, '', TRUE, FALSE, TRUE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Sales LCY', FALSE, '', TRUE, FALSE, TRUE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Margin', FALSE, '', TRUE, FALSE, TRUE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Margin %', FALSE, '', TRUE, FALSE, TRUE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Sales LCY', FALSE, '', TRUE, FALSE, TRUE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Margin', FALSE, '', TRUE, FALSE, TRUE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Margin %', FALSE, '', TRUE, FALSE, TRUE, '@', ExcelBuf."Cell Type"::Text);
    end;

    procedure MakeExcelDataBody()
    begin

        ExcelBuf.NewRow;

        ExcelBuf.AddColumn(Customer."No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Customer.Name, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Customer."Salesperson Code", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn(AgingBandBuf."Column 5 Amt.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(AgingBandBuf5, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        IF AgingBandBuf."Column 5 Amt." <> 0 THEN
            "M%" := ROUND((AgingBandBuf5 / AgingBandBuf."Column 5 Amt.") * 100, 0.01);
        ExcelBuf.AddColumn("M%", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        "M%" := 0;

        ExcelBuf.AddColumn(AgingBandBuf."Column 4 Amt.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(AgingBandBuf4, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        IF AgingBandBuf."Column 4 Amt." <> 0 THEN
            "M%" := ROUND((AgingBandBuf4 / AgingBandBuf."Column 4 Amt.") * 100, 0.01);
        //ExcelBuf.AddColumn(,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn("M%", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        "M%" := 0;

        ExcelBuf.AddColumn(AgingBandBuf."Column 3 Amt.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(AgingBandBuf3, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        IF AgingBandBuf."Column 3 Amt." <> 0 THEN
            "M%" := ROUND((AgingBandBuf3 / AgingBandBuf."Column 3 Amt.") * 100, 0.01);
        //ExcelBuf.AddColumn(,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn("M%", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        "M%" := 0;

        ExcelBuf.AddColumn(AgingBandBuf."Column 2 Amt.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(AgingBandBuf2, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        IF AgingBandBuf."Column 2 Amt." <> 0 THEN
            "M%" := ROUND((AgingBandBuf2 / AgingBandBuf."Column 2 Amt.") * 100, 0.01);
        //ExcelBuf.AddColumn(,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn("M%", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        "M%" := 0;

        /*ExcelBuf.AddColumn("Gross YTD",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(GrossMarginYTD,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("G. Marg. %",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        */

    end;

    // procedure CreateExcelbook()
    // begin
    //     //ExcelBuf.CreateBookAndOpenExcel(Text001,Text002,'',COMPANYNAME,USERID);
    //     ExcelBuf.CreateBookAndOpenExcel('', Text001, Text002, COMPANYNAME, USERID);//Sofyan
    //     ERROR('');
    // end;

    procedure CreateExcelbook()
    begin
        ExcelBuf.CreateNewBook(text001);
        ExcelBuf.WriteSheet(text001, CompanyName, UserId);
        ExcelBuf.CloseBook();
        ExcelBuf.SetFriendlyFilename(StrSubstNo(Text002, CurrentDateTime, UserId));
        ExcelBuf.OpenExcel();
    end;

    procedure MakeExcelFooter()
    begin
        /*
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Total :',FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'');
        
        ExcelBuf.AddColumn("Total Sales Profit",FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn("Total Profit",FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn("Total G. Margin %",FALSE,'',FALSE,FALSE,FALSE,'');
        
        ExcelBuf.AddColumn("Total Gross YTD",FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn("Total GrossMarginYTD",FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn("Total G. Marg. %",FALSE,'',FALSE,FALSE,FALSE,'');
        */

    end;

    local procedure CalcAgingBandDates()
    begin

        EVALUATE(PeriodLength2, '-' + FORMAT(PeriodLength));
        AgingDate[5] := AgingBandEndingDate;
        AgingDate[4] := CALCDATE(PeriodLength2, AgingDate[5]);
        AgingDate[3] := CALCDATE(PeriodLength2, AgingDate[4]);
        AgingDate[2] := CALCDATE(PeriodLength2, AgingDate[3]);
        AgingDate[1] := CALCDATE(PeriodLength2, AgingDate[2]);
    end;

    procedure calculatesalesvalue()
    begin
        valueentry.RESET;
        valueentry.SETRANGE(valueentry."Source No.", Customer."No.");
        valueentry.SETRANGE(valueentry."Item Ledger Entry Type", valueentry."Item Ledger Entry Type"::Sale);
        IF valueentry.FINDFIRST THEN
            REPEAT
                //IF NOT AgingBandBuf.FIND THEN
                //AgingBandBuf.INSERT;
                i := 1;
                GoOn := TRUE;
                WHILE (i <= 5) AND GoOn DO BEGIN
                    IF valueentry."Posting Date" <= AgingDate[i] THEN
                        IF i = 1 THEN BEGIN
                            Profit := valueentry."Sales Amount (Actual)" +
                                    valueentry."Cost Amount (Actual)" +
                                    valueentry."Cost Amount (Non-Invtbl.)";

                            AgingBandBuf1 := AgingBandBuf1 + Profit + valueentry."Discount Amount";
                            GoOn := FALSE;
                        END;
                    IF valueentry."Posting Date" <= AgingDate[i] THEN
                        IF i = 2 THEN BEGIN
                            Profit := valueentry."Sales Amount (Actual)" +
                                    valueentry."Cost Amount (Actual)" +
                                    valueentry."Cost Amount (Non-Invtbl.)";

                            AgingBandBuf2 := AgingBandBuf2 + Profit + valueentry."Discount Amount";
                            GoOn := FALSE;
                        END;
                    IF valueentry."Posting Date" <= AgingDate[i] THEN
                        IF i = 3 THEN BEGIN
                            Profit := valueentry."Sales Amount (Actual)" +
                                    valueentry."Cost Amount (Actual)" +
                                    valueentry."Cost Amount (Non-Invtbl.)";

                            AgingBandBuf3 := AgingBandBuf3 + Profit + valueentry."Discount Amount";
                            GoOn := FALSE;
                        END;
                    IF valueentry."Posting Date" <= AgingDate[i] THEN
                        IF i = 4 THEN BEGIN
                            Profit := valueentry."Sales Amount (Actual)" +
                                    valueentry."Cost Amount (Actual)" +
                                    valueentry."Cost Amount (Non-Invtbl.)";

                            AgingBandBuf4 := AgingBandBuf4 + Profit + valueentry."Discount Amount";
                            GoOn := FALSE;
                        END;
                    IF valueentry."Posting Date" <= AgingDate[i] THEN
                        IF i = 5 THEN BEGIN
                            Profit := valueentry."Sales Amount (Actual)" +
                                    valueentry."Cost Amount (Actual)" +
                                    valueentry."Cost Amount (Non-Invtbl.)";

                            AgingBandBuf5 := AgingBandBuf5 + Profit + valueentry."Discount Amount";
                            GoOn := FALSE;
                        END;
                    i := i + 1;
                END;
            //AgingBandBuf.MODIFY;
            UNTIL valueentry.NEXT = 0;
    end;

    procedure FindMonth()
    begin
        month := DATE2DMY(AgingDate[5], 2);
        IF month = 1 THEN
            monthtext := 'Jan'
        ELSE IF month = 2 THEN
            monthtext := 'Feb'
        ELSE IF month = 3 THEN
            monthtext := 'Mar'
        ELSE IF month = 4 THEN
            monthtext := 'Apr'
        ELSE IF month = 5 THEN
            monthtext := 'May'
        ELSE IF month = 6 THEN
            monthtext := 'Jun'
        ELSE IF month = 7 THEN
            monthtext := 'Jul'
        ELSE IF month = 8 THEN
            monthtext := 'Aug'
        ELSE IF month = 9 THEN
            monthtext := 'Sep'
        ELSE IF month = 10 THEN
            monthtext := 'Oct'
        ELSE IF month = 11 THEN
            monthtext := 'Nov'
        ELSE IF month = 12 THEN
            monthtext := 'Dec'
    end;

    procedure FindMonth1()
    begin

        month1 := DATE2DMY(AgingDate[4], 2);
        IF month1 = 1 THEN
            monthtext := 'Jan'
        ELSE IF month1 = 2 THEN
            monthtext := 'Feb'
        ELSE IF month1 = 3 THEN
            monthtext := 'Mar'
        ELSE IF month1 = 4 THEN
            monthtext := 'Apr'
        ELSE IF month1 = 5 THEN
            monthtext := 'May'
        ELSE IF month1 = 6 THEN
            monthtext := 'Jun'
        ELSE IF month1 = 7 THEN
            monthtext := 'Jul'
        ELSE IF month1 = 8 THEN
            monthtext := 'Aug'
        ELSE IF month1 = 9 THEN
            monthtext := 'Sep'
        ELSE IF month1 = 10 THEN
            monthtext := 'Oct'
        ELSE IF month1 = 11 THEN
            monthtext := 'Nov'
        ELSE IF month1 = 12 THEN
            monthtext := 'Dec'
    end;

    procedure FindMonth2()
    begin
        month2 := DATE2DMY(AgingDate[3], 2);
        IF month2 = 1 THEN
            monthtext := 'Jan'
        ELSE IF month2 = 2 THEN
            monthtext := 'Feb'
        ELSE IF month2 = 3 THEN
            monthtext := 'Mar'
        ELSE IF month2 = 4 THEN
            monthtext := 'Apr'
        ELSE IF month2 = 5 THEN
            monthtext := 'May'
        ELSE IF month2 = 6 THEN
            monthtext := 'Jun'
        ELSE IF month2 = 7 THEN
            monthtext := 'Jul'
        ELSE IF month2 = 8 THEN
            monthtext := 'Aug'
        ELSE IF month2 = 9 THEN
            monthtext := 'Sep'
        ELSE IF month2 = 10 THEN
            monthtext := 'Oct'
        ELSE IF month2 = 11 THEN
            monthtext := 'Nov'
        ELSE IF month2 = 12 THEN
            monthtext := 'Dec'
    end;

    procedure FindMonth3()
    begin
        month3 := DATE2DMY(AgingDate[2], 2);
        IF month3 = 1 THEN
            monthtext := 'Jan'
        ELSE IF month3 = 2 THEN
            monthtext := 'Feb'
        ELSE IF month3 = 3 THEN
            monthtext := 'Mar'
        ELSE IF month3 = 4 THEN
            monthtext := 'Apr'
        ELSE IF month3 = 5 THEN
            monthtext := 'May'
        ELSE IF month3 = 6 THEN
            monthtext := 'Jun'
        ELSE IF month3 = 7 THEN
            monthtext := 'Jul'
        ELSE IF month3 = 8 THEN
            monthtext := 'Aug'
        ELSE IF month3 = 9 THEN
            monthtext := 'Sep'
        ELSE IF month3 = 10 THEN
            monthtext := 'Oct'
        ELSE IF month3 = 11 THEN
            monthtext := 'Nov'
        ELSE IF month3 = 12 THEN
            monthtext := 'Dec'
    end;
}

