report 60049 "Purchase Order Analysis"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Purchase Order Analysis.rdl';
    Caption = 'Purchase Order Analysis';

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(STRSUBSTNO_Text000_PeriodText_; STRSUBSTNO(Text000, PeriodText))
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
            column(Vendor_TABLECAPTION__________VendorFilter; Vendor.TABLECAPTION + ': ' + VendorFilter)
            {
            }
            column(Purchase_Header__TABLECAPTION__________PurchaseHeaderFilter; "Purchase Header".TABLECAPTION + ': ' + PurchaseHeaderFilter)
            {
            }
            column(Vendor_Vendor_Name; Vendor.Name)
            {
            }
            column(Vendor_Vendor__No__; Vendor."No.")
            {
            }
            column(Vendor__Balance__LCY__; "Balance (LCY)")
            {
            }
            column(PurchasePrice; PurchasePrice)
            {
                DecimalPlaces = 0 : 2;
            }
            column(Purchase_Line__Quantity; "Purchase Line".Quantity)
            {
                DecimalPlaces = 0 : 2;
            }
            column(PurchasePrice1; PurchasePrice1)
            {
                DecimalPlaces = 2 : 2;
            }
            column(Profit; Profit)
            {
                DecimalPlaces = 2 : 2;
            }
            column(ProfitPercent; ProfitPercent)
            {
                DecimalPlaces = 2 : 2;
            }
            column(LowestSalesPriceProfitPer; LowestSalesPriceProfitPer)
            {
                DecimalPlaces = 2 : 2;
            }
            column(All_amounts_are_in_LCYCaption; All_amounts_are_in_LCYCaptionLbl)
            {
            }
            column(Purchase_Order_Vendor_Item_Wise_ProfitCaption; Purchase_Order_Vendor_Item_Wise_ProfitCaptionLbl)
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
            column(Order_No_Caption; Order_No_CaptionLbl)
            {
            }
            column(Order_QuantityCaption; Order_QuantityCaptionLbl)
            {
            }
            column(Total_Purchase_AmountCaption; Total_Purchase_AmountCaptionLbl)
            {
            }
            column(Cost_Per_UnitCaption; Cost_Per_UnitCaptionLbl)
            {
            }
            column(Av__Sales_Price__STG_Caption; Av__Sales_Price__STG_CaptionLbl)
            {
            }
            column(Line_Amount__STG_Caption; Line_Amount__STG_CaptionLbl)
            {
            }
            column(Average_Sales_Price_Profit__STG__Caption; Average_Sales_Price_Profit__STG__CaptionLbl)
            {
            }
            column(Unit_Cost__STG_Caption; Unit_Cost__STG_CaptionLbl)
            {
            }
            column(Wholesale_PriceCaption; Wholesale_PriceCaptionLbl)
            {
            }
            column(Base_PriceCaption; Base_PriceCaptionLbl)
            {
            }
            column(C_D__PriceCaption; C_D__PriceCaptionLbl)
            {
            }
            column(Lowest_Sales_PriceCaption; Lowest_Sales_PriceCaptionLbl)
            {
            }
            column(Average__Sales_Price_Profit___Caption; Average__Sales_Price_Profit___CaptionLbl)
            {
            }
            column(Lowest__Sales_Price_Profit___Caption; Lowest__Sales_Price_Profit___CaptionLbl)
            {
            }
            column(Vendor__Balance__LCY__Caption; FIELDCAPTION("Balance (LCY)"))
            {
            }
            column(Order_No_Caption_Control1000000010; Order_No_Caption_Control1000000010Lbl)
            {
            }
            dataitem("Purchase Header"; "Purchase Header")
            {
                DataItemLink = "Buy-from Vendor No." = FIELD("No.");
                DataItemTableView = WHERE("Document Type" = CONST("Blanket Order"));
                RequestFilterFields = "Buy-from Vendor No.", "Order Date", "No.";
                column(Purchase_Order_No_______Purchase_Header___No__; 'Purchase Order No : ' + "Purchase Header"."No.")
                {
                }
                column(Purchase_Header__Order_Date_; "Order Date")
                {
                }
                column(Purchase_Header__Purchase_Header___Currency_Code_; "Purchase Header"."Currency Code")
                {
                }
                column(Purchase_Line__Quantity_Control1000000038; "Purchase Line".Quantity)
                {
                    DecimalPlaces = 0 : 2;
                }
                column(PurchasePrice_Control1000000027; PurchasePrice)
                {
                    DecimalPlaces = 0 : 2;
                }
                column(PurchasePrice1_Control1000000035; PurchasePrice1)
                {
                    DecimalPlaces = 2 : 2;
                }
                column(Profit_Control1000000047; Profit)
                {
                    DecimalPlaces = 2 : 2;
                }
                column(ProfitPercent_Control1000000052; ProfitPercent)
                {
                    DecimalPlaces = 2 : 2;
                }
                column(LowestSalesPriceProfitPer_Control1000000067; LowestSalesPriceProfitPer)
                {
                    DecimalPlaces = 2 : 2;
                }
                column(Purchase_Header__Order_Date_Caption; FIELDCAPTION("Order Date"))
                {
                }
                column(Currency_of_OrderCaption; Currency_of_OrderCaptionLbl)
                {
                }
                column(Order_No_Caption_Control1000000006; Order_No_Caption_Control1000000006Lbl)
                {
                }
                column(Purchase_Header_Document_Type; "Document Type")
                {
                }
                column(Purchase_Header_No_; "No.")
                {
                }
                column(Purchase_Header_Buy_from_Vendor_No_; "Buy-from Vendor No.")
                {
                }
                dataitem("Purchase Line"; "Purchase Line")
                {
                    DataItemLink = "Document Type" = FIELD("Document Type"),
                                   "Buy-from Vendor No." = FIELD("Buy-from Vendor No."),
                                   "Document No." = FIELD("No.");
                    DataItemTableView = SORTING("Document Type", "Document No.", "Line No.")
                                        WHERE(Type = FILTER(Item));
                    PrintOnlyIfDetail = false;
                    column(Purchase_Line__Purchase_Line___No__; "Purchase Line"."No.")
                    {
                        //DecimalPlaces = 0:5;
                    }
                    column(Purchase_Line__Description__Purchase_Line___Description_2_; "Purchase Line".Description + "Purchase Line"."Description 2")
                    {
                        //DecimalPlaces = 0:5;
                    }
                    column(Purchase_Header___Posting_Date_; "Purchase Header"."Posting Date")
                    {
                        //DecimalPlaces = 0:5;
                    }
                    column(Purchase_Line__Purchase_Line___Document_No__; "Purchase Line"."Document No.")
                    {
                        //DecimalPlaces = 0:5;
                    }
                    column(Purchase_Line__Purchase_Line__Quantity; "Purchase Line".Quantity)
                    {
                        //DecimalPlaces = 0:5;
                    }
                    column(Purchase_Line__Purchase_Line___Unit_of_Measure_Code_; "Purchase Line"."Unit of Measure Code")
                    {
                        //DecimalPlaces = 0:5;
                    }
                    column(PurchasePrice_Control1000000031; PurchasePrice)
                    {
                        DecimalPlaces = 0 : 5;
                    }
                    column(Purchase_Line__Purchase_Line___Direct_Unit_Cost_; "Purchase Line"."Direct Unit Cost")
                    {
                        DecimalPlaces = 2 : 2;
                    }
                    column(ProfitPercent_Control1000000037; ProfitPercent)
                    {
                        DecimalPlaces = 2 : 2;
                    }
                    column(Profit_Control1000000044; Profit)
                    {
                        DecimalPlaces = 2 : 2;
                    }
                    column(AvgSalesPrice; AvgSalesPrice)
                    {
                    }
                    column(CostPerUnitSTG; CostPerUnitSTG)
                    {
                        DecimalPlaces = 2 : 2;
                    }
                    column(PriceD; PriceD)
                    {
                    }
                    column(PriceE; PriceE)
                    {
                    }
                    column(PriceA; PriceA)
                    {
                    }
                    column(LowestSalesPrice_; LowestSalesPrice)
                    {
                    }
                    column(LowestSalesPriceProfitPer_Control1000000065; LowestSalesPriceProfitPer)
                    {
                        DecimalPlaces = 2 : 2;
                    }
                    column(PurchasePrice1_Control1000000036; PurchasePrice1)
                    {
                        DecimalPlaces = 2 : 2;
                    }
                    column(Purchase_Line_Document_Type; "Document Type")
                    {
                    }
                    column(Purchase_Line_Line_No_; "Line No.")
                    {
                    }
                    column(Purchase_Line_Buy_from_Vendor_No_; "Buy-from Vendor No.")
                    {
                    }
                    column(ItemLineCount; m)
                    {
                    }
                    column(CellS; CellS)
                    {
                    }
                    column(CellR; CellR)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        AvgSalesPrice := 0;
                        SalesPrice := 0;
                        ItemLedQty := 0;
                        ProfitPercent := 0;
                        Profit := 0;
                        CostPerUnitSTG := 0;
                        PurchasePrice := "Purchase Line".Quantity * "Purchase Line"."Direct Unit Cost";
                        LowestSalesPrice := 0;
                        LowestSalesPriceProfitPer := 0;
                        LowestSalesPriceProfit := 0;
                        From_Date := 0D;
                        PriceD := 0;
                        PriceE := 0;
                        PriceA := 0;
                        Salesprice1.RESET;
                        Salesprice1.SETCURRENTKEY(Salesprice1."Item No.", Salesprice1."Sales Type");
                        Salesprice1.SETRANGE(Salesprice1."Item No.", "Purchase Line"."No.");
                        Salesprice1.SETRANGE(Salesprice1."Sales Type", Salesprice1."Sales Type"::"Customer Price Group");
                        IF Salesprice1.FINDFIRST THEN BEGIN
                            REPEAT
                                IF Salesprice1."Sales Code" = 'D' THEN       //CAS-07473-V7F4Z7_Keshab_131017
                                    PriceD := Salesprice1."Unit Price";
                                IF Salesprice1."Sales Code" = 'E' THEN
                                    PriceE := Salesprice1."Unit Price";
                                IF Salesprice1."Sales Code" = 'A' THEN
                                    PriceA := Salesprice1."Unit Price";



                            UNTIL Salesprice1.NEXT = 0;
                        END;


                        ItemQtyMeasure := 1;
                        ItemUnitOfMeasure.RESET;
                        ItemUnitOfMeasure.SETRANGE(ItemUnitOfMeasure."Item No.", "Purchase Line"."No.");
                        ItemUnitOfMeasure.SETRANGE(ItemUnitOfMeasure.Code, "Purchase Line"."Unit of Measure Code");
                        IF ItemUnitOfMeasure.FINDFIRST THEN
                            ItemQtyMeasure := ItemUnitOfMeasure."Qty. per Unit of Measure";




                        From_Date := CALCDATE('-30D', TODAY);
                        ItemLedgerentry.RESET;
                        ItemLedgerentry.SETRANGE(ItemLedgerentry."Item No.", "Purchase Line"."No.");
                        ItemLedgerentry.SETFILTER(ItemLedgerentry."Posting Date", '%1..%2', From_Date, TODAY);
                        ItemLedgerentry.SETRANGE(ItemLedgerentry."Entry Type", ItemLedgerentry."Entry Type"::Sale);
                        C1 := ItemLedgerentry.COUNT;
                        IF ItemLedgerentry.FINDFIRST THEN BEGIN
                            REPEAT
                                ItemLedgerentry.CALCFIELDS(ItemLedgerentry."Sales Amount (Actual)");
                                ItemLedQty := ItemLedQty + (ItemLedgerentry.Quantity * -1);
                                SalesPrice := SalesPrice + (ItemLedgerentry."Sales Amount (Actual)");
                            UNTIL
                            ItemLedgerentry.NEXT = 0;
                        END;


                        IF ItemLedQty <> 0 THEN
                            AvgSalesPrice := (SalesPrice / ItemLedQty);



                        IF AvgSalesPrice = 0 THEN
                            AvgSalesPrice := PriceD;

                        LowestSalesPrice := 0;
                        TempSalesPrice := 0;
                        ValueEntry.RESET;
                        //ValueEntry.SETCURRENTKEY(ValueEntry."Cost per Unit");
                        ValueEntry.SETRANGE(ValueEntry."Item No.", "Purchase Line"."No.");
                        ValueEntry.SETFILTER(ValueEntry."Posting Date", '%1..%2', From_Date, TODAY);
                        ValueEntry.SETRANGE(ValueEntry."Item Ledger Entry Type", ValueEntry."Item Ledger Entry Type"::Sale);
                        IF ValueEntry.FINDFIRST THEN
                            REPEAT
                                //ValueEntry.CALCFIELDS(ValueEntry."Item Ledger Entry Quantity");

                                IF (LowestSalesPrice = 0) THEN BEGIN
                                    IF ValueEntry."Item Ledger Entry Quantity" <> 0 THEN
                                        LowestSalesPrice := ValueEntry."Sales Amount (Actual)" / ValueEntry."Item Ledger Entry Quantity" * (-1);
                                END;
                                IF ValueEntry."Item Ledger Entry Quantity" <> 0 THEN
                                    TempSalesPrice := ValueEntry."Sales Amount (Actual)" / ValueEntry."Item Ledger Entry Quantity" * (-1);


                                IF TempSalesPrice < LowestSalesPrice THEN
                                    LowestSalesPrice := TempSalesPrice;
                            UNTIL ValueEntry.NEXT = 0;

                        IF LowestSalesPrice = 0 THEN
                            LowestSalesPrice := PriceD;




                        CurrencyExchangeRate.RESET;
                        CurrencyExchangeRate.SETCURRENTKEY(CurrencyExchangeRate."Starting Date");
                        CurrencyExchangeRate.SETRANGE(CurrencyExchangeRate."Currency Code", "Purchase Line"."Currency Code");
                        IF CurrencyExchangeRate.FINDLAST THEN
                            ExchangeRate := CurrencyExchangeRate."Exchange Rate Amount";

                        PurchasePrice1 := ("Purchase Line".Quantity * "Purchase Line"."Direct Unit Cost") / ExchangeRate;

                        IF (ExchangeRate <> 0) THEN BEGIN
                            CostPerUnitSTG := (("Purchase Line"."Direct Unit Cost") / ExchangeRate) / ItemQtyMeasure;
                        END;


                        Profit := (AvgSalesPrice * "Purchase Line".Quantity * ItemQtyMeasure) - PurchasePrice1;

                        LowestSalesPriceProfit := (LowestSalesPrice * "Purchase Line".Quantity * ItemQtyMeasure) - PurchasePrice1;
                        //Profit:=(AvgSalesPrice*"Purchase Line".Quantity*ItemQtyMeasure)-
                        //          (("Purchase Line".Quantity*"Purchase Line"."Direct Unit Cost"*ItemQtyMeasure)/ExchangeRate);

                        // IF (AvgSalesPrice<> 0) AND ("Purchase Line".Quantity<>0) THEN
                        //ProfitPercent:= (((AvgSalesPrice*"Purchase Line".Quantity)-PurchasePrice1)/(AvgSalesPrice*"Purchase Line".Quantity))*100;


                        IF (AvgSalesPrice <> 0) THEN
                            ProfitPercent := ((AvgSalesPrice - CostPerUnitSTG) / AvgSalesPrice) * 100;

                        IF (LowestSalesPrice <> 0) THEN
                            LowestSalesPriceProfitPer := ((LowestSalesPrice - CostPerUnitSTG) / LowestSalesPrice) * 100;

                        m += 1;


                        CellR += "Purchase Line"."Qty. on Blanket Order(Actual)" * LowestSalesPrice;
                        IF CellR = 0 THEN
                            CellR := 1;
                        CellS += "Purchase Line"."Qty. on Blanket Order(Actual)" * LowestSalesPrice - ("Purchase Line"."Qty. on Blanket Order(Actual)" * CostPerUnitSTG);
                    end;

                    trigger OnPreDataItem()
                    begin

                        //"Purchase Line".SETFILTER("Purchase Line"."No.",'%1','1-STEMTIT0020050');
                        CurrReport.CREATETOTALS("Purchase Line".Quantity, PurchasePrice, AvgSalesPrice, PurchasePrice1, Profit, CostPerUnitSTG,
                        LowestSalesPriceProfit);

                        AvgSalesPrice := 0;
                        SalesPrice := 0;
                        ItemLedQty := 0;
                        PurchasePrice := 0;

                        ExchangeRate := 1;
                        PurchasePrice1 := 0;
                        Profit := 0;
                        ProfitPercent := 0;
                        LowestSalesPrice := 0;
                        LowestSalesPriceProfitPer := 0;
                        LowestSalesPriceProfit := 0;
                        CellR := 0;
                        CellS := 0;
                    end;
                }

                trigger OnPreDataItem()
                begin
                    CurrReport.CREATETOTALS("Purchase Line".Quantity, PurchasePrice, AvgSalesPrice, PurchasePrice1, Profit, CostPerUnitSTG,
                    LowestSalesPriceProfit);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                C2 := 0;
                PurchHeader.RESET;
                PurchHeader.SETRANGE(PurchHeader."Document Type", PurchHeader."Document Type"::"Blanket Order");
                PurchHeader.SETRANGE(PurchHeader.Status, PurchHeader.Status::Open);
                PurchHeader.SETRANGE(PurchHeader."Buy-from Vendor No.", Vendor."No.");
                C2 := PurchHeader.COUNT;
            end;

            trigger OnPreDataItem()
            begin
                CurrReport.CREATETOTALS("Purchase Line".Quantity, PurchasePrice, AvgSalesPrice, PurchasePrice1, Profit, CostPerUnitSTG,
                LowestSalesPriceProfit);
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

    trigger OnPostReport()
    begin
        //IF PrintToExcel THEN BEGIN
        //CreateExcelbook;
        //ExcelBuf.DELETEALL
        //END
    end;

    trigger OnPreReport()
    begin
        VendorFilter := Vendor.GETFILTERS;
        PurchaseHeaderFilter := "Purchase Header".GETFILTERS;
        IntI := 1;
        //IF PrintToExcel THEN
        // MakeExcelInfo;
    end;

    var
        Text000: Label 'Period: %1';
        Text001: Label 'Data';
        Text002: Label 'Vendor/Item Wise';
        Text003: Label 'Company Name';
        Text004: Label 'Report No.';
        Text005: Label 'Report Name';
        Text006: Label 'User ID';
        Text007: Label 'Date';
        PeriodText: Text[30];
        From_Date: Date;
        ItemLedgerentry: Record 32;
        ItemLedQty: Decimal;
        SalesPrice: Decimal;
        AvgSalesPrice: Decimal;
        PurchasePrice: Decimal;
        CurrencyExchangeRate: Record 330;
        ExchangeRate: Decimal;
        PurchasePrice1: Decimal;
        Profit: Decimal;
        ProfitPercent: Decimal;
        ExcelBuf: Record 370;
        PrintToExcel: Boolean;
        VendorFilter: Text[100];
        PurchaseHeaderFilter: Text[100];
        Text008: Label 'Vendor Filters';
        Text009: Label 'Purchase Header Filters';
        C1: Integer;
        PurchHeader: Record 38;
        C2: Integer;
        CostPerUnitSTG: Decimal;
        Salesprice1: Record 7002;
        PriceD: Decimal;
        PriceE: Decimal;
        ItemQtyMeasure: Decimal;
        ItemUnitOfMeasure: Record 5404;
        PriceA: Decimal;
        ValueEntry: Record 5802;
        LowestSalesPrice: Decimal;
        TempSalesPrice: Decimal;
        LowestSalesPriceProfitPer: Decimal;
        LowestSalesPriceProfit: Decimal;
        IntI: Integer;
        All_amounts_are_in_LCYCaptionLbl: Label 'All amounts are in LCY';
        Purchase_Order_Vendor_Item_Wise_ProfitCaptionLbl: Label 'Purchase Order-Vendor/Item Wise Profit';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Item_No_CaptionLbl: Label 'Item No.';
        DescriptionCaptionLbl: Label 'Description';
        Order_No_CaptionLbl: Label 'Order No.';
        Order_QuantityCaptionLbl: Label 'Order Quantity';
        Total_Purchase_AmountCaptionLbl: Label 'Total Purchase Amount';
        Cost_Per_UnitCaptionLbl: Label 'Cost Per Unit';
        Av__Sales_Price__STG_CaptionLbl: Label 'Av. Sales Price (GBP)';
        Line_Amount__STG_CaptionLbl: Label 'Line Amount (GBP)';
        Average_Sales_Price_Profit__STG__CaptionLbl: Label 'Average Sales Price Profit (GBP)';
        Unit_Cost__STG_CaptionLbl: Label 'Unit Cost (GBP)';
        Wholesale_PriceCaptionLbl: Label 'Wholesale Price';
        Base_PriceCaptionLbl: Label 'Base Price';
        C_D__PriceCaptionLbl: Label 'C+D  Price';
        Lowest_Sales_PriceCaptionLbl: Label 'Lowest Sales Price';
        Average__Sales_Price_Profit___CaptionLbl: Label 'Average  Sales Price Profit % ';
        Lowest__Sales_Price_Profit___CaptionLbl: Label 'Lowest  Sales Price Profit % ';
        Order_No_Caption_Control1000000010Lbl: Label 'Order No.';
        Currency_of_OrderCaptionLbl: Label 'Currency of Order';
        Order_No_Caption_Control1000000006Lbl: Label 'Order No.';
        m: Integer;
        CellR: Decimal;
        CellS: Decimal;
}

