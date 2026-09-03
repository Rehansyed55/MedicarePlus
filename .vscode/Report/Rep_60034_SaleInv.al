report 60034 "Sales - Invoice"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'SalesInvoice.rdl';
    Caption = 'Sales - Invoice';
    PaperSourceDefaultPage = Lower;
    Permissions = TableData 7190 = rimd;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Posted Sales Invoice';
            column(SalesEmail; CompanyInfo."E-Mail")
            {
            }
            column(HomePage; CompanyInfo."Home Page")
            {
            }
            column(CompanyPicture; CompanyInfo.Picture)
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(ShipmentDateCaption; ShipmentDateCaptionLbl)
            {
            }
            column(UnitPriceCaption; UnitPriceCaptionLbl)
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(No_SalesInvcHeader; "No.")
            {
            }
            column(EmailCaption; EmailCaptionLbl)
            {
            }
            column(HomePageCaption; HomePageCaptionLbl)
            {
            }
            column(PaymentTermsCaption; PaymentTermsCaptionLbl)
            {
            }
            column(ShipmentMethodCaption; ShipmentMethodCaptionLbl)
            {
            }
            column(TypeOfSupplyCaption; TypeOfSupplyCaptionLbl)
            {
            }
            column(PaymentDiscountCaption; PaymentDiscountCaptionLbl)
            {
            }
            column(DocDateCaption; DocDateCaptionLbl)
            {
            }
            column(ShipToCode; "Sales Invoice Header"."Ship-to Code")
            {
            }
            column(PostingDate; FORMAT("Sales Invoice Header"."Posting Date"))
            {
            }
            column(ExtDocNo; "Sales Invoice Header"."External Document No.")
            {
            }
            column(OrderDate; FORMAT("Sales Invoice Header"."Order Date"))
            {
            }
            column(SalespersonCode; "Sales Invoice Header"."Salesperson Code")
            {
            }
            column(DueDate; FORMAT("Sales Invoice Header"."Due Date"))
            {
            }
            column(ShipMethodCode; "Sales Invoice Header"."Shipment Method Code")
            {
            }
            column(BilltoCustNo_SalesInvcHeader; "Sales Invoice Header"."Bill-to Customer No.")
            {
            }
            column(ShipToAddr1; ShipToAddr[1])
            {
            }
            column(s; ShipToAddr[2])
            {
            }
            column(ShipToAddr3; ShipToAddr[3])
            {
            }
            column(ShipToAddr4; ShipToAddr[4])
            {
            }
            column(ShipToAddr5; ShipToAddr[5])
            {
            }
            column(ShipToAddr6; ShipToAddr[6])
            {
            }
            column(ShipToAddr7; ShipToAddr[7])
            {
            }
            column(ShipToAddr8; ShipToAddr[8])
            {
            }
            column(NoOfCopies; NoOfCopies)
            {
            }
            // NOTE: CurrReport.PageNo is deprecated since 1.0, but this column is still referenced
            // by a hidden diagnostic textbox in SalesInvoice.rdl (Fields!PageNo.Value) - removing/
            // commenting it out would break RDLC rendering. Left as-is intentionally.
            column(PageNo; CurrReport.PAGENO)
            {
            }
            column(QtyToHandle; QtyToHandle)
            {
            }
            column(cnt; cnt)
            {
            }
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(PaymentTermsDescription; PaymentTerms.Description)
                    {
                    }
                    column(TypeOfSupplyDescription; Description)
                    {
                    }
                    column(ShipmentMethodDescription; ShipmentMethod.Description)
                    {
                    }
                    column(CompanyInfoPicture1; CompanyInfo1.Picture)
                    {
                    }
                    column(CompanyInfoPicture2; CompanyInfo2.Picture)
                    {
                    }
                    column(CompanyInfoPicture3; CompanyInfo3.Picture)
                    {
                    }
                    column(CompanyName1; CompanyInfo.Name)
                    {
                    }
                    column(CompanyAdd1; CompanyInfo.Address)
                    {
                    }
                    column(CompanyAdd2; CompanyInfo."Address 2")
                    {
                    }
                    column(CompanyCity; CompanyInfo.City)
                    {
                    }
                    column(CompanyPostCode; CompanyInfo."Post Code")
                    {
                    }
                    column(PaymentDiscountText; PaymentDiscountText)
                    {
                    }
                    column(CustAddr1; CustAddr[1])
                    {
                    }
                    column(CompanyAddr1; CompanyAddr[1])
                    {
                    }
                    column(CustAddr2; CustAddr[2])
                    {
                    }
                    column(CompanyAddr2; CompanyAddr[2])
                    {
                    }
                    column(CustAddr3; CustAddr[3])
                    {
                    }
                    column(CompanyAddr3; CompanyAddr[3])
                    {
                    }
                    column(CustAddr4; CustAddr[4])
                    {
                    }
                    column(CompanyAddr4; CompanyAddr[4])
                    {
                    }
                    column(CustAddr5; CustAddr[5])
                    {
                    }
                    column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
                    {
                    }
                    column(CompanyInfoFax; CompanyInfo."Fax No.")
                    {
                    }
                    column(CompanyInfoVatRegNo; CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(CustAddr6; CustAddr[6])
                    {
                    }
                    column(CompanyInfoVATRegNo1; CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(CompanyInfoBankName; CompanyInfo."Bank Name")
                    {
                    }
                    column(CompanyInfoBankAccNo; CompanyInfo."Bank Account No.")
                    {
                    }
                    column(PostDate_SalesInvcHeader; FORMAT("Sales Invoice Header"."Posting Date"))
                    {
                    }
                    column(VATNoText; VATNoText)
                    {
                    }
                    column(VATRegNo_SalesInvcHeader; "Sales Invoice Header"."VAT Registration No.")
                    {
                    }
                    column(DueDate_SalesInvcHeader; FORMAT("Sales Invoice Header"."Due Date"))
                    {
                    }
                    column(SalesPersonText; SalesPersonText)
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(No1_SalesInvcHeader; "Sales Invoice Header"."No.")
                    {
                    }
                    column(ReferenceText; ReferenceText)
                    {
                    }
                    column(YourRef_SalesInvcHeader; "Sales Invoice Header"."Your Reference")
                    {
                    }
                    column(OrderNoText; OrderNoText)
                    {
                    }
                    column(OrderNo_SalesInvcHeader; "Sales Invoice Header"."Order No.")
                    {
                    }
                    column(CustAddr7; CustAddr[7])
                    {
                    }
                    column(CustAddr8; CustAddr[8])
                    {
                    }
                    column(CompanyAddr5; CompanyAddr[5])
                    {
                    }
                    column(CompanyAddr6; 7)
                    {
                    }
                    column(DocDate_SalesInvcHeader; FORMAT("Sales Invoice Header"."Document Date", 0, 4))
                    {
                    }
                    column(PriceIncludVAT_SalesInvcHeader; "Sales Invoice Header"."Prices Including VAT")
                    {
                    }
                    column(CompanyInfoBankBranchNo; CompanyInfo."Bank Branch No.")
                    {
                    }
                    column(CompanyInfoEMail; CompanyInfo."E-Mail")
                    {
                    }
                    column(CompanyInfoHomePage; CompanyInfo."Home Page")
                    {
                    }
                    column(CompanyInfo1Picture; CompanyInfo1.Picture)
                    {
                    }
                    column(CopyLoopNumber; CopyLoop.Number)
                    {
                    }
                    column(PageCaption; STRSUBSTNO(Text005, ''))
                    {
                    }
                    column(PriceIncldVAT1_SalesInvcHeader; FORMAT("Sales Invoice Header"."Prices Including VAT"))
                    {
                    }
                    column(PhoneNoCaption; PhoneNoCaptionLbl)
                    {
                    }
                    column(VATRegNoCaption; VATRegNoCaptionLbl)
                    {
                    }
                    column(BankNameCaption; BankNameCaptionLbl)
                    {
                    }
                    column(BankAccNoCaption; BankAccNoCaptionLbl)
                    {
                    }
                    column(DueDateCaption; DueDateCaptionLbl)
                    {
                    }
                    column(InvoiceNoCaption; InvoiceNoCaptionLbl)
                    {
                    }
                    column(PostingDateCaption; PostingDateCaptionLbl)
                    {
                    }
                    column(BankBranchNoCaption; BankBranchNoCaptionLbl)
                    {
                    }
                    column(BilltoCustNo_SalesInvcHeaderCaption; "Sales Invoice Header".FIELDCAPTION("Bill-to Customer No."))
                    {
                    }
                    column(PriceIncludVAT_SalesInvcHeaderCaption; "Sales Invoice Header".FIELDCAPTION("Prices Including VAT"))
                    {
                    }
                    column(CustAddr11; CustAddr[1])
                    {
                    }
                    column(CustAddr22; CustAddr[2])
                    {
                    }
                    column(CustAddr33; CustAddr[3])
                    {
                    }
                    column(CustAddr44; CustAddr[4])
                    {
                    }
                    column(CustAddr55; CustAddr[5])
                    {
                    }
                    column(CustAddr66; CustAddr[6])
                    {
                    }
                    column(CustAddr77; CustAddr[7])
                    {
                    }
                    column(CustAddr88; CustAddr[8])
                    {
                    }
                    column(CopyText; CopyText)
                    {
                    }
                    dataitem(DimensionLoop1; Integer)
                    {
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = FILTER(1 ..));
                        column(DimText; DimText)
                        {
                        }
                        column(DimLoop1Number; Number)
                        {
                        }
                        column(HeaderDimensionsCaption; HeaderDimensionsCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN BEGIN
                                IF NOT DimSetEntry1.FIND('-') THEN
                                    CurrReport.BREAK;
                            END ELSE
                                IF NOT Continue THEN
                                    CurrReport.BREAK;

                            CLEAR(DimText);
                            Continue := FALSE;
                            REPEAT
                                OldDimText := DimText;
                                IF DimText = '' THEN
                                    DimText := STRSUBSTNO(
                                        '%1 %2', DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code")
                                ELSE
                                    DimText :=
                                      STRSUBSTNO(
                                        '%1, %2 %3', DimText,
                                        DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code");
                                IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                    DimText := OldDimText;
                                    Continue := TRUE;
                                    EXIT;
                                END;
                            UNTIL (DimSetEntry1.NEXT = 0);
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF NOT ShowInternalInfo THEN
                                CurrReport.BREAK;
                        end;
                    }
                    dataitem("Sales Invoice Line"; "Sales Invoice Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = SORTING("Document No.", "Line No.");
                        column(Type_SalesInvcLine; "Sales Invoice Line".Type)
                        {
                        }
                        column(LineNo_SalesInvcLine; "Line No.")
                        {
                        }
                        column(LineAmt_SalesInvcLine; "Line Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Desc_SalesInvcLine; Description)
                        {
                        }
                        column(Qty_SalesInvcLine; Quantity)
                        {
                        }
                        column(No_SalesInvcLine; "No.")
                        {
                        }
                        column(GLDesc; GLDesc)
                        {
                        }
                        column(No_SalesInvcLineCaption; FIELDCAPTION("No."))
                        {
                        }
                        column(UOM_SalesInvcLine; "Unit of Measure")
                        {
                        }
                        column(UnitPrice_SalesInvcLine; "Unit Price")
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 2;
                        }
                        column(LineDisc_SalesInvcLine; "Line Discount %")
                        {
                        }
                        column(VATIdentfr_SalesInvcLine; "VAT Identifier")
                        {
                        }
                        column(ShipmentDate_SalesInvcLine; FORMAT("Shipment Date"))
                        {
                        }
                        column(ReverseCharge_SalesInvcLine; "Reverse Charge")
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(SalesSetupInvcWording; SalesSetup."Invoice Wording")
                        {
                        }
                        column(VATBaseDisc_SalesInvcHeader; "Sales Invoice Header"."VAT Base Discount %")
                        {
                        }
                        column(TotalAmountInclVAT; TotalAmountInclVAT)
                        {
                        }
                        column(TotalAmount; TotalAmount)
                        {
                        }
                        column(TotalInvcDiscAmount; TotalInvoiceDiscAmount)
                        {
                        }
                        column(TotalLineAmount; TotalLineAmount)
                        {
                        }
                        column(TotalReverseCharge; TotalReverseCharge)
                        {
                        }
                        column(InvDiscAmt_SalesInvcLine; -"Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(TotalText; TotalText)
                        {
                        }
                        column(Amt_SalesInvcLine; Amount)
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(AmtIncludVATAmt; "Amount Including VAT" - Amount)
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(AmtIncludVAT_SalesInvcLine; "Amount Including VAT")
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmtText; VATAmountLine.VATAmountText)
                        {
                        }
                        column(TotalExclVATText; TotalExclVATText)
                        {
                        }
                        column(TotalInclVATText; TotalInclVATText)
                        {
                        }
                        column(LineAmtInvDiscAmtAmtIncludVAT; -("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT"))
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(CurrencyFactor_SalesInvcHeader; "Sales Invoice Header"."Currency Factor")
                        {
                            DecimalPlaces = 2 : 5;
                        }
                        column(TotalInclVATTextLCY; TotalInclVATTextLCY)
                        {
                        }
                        column(TotalExclVATTextLCY; TotalExclVATTextLCY)
                        {
                        }
                        column(AmountLCY; AmountLCY)
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(AmountIncLCYAmountLCY; AmountIncLCY - AmountLCY)
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(AmountIncLCY; AmountIncLCY)
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(CurrencyCode_SalesInvcHeader; "Sales Invoice Header"."Currency Code")
                        {
                        }
                        column(CurrencyLCY; CurrencyLCY)
                        {
                        }
                        column(DiscountPercentCaption; DiscountPercentCaptionLbl)
                        {
                        }
                        column(InvDiscountAmtCaption; InvDiscountAmtCaptionLbl)
                        {
                        }
                        column(SubtotalCaption; SubtotalCaptionLbl)
                        {
                        }
                        column(PaymentDiscVATCaption; PaymentDiscVATCaptionLbl)
                        {
                        }
                        column(ExchangeRateCaption; ExchangeRateCaptionLbl)
                        {
                        }
                        column(Desc_SalesInvcLineCaption; FIELDCAPTION(Description))
                        {
                        }
                        column(Qty_SalesInvcLineCaption; FIELDCAPTION(Quantity))
                        {
                        }
                        column(UOM_SalesInvcLineCaption; FIELDCAPTION("Unit of Measure"))
                        {
                        }
                        column(VATIdentfr_SalesInvcLineCaption; FIELDCAPTION("VAT Identifier"))
                        {
                        }
                        column(ReverseCharge_SalesInvcLineCaption; FIELDCAPTION("Reverse Charge"))
                        {
                        }
                        column(VAT; "Sales Invoice Line"."VAT %")
                        {
                        }
                        column(Today; TODAY)
                        {
                        }
                        column(Time; FORMAT(TIME, 8, '<Hours24,2>:<Minutes,2>:<Seconds,2>'))
                        {
                        }
                        column(RSP; RSP)
                        {
                        }
                        column(VATamt; VATamt)
                        {
                        }
                        column(Amount; "Sales Invoice Line".Amount)
                        {
                        }
                        column(AmountIncludingVat; "Sales Invoice Line"."Amount Including VAT")
                        {
                        }
                        column(barcode; barcode)
                        {
                        }
                        column(pipcode; Pipcode)
                        {
                        }
                        dataitem("Sales Shipment Buffer"; Integer)
                        {
                            DataItemTableView = SORTING(Number);
                            column(SalesShipmentBufferPostDate; FORMAT(SalesShipmentBuffer."Posting Date"))
                            {
                            }
                            column(SalesShipmentBufferQty; SalesShipmentBuffer.Quantity)
                            {
                                DecimalPlaces = 0 : 5;
                            }
                            column(ShipmentCaption; ShipmentCaptionLbl)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                IF Number = 1 THEN
                                    SalesShipmentBuffer.FIND('-')
                                ELSE
                                    SalesShipmentBuffer.NEXT;
                            end;

                            trigger OnPreDataItem()
                            begin
                                SalesShipmentBuffer.SETRANGE("Document No.", "Sales Invoice Line"."Document No.");
                                SalesShipmentBuffer.SETRANGE("Line No.", "Sales Invoice Line"."Line No.");

                                SETRANGE(Number, 1, SalesShipmentBuffer.COUNT);
                            end;
                        }
                        dataitem(DimensionLoop2; Integer)
                        {
                            DataItemTableView = SORTING(Number)
                                                WHERE(Number = FILTER(1 ..));
                            column(DimText2; DimText)
                            {
                            }
                            column(LineDimensionsCaption; LineDimensionsCaptionLbl)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                IF Number = 1 THEN BEGIN
                                    IF NOT DimSetEntry2.FIND('-') THEN
                                        CurrReport.BREAK;
                                END ELSE
                                    IF NOT Continue THEN
                                        CurrReport.BREAK;

                                CLEAR(DimText);
                                Continue := FALSE;
                                REPEAT
                                    OldDimText := DimText;
                                    IF DimText = '' THEN
                                        DimText := STRSUBSTNO(
                                            '%1 %2', DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code")
                                    ELSE
                                        DimText :=
                                          STRSUBSTNO(
                                            '%1, %2 %3', DimText,
                                            DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code");
                                    IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                        DimText := OldDimText;
                                        Continue := TRUE;
                                        EXIT;
                                    END;
                                UNTIL (DimSetEntry2.NEXT = 0);
                            end;

                            trigger OnPreDataItem()
                            begin
                                IF NOT ShowInternalInfo THEN
                                    CurrReport.BREAK;

                                DimSetEntry2.SETRANGE("Dimension Set ID", "Sales Invoice Line"."Dimension Set ID");
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            PostedShipmentDate := 0D;
                            IF Quantity <> 0 THEN
                                PostedShipmentDate := FindPostedShipmentDate;

                            IF (Type = Type::"G/L Account") AND (NOT ShowInternalInfo) THEN
                                "No." := '';

                            VATAmountLine.INIT;
                            VATAmountLine."VAT Identifier" := "VAT Identifier";
                            VATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
                            VATAmountLine."Tax Group Code" := "Tax Group Code";
                            VATAmountLine."VAT %" := "VAT %";
                            VATAmountLine."VAT Base" := Amount;
                            VATAmountLine."Amount Including VAT" := "Amount Including VAT";
                            VATAmountLine."Line Amount" := "Line Amount";
                            IF "Allow Invoice Disc." THEN
                                VATAmountLine."Inv. Disc. Base Amount" := "Line Amount";
                            VATAmountLine."Invoice Discount Amount" := "Inv. Discount Amount";
                            VATAmountLine.InsertLine;

                            //GB0005.BEGIN
                            TotalAmount += Amount;
                            TotalLineAmount += "Line Amount";
                            TotalInvoiceDiscAmount += "Inv. Discount Amount";
                            TotalAmountInclVAT += "Amount Including VAT";
                            TotalReverseCharge += "Reverse Charge";
                            //GB0005.END

                            RSP := 0;
                            //alok for Block Quantity on report
                            IF "Sales Invoice Line".Quantity = 0 THEN
                                printstatus := FALSE
                            ELSE
                                printstatus := TRUE;
                            CurrReport.SHOWOUTPUT((Type > 0) AND printstatus);
                            //alok finish
                            //CurrReport.SHOWOUTPUT(Type > 0) ;

                            //Rajesh
                            Salesprice.RESET;
                            Salesprice.SETCURRENTKEY(Salesprice."Item No.", Salesprice."Sales Type");
                            Salesprice.SETRANGE(Salesprice."Item No.", "Sales Invoice Line"."No.");
                            Salesprice.SETRANGE(Salesprice."Sales Type", Salesprice."Sales Type"::"Customer Price Group");
                            IF Salesprice.FINDFIRST THEN BEGIN
                                REPEAT
                                    IF Salesprice."Sales Code" = 'A' THEN
                                        RSP := Salesprice."Unit Price";
                                    IF Salesprice."Sales Code" = 'G' THEN
                                        RSP := Salesprice."Unit Price";

                                UNTIL Salesprice.NEXT = 0;
                            END;
                            //alok for vat calculation
                            IF "Sales Invoice Line"."VAT %" <> 0 THEN
                                VATamt := "Sales Invoice Line"."Amount Including VAT" - "Sales Invoice Line".Amount
                            ELSE
                                IF "Sales Invoice Line"."VAT %" = 0 THEN
                                    VATamt := 0;
                            //alok finish
                            //Rajesh
                            /*QtyToHandle :=QtyToHandle+"Sales Invoice Line".Quantity;
                            SIL.SETRANGE(SIL."Document No.","Sales Invoice Line"."Document No.");
                            SIL.SETRANGE(SIL.Type,SIL.Type::Item);
                            SIL.SETFILTER(SIL.Quantity,'<>%1',0);
                            IF SIL.FINDFIRST THEN
                               cnt :=SIL.COUNT; //Prathamesh
                             //MESSAGE(FORMAT(cnt));*/

                            item.RESET;
                            item.SETRANGE("No.", "Sales Invoice Line"."No.");
                            IF item.FINDFIRST THEN BEGIN
                                //barcode := item.Barcode;
                                barcode := barcode;
                                Pipcode := item."No. 2";
                            END;

                        end;

                        trigger OnPostDataItem()
                        begin
                            //MESSAGE(FORMAT( QtyToHandle));
                            //MESSAGE(FORMAT(cnt));
                        end;

                        trigger OnPreDataItem()
                        begin
                            VATAmountLine.DELETEALL;
                            SalesShipmentBuffer.RESET;
                            SalesShipmentBuffer.DELETEALL;
                            FirstValueEntryNo := 0;
                            //QtyToHandle := 0;    cnt :=0;
                            MoreLines := FIND('+');
                            WHILE MoreLines AND (Description = '') AND ("No." = '') AND (Quantity = 0) AND (Amount = 0) DO
                                MoreLines := NEXT(-1) <> 0;
                            IF NOT MoreLines THEN
                                CurrReport.BREAK;
                            SETRANGE("Line No.", 0, "Line No.");
                            // Deprecated since 1.0 - superseded by manual running totals below (GB0005 block)
                            //CurrReport.CREATETOTALS("Line Amount", Amount, "Amount Including VAT", "Inv. Discount Amount", "Reverse Charge"); // PS18964
                            //GB0005.BEGIN
                            TotalAmount := 0;
                            TotalLineAmount := 0;
                            TotalInvoiceDiscAmount := 0;
                            TotalAmountInclVAT := 0;
                            TotalReverseCharge := 0;
                            //GB0005.END
                        end;
                    }
                    dataitem(DataItem5444; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
                        dataitem(VATCounter; Integer)
                        {
                            DataItemTableView = SORTING(Number);
                            column(VATAmountLineVATBase; VATAmountLine."VAT Base")
                            {
                                AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                                AutoFormatType = 1;
                            }
                            column(VATAmountLineVATAmount; VATAmountLine."VAT Amount")
                            {
                                AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                                AutoFormatType = 1;
                            }
                            column(VATAmountLineLineAmount; VATAmountLine."Line Amount")
                            {
                                AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                                AutoFormatType = 1;
                            }
                            column(VATAmtLineInvDiscBaseAmt; VATAmountLine."Inv. Disc. Base Amount")
                            {
                                AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                                AutoFormatType = 1;
                            }
                            column(VATAmtLineInvcDiscAmt; VATAmountLine."Invoice Discount Amount")
                            {
                                AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                                AutoFormatType = 1;
                            }
                            column(VATAmountLineVAT; VATAmountLine."VAT %")
                            {
                                DecimalPlaces = 0 : 5;
                            }
                            column(VATAmountLineVATIdentifier; VATAmountLine."VAT Identifier")
                            {
                            }
                            column(VATPercentCaption; VATPercentCaptionLbl)
                            {
                            }
                            column(VATBaseCaption; VATBaseCaptionLbl)
                            {
                            }
                            column(VATAmountCaption; VATAmountCaptionLbl)
                            {
                            }
                            column(VATAmtSpecCaption; VATAmtSpecCaptionLbl)
                            {
                            }
                            column(VATIdentifierCaption; VATIdentifierCaptionLbl)
                            {
                            }
                            column(InvDiscBaseAmtCaption; InvDiscBaseAmtCaptionLbl)
                            {
                            }
                            column(LineAmountCaption; LineAmountCaptionLbl)
                            {
                            }
                            column(InvDiscountAmtCaption1; InvDiscountAmtCaption1Lbl)
                            {
                            }
                            column(TotalCaption; TotalCaptionLbl)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                VATAmountLine.GetLine(Number);
                            end;

                            trigger OnPreDataItem()
                            begin
                                SETRANGE(Number, 1, VATAmountLine.COUNT);
                                // Deprecated since 1.0 - VATAmountLine is a self-contained buffer read via GetLine; no CreateTotals dependency
                                //CurrReport.CREATETOTALS(
                                //  VATAmountLine."Line Amount", VATAmountLine."Inv. Disc. Base Amount",
                                //  VATAmountLine."Invoice Discount Amount", VATAmountLine."VAT Base", VATAmountLine."VAT Amount");
                            end;
                        }

                        trigger OnPreDataItem()
                        begin
                            IF VATAmountLine.COUNT <= 1 THEN
                                CurrReport.BREAK;
                        end;
                    }
                    dataitem(Total; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
                    }
                    dataitem(Integer2; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
                        dataitem(Total2; Integer)
                        {
                            DataItemTableView = SORTING(Number)
                                                WHERE(Number = CONST(1));
                            column(SelltoCustNo_SalesInvcHeader; "Sales Invoice Header"."Sell-to Customer No.")
                            {
                            }
                            column(ShiptoAddressCaption; ShiptoAddressCaptionLbl)
                            {
                            }
                            column(SelltoCustNo_SalesInvcHeaderCaption; "Sales Invoice Header".FIELDCAPTION("Sell-to Customer No."))
                            {
                            }
                        }

                        trigger OnPreDataItem()
                        begin
                            IF NOT ShowShippingAddr THEN
                                CurrReport.BREAK;
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    IF Number > 1 THEN
                        CopyText := Text009;
                    // Deprecated since 1.0 - dead code; RDLC layout resets per-copy page numbers itself via Globals!PageNumber/GetGroupPageNumber
                    //CurrReport.PAGENO := 1;
                    NoOfCopies := 1;
                end;

                trigger OnPostDataItem()
                begin
                    IF NOT CurrReport.PREVIEW THEN
                        SalesInvCountPrinted.RUN("Sales Invoice Header");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := ABS(NoOfCopies) + Cust."Invoice Copies" + 1;
                    IF NoOfLoops <= 0 THEN
                        NoOfLoops := 1;
                    CopyText := Text008;
                    SETRANGE(Number, 1, NoOfLoops);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                // CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");
                CurrReport.Language := LanguageMgt.GetLanguageIdOrDefault("Language Code");

                CompanyInfo.GET;
                CompanyInfo.CALCFIELDS(CompanyInfo.Picture);

                IF RespCenter.GET("Responsibility Center") THEN BEGIN
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                END ELSE
                    FormatAddr.Company(CompanyAddr, CompanyInfo);


                DimSetEntry1.SETRANGE("Dimension Set ID", "Sales Invoice Header"."Dimension Set ID");

                IF "Order No." = '' THEN
                    OrderNoText := ''
                ELSE
                    OrderNoText := FIELDCAPTION("Order No.");
                IF "Salesperson Code" = '' THEN BEGIN
                    SalesPurchPerson.INIT;
                    SalesPersonText := '';
                END ELSE BEGIN
                    SalesPurchPerson.GET("Salesperson Code");
                    SalesPersonText := Text000;
                END;
                IF "Your Reference" = '' THEN
                    ReferenceText := ''
                ELSE
                    ReferenceText := FIELDCAPTION("Your Reference");
                IF "VAT Registration No." = '' THEN
                    VATNoText := ''
                ELSE
                    VATNoText := FIELDCAPTION("VAT Registration No.");
                IF "Currency Code" = '' THEN BEGIN
                    GLSetup.TESTFIELD("LCY Code");
                    TotalText := STRSUBSTNO(Text001, GLSetup."LCY Code");
                    TotalInclVATText := STRSUBSTNO(Text002, GLSetup."LCY Code");
                    TotalExclVATText := STRSUBSTNO(Text006, GLSetup."LCY Code");
                END ELSE BEGIN
                    TotalText := STRSUBSTNO(Text001, "Currency Code");
                    TotalInclVATText := STRSUBSTNO(Text002, "Currency Code");
                    TotalExclVATText := STRSUBSTNO(Text006, "Currency Code");
                    TotalInclVATTextLCY := STRSUBSTNO(Text002, GLSetup."LCY Code");
                    TotalExclVATTextLCY := STRSUBSTNO(Text006, GLSetup."LCY Code");
                END;
                //FormatAddr.SalesInvBillTo(CustAddr,"Sales Invoice Header");
                //Cust.GET("Bill-to Customer No.");
                IF recCountry.GET("Sales Invoice Header"."Bill-to Country/Region Code") THEN;

                CLEAR(CustAddr);
                CustAddr[1] := "Sales Invoice Header"."Bill-to Name";
                CustAddr[2] := "Sales Invoice Header"."Bill-to Name 2";
                CustAddr[3] := "Sales Invoice Header"."Bill-to Address";
                CustAddr[4] := "Sales Invoice Header"."Bill-to Address 2";
                CustAddr[5] := "Sales Invoice Header"."Bill-to City" + '  ' + "Sales Invoice Header"."Bill-to Post Code";
                CustAddr[6] := FORMAT("Sales Invoice Header"."Bill-to County");
                CustAddr[7] := recCountry.Name;
                COMPRESSARRAY(CustAddr);

                IF "Payment Terms Code" = '' THEN
                    PaymentTerms.INIT
                ELSE
                    PaymentTerms.GET("Payment Terms Code");
                IF "Shipment Method Code" = '' THEN
                    ShipmentMethod.INIT
                ELSE
                    ShipmentMethod.GET("Shipment Method Code");
                /*IF "Type of Supply Code" = '' THEN
                  TypeOfSupply.INIT
                ELSE
                  TypeOfSupply.GET("Type of Supply Code");*///Sofyan

                IF ("VAT Base Discount %" = 0) AND ("Payment Discount %" = 0) THEN
                    PaymentDiscountText := ''
                ELSE
                    PaymentDiscountText :=
                      STRSUBSTNO(
                        Text1041000,
                        "Payment Discount %", "Pmt. Discount Date", "VAT Base Discount %");

                //FormatAddr.SalesInvShipTo(ShipToAddr,"Sales Invoice Header");
                IF recCountry.GET("Sales Invoice Header"."Ship-to Country/Region Code") THEN;

                CLEAR(ShipToAddr);
                ShipToAddr[1] := "Sales Invoice Header"."Ship-to Name";
                ShipToAddr[2] := "Sales Invoice Header"."Ship-to Name 2";
                ShipToAddr[3] := "Sales Invoice Header"."Ship-to Address";
                ShipToAddr[4] := "Sales Invoice Header"."Ship-to Address 2";
                ShipToAddr[5] := "Sales Invoice Header"."Ship-to City" + '  ' + "Sales Invoice Header"."Ship-to Post Code";
                ShipToAddr[6] := FORMAT("Sales Invoice Header"."Ship-to County");
                ShipToAddr[7] := recCountry.Name;
                COMPRESSARRAY(ShipToAddr);
                /*
                ShowShippingAddr := "Sell-to Customer No." <> "Bill-to Customer No.";
                FOR i := 1 TO ARRAYLEN(ShipToAddr) DO
                  IF ShipToAddr[i] <> CustAddr[i] THEN
                    ShowShippingAddr := TRUE;
                    */

                CALCFIELDS(Amount);
                CALCFIELDS("Amount Including VAT");
                AmountLCY :=
                  CurrExchRate.ExchangeAmtFCYToLCY(
                    WORKDATE, "Currency Code", Amount, "Currency Factor");
                AmountIncLCY :=
                  CurrExchRate.ExchangeAmtFCYToLCY(
                    WORKDATE, "Currency Code", "Amount Including VAT", "Currency Factor");

                IF LogInteraction THEN
                    IF NOT CurrReport.PREVIEW THEN BEGIN
                        IF "Bill-to Contact No." <> '' THEN
                            SegManagement.LogDocument(
                              4, "No.", 0, 0, DATABASE::Contact, "Bill-to Contact No.", "Salesperson Code",
                              "Campaign No.", "Posting Description", '')
                        ELSE
                            SegManagement.LogDocument(
                              4, "No.", 0, 0, DATABASE::Customer, "Bill-to Customer No.", "Salesperson Code",
                              "Campaign No.", "Posting Description", '');
                    END;
                //Prathamesh
                CLEAR(cnt);
                //CLEAR(QtyToHandle);
                SIL.RESET;
                SIL.SETRANGE(SIL."Document No.", "Sales Invoice Header"."No.");
                SIL.SETRANGE(SIL.Type, SIL.Type::Item);
                SIL.SETFILTER(SIL.Quantity, '<>%1', 0);
                IF SIL.FINDSET THEN BEGIN
                    cnt := SIL.COUNT;
                    //QtyToHandle +="Sales Invoice Line".Quantity;
                END;

                //CLEAR(cnt);
                CLEAR(QtyToHandle);
                SIL.RESET;
                SIL.SETRANGE(SIL."Document No.", "Sales Invoice Header"."No.");
                SIL.SETRANGE(SIL.Type, SIL.Type::Item);
                SIL.SETFILTER(SIL.Quantity, '<>%1', 0);
                IF SIL.FINDSET THEN
                    REPEAT
                        QtyToHandle += SIL.Quantity;
                    UNTIL SIL.NEXT = 0;
                //Prathamesh

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
                    field(NoOfCopies; NoOfCopies)
                    {
                        Caption = 'No. of Copies';
                    }
                    field(ShowInternalInfo; ShowInternalInfo)
                    {
                        Caption = 'Show Internal Information';
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                    }
                    field(CurrencyLCY; CurrencyLCY)
                    {
                        Caption = 'Show LCY for FCY';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            LogInteractionEnable := TRUE;
        end;

        trigger OnOpenPage()
        begin
            InitLogInteraction;
            LogInteractionEnable := LogInteraction;

            NoOfCopies := 1;
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        GLSetup.GET;
        CompanyInfo.GET;
        SalesSetup.GET;

        CASE SalesSetup."Logo Position on Documents" OF
            SalesSetup."Logo Position on Documents"::"No Logo":
                ;
            SalesSetup."Logo Position on Documents"::Left:
                BEGIN
                    CompanyInfo3.GET;
                    CompanyInfo3.CALCFIELDS(Picture);
                END;
            SalesSetup."Logo Position on Documents"::Center:
                BEGIN
                    CompanyInfo1.GET;
                    CompanyInfo1.CALCFIELDS(Picture);
                END;
            SalesSetup."Logo Position on Documents"::Right:
                BEGIN
                    CompanyInfo2.GET;
                    CompanyInfo2.CALCFIELDS(Picture);
                END;
        END;
    end;

    trigger OnPreReport()
    begin
        IF NOT CurrReport.USEREQUESTPAGE THEN
            InitLogInteraction;
    end;

    var
        Text000: Label 'Salesperson';
        Text001: Label 'Total %1';
        Text002: Label 'Total %1 Incl. VAT';
        Text003: Label 'COPY';
        Text004: Label 'Sales - Invoice %1';
        Text005: Label 'Page %1';
        Text006: Label 'Total %1 Excl. VAT';
        GLSetup: Record 98;
        ShipmentMethod: Record 10;
        PaymentTerms: Record 3;
        SalesPurchPerson: Record 13;
        CompanyInfo: Record 79;
        CompanyInfo1: Record 79;
        CompanyInfo2: Record 79;
        SalesSetup: Record 311;
        Cust: Record 18;
        VATAmountLine: Record 290 temporary;
        DimSetEntry1: Record 480;
        DimSetEntry2: Record 480;
        RespCenter: Record 5714;
        Languages: Record 8;
        //TypeOfSupply: Record 10500;
        SalesInvCountPrinted: Codeunit 315;
        FormatAddr: Codeunit 365;
        SegManagement: Codeunit 5051;
        SalesShipmentBuffer: Record 7190 temporary;
        PostedShipmentDate: Date;
        CustAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        OrderNoText: Text[30];
        SalesPersonText: Text[30];
        VATNoText: Text[30];
        ReferenceText: Text[30];
        TotalText: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        PaymentDiscountText: Text[80];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        ShowShippingAddr: Boolean;
        i: Integer;
        NextEntryNo: Integer;
        FirstValueEntryNo: Integer;
        DimText: Text[120];
        OldDimText: Text[75];
        ShowInternalInfo: Boolean;
        Text1041000: Label '%1 % if paid by %2, VAT discounted at %3 % ';
        Continue: Boolean;
        LogInteraction: Boolean;
        TotalInclVATTextLCY: Text[50];
        TotalExclVATTextLCY: Text[50];
        AmountLCY: Decimal;
        AmountIncLCY: Decimal;
        TotalInvoiceDiscAmount: Decimal;
        TotalLineAmount: Decimal;
        TotalAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalReverseCharge: Decimal;
        CurrExchRate: Record 330;
        CurrencyLCY: Boolean;
        [InDataSet]
        LogInteractionEnable: Boolean;
        CompanyInfo3: Record 79;
        ShipmentDateCaptionLbl: Label 'Shipment Date';
        UnitPriceCaptionLbl: Label 'Unit Price';
        AmountCaptionLbl: Label 'Amount';
        PhoneNoCaptionLbl: Label 'Phone No.';
        VATRegNoCaptionLbl: Label 'VAT Registration No.';
        BankNameCaptionLbl: Label 'Bank';
        BankAccNoCaptionLbl: Label 'Account No.';
        DueDateCaptionLbl: Label 'Due Date';
        InvoiceNoCaptionLbl: Label 'Invoice No.';
        PostingDateCaptionLbl: Label 'Posting Date';
        BankBranchNoCaptionLbl: Label 'Bank Branch No.';
        HeaderDimensionsCaptionLbl: Label 'Header Dimensions';
        DiscountPercentCaptionLbl: Label 'Discount %';
        InvDiscountAmtCaptionLbl: Label 'Invoice Discount Amount';
        SubtotalCaptionLbl: Label 'Subtotal';
        PaymentDiscVATCaptionLbl: Label 'Payment Discount on VAT';
        ExchangeRateCaptionLbl: Label 'Exchange Rate';
        ShipmentCaptionLbl: Label 'Shipment';
        LineDimensionsCaptionLbl: Label 'Line Dimensions';
        VATPercentCaptionLbl: Label 'VAT %';
        VATBaseCaptionLbl: Label 'VAT Base';
        VATAmountCaptionLbl: Label 'VAT Amount';
        VATAmtSpecCaptionLbl: Label 'VAT Amount Specification';
        VATIdentifierCaptionLbl: Label 'VAT Identifier';
        InvDiscBaseAmtCaptionLbl: Label 'Invoice Discount Base Amount';
        LineAmountCaptionLbl: Label 'Line Amount';
        InvDiscountAmtCaption1Lbl: Label 'Invoice Discount Amount';
        TotalCaptionLbl: Label 'Total';
        ShiptoAddressCaptionLbl: Label 'Ship-to Address';
        EmailCaptionLbl: Label 'E-mail';
        HomePageCaptionLbl: Label 'Home Page';
        PaymentTermsCaptionLbl: Label 'Payment Terms';
        ShipmentMethodCaptionLbl: Label 'Shipment Method';
        TypeOfSupplyCaptionLbl: Label 'Type of Supply';
        PaymentDiscountCaptionLbl: Label 'Payment Discount';
        DocDateCaptionLbl: Label 'Document Date';
        printstatus: Boolean;
        Salesprice: Record 7002;
        RSP: Decimal;
        VATamt: Decimal;
        Text008: Label 'Customer Copy';
        Text009: Label 'Office Copy';
        recCountry: Record 9;
        GLDesc: Text[1024];
        QtyToHandle: Decimal;
        cnt: Decimal;
        SIL: Record 113;
        item: Record 27;
        barcode: Code[40];
        Pipcode: Code[20];
        LanguageMgt: Codeunit Language;
        Description: text[50];

    procedure InitLogInteraction()
    begin
        LogInteraction := SegManagement.FindInteractionTemplateCode("Interaction Log Entry Document Type"::"Sales Inv.") <> '';
    end;

    procedure FindPostedShipmentDate(): Date
    var
        SalesShipmentHeader: Record 110;
        SalesShipmentBuffer2: Record 7190 temporary;
    begin
        NextEntryNo := 1;
        IF "Sales Invoice Line"."Shipment No." <> '' THEN
            IF SalesShipmentHeader.GET("Sales Invoice Line"."Shipment No.") THEN
                EXIT(SalesShipmentHeader."Posting Date");

        IF "Sales Invoice Header"."Order No." = '' THEN
            EXIT("Sales Invoice Header"."Posting Date");

        CASE "Sales Invoice Line".Type OF
            "Sales Invoice Line".Type::Item:
                GenerateBufferFromValueEntry("Sales Invoice Line");
            "Sales Invoice Line".Type::"G/L Account", "Sales Invoice Line".Type::Resource,
          "Sales Invoice Line".Type::"Charge (Item)", "Sales Invoice Line".Type::"Fixed Asset":
                GenerateBufferFromShipment("Sales Invoice Line");
            "Sales Invoice Line".Type::" ":
                EXIT(0D);
        END;

        SalesShipmentBuffer.RESET;
        SalesShipmentBuffer.SETRANGE("Document No.", "Sales Invoice Line"."Document No.");
        SalesShipmentBuffer.SETRANGE("Line No.", "Sales Invoice Line"."Line No.");
        IF SalesShipmentBuffer.FIND('-') THEN BEGIN
            SalesShipmentBuffer2 := SalesShipmentBuffer;
            IF SalesShipmentBuffer.NEXT = 0 THEN BEGIN
                SalesShipmentBuffer.GET(
                  SalesShipmentBuffer2."Document No.", SalesShipmentBuffer2."Line No.", SalesShipmentBuffer2."Entry No.");
                SalesShipmentBuffer.DELETE;
                EXIT(SalesShipmentBuffer2."Posting Date");
            END;
            SalesShipmentBuffer.CALCSUMS(Quantity);
            IF SalesShipmentBuffer.Quantity <> "Sales Invoice Line".Quantity THEN BEGIN
                SalesShipmentBuffer.DELETEALL;
                EXIT("Sales Invoice Header"."Posting Date");
            END;
        END ELSE
            EXIT("Sales Invoice Header"."Posting Date");
    end;

    procedure GenerateBufferFromValueEntry(SalesInvoiceLine2: Record 113)
    var
        ValueEntry: Record 5802;
        ItemLedgerEntry: Record 32;
        TotalQuantity: Decimal;
        Quantity: Decimal;
    begin
        TotalQuantity := SalesInvoiceLine2."Quantity (Base)";
        ValueEntry.SETCURRENTKEY("Document No.");
        ValueEntry.SETRANGE("Document No.", SalesInvoiceLine2."Document No.");
        ValueEntry.SETRANGE("Posting Date", "Sales Invoice Header"."Posting Date");
        ValueEntry.SETRANGE("Item Charge No.", '');
        ValueEntry.SETFILTER("Entry No.", '%1..', FirstValueEntryNo);
        IF ValueEntry.FIND('-') THEN
            REPEAT
                IF ItemLedgerEntry.GET(ValueEntry."Item Ledger Entry No.") THEN BEGIN
                    IF SalesInvoiceLine2."Qty. per Unit of Measure" <> 0 THEN
                        Quantity := ValueEntry."Invoiced Quantity" / SalesInvoiceLine2."Qty. per Unit of Measure"
                    ELSE
                        Quantity := ValueEntry."Invoiced Quantity";
                    AddBufferEntry(
                      SalesInvoiceLine2,
                      -Quantity,
                      ItemLedgerEntry."Posting Date");
                    TotalQuantity := TotalQuantity + ValueEntry."Invoiced Quantity";
                END;
                FirstValueEntryNo := ValueEntry."Entry No." + 1;
            UNTIL (ValueEntry.NEXT = 0) OR (TotalQuantity = 0);
    end;

    procedure GenerateBufferFromShipment(SalesInvoiceLine: Record 113)
    var
        SalesInvoiceHeader: Record 112;
        SalesInvoiceLine2: Record 113;
        SalesShipmentHeader: Record 110;
        SalesShipmentLine: Record 111;
        TotalQuantity: Decimal;
        Quantity: Decimal;
    begin
        TotalQuantity := 0;
        SalesInvoiceHeader.SETCURRENTKEY("Order No.");
        SalesInvoiceHeader.SETFILTER("No.", '..%1', "Sales Invoice Header"."No.");
        SalesInvoiceHeader.SETRANGE("Order No.", "Sales Invoice Header"."Order No.");
        IF SalesInvoiceHeader.FIND('-') THEN
            REPEAT
                SalesInvoiceLine2.SETRANGE("Document No.", SalesInvoiceHeader."No.");
                SalesInvoiceLine2.SETRANGE("Line No.", SalesInvoiceLine."Line No.");
                SalesInvoiceLine2.SETRANGE(Type, SalesInvoiceLine.Type);
                SalesInvoiceLine2.SETRANGE("No.", SalesInvoiceLine."No.");
                SalesInvoiceLine2.SETRANGE("Unit of Measure Code", SalesInvoiceLine."Unit of Measure Code");
                IF SalesInvoiceLine2.FIND('-') THEN
                    REPEAT
                        TotalQuantity := TotalQuantity + SalesInvoiceLine2.Quantity;
                    UNTIL SalesInvoiceLine2.NEXT = 0;
            UNTIL SalesInvoiceHeader.NEXT = 0;

        SalesShipmentLine.SETCURRENTKEY("Order No.", "Order Line No.");
        SalesShipmentLine.SETRANGE("Order No.", "Sales Invoice Header"."Order No.");
        SalesShipmentLine.SETRANGE("Order Line No.", SalesInvoiceLine."Line No.");
        SalesShipmentLine.SETRANGE("Line No.", SalesInvoiceLine."Line No.");
        SalesShipmentLine.SETRANGE(Type, SalesInvoiceLine.Type);
        SalesShipmentLine.SETRANGE("No.", SalesInvoiceLine."No.");
        SalesShipmentLine.SETRANGE("Unit of Measure Code", SalesInvoiceLine."Unit of Measure Code");
        SalesShipmentLine.SETFILTER(Quantity, '<>%1', 0);

        IF SalesShipmentLine.FIND('-') THEN
            REPEAT
                IF "Sales Invoice Header"."Get Shipment Used" THEN
                    CorrectShipment(SalesShipmentLine);
                IF ABS(SalesShipmentLine.Quantity) <= ABS(TotalQuantity - SalesInvoiceLine.Quantity) THEN
                    TotalQuantity := TotalQuantity - SalesShipmentLine.Quantity
                ELSE BEGIN
                    IF ABS(SalesShipmentLine.Quantity) > ABS(TotalQuantity) THEN
                        SalesShipmentLine.Quantity := TotalQuantity;
                    Quantity :=
                      SalesShipmentLine.Quantity - (TotalQuantity - SalesInvoiceLine.Quantity);

                    TotalQuantity := TotalQuantity - SalesShipmentLine.Quantity;
                    SalesInvoiceLine.Quantity := SalesInvoiceLine.Quantity - Quantity;

                    IF SalesShipmentHeader.GET(SalesShipmentLine."Document No.") THEN
                        AddBufferEntry(
                          SalesInvoiceLine,
                          Quantity,
                          SalesShipmentHeader."Posting Date");
                END;
            UNTIL (SalesShipmentLine.NEXT = 0) OR (TotalQuantity = 0);
    end;

    procedure CorrectShipment(var SalesShipmentLine: Record 111)
    var
        SalesInvoiceLine: Record 113;
    begin
        SalesInvoiceLine.SETCURRENTKEY("Shipment No.", "Shipment Line No.");
        SalesInvoiceLine.SETRANGE("Shipment No.", SalesShipmentLine."Document No.");
        SalesInvoiceLine.SETRANGE("Shipment Line No.", SalesShipmentLine."Line No.");
        IF SalesInvoiceLine.FIND('-') THEN
            REPEAT
                SalesShipmentLine.Quantity := SalesShipmentLine.Quantity - SalesInvoiceLine.Quantity;
            UNTIL SalesInvoiceLine.NEXT = 0;
    end;

    procedure AddBufferEntry(SalesInvoiceLine: Record 113; QtyOnShipment: Decimal; PostingDate: Date)
    begin
        SalesShipmentBuffer.SETRANGE("Document No.", SalesInvoiceLine."Document No.");
        SalesShipmentBuffer.SETRANGE("Line No.", SalesInvoiceLine."Line No.");
        SalesShipmentBuffer.SETRANGE("Posting Date", PostingDate);
        IF SalesShipmentBuffer.FIND('-') THEN BEGIN
            SalesShipmentBuffer.Quantity := SalesShipmentBuffer.Quantity + QtyOnShipment;
            SalesShipmentBuffer.MODIFY;
            EXIT;
        END;

        // Deprecated since 1.0 - WITH statement removed (deprecated for cloud development)
        SalesShipmentBuffer."Document No." := SalesInvoiceLine."Document No.";
        SalesShipmentBuffer."Line No." := SalesInvoiceLine."Line No.";
        SalesShipmentBuffer."Entry No." := NextEntryNo;
        SalesShipmentBuffer.Type := SalesInvoiceLine.Type;
        SalesShipmentBuffer."No." := SalesInvoiceLine."No.";
        SalesShipmentBuffer.Quantity := QtyOnShipment;
        SalesShipmentBuffer."Posting Date" := PostingDate;
        SalesShipmentBuffer.INSERT;
        NextEntryNo := NextEntryNo + 1
    end;
}

