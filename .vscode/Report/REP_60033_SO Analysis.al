report 60033 "Sales Order Line Wise Manish1"
{


    DefaultLayout = RDLC;
    RDLCLayout = './Sales Order Line Wise Manish1.rdlc';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    Caption = 'Sales Order Analysis';

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(STRSUBSTNO_Text000_PeriodText_; STRSUBSTNO(Text000, PeriodText))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(USERID; USERID)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(Customer_TABLECAPTION__________CustFilter; Customer.TABLECAPTION + ': ' + CustFilter)
            {
            }
            column(Sales_Header__TABLECAPTION__________SalesheaderFilter; "Sales Header".TABLECAPTION + ': ' + SalesheaderFilter)
            {
            }
            column(Customer_Name; Name)
            {
            }
            column(Customer__Phone_No__; "Phone No.")
            {
            }
            column(Customer__No__; "No.")
            {
            }
            column(Customer__Balance__LCY__; "Balance (LCY)")
            {
            }
            column(Customer__Credit_Limit__LCY__; "Credit Limit (LCY)")
            {
            }
            column(Customer_Customer_Name; Customer.Name)
            {
            }
            column(Sales_Line__Quantity; "Sales Line".Quantity)
            {
                DecimalPlaces = 2 : 2;
            }
            column(SalesAmount; SalesAmount)
            {
                DecimalPlaces = 2 : 2;
            }
            column(CostAmount; CostAmount)
            {
                DecimalPlaces = 2 : 2;
            }
            column(Profit; Profit)
            {
                DecimalPlaces = 2 : 2;
            }
            column(ProfitPct; ProfitPct)
            {
                DecimalPlaces = 2 : 2;
            }
            column(cnt5; cnt5)
            {
            }
            column(cnt4; cnt4)
            {
            }
            column(cnt3; cnt3)
            {
            }
            column(cnt2; cnt2)
            {
            }
            column(cnt1; cnt1)
            {
            }
            column(Cnt1Per; Cnt1Per)
            {
            }
            column(Cnt2Per; Cnt2Per)
            {
            }
            column(Cnt3Per; Cnt3Per)
            {
            }
            column(Cnt4Per; Cnt4Per)
            {
            }
            column(NormalQty; NormalQty)
            {
                DecimalPlaces = 0 : 2;
            }
            column(MediumQty; MediumQty)
            {
                DecimalPlaces = 0 : 2;
            }
            column(EasyQty; EasyQty)
            {
                DecimalPlaces = 0 : 2;
            }
            column(DifficultQty; DifficultQty)
            {
                DecimalPlaces = 0 : 0;
            }
            column(DifficultValue; DifficultValue)
            {
            }
            column(NormalValue; NormalValue)
            {
            }
            column(EasyValue; EasyValue)
            {
            }
            column(MediumValue; MediumValue)
            {
            }
            column(SalesAmount_Control1000000035; SalesAmount)
            {
            }
            column(Sales_Line__Quantity_Control1000000036; "Sales Line".Quantity)
            {
            }
            column(Sales_Order_Customer_Item_Wise_ProfitCaption; Sales_Order_Customer_Item_Wise_ProfitCaptionLbl)
            {
            }
            column(All_amounts_are_in_LCYCaption; All_amounts_are_in_LCYCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Item_No_Caption; Item_No_CaptionLbl)
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(Posting_DateCaption; Posting_DateCaptionLbl)
            {
            }
            column(Customer_Order_No_Caption; Customer_Order_No_CaptionLbl)
            {
            }
            column(Order_No_Caption; Order_No_CaptionLbl)
            {
            }
            column(Order_QuantityCaption; Order_QuantityCaptionLbl)
            {
            }
            column(Unit_of_MeasureCaption; Unit_of_MeasureCaptionLbl)
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(Cost_AmountCaption; Cost_AmountCaptionLbl)
            {
            }
            column(Cost_Per_UnitCaption; Cost_Per_UnitCaptionLbl)
            {
            }
            column(Price_Per_UnitCaption; Price_Per_UnitCaptionLbl)
            {
            }
            column(ProfitCaption; ProfitCaptionLbl)
            {
            }
            column(Profit__Caption; Profit__CaptionLbl)
            {
            }
            column(Wholesales_Price_D_Caption; Wholesales_Price_D_CaptionLbl)
            {
            }
            column(Sales_Base_Price_E_Caption; Sales_Base_Price_E_CaptionLbl)
            {
            }
            column(Customer__Phone_No__Caption; FIELDCAPTION("Phone No."))
            {
            }
            column(Customer__Balance__LCY__Caption; FIELDCAPTION("Balance (LCY)"))
            {
            }
            column(Customer__Credit_Limit__LCY__Caption; FIELDCAPTION("Credit Limit (LCY)"))
            {
            }
            column(NormalCaption; NormalCaptionLbl)
            {
            }
            column(MediumCaption; MediumCaptionLbl)
            {
            }
            column(EasyCaption; EasyCaptionLbl)
            {
            }
            column(DifficultCaption; DifficultCaptionLbl)
            {
            }
            column(Total_LinesCaption; Total_LinesCaptionLbl)
            {
            }
            column(Difficult__Caption; Difficult__CaptionLbl)
            {
            }
            column(Easy__Caption; Easy__CaptionLbl)
            {
            }
            column(Medium__Caption; Medium__CaptionLbl)
            {
            }
            column(Normal__Caption; Normal__CaptionLbl)
            {
            }
            column(Normal_UnitsCaption; Normal_UnitsCaptionLbl)
            {
            }
            column(Medium_UnitsCaption; Medium_UnitsCaptionLbl)
            {
            }
            column(Easy_UnitsCaption; Easy_UnitsCaptionLbl)
            {
            }
            column(Difficult_UnitsCaption; Difficult_UnitsCaptionLbl)
            {
            }
            column(Difficult_ValueCaption; Difficult_ValueCaptionLbl)
            {
            }
            column(Easy_ValueCaption; Easy_ValueCaptionLbl)
            {
            }
            column(Medium_ValueCaption; Medium_ValueCaptionLbl)
            {
            }
            column(Normal_ValueCaption; Normal_ValueCaptionLbl)
            {
            }
            column(Total_ValueCaption; Total_ValueCaptionLbl)
            {
            }
            column(Total_UnitsCaption; Total_UnitsCaptionLbl)
            {
            }
            dataitem("Sales Header"; "Sales Header")
            {
                DataItemLink = "Sell-to Customer No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "No.")
                                    WHERE("Document Type" = FILTER(Order));
                PrintOnlyIfDetail = true;
                RequestFilterFields = "No.", "Posting Date";
                column(Sales_Order_No_______Sales_Header___No__; 'Sales Order No : ' + "Sales Header"."No.")
                {
                }
                column(Sales_Order_No_______Sales_Header___No___Control1040052; 'Sales Order No : ' + "Sales Header"."No.")
                {
                }
                column(Sales_Line__Quantity_Control1040038; "Sales Line".Quantity)
                {
                    DecimalPlaces = 2 : 2;
                }
                column(SalesAmount_Control1040040; SalesAmount)
                {
                    DecimalPlaces = 2 : 2;
                }
                column(CostAmount_Control1040042; CostAmount)
                {
                    DecimalPlaces = 2 : 2;
                }
                column(Profit_Control1040043; Profit)
                {
                    DecimalPlaces = 2 : 2;
                }
                column(ProfitPct_Control1040044; ProfitPct)
                {
                    DecimalPlaces = 2 : 2;
                }
                column(Sales_Header_Document_Type; "Document Type")
                {
                }
                column(Sales_Header_No_; "No.")
                {
                }
                column(Sales_Header_Sell_to_Customer_No_; "Sell-to Customer No.")
                {
                }
                dataitem("Sales Line"; "Sales Line")
                {
                    DataItemLink = "Document Type" = FIELD("Document Type"),
                                   "Sell-to Customer No." = FIELD("Sell-to Customer No."),
                                   "Document No." = FIELD("No.");
                    DataItemTableView = SORTING("Document Type", Type, "No.", "Variant Code", "Drop Shipment", "Location Code", "Shipment Date")
                                        WHERE(Type = FILTER(Item));
                    PrintOnlyIfDetail = false;
                    RequestFilterFields = "No.";
                    column(Sales_Line__Sales_Line___No__; "Sales Line"."No.")
                    {
                        //DecimalPlaces = 0:5;
                    }
                    column(Sales_Line__Description__Sales_Line___Description_2_; "Sales Line".Description + "Sales Line"."Description 2")
                    {
                        //DecimalPlaces = 0:5;
                    }
                    column(Sales_Header___Posting_Date_; "Sales Header"."Posting Date")
                    {
                        //DecimalPlaces = 0:5;
                    }
                    column(Sales_Header___External_Document_No__; "Sales Header"."External Document No.")
                    {
                        //DecimalPlaces = 0:5;
                    }
                    column(Sales_Line__Sales_Line___Document_No__; "Sales Line"."Document No.")
                    {
                        //DecimalPlaces = 0:5;
                    }
                    column(Sales_Line__Sales_Line__Quantity; "Sales Line".Quantity)
                    {
                        DecimalPlaces = 0 : 5;
                    }
                    column(Sales_Line__Sales_Line___Unit_of_Measure_Code_; "Sales Line"."Unit of Measure Code")
                    {
                        //DecimalPlaces = 0:5;
                    }
                    column(SalesAmount_Control1040031; SalesAmount)
                    {
                        DecimalPlaces = 0 : 2;
                    }
                    column(CostAmount_Control1040033; CostAmount)
                    {
                        DecimalPlaces = 0 : 2;
                    }
                    column(CostPerUnit; CostPerUnit)
                    {
                        DecimalPlaces = 2 : 2;
                    }
                    column(PricePerUnit; PricePerUnit)
                    {
                        DecimalPlaces = 2 : 2;
                    }
                    column(Profit_Control1040036; Profit)
                    {
                        DecimalPlaces = 2 : 2;
                    }
                    column(ProfitPct_Control1040037; ProfitPct)
                    {
                        DecimalPlaces = 2 : 2;
                    }
                    column(recSalesprice__Unit_Price_; recSalesprice."Unit Price")
                    {
                    }
                    column(recSalesprice1__Unit_Price_; recSalesprice1."Unit Price")
                    {
                    }
                    column(Sales_Line_Document_Type; "Document Type")
                    {
                    }
                    column(Sales_Line_Line_No_; "Line No.")
                    {
                    }
                    column(Sales_Line_Sell_to_Customer_No_; "Sell-to Customer No.")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        CostPerUnit := 0;
                        CostAmount := 0;

                        IF "Sales Header"."Currency Factor" <> 0 THEN BEGIN
                            SalesAmount := "Sales Line"."Line Amount" / "Sales Header"."Currency Factor";
                            SalesDiscAmount := "Sales Line"."Line Discount Amount" / "Sales Header"."Currency Factor";
                            PricePerUnit := "Sales Line"."Unit Price" / "Sales Header"."Currency Factor";
                        END ELSE BEGIN
                            SalesAmount := "Sales Line"."Line Amount";
                            SalesDiscAmount := "Sales Line"."Line Discount Amount";
                            PricePerUnit := "Sales Line"."Unit Price";
                        END;


                        ItemRec.RESET;
                        IF ItemRec.GET("Sales Line"."No.") THEN BEGIN
                            CostPerUnit := ItemRec."Unit Cost";
                        END ELSE BEGIN
                            CostAmount := 0;
                            CostPerUnit := 0;
                        END;


                        IF CostPerUnit = 0 THEN BEGIN
                            ValueEntry.RESET;
                            ValueEntry.SETRANGE(ValueEntry."Item No.", "Sales Line"."No.");
                            ValueEntry.SETFILTER(ValueEntry."Item Ledger Entry Type", '0|2');
                            IF ValueEntry.FINDLAST THEN BEGIN
                                CostAmount := (ValueEntry."Cost Amount (Actual)");
                                CostPerUnit := ValueEntry."Cost per Unit";
                            END ELSE BEGIN
                                CostAmount := 0;
                                CostPerUnit := 0;
                            END;
                        END;

                        CostAmount := "Sales Line".Quantity * CostPerUnit;

                        Profit := 0;
                        ProfitPct := 0;
                        Profit := SalesAmount - CostAmount;

                        //Code for calculating number of Dimensions..

                        DefaultDimension.RESET;
                        DefaultDimension.SETFILTER(DefaultDimension."Table ID", '%1', 27);
                        DefaultDimension.SETRANGE(DefaultDimension."No.", "Sales Line"."No.");
                        DefaultDimension.SETFILTER(DefaultDimension."Dimension Code", '%1', 'CATEGORY');
                        IF DefaultDimension.FINDFIRST THEN
                            DimensionCode := DefaultDimension."Dimension Value Code";

                        //Sales Line, Body (1) - OnPreSection()++

                        IF SalesAmount <> 0 THEN BEGIN
                            ProfitPct := ROUND(100 * Profit / SalesAmount, 0.1)
                        END
                        ELSE BEGIN
                            ProfitPct := 0;
                        END;

                        IF DimensionCode = 'DIFFICULT' THEN BEGIN
                            cnt1 := cnt1 + 1;
                            DifficultQty := DifficultQty + "Sales Line".Quantity;
                            DifficultValue := DifficultValue + SalesAmount;
                        END;

                        IF DimensionCode = 'EASY' THEN BEGIN
                            cnt2 := cnt2 + 1;
                            EasyQty := EasyQty + "Sales Line".Quantity;
                            EasyValue := EasyValue + SalesAmount;

                        END;

                        IF DimensionCode = 'MEDIUM' THEN BEGIN
                            cnt3 := cnt3 + 1;
                            MediumQty := MediumQty + "Sales Line".Quantity;
                            MediumValue := MediumValue + SalesAmount;
                        END;

                        IF DimensionCode = 'NORMAL' THEN BEGIN
                            cnt4 := cnt4 + 1;
                            NormalQty := NormalQty + "Sales Line".Quantity;
                            NormalValue := NormalValue + SalesAmount;
                        END;

                        cnt5 := cnt1 + cnt2 + cnt3 + cnt4;
                        IF cnt5 <> 0 THEN BEGIN
                            Cnt1Per := (cnt1 / cnt5) * 100;
                            Cnt2Per := (cnt2 / cnt5) * 100;
                            Cnt3Per := (cnt3 / cnt5) * 100;
                            Cnt4Per := (cnt4 / cnt5) * 100;
                        END;

                        CLEAR(recSalesprice."Unit Price");
                        CLEAR(recSalesprice1."Unit Price");
                        recSalesprice.RESET;
                        //recSalesprice.SETRANGE(recSalesprice."Item No.",Item."No.");
                        recSalesprice.SETRANGE(recSalesprice."Item No.", "Sales Line"."No.");
                        recSalesprice.SETFILTER(recSalesprice."Sales Type", 'Customer Price Group');
                        recSalesprice.SETFILTER(recSalesprice."Sales Code", 'D');
                        IF recSalesprice.FINDFIRST THEN;

                        recSalesprice1.RESET;
                        //recSalesprice1.SETRANGE(recSalesprice1."Item No.",Item."No.");
                        recSalesprice1.SETRANGE(recSalesprice1."Item No.", "Sales Line"."No.");
                        recSalesprice1.SETFILTER(recSalesprice1."Sales Type", 'Customer Price Group');
                        recSalesprice1.SETFILTER(recSalesprice1."Sales Code", 'E');
                        IF recSalesprice1.FINDFIRST THEN;

                        //Sales Line, Body (1) - OnPreSection()--
                    end;

                    trigger OnPreDataItem()
                    begin
                        CurrReport.CREATETOTALS("Sales Line".Quantity, SalesAmount, CostAmount, SalesDiscAmount, CostPerUnit, PricePerUnit, Profit, ProfitPct)
                    end;
                }

                trigger OnPreDataItem()
                begin
                    CurrReport.CREATETOTALS("Sales Line".Quantity, SalesAmount, CostAmount, SalesDiscAmount, CostPerUnit, PricePerUnit, Profit, ProfitPct)
                end;
            }

            trigger OnPreDataItem()
            begin
                CurrReport.CREATETOTALS("Sales Line".Quantity, SalesAmount, CostAmount, SalesDiscAmount, CostPerUnit, PricePerUnit, Profit, ProfitPct)
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        CustFilter := Customer.GETFILTERS;
        SalesheaderFilter := "Sales Header".GETFILTERS;
    end;

    var
        Item: Record Item;
        ValueEntryBuffer: Record "Value Entry" temporary;
        ExcelBuf: Record "Excel Buffer" temporary;
        SalesheaderFilter: Text[250];
        ItemLedgEntryFilter: Text[250];
        PeriodText: Text[30];
        NextEntryNo: Integer;
        PrintOnlyOnePerPage: Boolean;
        Profit: Decimal;
        ProfitPct: Decimal;
        PrintToExcel: Boolean;
        Text000: Label 'Period: %1';
        Text001: Label 'Data';
        Text002: Label 'Customer/Item Sales';
        Text003: Label 'Company Name';
        Text004: Label 'Report No.';
        Text005: Label 'Report Name';
        Text006: Label 'User ID';
        Text007: Label 'Date';
        Text008: Label 'Customer Filters';
        Text009: Label 'Value Entry Filters';
        Text010: Label 'Profit';
        Text011: Label 'Profit %';
        ValueEntry: Record "Value Entry";
        CustFilter: Text[30];
        SalesAmount: Decimal;
        SalesDiscAmount: Decimal;
        CostAmount: Decimal;
        CostPerUnit: Decimal;
        PricePerUnit: Decimal;
        ItemRec: Record Item;
        DefaultDimension: Record "Default Dimension";
        cnt1: Integer;
        cnt2: Integer;
        cnt3: Integer;
        cnt4: Integer;
        cnt5: Integer;
        DimensionCode: Text[30];
        Cnt1Per: Decimal;
        Cnt2Per: Decimal;
        Cnt3Per: Decimal;
        Cnt4Per: Decimal;
        DifficultQty: Decimal;
        EasyQty: Decimal;
        MediumQty: Decimal;
        NormalQty: Decimal;
        DifficultValue: Decimal;
        EasyValue: Decimal;
        MediumValue: Decimal;
        NormalValue: Decimal;
        recSalesprice: Record "Sales Price";
        recSalesprice1: Record "Sales Price";
        Sales_Order_Customer_Item_Wise_ProfitCaptionLbl: Label 'Sales Order-Customer/Item Wise Profit';
        All_amounts_are_in_LCYCaptionLbl: Label 'All amounts are in LCY';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Item_No_CaptionLbl: Label 'Item No.';
        DescriptionCaptionLbl: Label 'Description';
        Posting_DateCaptionLbl: Label 'Posting Date';
        Customer_Order_No_CaptionLbl: Label 'Customer Order No.';
        Order_No_CaptionLbl: Label 'Order No.';
        Order_QuantityCaptionLbl: Label 'Order Quantity';
        Unit_of_MeasureCaptionLbl: Label 'Unit of Measure';
        AmountCaptionLbl: Label 'Amount';
        Cost_AmountCaptionLbl: Label 'Cost Amount';
        Cost_Per_UnitCaptionLbl: Label 'Cost Per Unit';
        Price_Per_UnitCaptionLbl: Label 'Price Per Unit';
        ProfitCaptionLbl: Label 'Profit';
        Profit__CaptionLbl: Label 'Profit %';
        Wholesales_Price_D_CaptionLbl: Label 'Wholesales Price(D)';
        Sales_Base_Price_E_CaptionLbl: Label 'Sales Base Price(E)';
        NormalCaptionLbl: Label 'Normal';
        MediumCaptionLbl: Label 'Medium';
        EasyCaptionLbl: Label 'Easy';
        DifficultCaptionLbl: Label 'Difficult';
        Total_LinesCaptionLbl: Label 'Total Lines';
        Difficult__CaptionLbl: Label 'Difficult %';
        Easy__CaptionLbl: Label 'Easy %';
        Medium__CaptionLbl: Label 'Medium %';
        Normal__CaptionLbl: Label 'Normal %';
        Normal_UnitsCaptionLbl: Label 'Normal Units';
        Medium_UnitsCaptionLbl: Label 'Medium Units';
        Easy_UnitsCaptionLbl: Label 'Easy Units';
        Difficult_UnitsCaptionLbl: Label 'Difficult Units';
        Difficult_ValueCaptionLbl: Label 'Difficult Value';
        Easy_ValueCaptionLbl: Label 'Easy Value';
        Medium_ValueCaptionLbl: Label 'Medium Value';
        Normal_ValueCaptionLbl: Label 'Normal Value';
        Total_ValueCaptionLbl: Label 'Total Value';
        Total_UnitsCaptionLbl: Label 'Total Units';

    local procedure CalcProfitPct()
    begin
        WITH ValueEntryBuffer DO BEGIN
            IF "Sales Amount (Actual)" <> 0 THEN
                ProfitPct := ROUND(100 * Profit / "Sales Amount (Actual)", 0.1)
            ELSE
                ProfitPct := 0;
        END;
    end;

    procedure MakeExcelInfo()
    begin
        /*
        ExcelBuf.SetUseInfoSheed;
        ExcelBuf.AddInfoColumn(FORMAT(Text003),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddInfoColumn(COMPANYNAME,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text005),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddInfoColumn(FORMAT(Text002),FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text004),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddInfoColumn(REPORT::"Document Wise Cust./Item Sales",FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text006),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddInfoColumn(USERID,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text007),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddInfoColumn(TODAY,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text008),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddInfoColumn(Customer.GETFILTERS,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text009),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddInfoColumn("Value Entry".GETFILTERS,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.ClearNewRow;
        MakeExcelDataHeader;
         */

    end;

    local procedure MakeExcelDataHeader()
    begin
        /*
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(Customer.FIELDCAPTION("No."),FALSE,'',TRUE,FALSE,TRUE,'@');
        ExcelBuf.AddColumn(Customer.FIELDCAPTION(Name),FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(ValueEntryBuffer.FIELDCAPTION("Item No."),FALSE,'',TRUE,FALSE,TRUE,'@');
        ExcelBuf.AddColumn(Item.FIELDCAPTION(Description),FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Order No.',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Invoice No.',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(ValueEntryBuffer.FIELDCAPTION("Invoiced Quantity"),FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(Item.FIELDCAPTION("Base Unit of Measure"),FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(ValueEntryBuffer.FIELDCAPTION("Sales Amount (Actual)"),FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(ValueEntryBuffer.FIELDCAPTION("Discount Amount"),FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Cost Amount',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Cost Per Unit',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Price Per Unit',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(FORMAT(Text010),FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(FORMAT(Text011),FALSE,'',TRUE,FALSE,TRUE,'');
        */

    end;

    procedure MakeExcelDataBody()
    begin
        /*
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(Customer."No.",FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(Customer.Name,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(ValueEntryBuffer."Item No.",FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(Item.Description,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(SalesInvoiceHad."Order No.",FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(ValueEntryBuffer."Document No.",FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(-ValueEntryBuffer."Invoiced Quantity",FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(Item."Base Unit of Measure",FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(ValueEntryBuffer."Sales Amount (Actual)",FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(-ValueEntryBuffer."Discount Amount",FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(-ValueEntryBuffer."Cost Amount (Actual)",FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(ValueEntryBuffer."Cost per Unit",FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(ValueEntryBuffer."Price Per Unit",FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(Profit,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(ProfitPct,FALSE,'',FALSE,FALSE,FALSE,'');
         */

    end;

    procedure CreateExcelbook()
    begin
        /*
        ExcelBuf.CreateBook;
        ExcelBuf.CreateSheet(Text001,Text002,COMPANYNAME,USERID);
        ExcelBuf.GiveUserControl;
        ERROR('');
        */

    end;
}

