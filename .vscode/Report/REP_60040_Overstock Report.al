report 60040 "Overstock Report"
{
    // version avinash

    // DefaultLayout = RDLC;
    // RDLCLayout = './Overstock Report.rdlc';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Overstock Report';
    ProcessingOnly = true;
    dataset
    {
        dataitem(Item; Item)
        {
            CalcFields = Inventory, "Qty. on Purch. Order", "Qty. on Sales Order", "Qty on Blanket Order";
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Date Filter";
            column(Column1Amt_AgingBandBuff; AgingBandBuf."Column 1 Amt.")
            {
            }
            column(Column2Amt_AgingBandBuff; AgingBandBuf."Column 2 Amt.")
            {
            }
            column(Column3Amt_AgingBandBuff; AgingBandBuf."Column 3 Amt.")
            {
            }
            column(Column4Amt_AgingBandBuff; AgingBandBuf."Column 4 Amt.")
            {
            }
            column(Column5Amt_AgingBandBuff; AgingBandBuf."Column 5 Amt.")
            {
            }

            trigger OnAfterGetRecord()
            begin

                Item.CALCFIELDS(Item.Inventory2);

                AgingBandBuf1 := 0;
                AgingBandBuf2 := 0;
                estcost := 0;
                AgingBandBuf3 := 0;
                AgingBandBuf4 := 0;
                AgingBandBuf5 := 0;
                Avgdmd := 0;
                latestaup := 0;
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
                CalcAgingBandDates;
                postedsalesinvoiceline.SETRANGE(postedsalesinvoiceline."No.", Item."No.");
                IF postedsalesinvoiceline.FINDFIRST THEN BEGIN
                    REPEAT
                        IF NOT AgingBandBuf.FIND THEN
                            AgingBandBuf.INSERT;
                        I := 1;
                        GoOn := TRUE;
                        WHILE (I <= 5) AND GoOn DO BEGIN
                            IF postedsalesinvoiceline."Posting Date" <= AgingDate[I] THEN
                                IF I = 1 THEN BEGIN
                                    AgingBandBuf."Column 1 Amt." := AgingBandBuf."Column 1 Amt." + postedsalesinvoiceline.Quantity;
                                    AgingBandBuf1 := AgingBandBuf1 + postedsalesinvoiceline.Amount;     //MADAN
                                    GoOn := FALSE;
                                END;
                            IF postedsalesinvoiceline."Posting Date" <= AgingDate[I] THEN
                                IF I = 2 THEN BEGIN
                                    AgingBandBuf."Column 2 Amt." := AgingBandBuf."Column 2 Amt." + postedsalesinvoiceline.Quantity;
                                    AgingBandBuf2 := AgingBandBuf2 + postedsalesinvoiceline.Amount;     //MADAN
                                    GoOn := FALSE;
                                END;
                            IF postedsalesinvoiceline."Posting Date" <= AgingDate[I] THEN
                                IF I = 3 THEN BEGIN
                                    AgingBandBuf."Column 3 Amt." := AgingBandBuf."Column 3 Amt." + postedsalesinvoiceline.Quantity;
                                    AgingBandBuf3 := AgingBandBuf3 + postedsalesinvoiceline.Amount; //MADAN
                                    GoOn := FALSE;
                                END;
                            IF postedsalesinvoiceline."Posting Date" <= AgingDate[I] THEN
                                IF I = 4 THEN BEGIN
                                    AgingBandBuf."Column 4 Amt." := AgingBandBuf."Column 4 Amt." + postedsalesinvoiceline.Quantity;
                                    AgingBandBuf4 := AgingBandBuf4 + postedsalesinvoiceline.Amount;  //MADAN
                                    GoOn := FALSE;
                                END;
                            IF postedsalesinvoiceline."Posting Date" <= AgingDate[I] THEN
                                IF I = 5 THEN BEGIN
                                    AgingBandBuf."Column 5 Amt." := AgingBandBuf."Column 5 Amt." + postedsalesinvoiceline.Quantity;
                                    AgingBandBuf5 := AgingBandBuf5 + postedsalesinvoiceline.Amount; //MADAN
                                    GoOn := FALSE;
                                END;
                            I := I + 1;
                        END;
                        AgingBandBuf.MODIFY;
                        //MADAN
                        IF (postedsalesinvoiceline."Posting Date" <= AgingDate[5]) AND (postedsalesinvoiceline."Posting Date" >= AgingDate[2]) THEN BEGIN
                            IF lowestprice = 0 THEN BEGIN
                                lowestprice := postedsalesinvoiceline."Unit Price";
                            END ELSE BEGIN
                                IF lowestprice > postedsalesinvoiceline."Unit Price" THEN BEGIN
                                    lowestprice := postedsalesinvoiceline."Unit Price";
                                END;
                            END;
                        END;
                    UNTIL postedsalesinvoiceline.NEXT = 0;
                END;

                Item.CALCFIELDS(Item."Qty. on Sales Order");
                Item.CALCFIELDS(Item."Qty. on Blanket Order(Actual)");
                IF Item."Qty. on Sales Order" <> 0 THEN BEGIN
                    Salesline.SETRANGE(Salesline."Document Type", Salesline."Document Type"::Order);
                    Salesline.SETRANGE(Salesline."No.", Item."No.");
                    Salesline.SETFILTER(Salesline."Outstanding Quantity", '>%1', 0);
                    IF Salesline.FINDFIRST THEN BEGIN
                        REPEAT

                            estcost := estcost + Salesline."Outstanding Quantity" * Salesline."Unit Price";
                        UNTIL Salesline.NEXT = 0;
                    END;
                END;
                /* MADAN
                postedsalesinvoiceline.RESET;
                postedsalesinvoiceline.SETRANGE(postedsalesinvoiceline."No.",Item."No.");
                IF postedsalesinvoiceline.FINDFIRST THEN BEGIN
                REPEAT
                 IF (postedsalesinvoiceline."Posting Date"<=AgingDate[5]) AND (postedsalesinvoiceline."Posting Date">=AgingDate[2])  THEN BEGIN
                     IF lowestprice=0 THEN BEGIN
                        lowestprice:=postedsalesinvoiceline."Unit Price";
                       END ELSE BEGIN
                        IF lowestprice>postedsalesinvoiceline."Unit Price" THEN BEGIN
                           lowestprice:=postedsalesinvoiceline."Unit Price";
                          END;
                         END;
                  END;
                 UNTIL postedsalesinvoiceline.NEXT=0;
                END;
                */
                IF cnt = 1 THEN BEGIN
                    cnt := cnt + 1;
                    IF Printtoexcel THEN
                        MakeExcelDataHeader1;
                END;
                //calculatesalesvalue; //MADAN



                Blanketqty := 0;
                Inventory3 := 0;
                Overstockqty := 0;
                Inventory1 := 0;
                sum := 0;
                Overstockval := 0;
                riskvalue := 0;
                Purchaseline.RESET;
                Purchaseline.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
                Purchaseline.SETRANGE(Purchaseline."Document Type", Purchaseline."Document Type"::"Blanket Order");
                Purchaseline.SETRANGE(Purchaseline."No.", Item."No.");
                IF Purchaseline.FINDFIRST THEN BEGIN
                    REPEAT
                        Blanketqty := Blanketqty + Purchaseline.Quantity;
                    UNTIL Purchaseline.NEXT = 0;
                END;
                Itemledgerentry.RESET;
                Itemledgerentry.SETCURRENTKEY(Itemledgerentry."Item No.", Itemledgerentry."Location Code");
                Itemledgerentry.SETRANGE(Itemledgerentry."Item No.", Item."No.");
                //Itemledgerentry.SETRANGE(Itemledgerentry."Location Code",'CHEMILINES'); //MADAN
                IF Itemledgerentry.FINDFIRST THEN BEGIN
                    REPEAT
                        IF Itemledgerentry."Location Code" = 'CHEMILINES' THEN //MADAN
                            Inventory1 := Inventory1 + Itemledgerentry.Quantity
                        ELSE IF Itemledgerentry."Location Code" = 'FREE' THEN //MADAN
                            Inventory3 := Inventory3 + Itemledgerentry.Quantity;
                    UNTIL Itemledgerentry.NEXT = 0;
                END;
                /* MADAN
                Itemledgerentry.RESET;
                Itemledgerentry.SETRANGE(Itemledgerentry."Item No.",Item."No.");
                Itemledgerentry.SETRANGE(Itemledgerentry."Location Code",'FREE');
                IF Itemledgerentry.FINDFIRST THEN BEGIN
                 REPEAT
                  Inventory3:=Inventory3+Itemledgerentry.Quantity;
                 UNTIL Itemledgerentry.NEXT=0;
                END;
                */
                Avgdmd := (AgingBandBuf."Column 5 Amt." + AgingBandBuf."Column 4 Amt." + AgingBandBuf."Column 3 Amt." + AgingBandBuf."Column 2 Amt.") / 4;

                IF Item.Inventory > (Avgdmd * 2) THEN
                    Overstockqty := (Item.Inventory + Item."Qty. on Purch. Order") - (Avgdmd * 2)
                ELSE
                    Overstockqty := 0;
                Overstockval := Overstockqty * ROUND(Item."Unit Cost", 0.01);
                IF Overstockqty > Inventory3 THEN
                    sum := Inventory3
                ELSE IF Overstockqty < Inventory3 THEN
                    sum := Overstockqty
                ELSE IF Overstockqty = Inventory3 THEN
                    sum := Overstockqty;

                /*
                IF(Inventory2  + Item."Qty. on Purch. Order") > Overstockqty THEN
                sum:=Overstockqty
                 ELSE
                 sum:= Inventory2  + Item."Qty. on Purch. Order";
                 */

                riskvalue := sum * ROUND(Item."Unit Cost", 0.01);
                IF Printtoexcel THEN
                    MakeExcelDataBody;

            end;

            trigger OnPreDataItem()
            begin

                IF Item.GETFILTER("Date Filter") = '' THEN BEGIN
                    StartDate := DMY2DATE(1, 5, 2000);
                    EndDate := WORKDATE;
                END ELSE BEGIN
                    StartDate := GETRANGEMIN("Date Filter");
                    EndDate := GETRANGEMAX("Date Filter");
                END;
                AgingBandEndingDate := EndDate;
                cnt := 1;
                AgingBandBuf.DELETEALL;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Other)
                {
                    field("Print to Excel"; Printtoexcel)
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

        IF Printtoexcel THEN
            CreateExcelbook;
    end;

    trigger OnPreReport()
    begin

        EVALUATE(PeriodLength, '<1M+CM>');

        Printtoexcel := TRUE;
        IF Printtoexcel THEN BEGIN
            ExcelBuf.DELETEALL;
            MakeExcelInfo;
        END;
    end;

    var
        ExcelBuf: Record 370 temporary;
        Printtoexcel: Boolean;
        StartDate: Date;
        EndDate: Date;
        AgingBandEndingDate: Date;
        PeriodLength2: DateFormula;
        AgingDate: array[5] of Date;
        PeriodLength: DateFormula;
        postedsalesinvoiceline: Record 113;
        AgingBandBuf: Record 47;
        I: Integer;
        GoOn: Boolean;
        month: Integer;
        monthtext: Text[50];
        month1: Integer;
        cnt: Integer;
        month2: Integer;
        month3: Integer;
        AgingBandBuf1: Decimal;
        AgingBandBuf2: Decimal;
        AgingBandBuf3: Decimal;
        AgingBandBuf4: Decimal;
        AgingBandBuf5: Decimal;
        Avgdmd: Decimal;
        latestaup: Decimal;
        Purchaseline: Record 39;
        Blanketqty: Decimal;
        Itemledgerentry: Record 32;
        Inventory1: Decimal;
        Inventory3: Decimal;
        "sum": Decimal;
        Overstockqty: Decimal;
        riskvalue: Decimal;
        Overstockval: Decimal;
        Salesline: Record 37;
        estcost: Decimal;
        lowestprice: Decimal;
        text000: Label 'DATA';
        text001: Label 'Warehouse Entry Report';
        ExcelFileName: Label 'Overstock Report';

    procedure MakeExcelInfo()
    begin
        ExcelBuf.SetUseInfoSheet;
        ExcelBuf.AddInfoColumn('Company Name', FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(COMPANYNAME, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn('Report Name', FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn('Overstock Report', FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn('Report No', FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(60040, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn('User Id', FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(USERID, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn('Date', FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(TODAY, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Date);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn('Filter', FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(Item.GETFILTERS, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.ClearNewRow;
        MakeExcelDataHeader;
    end;

    procedure MakeExcelDataHeader1()
    begin

        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Code', FALSE, '', TRUE, FALSE, TRUE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Description', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        FindMonth;
        ExcelBuf.AddColumn(monthtext, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        FindMonth1;
        ExcelBuf.AddColumn(monthtext, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        FindMonth2;
        ExcelBuf.AddColumn(monthtext, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        FindMonth3;
        ExcelBuf.AddColumn(monthtext, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        FindMonth;
        ExcelBuf.AddColumn(monthtext, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        FindMonth1;
        ExcelBuf.AddColumn(monthtext, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        FindMonth2;
        ExcelBuf.AddColumn(monthtext, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        FindMonth3;
        ExcelBuf.AddColumn(monthtext, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Average Demand', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Latest AUP', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Lowest Price', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Current stock', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('On Order', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('NEW ORDER Check', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Current Cost', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Current Value', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Sales back orders Qty', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Sales back orders est cost', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Overstock Qty', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Overstock Value', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Free', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Res', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('GIT', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Risk value Qty', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Risk value Value', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
    end;

    procedure MakeExcelDataBody()
    begin

        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(Item."No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Item.Description, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(AgingBandBuf."Column 5 Amt.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(AgingBandBuf."Column 4 Amt.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(AgingBandBuf."Column 3 Amt.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(AgingBandBuf."Column 2 Amt.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(AgingBandBuf5, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(AgingBandBuf4, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(AgingBandBuf3, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(AgingBandBuf2, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        //Avgdmd:=(AgingBandBuf."Column 5 Amt."+AgingBandBuf."Column 4 Amt."+AgingBandBuf."Column 3 Amt."+AgingBandBuf."Column 2 Amt.")/4;
        ExcelBuf.AddColumn(Avgdmd, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        IF AgingBandBuf."Column 5 Amt." > 0 THEN
            latestaup := AgingBandBuf5 / AgingBandBuf."Column 5 Amt."
        ELSE IF AgingBandBuf."Column 4 Amt." > 0 THEN
            latestaup := AgingBandBuf4 / AgingBandBuf."Column 4 Amt."
        ELSE IF AgingBandBuf."Column 3 Amt." > 0 THEN
            latestaup := AgingBandBuf3 / AgingBandBuf."Column 3 Amt."
        ELSE IF AgingBandBuf."Column 2 Amt." > 0 THEN
            latestaup := AgingBandBuf2 / AgingBandBuf."Column 2 Amt.";
        latestaup := ROUND(latestaup, 0.01);
        ExcelBuf.AddColumn(latestaup, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(lowestprice, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(Item.Inventory2, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(Item."Qty. on Blanket Order(Actual)", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(ROUND(Item."Unit Cost", 0.01), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(ROUND(Item."Unit Cost" * Item.Inventory2, 0.01), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(Item."Qty. on Sales Order", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(estcost, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(Overstockqty, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(Overstockval, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(Inventory3, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(Inventory1, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(Item."Qty. on Purch. Order", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(sum, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(riskvalue, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
    end;

    // procedure CreateExcelbook()
    // begin
    //     /*ExcelBuf.CreateBook;
    //     ExcelBuf.CreateSheet(text000,text001,COMPANYNAME,USERID);
    //     ExcelBuf.GiveUserControl;
    //     ERROR('');
    //     */
    //     //ExcelBuf.CreateBookAndOpenExcel('Data','Overstock Report','',COMPANYNAME,USERID);
    //     ExcelBuf.CreateBookAndOpenExcel('', 'Data', 'Overstock Report', COMPANYNAME, USERID);//Sofyan
    //     ERROR('');

    // end;

    procedure CreateExcelbook()
    begin
        ExcelBuf.CreateNewBook(text001);
        ExcelBuf.WriteSheet(text001, CompanyName, UserId);
        ExcelBuf.CloseBook();
        ExcelBuf.SetFriendlyFilename(StrSubstNo(ExcelFileName, CurrentDateTime, UserId));
        ExcelBuf.OpenExcel();
    end;

    local procedure CalcAgingBandDates()
    begin
        //IF NOT IncludeAgingBand THEN
        //EXIT;
        //IF AgingBandEndingDate = 0D THEN
        //ERROR(Text010);
        //IF FORMAT(PeriodLength) = '' THEN
        //ERROR(Text008);
        EVALUATE(PeriodLength2, '-' + FORMAT(PeriodLength));
        //MESSAGE(FORMAT(PeriodLength2)); //Blocked by aditi
        AgingDate[5] := AgingBandEndingDate;
        AgingDate[4] := CALCDATE(PeriodLength2, AgingDate[5]);
        AgingDate[3] := CALCDATE(PeriodLength2, AgingDate[4]);
        AgingDate[2] := CALCDATE(PeriodLength2, AgingDate[3]);
        AgingDate[1] := CALCDATE(PeriodLength2, AgingDate[2]);
        //IF AgingDate[2] <= AgingDate[1] THEN
        //ERROR(Text012);
        // ERROR('%1-%2-%3-%4-%5',PeriodLength2,AgingDate[4],AgingDate[3],AgingDate[2],AgingDate[1]);
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

    procedure calculatesalesvalue()
    begin

        postedsalesinvoiceline.SETRANGE(postedsalesinvoiceline."No.", Item."No.");
        IF postedsalesinvoiceline.FINDFIRST THEN BEGIN
            REPEAT
                //IF NOT AgingBandBuf.FIND THEN
                //AgingBandBuf.INSERT;
                I := 1;
                GoOn := TRUE;
                WHILE (I <= 5) AND GoOn DO BEGIN
                    IF postedsalesinvoiceline."Posting Date" <= AgingDate[I] THEN
                        IF I = 1 THEN BEGIN
                            AgingBandBuf1 := AgingBandBuf1 + postedsalesinvoiceline.Amount;
                            GoOn := FALSE;
                        END;
                    IF postedsalesinvoiceline."Posting Date" <= AgingDate[I] THEN
                        IF I = 2 THEN BEGIN
                            AgingBandBuf2 := AgingBandBuf2 + postedsalesinvoiceline.Amount;
                            GoOn := FALSE;
                        END;
                    IF postedsalesinvoiceline."Posting Date" <= AgingDate[I] THEN
                        IF I = 3 THEN BEGIN
                            AgingBandBuf3 := AgingBandBuf3 + postedsalesinvoiceline.Amount;
                            GoOn := FALSE;
                        END;
                    IF postedsalesinvoiceline."Posting Date" <= AgingDate[I] THEN
                        IF I = 4 THEN BEGIN
                            AgingBandBuf4 := AgingBandBuf4 + postedsalesinvoiceline.Amount;
                            GoOn := FALSE;
                        END;
                    IF postedsalesinvoiceline."Posting Date" <= AgingDate[I] THEN
                        IF I = 5 THEN BEGIN
                            AgingBandBuf5 := AgingBandBuf5 + postedsalesinvoiceline.Amount;
                            GoOn := FALSE;
                        END;
                    I := I + 1;
                END;
            //AgingBandBuf.MODIFY;
            UNTIL postedsalesinvoiceline.NEXT = 0;
        END;
    end;

    procedure MakeExcelDataHeader()
    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Sales Qty', FALSE, '', TRUE, FALSE, TRUE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '@', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Sales Value', FALSE, '', TRUE, FALSE, TRUE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '@', ExcelBuf."Cell Type"::Text);
    end;
}

