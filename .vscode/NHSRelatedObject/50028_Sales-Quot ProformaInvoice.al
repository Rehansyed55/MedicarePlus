report 60044 "Sales - Quot  Proforma Invoice"
{
    // version vaibhav

    // <changelog>
    //   <change id="GB0001" dev="TMARTI" date="2005-05-25" area="UKGEN" feature="10048"
    //     baseversion="UK4.00" releaseversion="GB4.00.A">General UK functionality</change>
    //   <remove id="GB0002" dev="TMARTI" date="2007-06-14" area="UKGEN"  request="UK-START-51"
    //     baseversion="GB4.00" releaseversion="GB6.00">C/Track cleanup</remove>
    //   <add id="GB0003" dev="TMARTI" date="2007-06-14" area="DOCLAY"  request="UK-START-51"
    //     releaseversion="GB6.00">Document layout</add>
    //   <change id="GB0004" dev="AUGMENTUM" date="2007-08-31" area="DOCLAY" feature="PSCORS1177"
    //     baseversion="GB6.00" releaseversion="GB6.00">Report Transformation - local Report Layout Format date to
    //     consistent NNC with Classic client.</change>
    //   <add id="GB0049" dev="TMARTI" date="2004-07-25" area="UKGEN"  request="UK-START-40"
    //     releaseversion="GB4.00">Object moved into UK object range</add>
    // </changelog>
    // 
    // JIRA No : CHEM-420
    // Author : Vaibhav
    // Description : PRovide sales order no as invoice no for eg . iF Sales order no is SOR012345 then invoice no is 012345
    DefaultLayout = RDLC;
    RDLCLayout = './Sales - Quot  Proforma Invoice.rdlc';

    Caption = 'Proforma Invoice';

    dataset
    {
        dataitem("Sales Header";"Sales Header")
        {
            DataItemTableView = SORTING("Document Type","No.")
                                WHERE("Document Type"=CONST(Order));
            RequestFilterFields = "No.","Sell-to Customer No.","No. Printed";
            RequestFilterHeading = 'Sales Order';
            column(DocumentType_SalesHeader;"Document Type")
            {
            }
            column(No_SalesHeader;"No.")
            {
            }
            column(InvDiscAmtCaption;InvDiscAmtCaptionLbl)
            {
            }
            column(ExtDocNo_salesHeader;"Sales Header"."External Document No.")
            {
            }
            column(ShipToAddr8;ShipToAddr[8])
            {
            }
            column(ShipToAddr7;ShipToAddr[7])
            {
            }
            column(ShipToAddr6;ShipToAddr[6])
            {
            }
            column(ShipToAddr5;ShipToAddr[5])
            {
            }
            column(ShipToAddr4;ShipToAddr[4])
            {
            }
            column(ShipToAddr3;ShipToAddr[3])
            {
            }
            column(ShipToAddr2;ShipToAddr[2])
            {
            }
            column(ShipToAddr1;ShipToAddr[1])
            {
            }
            column(ShipToName;"Sales Header"."Ship-to Name")
            {
            }
            column(INVNo;INVNo)
            {
            }
            dataitem(CopyLoop;2000000026)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop;2000000026)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number=CONST(1));
                    column(OrderConfirmationCaption;STRSUBSTNO(Text004,CopyText))
                    {
                    }
                    column(CustAddr1;CustAddr[1])
                    {
                    }
                    column(CompanyAddr1;CompanyAddr[1])
                    {
                    }
                    column(CustAddr2;CustAddr[2])
                    {
                    }
                    column(CompanyAddr2;CompanyAddr[2])
                    {
                    }
                    column(CustAddr3;CustAddr[3])
                    {
                    }
                    column(CompanyAddr3;CompanyAddr[3])
                    {
                    }
                    column(CustAddr4;CustAddr[4])
                    {
                    }
                    column(CompanyAddr4;CompanyAddr[4])
                    {
                    }
                    column(CustAddr5;CustAddr[5])
                    {
                    }
                    column(CompanyInfoHomePage;CompanyInfo."Home Page")
                    {
                    }
                    column(CompanyInfoEmail;CompanyInfo."E-Mail")
                    {
                    }
                    column(CompanyInfoPhoneNo;CompanyInfo."Phone No.")
                    {
                    }
                    column(CompanyInfoFaxNo;CompanyInfo."Fax No.")
                    {
                    }
                    column(CompanyInfoPicture;CompanyInfo.Picture)
                    {
                    }
                    column(CustAddr6;CustAddr[6])
                    {
                    }
                    column(CompanyInfoVATRegNo;CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(CompanyInfoBankName;CompanyInfo."Bank Name")
                    {
                    }
                    column(CompanyInfoBankAccount;CompanyInfo."Bank Account No.")
                    {
                    }
                    column(BilltoCustNo_SalesHeader;"Sales Header"."Bill-to Customer No.")
                    {
                    }
                    column(BilltoCustNo_SalesHeaderCaption;"Sales Header".FIELDCAPTION("Bill-to Customer No."))
                    {
                    }
                    column(DocumentDate_SalesHeader;FORMAT("Sales Header"."Document Date",0,4))
                    {
                    }
                    column(VATNoText;VATNoText)
                    {
                    }
                    column(VATRegNo_SalesHeader;"Sales Header"."VAT Registration No.")
                    {
                    }
                    column(ShipmentDate_SalesHeader;FORMAT("Sales Header"."Shipment Date"))
                    {
                    }
                    column(SalesPersonText;SalesPersonText)
                    {
                    }
                    column(Name_SalesPurchPerson;SalesPurchPerson.Name)
                    {
                    }
                    column(ReferenceText;ReferenceText)
                    {
                    }
                    column(YourRef_SalesHeader;"Sales Header"."Your Reference")
                    {
                    }
                    column(CustAddr7;CustAddr[7])
                    {
                    }
                    column(CustAddr8;CustAddr[8])
                    {
                    }
                    column(CompanyAddr5;CompanyAddr[5])
                    {
                    }
                    column(CompanyAddr6;CompanyAddr[6])
                    {
                    }
                    column(PricesIncVAT_SalesHeader;"Sales Header"."Prices Including VAT")
                    {
                    }
                    column(PricesIncVAT_SalesHeaderCaption;"Sales Header".FIELDCAPTION("Prices Including VAT"))
                    {
                    }
                    column(CompanyInfoBankBranchNo;CompanyInfo."Bank Branch No.")
                    {
                    }
                    column(CompanyInfo3Picture;CompanyInfo3.Picture)
                    {
                    }
                    column(CompanyInfo2Picture;CompanyInfo2.Picture)
                    {
                    }
                    column(CompanyInfo1Picture;CompanyInfo1.Picture)
                    {
                    }
                    column(Number_CopyLoop;CopyLoop.Number)
                    {
                    }
                    column(PageCaption;STRSUBSTNO(Text005,''))
                    {
                    }
                    column(PaymentDiscountText;PaymentDiscountText)
                    {
                    }
                    column(Desc_ShipmentMethod;ShipmentMethod.Description)
                    {
                    }
                    column(Description_TypeOfSupply;TypeOfSupplyDescription)
                    {
                    }
                    column(Description_PaymentTerms;PaymentTerms.Description)
                    {
                    }
                    column(FormatPricesIncVAT_SalesHeader;FORMAT("Sales Header"."Prices Including VAT"))
                    {
                    }
                    column(DocDateCaption;DocDateCaptionLbl)
                    {
                    }
                    column(EmailCaption;EmailCaptionLbl)
                    {
                    }
                    column(HomePageCaption;HomePageCaptionLbl)
                    {
                    }
                    column(PhoneNoCaption;PhoneNoCaptionLbl)
                    {
                    }
                    column(VATRegNoCaption;VATRegNoCaptionLbl)
                    {
                    }
                    column(BankNameCaption;BankNameCaptionLbl)
                    {
                    }
                    column(BankAccNoCaption;BankAccNoCaptionLbl)
                    {
                    }
                    column(ShpDateCaption;ShpDateCaptionLbl)
                    {
                    }
                    column(OrderNoCaption;OrderNoCaptionLbl)
                    {
                    }
                    column(BankBranchNoCaption;BankBranchNoCaptionLbl)
                    {
                    }
                    column(PaymentTermsCaption;PaymentTermsCaptionLbl)
                    {
                    }
                    column(ShpMethodCaption;ShpMethodCaptionLbl)
                    {
                    }
                    column(TypeOfSupplyCaption;TypeOfSupplyCaptionLbl)
                    {
                    }
                    column(PaymentDiscountCaption;PaymentDiscountCaptionLbl)
                    {
                    }
                    dataitem(DimensionLoop1;2000000026)
                    {
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number=FILTER(1..));
                        column(DimText;DimText)
                        {
                        }
                        column(Number_IntegerLine;Number)
                        {
                        }
                        column(HdrDimsCaption;HdrDimsCaptionLbl)
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
                                    '%1 %2',DimSetEntry1."Dimension Code",DimSetEntry1."Dimension Value Code")
                              ELSE
                                DimText :=
                                  STRSUBSTNO(
                                    '%1, %2 %3',DimText,
                                    DimSetEntry1."Dimension Code",DimSetEntry1."Dimension Value Code");
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
                    dataitem("Sales Line";"Sales Line")
                    {
                        DataItemLink = "Document Type"=FIELD("Document Type"),
                                       "Document No."=FIELD("No.");
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING("Document Type","Document No.","Line No.");

                        trigger OnPreDataItem()
                        begin
                            CurrReport.BREAK;
                        end;
                    }
                    dataitem(RoundLoop;2000000026)
                    {
                        DataItemTableView = SORTING(Number);
                        column(LineNo_SalesLine;"Sales Line"."Line No.")
                        {
                        }
                        column(Type_SalesLine;SalesLine.Type)
                        {
                        }
                        column(FormatLineAmount_SalesLine;SalesLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Description_SalesLine;"Sales Line".Description)
                        {
                        }
                        column(No_SalesLine;"Sales Line"."No.")
                        {
                        }
                        column(Quantity_SalesLine;"Sales Line".Quantity)
                        {
                        }
                        column(UnitofMeasure_SalesLine;"Sales Line"."Unit of Measure")
                        {
                        }
                        column(No_SalesLineCaption;"Sales Line".FIELDCAPTION("No."))
                        {
                        }
                        column(Description_SalesLineCaption;"Sales Line".FIELDCAPTION(Description))
                        {
                        }
                        column(Quantity_SalesLineCaption;"Sales Line".FIELDCAPTION(Quantity))
                        {
                        }
                        column(UnitofMeasure_SalesLineCaption;"Sales Line".FIELDCAPTION("Unit of Measure"))
                        {
                        }
                        column(UnitPrice_SalesLine;"Sales Line"."Unit Price")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(LineDiscount_SalesLine;"Sales Line"."Line Discount %")
                        {
                        }
                        column(LineAmount_SalesLine;"Sales Line"."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATIdentifier_SalesLine;"Sales Line"."VAT Identifier")
                        {
                        }
                        column(VATIdentifier_SalesLineCaption;"Sales Line".FIELDCAPTION("VAT Identifier"))
                        {
                        }
                        column(CurrencyCode;"Sales Line"."Currency Code")
                        {
                        }
                        column(VATBaseDisc_SalesHeader;"Sales Header"."VAT Base Discount %")
                        {
                        }
                        column(TotalInvoiceDiscAmount;TotalInvoiceDiscAmount)
                        {
                        }
                        column(TotalLineAmount;TotalLineAmount)
                        {
                        }
                        column(InvDiscountAmt_SalesLine;-SalesLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalText;TotalText)
                        {
                        }
                        column(SalesLineLineAmtInvDiscAmt;SalesLine."Line Amount" - SalesLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalExclVATText;TotalExclVATText)
                        {
                        }
                        column(VATAmtLineVATAmountText;VATAmountLine.VATAmountText)
                        {
                        }
                        column(TotalInclVATText;TotalInclVATText)
                        {
                        }
                        column(VATAmount;VATAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SalesLineInvDiscAmtVATAmt;SalesLine."Line Amount" - SalesLine."Inv. Discount Amount" + VATAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATDiscountAmount;-VATDiscountAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATBaseAmount;VATBaseAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmountInclVAT;TotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(UnitPriceCaption;UnitPriceCaptionLbl)
                        {
                        }
                        column(DiscountPercentCaption;DiscountPercentCaptionLbl)
                        {
                        }
                        column(AmtCaption;AmtCaptionLbl)
                        {
                        }
                        column(SubtotalCaption;SubtotalCaptionLbl)
                        {
                        }
                        column(PaymentDiscountVATCaption;PaymentDiscountVATCaptionLbl)
                        {
                        }
                        dataitem(DimensionLoop2;2000000026)
                        {
                            DataItemTableView = SORTING(Number)
                                                WHERE(Number=FILTER(1..));
                            column(DimText_DimensionLoop2;DimText)
                            {
                            }
                            column(LineDimsCaption;LineDimsCaptionLbl)
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
                                        '%1 %2',DimSetEntry2."Dimension Code",DimSetEntry2."Dimension Value Code")
                                  ELSE
                                    DimText :=
                                      STRSUBSTNO(
                                        '%1, %2 %3',DimText,
                                        DimSetEntry2."Dimension Code",DimSetEntry2."Dimension Value Code");
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

                                DimSetEntry2.SETRANGE("Dimension Set ID","Sales Line"."Dimension Set ID");
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN
                              SalesLine.FIND('-')
                            ELSE
                              SalesLine.NEXT;
                            "Sales Line" := SalesLine;

                            IF NOT "Sales Header"."Prices Including VAT" AND
                               (SalesLine."VAT Calculation Type" = SalesLine."VAT Calculation Type"::"Full VAT")
                            THEN
                              SalesLine."Line Amount" := 0;

                            IF (SalesLine.Type = SalesLine.Type::"G/L Account") AND (NOT ShowInternalInfo) THEN
                              "Sales Line"."No." := '';

                            //GB0004.BEGIN
                            TotalInvoiceDiscAmount += SalesLine."Inv. Discount Amount";
                            TotalLineAmount += SalesLine."Line Amount";
                            //GB0004.END
                        end;

                        trigger OnPostDataItem()
                        begin
                            SalesLine.DELETEALL;
                        end;

                        trigger OnPreDataItem()
                        begin
                            MoreLines := SalesLine.FIND('+');
                            WHILE MoreLines AND (SalesLine.Description = '') AND (SalesLine."Description 2" = '') AND
                                  (SalesLine."No." = '') AND (SalesLine.Quantity = 0) AND
                                  (SalesLine.Amount = 0)
                            DO
                              MoreLines := SalesLine.NEXT(-1) <> 0;
                            IF NOT MoreLines THEN
                              CurrReport.BREAK;
                            SalesLine.SETRANGE("Line No.",0,SalesLine."Line No.");
                            SETRANGE(Number,1,SalesLine.COUNT);
                            CurrReport.CREATETOTALS(SalesLine."Line Amount",SalesLine."Inv. Discount Amount");
                            //GB0004.BEGIN
                            TotalInvoiceDiscAmount := 0;
                            TotalLineAmount := 0;
                            //GB0004.END
                        end;
                    }
                    dataitem(DataItem5444;2000000026)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number=CONST(1));
                        dataitem(VATCounter;2000000026)
                        {
                            DataItemTableView = SORTING(Number);
                            column(VATAmountLineVATBase;VATAmountLine."VAT Base")
                            {
                                AutoFormatExpression = "Sales Header"."Currency Code";
                                AutoFormatType = 1;
                            }
                            column(VATAmountLineVATAmount;VATAmountLine."VAT Amount")
                            {
                                AutoFormatExpression = "Sales Header"."Currency Code";
                                AutoFormatType = 1;
                            }
                            column(VATAmountLineLineAmount;VATAmountLine."Line Amount")
                            {
                                AutoFormatExpression = "Sales Header"."Currency Code";
                                AutoFormatType = 1;
                            }
                            column(VATAmtLineInvDiscBaseAmt;VATAmountLine."Inv. Disc. Base Amount")
                            {
                                AutoFormatExpression = "Sales Header"."Currency Code";
                                AutoFormatType = 1;
                            }
                            column(VATAmtLineInvDiscountAmt;VATAmountLine."Invoice Discount Amount")
                            {
                                AutoFormatExpression = "Sales Header"."Currency Code";
                                AutoFormatType = 1;
                            }
                            column(VATAmountLineVAT;VATAmountLine."VAT %")
                            {
                                DecimalPlaces = 0:5;
                            }
                            column(VATAmtLineVATIdentifier;VATAmountLine."VAT Identifier")
                            {
                            }
                            column(VATPercentCaption;VATPercentCaptionLbl)
                            {
                            }
                            column(VATBaseCaption;VATBaseCaptionLbl)
                            {
                            }
                            column(VATAmtCaption;VATAmtCaptionLbl)
                            {
                            }
                            column(VATAmtSpecCaption;VATAmtSpecCaptionLbl)
                            {
                            }
                            column(InvDiscBaseAmtCaption;InvDiscBaseAmtCaptionLbl)
                            {
                            }
                            column(LineAmtCaption;LineAmtCaptionLbl)
                            {
                            }
                            column(VATIdentCaption;VATIdentCaptionLbl)
                            {
                            }
                            column(TotalCaption;TotalCaptionLbl)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                VATAmountLine.GetLine(Number);
                            end;

                            trigger OnPreDataItem()
                            begin
                                SETRANGE(Number,1,VATAmountLine.COUNT);
                                CurrReport.CREATETOTALS(
                                  VATAmountLine."Line Amount",VATAmountLine."Inv. Disc. Base Amount",
                                  VATAmountLine."Invoice Discount Amount",VATAmountLine."VAT Base",VATAmountLine."VAT Amount");
                            end;
                        }

                        trigger OnPreDataItem()
                        begin
                            IF VATAmountLine.COUNT <= 1 THEN
                              CurrReport.BREAK;
                        end;
                    }
                    dataitem(Total;2000000026)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number=CONST(1));
                    }
                    dataitem(Integer2;2000000026)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number=CONST(1));
                        dataitem(Total2;2000000026)
                        {
                            DataItemTableView = SORTING(Number)
                                                WHERE(Number=CONST(1));
                            column(SelltoCustNo_SalesHeader;"Sales Header"."Sell-to Customer No.")
                            {
                            }
                            column(SelltoCustNo_SalesHeaderCaption;"Sales Header".FIELDCAPTION("Sell-to Customer No."))
                            {
                            }
                            column(ShiptoAddressCaption;ShiptoAddressCaptionLbl)
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
                var
                    SalesPost: Codeunit 80;
                begin
                    CLEAR(SalesLine);
                    CLEAR(SalesPost);
                    VATAmountLine.DELETEALL;
                    SalesLine.DELETEALL;
                    SalesPost.GetSalesLines("Sales Header",SalesLine,0);
                    SalesLine.CalcVATAmountLines(0,"Sales Header",SalesLine,VATAmountLine);
                    SalesLine.UpdateVATOnLines(0,"Sales Header",SalesLine,VATAmountLine);
                    VATAmount := VATAmountLine.GetTotalVATAmount;
                    VATBaseAmount := VATAmountLine.GetTotalVATBase;
                    VATDiscountAmount :=
                      VATAmountLine.GetTotalVATDiscount("Sales Header"."Currency Code","Sales Header"."Prices Including VAT");
                    TotalAmountInclVAT := VATAmountLine.GetTotalAmountInclVAT;

                    IF Number > 1 THEN
                      CopyText := Text003;
                    CurrReport.PAGENO := 1;
                end;

                trigger OnPostDataItem()
                begin
                    IF NOT CurrReport.PREVIEW THEN
                      SalesCountPrinted.RUN("Sales Header");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := ABS(NoOfCopies) + 1;
                    CopyText := '';
                    SETRANGE(Number,1,NoOfLoops);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CompanyInfo.GET;
                CompanyInfo.CALCFIELDS(CompanyInfo.Picture);
                
                //JIRA No : CHEM-420
                
                INVNo := COPYSTR("Sales Header"."No.",4,STRLEN("Sales Header"."No."));
                
                //JIRA No : CHEM-420
                
                CurrReport.LANGUAGE := LanguageMgt.GetLanguageId("Language Code");
                
                IF RespCenter.GET("Responsibility Center") THEN BEGIN
                  FormatAddr.RespCenter(CompanyAddr,RespCenter);
                  CompanyInfo."Phone No." := RespCenter."Phone No.";
                  CompanyInfo."Fax No." := RespCenter."Fax No.";
                END ELSE
                  FormatAddr.Company(CompanyAddr,CompanyInfo);
                
                DimSetEntry1.SETRANGE("Dimension Set ID","Sales Header"."Dimension Set ID");
                
                IF "Salesperson Code" = '' THEN BEGIN
                  CLEAR(SalesPurchPerson);
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
                  TotalText := STRSUBSTNO(Text001,GLSetup."LCY Code");
                  TotalInclVATText := STRSUBSTNO(Text002,GLSetup."LCY Code");
                  TotalExclVATText := STRSUBSTNO(Text006,GLSetup."LCY Code");
                END ELSE BEGIN
                  TotalText := STRSUBSTNO(Text001,"Currency Code");
                  TotalInclVATText := STRSUBSTNO(Text002,"Currency Code");
                  TotalExclVATText := STRSUBSTNO(Text006,"Currency Code");
                END;
                FormatAddr.SalesHeaderBillTo(CustAddr,"Sales Header");
                
                IF "Payment Terms Code" = '' THEN
                  PaymentTerms.INIT
                ELSE
                  PaymentTerms.GET("Payment Terms Code");
                IF "Shipment Method Code" = '' THEN
                  ShipmentMethod.INIT
                ELSE
                  ShipmentMethod.GET("Shipment Method Code");
                //Table 10500 "Type of Supply" does not exist in this database; field removed from Sales Header. Left blank to preserve report structure.
                TypeOfSupplyDescription := '';
                
                IF ("VAT Base Discount %" = 0) AND ("Payment Discount %" = 0) THEN
                  PaymentDiscountText := ''
                ELSE
                  PaymentDiscountText :=
                    STRSUBSTNO(
                      Text1041000,
                      "Payment Discount %","VAT Base Discount %");
                
                FormatAddr.SalesHeaderShipTo(ShipToAddr,CustAddr,"Sales Header");
                ShowShippingAddr := "Sell-to Customer No." <> "Bill-to Customer No.";
                FOR i := 1 TO ARRAYLEN(ShipToAddr) DO
                  IF ShipToAddr[i] <> CustAddr[i] THEN
                    ShowShippingAddr := TRUE;
                
                IF NOT CurrReport.PREVIEW THEN BEGIN
                  IF ArchiveDocument THEN
                    ArchiveManagement.StoreSalesDocument("Sales Header",LogInteraction);
                
                  IF LogInteraction THEN BEGIN
                    CALCFIELDS("No. of Archived Versions");
                    IF "Bill-to Contact No." <> '' THEN
                      SegManagement.LogDocument(
                        3,"No.","Doc. No. Occurrence",
                        "No. of Archived Versions",DATABASE::Contact,"Bill-to Contact No."
                        ,"Salesperson Code","Campaign No.","Posting Description","Opportunity No.")
                    ELSE
                      SegManagement.LogDocument(
                        3,"No.","Doc. No. Occurrence",
                        "No. of Archived Versions",DATABASE::Customer,"Bill-to Customer No.",
                        "Salesperson Code","Campaign No.","Posting Description","Opportunity No.");
                  END;
                END;

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
                    field(NoOfCopies;NoOfCopies)
                    {
                        Caption = 'No. of Copies';
                    }
                    field(ShowInternalInfo;ShowInternalInfo)
                    {
                        Caption = 'Show Internal Information';
                    }
                    field(ArchiveDocument;ArchiveDocument)
                    {
                        Caption = 'Archive Document';
                        Enabled = ArchiveDocumentEnable;

                        trigger OnValidate()
                        begin
                            IF NOT ArchiveDocument THEN
                              LogInteraction := FALSE;
                        end;
                    }
                    field(LogInteraction;LogInteraction)
                    {
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;

                        trigger OnValidate()
                        begin
                            IF LogInteraction THEN
                              ArchiveDocument := ArchiveDocumentEnable;
                        end;
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
            ArchiveDocumentEnable := TRUE;
        end;

        trigger OnOpenPage()
        begin
            ArchiveDocument := ArchiveManagement.SalesDocArchiveGranule;
            LogInteraction := SegManagement.FindInteractionTemplateCode("Interaction Log Entry Document Type"::"Sales Ord. Cnfrmn.") <> '';

            ArchiveDocumentEnable := ArchiveDocument;
            LogInteractionEnable := LogInteraction;
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

    var
        Text000: Label 'Salesperson';
        Text001: Label 'Total %1';
        Text002: Label 'Total %1 Incl. VAT';
        Text003: Label 'COPY';
        Text004: Label 'Order Confirmation%1';
        Text005: Label 'Page %1';
        Text006: Label 'Total %1 Excl. VAT';
        GLSetup: Record 98;
        ShipmentMethod: Record 10;
        PaymentTerms: Record 3;
        SalesPurchPerson: Record 13;
        CompanyInfo: Record 79;
        CompanyInfo1: Record 79;
        CompanyInfo3: Record 79;
        CompanyInfo2: Record 79;
        SalesSetup: Record 311;
        VATAmountLine: Record 290 temporary;
        SalesLine: Record 37 temporary;
        DimSetEntry1: Record 480;
        DimSetEntry2: Record 480;
        RespCenter: Record 5714;
        LanguageMgt: Codeunit 43;
        SalesCountPrinted: Codeunit 313;
        FormatAddr: Codeunit 365;
        SegManagement: Codeunit 5051;
        ArchiveManagement: Codeunit 5063;
        CustAddr: array [8] of Text[50];
        ShipToAddr: array [8] of Text[50];
        CompanyAddr: array [8] of Text[50];
        SalesPersonText: Text[30];
        VATNoText: Text[30];
        ReferenceText: Text[30];
        TotalText: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        PaymentDiscountText: Text[80];
        TypeOfSupplyDescription: Text[50];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        ShowShippingAddr: Boolean;
        i: Integer;
        DimText: Text[120];
        OldDimText: Text[75];
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        ArchiveDocument: Boolean;
        LogInteraction: Boolean;
        VATAmount: Decimal;
        VATBaseAmount: Decimal;
        VATDiscountAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        Text1041000: Label '%1 %, VAT discounted at %2 %';
        TotalInvoiceDiscAmount: Decimal;
        TotalLineAmount: Decimal;
        [InDataSet]
        ArchiveDocumentEnable: Boolean;
        [InDataSet]
        LogInteractionEnable: Boolean;
        InvDiscAmtCaptionLbl: Label 'Invoice Discount Amount';
        DocDateCaptionLbl: Label 'Document Date';
        EmailCaptionLbl: Label 'E-Mail';
        HomePageCaptionLbl: Label 'Home Page';
        PhoneNoCaptionLbl: Label 'Phone No.';
        VATRegNoCaptionLbl: Label 'VAT Reg. No.';
        BankNameCaptionLbl: Label 'Bank';
        BankAccNoCaptionLbl: Label 'Account No.';
        ShpDateCaptionLbl: Label 'Shipment Date';
        OrderNoCaptionLbl: Label 'Order No.';
        BankBranchNoCaptionLbl: Label 'Bank Branch No.';
        PaymentTermsCaptionLbl: Label 'Payment Terms';
        ShpMethodCaptionLbl: Label 'Shipment Method';
        TypeOfSupplyCaptionLbl: Label 'Type of Supply';
        PaymentDiscountCaptionLbl: Label 'Payment Discount';
        HdrDimsCaptionLbl: Label 'Header Dimensions';
        UnitPriceCaptionLbl: Label 'Unit Price';
        DiscountPercentCaptionLbl: Label 'Discount %';
        AmtCaptionLbl: Label 'Amount';
        SubtotalCaptionLbl: Label 'Subtotal';
        PaymentDiscountVATCaptionLbl: Label 'Payment Discount on VAT';
        LineDimsCaptionLbl: Label 'Line Dimensions';
        VATPercentCaptionLbl: Label 'VAT %';
        VATBaseCaptionLbl: Label 'VAT Base';
        VATAmtCaptionLbl: Label 'VAT Amount';
        VATAmtSpecCaptionLbl: Label 'VAT Amount Specification';
        InvDiscBaseAmtCaptionLbl: Label 'Invoice Discount Base Amount';
        LineAmtCaptionLbl: Label 'Line Amount';
        VATIdentCaptionLbl: Label 'VAT Identifier';
        TotalCaptionLbl: Label 'Total';
        ShiptoAddressCaptionLbl: Label 'Ship-to Address';
        INVNo: Code[20];
}

