report 60048 "Purchase - InvoiceGB"
{
    // version vaibhav

    // <changelog>
    //   <change id="GB0001" dev="TMARTI" date="2005-04-28" area="UKGEN" feature="5386"
    //     baseversion="UK4.00" releaseversion="GB4.00.A">General UK functionality</change>
    //   <change id="GB0002" dev="TMARTI" date="2006-10-31" area="UKGEN" feature="NAVCORS4154"
    //     baseversion="UK4.00" releaseversion="GB5.00">&quot;Show LCY for FCY&quot; field on Report 10577 - request form
    //     does not work properly</change>
    //   <remove id="GB0003" dev="TMARTI" date="2007-06-14" area="UKGEN"  request="UK-START-51"
    //     baseversion="GB4.00" releaseversion="GB6.00">C/Track cleanup</remove>
    //   <add id="GB0004" dev="TMARTI" date="2007-06-14" area="DOCLAY"  request="UK-START-51"
    //     releaseversion="GB6.00">Document layout</add>
    //   <add id="GB0005" dev="TMARTI" date="2007-09-03" area="VATREP" feature="NAVCORS13286"
    //     releaseversion="GB6.00">HMRC Reverse Charges Sales List</add>
    //   <change id="GB0006" dev="AUGMENTUM" date="2007-08-31" area="DOCLAY" feature="PSCORS1177"
    //     baseversion="GB6.00" releaseversion="GB6.00">Report Transformation - local Report Layout Format all the dates
    //     to make NNC consistent with old client</change>
    //   <add id="GB0029" dev="TMARTI" date="2004-06-26" area="INTRASTAT"  request="PS 1410"
    //     releaseversion="GB4.00">PS 1410 - VAT amount in local currency</add>
    //   <add id="GB0054" dev="TMARTI" date="2004-07-25" area="UKGEN"  request="UK-START-40"
    //     releaseversion="GB4.00">Object moved into UK object range</add>
    // </changelog>
    DefaultLayout = RDLC;
    RDLCLayout = './Purchase-InvoiceGB.rdl';

    Caption = 'Purchase - Invoice';

    dataset
    {
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Buy-from Vendor No.", "No. Printed";
            RequestFilterHeading = 'Posted Purchase Invoice';
            column(No_PurchInvHeader; "No.")
            {
            }
            column(VendorInvoice_PurchInvHeader; "Purch. Inv. Header"."Vendor Invoice No.")
            {
            }
            column(PurchInvHeader_DocumentDate; FORMAT("Purch. Inv. Header"."Document Date"))
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
                    column(ShipmentMethodDescription; ShipmentMethod.Description)
                    {
                    }
                    // column(TypeOfSupplyDescription; TypeOfSupply.Description)
                    // {
                    // }
                    column(PaymentDiscountText; PaymentDiscountText)
                    {
                    }
                    column(PurchaseInvoice; STRSUBSTNO(Text004, CopyText))
                    {
                    }
                    column(VendAddr1; VendAddr[1])
                    {
                    }
                    column(CompanyAddr1; CompanyAddr[1])
                    {
                    }
                    column(VendAddr2; VendAddr[2])
                    {
                    }
                    column(CompanyAddr2; CompanyAddr[2])
                    {
                    }
                    column(VendAddr3; VendAddr[3])
                    {
                    }
                    column(CompanyAddr3; CompanyAddr[3])
                    {
                    }
                    column(VendAddr4; VendAddr[4])
                    {
                    }
                    column(CompanyAddr4; CompanyAddr[4])
                    {
                    }
                    column(VendAddr5; VendAddr[5])
                    {
                    }
                    column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
                    {
                    }
                    column(CompanyInfoFaxNo; CompanyInfo."Fax No.")
                    {
                    }
                    column(VendAddr6; VendAddr[6])
                    {
                    }
                    column(CompanyInfoHomePage; CompanyInfo."Home Page")
                    {
                    }
                    column(CompanyInfoEmail; CompanyInfo."E-Mail")
                    {
                    }
                    column(CompanyInfoPicture; CompanyInfo.Picture)
                    {
                    }
                    column(CompanyInfoVATRegNo; CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(CompanyInfoBankName; CompanyInfo."Bank Name")
                    {
                    }
                    column(CompanyInfoBankAccountNo; CompanyInfo."Bank Account No.")
                    {
                    }
                    column(PayVendNo_PurchInvHeader; "Purch. Inv. Header"."Pay-to Vendor No.")
                    {
                    }
                    column(DocDate_PurchInvHeader; FORMAT("Purch. Inv. Header"."Document Date"))
                    {
                    }
                    column(VATNoText; VATNoText)
                    {
                    }
                    column(VATRegNo_PurchInvHeader; "Purch. Inv. Header"."VAT Registration No.")
                    {
                    }
                    column(DueDate_PurchInvHeader; FORMAT("Purch. Inv. Header"."Due Date"))
                    {
                    }
                    column(PurchaserText; PurchaserText)
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(ReferenceText; ReferenceText)
                    {
                    }
                    column(YourRef_PurchInvHeader; "Purch. Inv. Header"."Your Reference")
                    {
                    }
                    column(OrderNoText; OrderNoText)
                    {
                    }
                    column(OrderNo_PurchInvHeader; "Purch. Inv. Header"."Order No.")
                    {
                    }
                    column(VendAddr7; VendAddr[7])
                    {
                    }
                    column(VendAddr8; VendAddr[8])
                    {
                    }
                    column(CompanyAddr5; CompanyAddr[5])
                    {
                    }
                    column(CompanyAddr6; CompanyAddr[6])
                    {
                    }
                    column(PostDate_PurchInvHeader; FORMAT("Purch. Inv. Header"."Posting Date"))
                    {
                    }
                    column(PricIncVAT_PurchInvHeader; "Purch. Inv. Header"."Prices Including VAT")
                    {
                    }
                    column(CompanyInfoBankBranchNo; CompanyInfo."Bank Branch No.")
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(Pagecaption; STRSUBSTNO(Text005, ''))
                    {
                    }
                    column(PricIncVAT1_PurchInvHeader; FORMAT("Purch. Inv. Header"."Prices Including VAT"))
                    {
                    }
                    column(BuyVendNo_PurchInvHeader; "Purch. Inv. Header"."Buy-from Vendor No.")
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
                    column(BankAccountNoCaption; BankAccountNoCaptionLbl)
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
                    column(BranchNoCaption; BranchNoCaptionLbl)
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
                    column(HomePageCaption; HomePageCaptionLbl)
                    {
                    }
                    column(EmailCaption; EmailCaptionLbl)
                    {
                    }
                    column(DocumentDateCaption; DocumentDateCaptionLbl)
                    {
                    }
                    column(PayVendNo_PurchInvHeaderCaption; "Purch. Inv. Header".FIELDCAPTION("Pay-to Vendor No."))
                    {
                    }
                    column(PricIncVAT_PurchInvHeaderCaption; "Purch. Inv. Header".FIELDCAPTION("Prices Including VAT"))
                    {
                    }
                    column(BuyVendNo_PurchInvHeaderCaption; "Purch. Inv. Header".FIELDCAPTION("Buy-from Vendor No."))
                    {
                    }
                    dataitem(DimensionLoop1; Integer)
                    {
                        DataItemLinkReference = "Purch. Inv. Header";
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = FILTER(1 ..));
                        column(DimText; DimText)
                        {
                        }
                        column(Number_IntegerLine; Number)
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
                    dataitem("Purch. Inv. Line"; "Purch. Inv. Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Purch. Inv. Header";
                        DataItemTableView = SORTING("Document No.", "Line No.");
                        column(LineAmount_PurchInvLine; "Line Amount")
                        {
                            AutoFormatExpression = "Purch. Inv. Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Description_PurchInvLine; Description)
                        {
                        }
                        column(Type_PurchInvLine; "Purch. Inv. Line".Type)
                        {
                        }
                        column(No_PurchInvLine; "No.")
                        {
                        }
                        column(NoFieldCaption; FIELDCAPTION("No."))
                        {
                        }
                        column(Quantity_PurchInvLine; Quantity)
                        {
                        }
                        column(UOM_PurchInvLine; "Unit of Measure")
                        {
                        }
                        column(DirUnitCost_PurchInvLine; "Direct Unit Cost")
                        {
                            AutoFormatExpression = "Purch. Inv. Line".GetCurrencyCode;
                            AutoFormatType = 2;
                        }
                        column(LineDiscount_PurchInvLine; "Line Discount %")
                        {
                        }
                        column(VATIdent_PurchInvLine; "VAT Identifier")
                        {
                        }
                        column(RevCharge_PurchInvLine; "Reverse Charge")
                        {
                            AutoFormatExpression = "Purch. Inv. Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalLineAmount; TotalLineAmount)
                        {
                        }
                        column(TotalInvoiceDiscAmount; TotalInvoiceDiscAmount)
                        {
                        }
                        column(TotalAmount; TotalAmount)
                        {
                        }
                        column(TotalAmountInclVAT; TotalAmountInclVAT)
                        {
                        }
                        column(InvDiscAmt_PurchInvLine; -"Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Purch. Inv. Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(TotalText; TotalText)
                        {
                        }
                        column(Amount_PurchInvLine; Amount)
                        {
                            AutoFormatExpression = "Purch. Inv. Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(TotalInclVATText; TotalInclVATText)
                        {
                        }
                        column(AmtIncVAT_PurchInvLine; "Amount Including VAT")
                        {
                            AutoFormatExpression = "Purch. Inv. Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(AmountIncludingVATAmount; "Amount Including VAT" - Amount)
                        {
                            AutoFormatExpression = "Purch. Inv. Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmountText; VATAmountLine.VATAmountText)
                        {
                        }
                        column(TotalExclVATText; TotalExclVATText)
                        {
                        }
                        column(LineAmtInvDiscAmtIncVAT; -("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT"))
                        {
                            AutoFormatExpression = "Purch. Inv. Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATBasDisc_PurchInvHeader; "Purch. Inv. Header"."VAT Base Discount %")
                        {
                        }
                        column(CurrFactor_PurchInvHeader; "Purch. Inv. Header"."Currency Factor")
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
                            AutoFormatExpression = "Purch. Inv. Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(AmountIncLCYAmountLCY; AmountIncLCY - AmountLCY)
                        {
                            AutoFormatExpression = "Purch. Inv. Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(AmountIncLCY; AmountIncLCY)
                        {
                            AutoFormatExpression = "Purch. Inv. Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(CurrCode_PurchInvHeader; "Purch. Inv. Header"."Currency Code")
                        {
                        }
                        column(CurrencyLCY; CurrencyLCY)
                        {
                        }
                        column(LineNo_PurchInvLine; "Line No.")
                        {
                        }
                        column(DirectUnitCostCaption; DirectUnitCostCaptionLbl)
                        {
                        }
                        column(DiscountPercentCaption; DiscountPercentCaptionLbl)
                        {
                        }
                        column(AmountCaption; AmountCaptionLbl)
                        {
                        }
                        column(InvDiscountAmountCaption; InvDiscountAmountCaptionLbl)
                        {
                        }
                        column(SubtotalCaption; SubtotalCaptionLbl)
                        {
                        }
                        column(PaymentDisconVATCaption; PaymentDisconVATCaptionLbl)
                        {
                        }
                        column(ExchangeRateCaption; ExchangeRateCaptionLbl)
                        {
                        }
                        column(Description_PurchInvLineCaption; FIELDCAPTION(Description))
                        {
                        }
                        column(Quantity_PurchInvLineCaption; FIELDCAPTION(Quantity))
                        {
                        }
                        column(UOM_PurchInvLineCaption; FIELDCAPTION("Unit of Measure"))
                        {
                        }
                        column(VATIdent_PurchInvLineCaption; FIELDCAPTION("VAT Identifier"))
                        {
                        }
                        column(RevCharge_PurchInvLineCaption; FIELDCAPTION("Reverse Charge"))
                        {
                        }
                        dataitem(DimensionLoop2; Integer)
                        {
                            DataItemTableView = SORTING(Number)
                                                WHERE(Number = FILTER(1 ..));
                            column(DimText1; DimText)
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

                                DimSetEntry2.SETRANGE("Dimension Set ID", "Purch. Inv. Line"."Dimension Set ID");
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF (Type = Type::"G/L Account") AND (NOT ShowInternalInfo) THEN
                                "No." := '';

                            VATAmountLine.INIT;
                            VATAmountLine."VAT Identifier" := "Purch. Inv. Line"."VAT Identifier";
                            VATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
                            VATAmountLine."Tax Group Code" := "Tax Group Code";
                            VATAmountLine."Use Tax" := "Use Tax";
                            VATAmountLine."VAT %" := "VAT %";
                            VATAmountLine."VAT Base" := Amount;
                            VATAmountLine."Amount Including VAT" := "Amount Including VAT";
                            VATAmountLine."Line Amount" := "Line Amount";
                            IF "Allow Invoice Disc." THEN
                                VATAmountLine."Inv. Disc. Base Amount" := "Line Amount";
                            VATAmountLine."Invoice Discount Amount" := "Inv. Discount Amount";
                            VATAmountLine.InsertLine;

                            //GB0006.BEGIN
                            TotalAmount += Amount;
                            TotalLineAmount += "Line Amount";
                            TotalInvoiceDiscAmount += "Inv. Discount Amount";
                            TotalAmountInclVAT += "Amount Including VAT";
                            //GB0006.END
                        end;

                        trigger OnPreDataItem()
                        begin
                            VATAmountLine.DELETEALL;
                            MoreLines := FIND('+');
                            WHILE MoreLines AND (Description = '') AND ("No." = '') AND (Quantity = 0) AND (Amount = 0) DO
                                MoreLines := NEXT(-1) <> 0;
                            IF NOT MoreLines THEN
                                CurrReport.BREAK;
                            SETRANGE("Line No.", 0, "Line No.");
                            CurrReport.CREATETOTALS("Line Amount", "Inv. Discount Amount", Amount, "Amount Including VAT", "Reverse Charge"); // PS18964
                            //GB0006.BEGIN
                            TotalAmount := 0;
                            TotalLineAmount := 0;
                            TotalInvoiceDiscAmount := 0;
                            TotalAmountInclVAT := 0;
                            //GB0006.END
                        end;
                    }
                    dataitem(DataItem5444; integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
                        dataitem(VATCounter; Integer)
                        {
                            DataItemTableView = SORTING(Number);
                            column(VATAmountLineVATBase; VATAmountLine."VAT Base")
                            {
                                AutoFormatExpression = "Purch. Inv. Header"."Currency Code";
                                AutoFormatType = 1;
                            }
                            column(VATAmountLineVATAmount; VATAmountLine."VAT Amount")
                            {
                                AutoFormatExpression = "Purch. Inv. Header"."Currency Code";
                                AutoFormatType = 1;
                            }
                            column(VATAmountLineLineAmount; VATAmountLine."Line Amount")
                            {
                                AutoFormatExpression = "Purch. Inv. Header"."Currency Code";
                                AutoFormatType = 1;
                            }
                            column(VATAmtLineInvDiscBaseAmt; VATAmountLine."Inv. Disc. Base Amount")
                            {
                                AutoFormatExpression = "Purch. Inv. Header"."Currency Code";
                                AutoFormatType = 1;
                            }
                            column(VATAmtLineInvDiscountAmt; VATAmountLine."Invoice Discount Amount")
                            {
                                AutoFormatExpression = "Purch. Inv. Header"."Currency Code";
                                AutoFormatType = 1;
                            }
                            column(VATAmountLineVAT; VATAmountLine."VAT %")
                            {
                                DecimalPlaces = 0 : 5;
                            }
                            column(VATAmtLineVATIdentifier; VATAmountLine."VAT Identifier")
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
                            column(VATAmountSpecificationCaption; VATAmountSpecificationCaptionLbl)
                            {
                            }
                            column(InvcDiscAmtCaption; InvcDiscAmtCaptionLbl)
                            {
                            }
                            column(InvDiscBaseAmtCaption; InvDiscBaseAmtCaptionLbl)
                            {
                            }
                            column(LineAmountCaption; LineAmountCaptionLbl)
                            {
                            }
                            column(VATIdentifierCaption; VATIdentifierCaptionLbl)
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
                                CurrReport.CREATETOTALS(
                                  VATAmountLine."Line Amount", VATAmountLine."Inv. Disc. Base Amount",
                                  VATAmountLine."Invoice Discount Amount", VATAmountLine."VAT Base", VATAmountLine."VAT Amount");
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
                    dataitem(Total2; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));

                        trigger OnPreDataItem()
                        begin
                            IF "Purch. Inv. Header"."Buy-from Vendor No." = "Purch. Inv. Header"."Pay-to Vendor No." THEN
                                CurrReport.BREAK;
                        end;
                    }
                    dataitem(Integer2; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
                        dataitem(Total3; Integer)
                        {
                            DataItemTableView = SORTING(Number)
                                                WHERE(Number = CONST(1));
                            column(ShipToAddr1; ShipToAddr[1])
                            {
                            }
                            column(ShipToAddr2; ShipToAddr[2])
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
                            column(ShiptoAddressCaption; ShiptoAddressCaptionLbl)
                            {
                            }
                        }

                        trigger OnPreDataItem()
                        begin
                            IF ShipToAddr[1] = '' THEN
                                CurrReport.BREAK;
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    IF Number > 1 THEN BEGIN
                        CopyText := Text003;
                        // GB0006.begin
                        OutputNo += 1;
                        // GB0006.end
                    END;

                    CurrReport.PAGENO := 1;
                end;

                trigger OnPostDataItem()
                begin
                    IF NOT CurrReport.PREVIEW THEN
                        PurchInvCountPrinted.RUN("Purch. Inv. Header");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := ABS(NoOfCopies) + 1;
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                    // GB0006.begin
                    OutputNo := 1;
                    // GB0006.end
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CurrReport.Language := LanguageMgt.GetLanguageIdOrDefault("Language Code");
                //CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");

                CompanyInfo.GET;
                CompanyInfo.CALCFIELDS(CompanyInfo.Picture);

                IF RespCenter.GET("Responsibility Center") THEN BEGIN
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                END ELSE
                    FormatAddr.Company(CompanyAddr, CompanyInfo);

                DimSetEntry1.SETRANGE("Dimension Set ID", "Purch. Inv. Header"."Dimension Set ID");

                IF "Order No." = '' THEN
                    OrderNoText := ''
                ELSE
                    OrderNoText := FIELDCAPTION("Order No.");
                IF "Purchaser Code" = '' THEN BEGIN
                    CLEAR(SalesPurchPerson);
                    PurchaserText := '';
                END ELSE BEGIN
                    SalesPurchPerson.GET("Purchaser Code");
                    PurchaserText := Text000
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
                FormatAddr.PurchInvPayTo(VendAddr, "Purch. Inv. Header");

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
                  TypeOfSupply.GET("Type of Supply Code");*/

                IF ("VAT Base Discount %" = 0) AND ("Payment Discount %" = 0) THEN
                    PaymentDiscountText := ''
                ELSE
                    PaymentDiscountText :=
                      STRSUBSTNO(
                        '%1 % if paid by %2, VAT discounted at %3 % ',
                        "Payment Discount %", "Pmt. Discount Date", "VAT Base Discount %");

                //FormatAddr.PurchInvShipTo(ShipToAddr,"Purch. Inv. Header");


                IF recCountry.GET("Purch. Inv. Header"."Ship-to Country/Region Code") THEN;

                CLEAR(ShipToAddr);
                ShipToAddr[1] := "Purch. Inv. Header"."Ship-to Name";
                ShipToAddr[2] := "Purch. Inv. Header"."Ship-to Name 2";
                ShipToAddr[3] := "Purch. Inv. Header"."Ship-to Address";
                ShipToAddr[4] := "Purch. Inv. Header"."Ship-to Address 2";
                ShipToAddr[5] := "Purch. Inv. Header"."Ship-to City" + '  ' + "Purch. Inv. Header"."Ship-to Post Code";
                ShipToAddr[6] := FORMAT("Purch. Inv. Header"."Ship-to County");
                ShipToAddr[7] := recCountry.Name;
                COMPRESSARRAY(ShipToAddr);


                CALCFIELDS(Amount);
                CALCFIELDS("Amount Including VAT");

                AmountLCY :=
                  CurrExchRate.ExchangeAmtFCYToLCY(
                    WORKDATE, "Currency Code", Amount, "Currency Factor");
                AmountIncLCY :=
                  CurrExchRate.ExchangeAmtFCYToLCY(
                    WORKDATE, "Currency Code", "Amount Including VAT", "Currency Factor");

                IF LogInteraction THEN
                    IF NOT CurrReport.PREVIEW THEN
                        SegManagement.LogDocument(
                          14, "No.", 0, 0, DATABASE::Vendor, "Buy-from Vendor No.", "Purchaser Code", '', "Posting Description", '');

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
                        ApplicationArea = All;
                        Caption = 'No. of Copies';
                    }
                    field(ShowInternalInfo; ShowInternalInfo)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Internal Information';
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        ApplicationArea = All;
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                    }
                    field(CurrencyLCY; CurrencyLCY)
                    {
                        ApplicationArea = All;
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
            LogInteraction := SegManagement.FindInteractionTemplateCode("Interaction Log Entry Document Type"::"Purch. Inv.") <> '';
            //LogInteraction := SegManagement.FindInteractTmplCode(14) <> '';
            LogInteractionEnable := LogInteraction;
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        GLSetup.GET;
    end;

    var
        Text000: Label 'Purchaser';
        Text001: Label 'Total %1';
        Text002: Label 'Total %1 Incl. VAT';
        Text003: Label 'COPY';
        Text004: Label 'Purchase - Invoice %1';
        Text005: Label 'Page %1';
        Text006: Label 'Total %1 Excl. VAT';
        GLSetup: Record 98;
        CompanyInfo: Record 79;
        ShipmentMethod: Record 10;
        PaymentTerms: Record 3;
        SalesPurchPerson: Record 13;
        VATAmountLine: Record 290 temporary;
        DimSetEntry1: Record 480;
        DimSetEntry2: Record 480;
        RespCenter: Record 5714;
        Language1: Record 8;
        //TypeOfSupply: Record 10500;
        LanguageMgt: Codeunit Language;
        PurchInvCountPrinted: Codeunit 319;
        FormatAddr: Codeunit 365;
        SegManagement: Codeunit 5051;
        VendAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        PurchaserText: Text[30];
        VATNoText: Text[30];
        ReferenceText: Text[30];
        OrderNoText: Text[30];
        TotalText: Text[50];
        TotalInclVATText: Text[50];
        TotalExclVATText: Text[50];
        PaymentDiscountText: Text[80];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[10];
        DimText: Text[120];
        OldDimText: Text[75];
        ShowInternalInfo: Boolean;
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
        CurrExchRate: Record 330;
        CurrencyLCY: Boolean;
        OutputNo: Integer;
        [InDataSet]
        LogInteractionEnable: Boolean;
        PhoneNoCaptionLbl: Label 'Phone No.';
        VATRegNoCaptionLbl: Label 'VAT Registration No.';
        BankNameCaptionLbl: Label 'Bank';
        BankAccountNoCaptionLbl: Label 'Account No.';
        DueDateCaptionLbl: Label 'Due Date';
        InvoiceNoCaptionLbl: Label 'Invoice No.';
        PostingDateCaptionLbl: Label 'Posting Date';
        BranchNoCaptionLbl: Label 'Bank Branch No.';
        PaymentTermsCaptionLbl: Label 'Payment Terms';
        ShipmentMethodCaptionLbl: Label 'Shipment Method';
        TypeOfSupplyCaptionLbl: Label 'Type of Supply';
        PaymentDiscountCaptionLbl: Label 'Payment Discount';
        HomePageCaptionLbl: Label 'Home Page';
        EmailCaptionLbl: Label 'E-Mail';
        DocumentDateCaptionLbl: Label 'Document Date';
        HeaderDimensionsCaptionLbl: Label 'Header Dimensions';
        DirectUnitCostCaptionLbl: Label 'Direct Unit Cost';
        DiscountPercentCaptionLbl: Label 'Discount %';
        AmountCaptionLbl: Label 'Amount';
        InvDiscountAmountCaptionLbl: Label 'Invoice Discount Amount';
        SubtotalCaptionLbl: Label 'Subtotal';
        PaymentDisconVATCaptionLbl: Label 'Payment Discount on VAT';
        ExchangeRateCaptionLbl: Label 'Exchange Rate';
        LineDimensionsCaptionLbl: Label 'Line Dimensions';
        VATPercentCaptionLbl: Label 'VAT %';
        VATBaseCaptionLbl: Label 'VAT Base';
        VATAmountCaptionLbl: Label 'VAT Amount';
        VATAmountSpecificationCaptionLbl: Label 'VAT Amount Specification';
        InvcDiscAmtCaptionLbl: Label 'Invoice Discount Amount';
        InvDiscBaseAmtCaptionLbl: Label 'Invoice Discount Base Amount';
        LineAmountCaptionLbl: Label 'Line Amount';
        VATIdentifierCaptionLbl: Label 'VAT Identifier';
        TotalCaptionLbl: Label 'Total';
        ShiptoAddressCaptionLbl: Label 'Ship-to Address';
        recCountry: Record 9;
}

