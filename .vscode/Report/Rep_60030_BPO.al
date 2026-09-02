report 60030 "Blanket PurchaseOrderGB"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Blanket Purchase Order GB.rdl';
    Caption = 'Order';

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = SORTING("Document Type", "No.")
                                WHERE("Document Type" = CONST("Blanket Order"));
            RequestFilterFields = "No.", "Buy-from Vendor No.", "No. Printed";
            RequestFilterHeading = 'Purchase Order';
            column(DocumentType_PurchHeader; "Document Type")
            {
            }
            column(No_PurchaseHeader; "No.")
            {
            }
            column(PostingDate_PurchaseHeader; FORMAT("Purchase Header"."Posting Date"))
            {
            }
            column(QuoteNo_PurchaseHeader; "Purchase Header"."Quote No.")
            {
            }
            column(BuyfromVendorNo_PurchaseHeader; "Purchase Header"."Buy-from Vendor No.")
            {
            }
            column(YourReference_PurchaseHeader; "Purchase Header"."Your Reference")
            {
            }
            column(VendorInvoiceNo_PurchaseHeader; "Purchase Header"."Vendor Invoice No.")
            {
            }
            column(BuyfromContact_PurchaseHeader; "Purchase Header"."Buy-from Contact")
            {
            }
            column(Expected_Rcpt_Date; FORMAT("Purchase Header"."Expected Receipt Date"))
            {
            }
            column(Technicalagreement_PurchaseHeader; "Purchase Header"."Technical Agreement No.")
            {
            }
            column(PaymentDesc; PaymentDesc)
            {
            }
            column(VendorTel; VendorTel)
            {
            }
            column(VendorFax; VendorFax)
            {
            }
            column(VendorAddress1; VendorAddress[1])
            {
            }
            column(VendorAddress2; VendorAddress[2])
            {
            }
            column(VendorAddress3; VendorAddress[3])
            {
            }
            column(VendorAddress4; VendorAddress[4])
            {
            }
            column(VendorAddress5; VendorAddress[5])
            {
            }
            column(VendorAddress6; VendorAddress[6])
            {
            }
            column(VendorAddress7; VendorAddress[7])
            {
            }
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(OrderCaption; STRSUBSTNO(Text004, CopyText))
                    {
                    }
                    column(CompanyAddr1; CompanyAddr[1])
                    {
                    }
                    column(CompanyAddr2; CompanyAddr[2])
                    {
                    }
                    column(CompanyAddr3; CompanyAddr[3])
                    {
                    }
                    column(CompanyAddr4; CompanyAddr[4])
                    {
                    }
                    column(PaymentDisc_PurchHeader; "Purchase Header"."Payment Discount %")
                    {
                    }
                    // column(TypeOfSupplyDescription; TypeOfSupply.Description)
                    // {
                    // }
                    column(TypeOfSupplyDescription; Description)
                    {
                    }
                    column(ShipmentMethodDescription; ShipmentMethod.Description)
                    {
                    }
                    column(PaymentTermsDescription; PaymentTerms.Description)
                    {
                    }
                    column(CompanyInfoHomePage; CompanyInfo."Home Page")
                    {
                    }
                    column(CompanyInfoEmail; CompanyInfo."E-Mail")
                    {
                    }
                    column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
                    {
                    }
                    column(CompanyInfoFaxNo; CompanyInfo."Fax No.")
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
                    column(CompanyInfoPicture; CompanyInfo.Picture)
                    {
                    }
                    column(CompanyName; CompanyInfo.Name)
                    {
                    }
                    column(DocumentDate_PurchHeader; FORMAT("Purchase Header"."Document Date"))
                    {
                    }
                    column(VATNoText; VATNoText)
                    {
                    }
                    column(VATRegNo_PurchHeader; "Purchase Header"."VAT Registration No.")
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
                    column(YourReference_PurchHeader; "Purchase Header"."Your Reference")
                    {
                    }
                    column(CompanyAddr5; CompanyAddr[5])
                    {
                    }
                    column(CompanyAddr6; CompanyAddr[6])
                    {
                    }
                    column(BuyfromVendNo_PurchHeader; "Purchase Header"."Buy-from Vendor No.")
                    {
                    }
                    column(BuyFromAddr1; BuyFromAddr[1])
                    {
                    }
                    column(BuyFromAddr2; BuyFromAddr[2])
                    {
                    }
                    column(BuyFromAddr3; BuyFromAddr[3])
                    {
                    }
                    column(BuyFromAddr4; BuyFromAddr[4])
                    {
                    }
                    column(BuyFromAddr5; BuyFromAddr[5])
                    {
                    }
                    column(BuyFromAddr6; BuyFromAddr[6])
                    {
                    }
                    column(BuyFromAddr7; BuyFromAddr[7])
                    {
                    }
                    column(BuyFromAddr8; BuyFromAddr[8])
                    {
                    }
                    column(PricesInclVAT_PurchHeader; "Purchase Header"."Prices Including VAT")
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
                    column(PricesInclVAT1_PurchHeader; FORMAT("Purchase Header"."Prices Including VAT"))
                    {
                    }
                    column(DocumentDateCaption; DocumentDateCaptionLbl)
                    {
                    }
                    column(EmailCaption; EmailCaptionLbl)
                    {
                    }
                    column(HomePageCaptn; HomePageCaptnLbl)
                    {
                    }
                    column(PhoneNoCaption; PhoneNoCaptionLbl)
                    {
                    }
                    column(FaxNoCaption; FaxNoCaptionLbl)
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
                    column(OrderNoCaption; OrderNoCaptionLbl)
                    {
                    }
                    column(BankBranchNoCaption; BankBranchNoCaptionLbl)
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
                    column(PaymentDiscountPercentCaption; PaymentDiscountPercentCaptionLbl)
                    {
                    }
                    column(BuyfromVendNo_PurchHeaderCaption; "Purchase Header".FIELDCAPTION("Buy-from Vendor No."))
                    {
                    }
                    column(PricesInclVAT_PurchHeaderCaption; "Purchase Header".FIELDCAPTION("Prices Including VAT"))
                    {
                    }
                    dataitem(DimensionLoop1; Integer)
                    {
                        DataItemLinkReference = "Purchase Header";
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
                    dataitem(DataItem1000000000; "Purch. Comment Line")
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"),
                                       "No." = FIELD("No.");
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.")
                                            WHERE("Document Line No." = FILTER(0));
                    }
                    dataitem("Purchase Line"; "Purchase Line")
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"),
                                       "Document No." = FIELD("No.");
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");

                        trigger OnPreDataItem()
                        begin
                            CurrReport.BREAK;
                        end;
                    }
                    dataitem(RoundLoop; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(PurchLineLineAmount; PurchLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Line"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Description_PurchLine; "Purchase Line".Description)
                        {
                        }
                        column(PurchLineType; PurchLine.Type)
                        {
                        }
                        column(No_PurchLine; "Purchase Line"."No.")
                        {
                        }
                        column(No2_PurchLineCaption; "Purchase Line".FIELDCAPTION("No."))
                        {
                        }
                        // column(ForeignName_PurchLine; "Purchase Line"."Foreign Name")
                        // {
                        // }
                        // column(ECMANo_PurchLine; "Purchase Line"."ECMA No.")
                        // {
                        // }
                        // column(ForeignPackSize; "Purchase Line"."Foreign Pack Size")
                        // {
                        // }
                        column(ForeignName_PurchLine; ForeignName)
                        {
                        }
                        column(ECMANo_PurchLine; ECMANo)
                        {
                        }
                        column(ForeignPackSize; ForeignPackSize)
                        {
                        }
                        column(PORNo_PurchLine; "Purchase Line"."Blanket Order No.")
                        {
                        }
                        column(Quantity_PurchLine; "Purchase Line".Quantity)
                        {
                        }
                        column(UnitofMeasure_PurchLine; "Purchase Line"."Unit of Measure")
                        {
                        }
                        column(DirectUnitCost_PurchLine; "Purchase Line"."Direct Unit Cost")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(LineDiscount_PurchLine; "Purchase Line"."Line Discount %")
                        {
                        }
                        column(LineAmount_PurchLine; "Purchase Line"."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATIdentifier_PurchLine; "Purchase Line"."VAT Identifier")
                        {
                        }
                        column(VATAmount_PurchLine; VATAmount1)
                        {
                        }
                        column(PurchLineLineNo; PurchLine."Line No.")
                        {
                        }
                        column(InvDiscAmount_PurchLine; "Purchase Line"."Inv. Discount Amount")
                        {
                        }
                        column(TotalInvoiceDiscAmount; TotalInvoiceDiscAmount)
                        {
                        }
                        column(TotalLineAmount; TotalLineAmount)
                        {
                        }
                        column(PurchLineInvDiscountAmt; -PurchLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Line"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalText; TotalText)
                        {
                        }
                        column(PurchLineLineAmtInvDiscAmt; PurchLine."Line Amount" - PurchLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInclVATText; TotalInclVATText)
                        {
                        }
                        column(VATAmountLineVATAmtText; VATAmountLine.VATAmountText)
                        {
                        }
                        column(VATAmount; VATAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PurchLineLineAmtInvAmtVATAmt; PurchLine."Line Amount" - PurchLine."Inv. Discount Amount" + VATAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalExclVATText; TotalExclVATText)
                        {
                        }
                        column(VATDiscountAmount; -VATDiscountAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATBaseDisc_PurchHeader; "Purchase Header"."VAT Base Discount %")
                        {
                        }
                        column(VATBaseAmount; VATBaseAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmountInclVAT; TotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(DirectUnitCostCaption; DirectUnitCostCaptionLbl)
                        {
                        }
                        column(DiscountPercentageCaption; DiscountPercentageCaptionLbl)
                        {
                        }
                        column(AmountCaption; AmountCaptionLbl)
                        {
                        }
                        column(InvDiscountAmtCaption; InvDiscountAmtCaptionLbl)
                        {
                        }
                        column(SubtotalCaption; SubtotalCaptionLbl)
                        {
                        }
                        column(VATDiscountAmtCaption; VATDiscountAmtCaptionLbl)
                        {
                        }
                        column(Description_PurchLineCaption; "Purchase Line".FIELDCAPTION(Description))
                        {
                        }
                        column(Quantity_PurchLineCaption; "Purchase Line".FIELDCAPTION(Quantity))
                        {
                        }
                        column(UnitofMeasure_PurchLineCaption; "Purchase Line".FIELDCAPTION("Unit of Measure"))
                        {
                        }
                        column(VATIdentifier_PurchLineCaption; "Purchase Line".FIELDCAPTION("VAT Identifier"))
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

                                DimSetEntry2.SETRANGE("Dimension Set ID", "Purchase Line"."Dimension Set ID");
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN
                                PurchLine.FIND('-')
                            ELSE
                                PurchLine.NEXT;
                            "Purchase Line" := PurchLine;

                            IF NOT "Purchase Header"."Prices Including VAT" AND
                               (PurchLine."VAT Calculation Type" = PurchLine."VAT Calculation Type"::"Full VAT")
                            THEN
                                PurchLine."Line Amount" := 0;

                            IF (PurchLine.Type = PurchLine.Type::"G/L Account") AND (NOT ShowInternalInfo) THEN
                                "Purchase Line"."No." := '';

                            //GB0004.BEGIN
                            TotalInvoiceDiscAmount += PurchLine."Inv. Discount Amount";
                            TotalLineAmount += PurchLine."Line Amount";
                            //GB0004.END

                            //Code added By Parag++
                            Amountexlvat := 0;
                            VATAmount1 := 0;

                            IF "Purchase Header"."Prices Including VAT" = TRUE THEN BEGIN
                                Amountexlvat := "Purchase Line"."Direct Unit Cost" * (100 / (100 + "Purchase Line"."VAT %"));
                                VATAmount1 := "Purchase Line"."Direct Unit Cost" - Amountexlvat;
                            END ELSE BEGIN
                                IF "Purchase Line"."VAT %" <> 0 THEN BEGIN
                                    Amountexlvat := "Purchase Line"."Direct Unit Cost";
                                    VATAmount1 := "Purchase Line"."Amount Including VAT" - "Purchase Line".Amount;
                                END
                                ELSE BEGIN
                                    Amountexlvat := "Purchase Line"."Direct Unit Cost";
                                    VATAmount1 := 0;
                                END;
                            END;
                            //Code added By Parag--
                        end;

                        trigger OnPostDataItem()
                        begin
                            PurchLine.DELETEALL;
                        end;

                        trigger OnPreDataItem()
                        begin
                            MoreLines := PurchLine.FIND('+');
                            WHILE MoreLines AND (PurchLine.Description = '') AND (PurchLine."Description 2" = '') AND
                                  (PurchLine."No." = '') AND (PurchLine.Quantity = 0) AND
                                  (PurchLine.Amount = 0)
                            DO
                                MoreLines := PurchLine.NEXT(-1) <> 0;
                            IF NOT MoreLines THEN
                                CurrReport.BREAK;
                            PurchLine.SETRANGE("Line No.", 0, PurchLine."Line No.");
                            SETRANGE(Number, 1, PurchLine.COUNT);
                            // Deprecated since 1.0 - superseded by manual running totals below (TotalLineAmount/TotalInvoiceDiscAmount)
                            //CurrReport.CREATETOTALS(PurchLine."Line Amount", PurchLine."Inv. Discount Amount");
                            //GB0004.BEGIN
                            TotalInvoiceDiscAmount := 0;
                            TotalLineAmount := 0;
                            //GB0004.END
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
                                AutoFormatExpression = "Purchase Header"."Currency Code";
                                AutoFormatType = 1;
                            }
                            column(VATAmountLineVATAmount; VATAmountLine."VAT Amount")
                            {
                                AutoFormatExpression = "Purchase Header"."Currency Code";
                                AutoFormatType = 1;
                            }
                            column(VATAmountLineLineAmount; VATAmountLine."Line Amount")
                            {
                                AutoFormatExpression = "Purchase Header"."Currency Code";
                                AutoFormatType = 1;
                            }
                            column(VATAmtLineInvDiscBaseAmt; VATAmountLine."Inv. Disc. Base Amount")
                            {
                                AutoFormatExpression = "Purchase Header"."Currency Code";
                                AutoFormatType = 1;
                            }
                            column(VATAmtLineInvoiceDiscAmt; VATAmountLine."Invoice Discount Amount")
                            {
                                AutoFormatExpression = "Purchase Header"."Currency Code";
                                AutoFormatType = 1;
                            }
                            column(VATAmountLineVAT; VATAmountLine."VAT %")
                            {
                                DecimalPlaces = 0 : 5;
                            }
                            column(VATAmtLineVATIdentifier; VATAmountLine."VAT Identifier")
                            {
                            }
                            column(VATAmountText; VATAmountLine.VATAmountText)
                            {
                            }
                            column(VATPercentageCaption; VATPercentageCaptionLbl)
                            {
                            }
                            column(VATBaseCaption; VATBaseCaptionLbl)
                            {
                            }
                            column(VATAmountCaption; VATAmountCaptionLbl)
                            {
                            }
                            column(VATAmtSpecificationCaption; VATAmtSpecificationCaptionLbl)
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
                            column(InvoiceDiscountAmtCaption1; InvoiceDiscountAmtCaption1Lbl)
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
                                // Deprecated since 1.0 - VATAmountLine totals already provided via GetTotalVATAmount/GetTotalVATBase/etc.
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
                    dataitem(Total2; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
                        column(PaytoVendorNo_PurchHeader; "Purchase Header"."Pay-to Vendor No.")
                        {
                        }
                        column(VendAddr8; VendAddr[8])
                        {
                        }
                        column(VendAddr7; VendAddr[7])
                        {
                        }
                        column(VendAddr6; VendAddr[6])
                        {
                        }
                        column(VendAddr5; VendAddr[5])
                        {
                        }
                        column(VendAddr4; VendAddr[4])
                        {
                        }
                        column(VendAddr3; VendAddr[3])
                        {
                        }
                        column(VendAddr2; VendAddr[2])
                        {
                        }
                        column(VendAddr1; VendAddr[1])
                        {
                        }
                        column(PaymentDetailsCaption; PaymentDetailsCaptionLbl)
                        {
                        }
                        column(VendNoCaption; VendNoCaptionLbl)
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            IF "Purchase Header"."Buy-from Vendor No." = "Purchase Header"."Pay-to Vendor No." THEN
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
                            column(SelltoCustNo_PurchHeader; "Purchase Header"."Sell-to Customer No.")
                            {
                            }
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
                            column(SelltoCustNo_PurchHeaderCaption; "Purchase Header".FIELDCAPTION("Sell-to Customer No."))
                            {
                            }
                        }

                        trigger OnPreDataItem()
                        begin
                            IF ("Purchase Header"."Sell-to Customer No." = '') AND (ShipToAddr[1] = '') THEN
                                CurrReport.BREAK;
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    CLEAR(PurchLine);
                    CLEAR(PurchPost);
                    PurchLine.DELETEALL;
                    VATAmountLine.DELETEALL;
                    PurchPost.GetPurchLines("Purchase Header", PurchLine, 0);
                    PurchLine.CalcVATAmountLines(0, "Purchase Header", PurchLine, VATAmountLine);
                    PurchLine.UpdateVATOnLines(0, "Purchase Header", PurchLine, VATAmountLine);
                    VATAmount := VATAmountLine.GetTotalVATAmount;
                    VATBaseAmount := VATAmountLine.GetTotalVATBase;
                    VATDiscountAmount :=
                      VATAmountLine.GetTotalVATDiscount("Purchase Header"."Currency Code", "Purchase Header"."Prices Including VAT");
                    TotalAmountInclVAT := VATAmountLine.GetTotalAmountInclVAT;

                    IF Number > 1 THEN BEGIN
                        CopyText := Text003;
                        // GB0004.begin
                        OutputNo += 1;
                        // GB0004.end
                    END;

                    // Deprecated since 1.0 - dead code; RDLC layout resets per-copy page numbers itself via Globals!PageNumber/GetGroupPageNumber
                    //CurrReport.PAGENO := 1;
                end;

                trigger OnPostDataItem()
                begin
                    IF NOT CurrReport.PREVIEW THEN
                        PurchCountPrinted.RUN("Purchase Header");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := ABS(NoOfCopies) + 1;
                    CopyText := 'Confirmed Purchase Order (PDN)';
                    SETRANGE(Number, 1, NoOfLoops);
                    // GB0004.begin
                    OutputNo := 1;
                    // GB0004.end
                end;
            }

            trigger OnAfterGetRecord()
            var
                a: Report "Blanket Purchase Order";
            begin
                CurrReport.Language := LanguageMgt.GetLanguageIdOrDefault("Language Code");

                CompanyInfo.GET;

                IF RespCenter.GET("Responsibility Center") THEN BEGIN
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                END ELSE
                    FormatAddr.Company(CompanyAddr, CompanyInfo);

                //Upgraded code from NAV 5.0//
                CompanyInfo.CALCFIELDS(CompanyInfo.Picture);

                DimSetEntry1.SETRANGE("Dimension Set ID", "Purchase Header"."Dimension Set ID");

                IF "Purchaser Code" = '' THEN BEGIN
                    SalesPurchPerson.INIT;
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
                    //Upgraded code from NAV 5.0//
                    //  TotalInclVATText := STRSUBSTNO(Text002,GLSetup."LCY Code");
                    TotalInclVATText := STRSUBSTNO(Text002, 'GBP');
                    //Upgraded code from NAV 5.0//
                    TotalExclVATText := STRSUBSTNO(Text006, GLSetup."LCY Code");
                END ELSE BEGIN
                    TotalText := STRSUBSTNO(Text001, "Currency Code");
                    TotalInclVATText := STRSUBSTNO(Text002, "Currency Code");
                    TotalExclVATText := STRSUBSTNO(Text006, "Currency Code");
                END;

                FormatAddr.PurchHeaderBuyFrom(BuyFromAddr, "Purchase Header");
                IF "Purchase Header"."Buy-from Vendor No." <> "Purchase Header"."Pay-to Vendor No." THEN
                    FormatAddr.PurchHeaderPayTo(VendAddr, "Purchase Header");

                IF "Payment Terms Code" = '' THEN
                    PaymentTerms.INIT
                ELSE
                    PaymentTerms.GET("Payment Terms Code");   //end
                PaymentDesc := PaymentTerms.Description;


                IF "Payment Terms Code" = '' THEN
                    PaymentTerms.INIT
                ELSE
                    PaymentTerms.GET("Payment Terms Code");
                IF "Shipment Method Code" = '' THEN
                    ShipmentMethod.INIT
                ELSE
                    ShipmentMethod.GET("Shipment Method Code");
                //sam
                // IF "Type of Supply Code" = '' THEN
                //     TypeOfSupply.INIT
                // ELSE
                //     TypeOfSupply.GET("Type of Supply Code");

                //FormatAddr.PurchHeaderShipTo(ShipToAddr,"Purchase Header");

                IF recCountry.GET("Purchase Header"."Ship-to Country/Region Code") THEN;

                CLEAR(ShipToAddr);
                ShipToAddr[1] := "Purchase Header"."Ship-to Name";
                ShipToAddr[2] := "Purchase Header"."Ship-to Name 2";
                ShipToAddr[3] := "Purchase Header"."Ship-to Address";
                ShipToAddr[4] := "Purchase Header"."Ship-to Address 2";
                ShipToAddr[5] := "Purchase Header"."Ship-to City" + '  ' + FORMAT("Purchase Header"."Ship-to Post Code");
                ShipToAddr[6] := FORMAT("Purchase Header"."Ship-to County");
                ShipToAddr[7] := recCountry.Name;
                COMPRESSARRAY(ShipToAddr);

                //Prathamesh
                CountryRegion.RESET;
                CLEAR(VendorAddress);
                VendorAddress[1] := "Purchase Header"."Buy-from Vendor Name";
                VendorAddress[2] := "Purchase Header"."Buy-from Vendor Name 2";
                VendorAddress[3] := "Purchase Header"."Buy-from Address";
                VendorAddress[4] := "Purchase Header"."Buy-from Address 2";
                VendorAddress[5] := "Purchase Header"."Buy-from City" + ' ' + "Purchase Header"."Buy-from Post Code";
                VendorAddress[6] := "Purchase Header"."Buy-from County";
                CountryRegion.SETRANGE(Code, "Purchase Header"."Buy-from Country/Region Code");
                IF CountryRegion.FINDFIRST THEN
                    VendorAddress[7] := CountryRegion.Name;
                COMPRESSARRAY(VendorAddress);
                //Prathamesh
                IF NOT CurrReport.PREVIEW THEN BEGIN
                    IF ArchiveDocument THEN
                        ArchiveManagement.StorePurchDocument("Purchase Header", LogInteraction);

                    IF LogInteraction THEN BEGIN
                        CALCFIELDS("No. of Archived Versions");
                        SegManagement.LogDocument(
                          13, "No.", "Doc. No. Occurrence", "No. of Archived Versions", DATABASE::Vendor, "Buy-from Vendor No.",
                          "Purchaser Code", '', "Posting Description", '');
                    END;
                END;

                //Upgraded code from NAV 5.0//
                RecVendor.SETRANGE(RecVendor."No.", "Buy-from Vendor No.");
                IF RecVendor.FINDFIRST THEN BEGIN
                    VendorTel := RecVendor."Phone No.";
                    VendorFax := RecVendor."Fax No.";
                END
                //Upgraded code from NAV 5.0//
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
                    field(ArchiveDocument; ArchiveDocument)
                    {
                        Caption = 'Archive Document';
                        Enabled = ArchiveDocumentEnable;
                        Visible = false;

                        trigger OnValidate()
                        begin
                            IF NOT ArchiveDocument THEN
                                LogInteraction := FALSE;
                        end;
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                        Visible = false;

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
            LogInteraction := FALSE;//SegManagement.FindInteractTmplCode(13) <> '';

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
    end;

    var
        Text000: Label 'Purchaser';
        Text001: Label 'Sub Total %1';
        Text002: Label 'Total %1 Incl. VAT';
        Text003: Label 'COPY';
        Text004: Label '%1';
        Text005: Label 'Page %1';
        Text006: Label 'Total %1 Excl. VAT';
        GLSetup: Record 98;
        CompanyInfo: Record 79;
        ShipmentMethod: Record 10;
        PaymentTerms: Record 3;
        SalesPurchPerson: Record 13;
        VATAmountLine: Record 290 temporary;
        PurchLine: Record 39 temporary;
        DimSetEntry1: Record 480;
        DimSetEntry2: Record 480;
        RespCenter: Record 5714;
        LanguageMgt: Codeunit Language;
        //TypeOfSupply: Record "Type Of Supply";
        PurchCountPrinted: Codeunit 317;
        FormatAddr: Codeunit 365;
        PurchPost: Codeunit "Purch.-Post";
        ArchiveManagement: Codeunit 5063;
        SegManagement: Codeunit 5051;
        VendAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        BuyFromAddr: array[8] of Text[50];
        PurchaserText: Text[30];
        VATNoText: Text[30];
        ReferenceText: Text[30];
        TotalText: Text[50];
        TotalInclVATText: Text[50];
        TotalExclVATText: Text[50];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        OutputNo: Integer;
        CopyText: Text[30];
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
        TotalInvoiceDiscAmount: Decimal;
        TotalLineAmount: Decimal;
        [InDataSet]
        ArchiveDocumentEnable: Boolean;
        [InDataSet]
        LogInteractionEnable: Boolean;
        DocumentDateCaptionLbl: Label 'Document Date';
        EmailCaptionLbl: Label 'E-Mail';
        HomePageCaptnLbl: Label 'Home Page';
        PhoneNoCaptionLbl: Label 'Phone No.';
        FaxNoCaptionLbl: Label 'Fax No.';
        VATRegNoCaptionLbl: Label 'VAT Reg. No.';
        BankNameCaptionLbl: Label 'Bank';
        BankAccNoCaptionLbl: Label 'Account No.';
        OrderNoCaptionLbl: Label 'Order No.';
        BankBranchNoCaptionLbl: Label 'Bank Branch No.';
        PaymentTermsCaptionLbl: Label 'Payment Terms';
        ShipmentMethodCaptionLbl: Label 'Shipment Method';
        TypeOfSupplyCaptionLbl: Label 'Type of Supply';
        PaymentDiscountPercentCaptionLbl: Label 'Payment Discount %';
        HeaderDimensionsCaptionLbl: Label 'Header Dimensions';
        DirectUnitCostCaptionLbl: Label 'Direct Unit Cost';
        DiscountPercentageCaptionLbl: Label 'Discount %';
        AmountCaptionLbl: Label 'Amount';
        InvDiscountAmtCaptionLbl: Label 'Invoice Discount Amount';
        SubtotalCaptionLbl: Label 'Subtotal';
        VATDiscountAmtCaptionLbl: Label 'Payment Discount on VAT';
        LineDimensionsCaptionLbl: Label 'Line Dimensions';
        VATPercentageCaptionLbl: Label 'VAT %';
        VATBaseCaptionLbl: Label 'VAT Base';
        VATAmountCaptionLbl: Label 'VAT Amount';
        VATAmtSpecificationCaptionLbl: Label 'VAT Amount Specification';
        VATIdentifierCaptionLbl: Label 'VAT Identifier';
        InvDiscBaseAmtCaptionLbl: Label 'Invoice Discount Base Amount';
        LineAmountCaptionLbl: Label 'Line Amount';
        InvoiceDiscountAmtCaption1Lbl: Label 'Invoice Discount Amount';
        TotalCaptionLbl: Label 'Total';
        PaymentDetailsCaptionLbl: Label 'Payment Details';
        VendNoCaptionLbl: Label 'Vendor No.';
        ShiptoAddressCaptionLbl: Label 'Ship-to Address';
        RecVendor: Record 23;
        VendorTel: Text[30];
        VendorFax: Text[30];
        recCountry: Record 9;
        PaymentDesc: Text[250];
        Amountexlvat: Decimal;
        VATAmount1: Decimal;
        VendorAddress: array[7] of Text[250];
        CountryRegion: Record 9;
        ForeignName: Text[20];
        ForeignPackSize: Integer;
        ECMANo: Code[20];
        Description: Text[50];


}

