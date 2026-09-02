report 60039 "Packing List new"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Packing List new.rdl';

    dataset
    {
        dataitem("Posted Invt. Pick Header"; "Posted Invt. Pick Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(LastNoused; LastNoused)
            {
            }
            column(WMSMgt_GetDestinationName__Destination_Type___Destination_No___; GetDestinationName("Destination Type", "Destination No."))
            {
            }
            column(Posted_Invt__Pick_Header__Posting_Date_; "Posting Date")
            {
            }
            column(Posted_Invt__Pick_Header__External_Document_No__; "External Document No.")
            {
            }
            column(Posted_Invt__Pick_Line___Units_Sub_Total_; "Posted Invt. Pick Line"."Units Sub Total")
            {
            }
            column(Posted_Invt__Pick_Line___Total_Unit_Box_; "Posted Invt. Pick Line"."Total Unit/Box")
            {
            }
            column(Posted_Invt__Pick_Line___No__of_Box_; "Posted Invt. Pick Line"."No. of Box")
            {
            }
            column(Posted_Invt__Pick_Line___Pallette_number_; "Posted Invt. Pick Line"."Pallet Number")
            {
            }
            column(Posted_Invt__Pick_Line___Gross_Weight_; "Posted Invt. Pick Line"."Gross Weight")
            {
            }
            column(WORKDATE; WORKDATE)
            {
            }
            column(TIME; TIME)
            {
            }
            column(Posted_Invt__Pick_HeaderCaption; Posted_Invt__Pick_HeaderCaptionLbl)
            {
            }
            column(DateCaption; DateCaptionLbl)
            {
            }
            column(Delivery_To_Caption; Delivery_To_CaptionLbl)
            {
            }
            column(Invoice_No__Caption; Invoice_No__CaptionLbl)
            {
            }
            column(Your_PO_No_Caption; Your_PO_No_CaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(Total_Gross_Weight_Caption; Total_Gross_Weight_CaptionLbl)
            {
            }
            column(Checked_By_Caption; Checked_By_CaptionLbl)
            {
            }
            column(Packed_By_Caption; Packed_By_CaptionLbl)
            {
            }
            column(Date_Time_Caption; Date_Time_CaptionLbl)
            {
            }
            column(Posted_Invt__Pick_Header_No_; "No.")
            {
            }
            column(InvoiceDate; InvoiceDate)
            {
            }
            column(InvoiceDueDate; InvoiceDueDate)
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
            column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfoVATRegNo; CompanyInfo."VAT Registration No.")
            {
            }
            column(CompanyInfoBankName; CompanyInfo."Bank Name")
            {
            }
            column(CompanyInfoBankAccNo; CompanyInfo."Bank Account No.")
            {
            }
            column(CompanyAddr5; CompanyAddr[5])
            {
            }
            column(CompanyAddr6; CompanyAddr[6])
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
            column(CompanyInfoPicture; CompanyInfo.Picture)
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
            column(CustAddr1; CustAddr[1])
            {
            }
            column(CustAddr2; CustAddr[2])
            {
            }
            column(CustAddr3; CustAddr[3])
            {
            }
            column(CustAddr4; CustAddr[4])
            {
            }
            column(CustAddr5; CustAddr[5])
            {
            }
            column(CustAddr6; CustAddr[6])
            {
            }
            column(CustAddr7; CustAddr[7])
            {
            }
            column(CustAddr8; CustAddr[8])
            {
            }
            dataitem("Posted Invt. Pick Line"; "Posted Invt. Pick Line")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = SORTING("No.", "Line No.")
                                    ORDER(Ascending);
                column(Posted_Invt__Pick_Line__Lot_No__; "Lot No.")
                {
                }
                column(Posted_Invt__Pick_Line_Description; Description)
                {
                }
                column(orderedqty; orderedqty)
                {
                    DecimalPlaces = 0 : 0;
                }
                column(Posted_Invt__Pick_Line__Box_Number_; "Box Number")
                {
                }
                column(Posted_Invt__Pick_Line_Quantity; Quantity)
                {
                }
                column(Posted_Invt__Pick_Line__No__of_Box_; "No. of Box")
                {
                }
                column(Posted_Invt__Pick_Line__Units_Sub_Total_; "Units Sub Total")
                {
                }
                column(Posted_Invt__Pick_Line__Total_Unit_Box_; "Total Unit/Box")
                {
                }
                column(Posted_Invt__Pick_Line__Expiration_Date_; "Expiration Date")
                {
                }
                column(Posted_Invt__Pick_Line__Pallette_number_; "Pallet Number")
                {
                }
                column(Quantity_ShippedCaption; Quantity_ShippedCaptionLbl)
                {
                }
                column(Qty_of_boxesCaption; Qty_of_boxesCaptionLbl)
                {
                }
                column(DescriptionCaption; DescriptionCaptionLbl)
                {
                }
                column(Quantity_OrderedCaption; Quantity_OrderedCaptionLbl)
                {
                }
                column(Box_NumberCaption; Box_NumberCaptionLbl)
                {
                }
                column(Batch_No_Caption; Batch_No_CaptionLbl)
                {
                }
                column(Total_Units_BoxCaption; Total_Units_BoxCaptionLbl)
                {
                }
                column(Units_Caption; Units_CaptionLbl)
                {
                }
                column(Expiry_DateCaption; Expiry_DateCaptionLbl)
                {
                }
                column(Posted_Invt__Pick_Line__Pallette_number_Caption; FIELDCAPTION("Pallet Number"))
                {
                }
                column(Posted_Invt__Pick_Line_No_; "No.")
                {
                }
                column(Posted_Invt__Pick_Line_Line_No_; "Line No.")
                {
                }
                column(Posted_Invt__Pick_Line_Item_No_; "Item No.")
                {
                }
                column("Count"; "Posted Invt. Pick Line".COUNT)
                {
                }
                column(QtyToHanndle; QtyToHandle)
                {
                }
                column(BinCode; "Bin Code")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //Section
                    CLEAR(orderedqty);
                    IF SalesLineArch.GET THEN;
                    SalesLineArch.RESET;
                    SalesLineArch.SETRANGE(SalesLineArch."Document No.", "Posted Invt. Pick Line"."Source No.");
                    SalesLineArch.SETRANGE(SalesLineArch."Line No.", "Posted Invt. Pick Line"."Line No.");

                    IF SalesLineArch.FINDFIRST THEN
                        orderedqty := SalesLineArch.Quantity;
                    //Section
                    QtyToHandle := QtyToHandle + "Posted Invt. Pick Line".Quantity;
                    //  MESSAGE(FORMAT(QtyToHandle));
                end;

                trigger OnPreDataItem()
                begin
                    QtyToHandle := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CompanyInfo.GET;
                CompanyInfo.CALCFIELDS(CompanyInfo.Picture);
                FormatAddr.Company(CompanyAddr, CompanyInfo);

                //Section
                /*
                IF recSalesReceivable.GET THEN;
                "No.Series".GET(recSalesReceivable."Posted Invoice Nos.");
                //"No.Series Line".SETFILTER("No.Series Line"."Series Code","No.Series".Code);
                //CLEAR(LastNoused);
                recSalesReceivable.GET;
                IF recSalesReceivable."Posted Invoice Nos." <> '' THEN BEGIN
                  recNoSeriesLine.RESET;
                  recNoSeriesLine.SETRANGE("Series Code",recSalesReceivable."Posted Invoice Nos.");
                  IF recNoSeriesLine.FINDFIRST THEN
                    LastNoused := recNoSeriesLine."Last No. Used";
                END;
                */

                IF Customer.GET THEN;
                Customer.RESET;
                Customer.SETRANGE(Customer."No.", "Posted Invt. Pick Header"."Destination No.");
                IF Customer.FINDFIRST THEN
                    //Section

                    SalesShptLine.RESET;
                SalesShptLine.SETRANGE(SalesShptLine."Document No.", "Posted Invt. Pick Header"."Source No.");
                SalesShptLine.SETFILTER(SalesShptLine.Quantity, '<>0');
                IF SalesShptLine.FINDFIRST THEN BEGIN
                    SalesShptLine.GetSalesInvLines(TempSalesInvLine);
                    TempSalesInvLine.RESET;
                    IF TempSalesInvLine.FINDFIRST THEN BEGIN
                        recSalesInvoice.RESET;
                        recSalesInvoice.SETRANGE(recSalesInvoice."No.", TempSalesInvLine."Document No.");
                        IF recSalesInvoice.FINDFIRST THEN BEGIN
                            LastNoused := recSalesInvoice."No.";
                            InvoiceDate := recSalesInvoice."Order Date";
                            InvoiceDueDate := recSalesInvoice."Due Date";
                            //FormatAddr.SalesInvBillTo(CustAddr,"Sales Invoice Header");
                            //Cust.GET("Bill-to Customer No.");
                            IF recCountry.GET(recSalesInvoice."Bill-to Country/Region Code") THEN;
                            CLEAR(CustAddr);
                            CustAddr[1] := recSalesInvoice."Bill-to Name";
                            CustAddr[2] := recSalesInvoice."Bill-to Name 2";
                            CustAddr[3] := recSalesInvoice."Bill-to Address";
                            CustAddr[4] := recSalesInvoice."Bill-to Address 2";
                            CustAddr[5] := recSalesInvoice."Bill-to City" + '  ' + recSalesInvoice."Bill-to Post Code";
                            CustAddr[6] := FORMAT(recSalesInvoice."Bill-to County");
                            CustAddr[7] := recCountry.Name;
                            COMPRESSARRAY(CustAddr);


                            //FormatAddr.SalesInvShipTo(ShipToAddr,recSalesInvoice);
                            IF recCountry.GET(recSalesInvoice."Ship-to Country/Region Code") THEN;

                            CLEAR(ShipToAddr);
                            ShipToAddr[1] := recSalesInvoice."Ship-to Name";
                            ShipToAddr[2] := recSalesInvoice."Ship-to Name 2";
                            ShipToAddr[3] := recSalesInvoice."Ship-to Address";
                            ShipToAddr[4] := recSalesInvoice."Ship-to Address 2";
                            ShipToAddr[5] := recSalesInvoice."Ship-to City" + '  ' + recSalesInvoice."Ship-to Post Code";
                            ShipToAddr[6] := FORMAT(recSalesInvoice."Ship-to County");
                            ShipToAddr[7] := recCountry.Name;
                            COMPRESSARRAY(ShipToAddr);
                        END;
                    END;
                END;

            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("No.");
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

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        recSalesReceivable: Record 311;
        recNoSeriesLine: Record 309;
        "No.Series": Record 308;
        "invoice no.": Code[50];
        WMSMgt: Codeunit 7302;
        LastNoused: Code[50];
        SalesLineArch: Record 5108;
        SalesLine: Record 37;
        orderedqty: Decimal;
        Customer: Record 18;
        Posted_Invt__Pick_HeaderCaptionLbl: Label 'Posted Invt. Pick Header';
        DateCaptionLbl: Label 'Date';
        Delivery_To_CaptionLbl: Label 'Delivery To:';
        Invoice_No__CaptionLbl: Label 'Invoice No.:';
        Your_PO_No_CaptionLbl: Label 'Your PO No.';
        TotalCaptionLbl: Label 'Total';
        Total_Gross_Weight_CaptionLbl: Label 'Total Gross Weight:';
        Checked_By_CaptionLbl: Label 'Checked By:';
        Packed_By_CaptionLbl: Label 'Packed By:';
        Date_Time_CaptionLbl: Label 'Date/Time:';
        Quantity_ShippedCaptionLbl: Label 'Quantity Shipped';
        Qty_of_boxesCaptionLbl: Label 'Qty of boxes';
        DescriptionCaptionLbl: Label 'Description';
        Quantity_OrderedCaptionLbl: Label 'Quantity Ordered';
        Box_NumberCaptionLbl: Label 'Box Number';
        Batch_No_CaptionLbl: Label 'Batch No.';
        Total_Units_BoxCaptionLbl: Label 'Total Units/Box';
        Units_CaptionLbl: Label 'Units ';
        Expiry_DateCaptionLbl: Label 'Expiry Date';
        recSalesInvoice: Record 112;
        InvoiceDate: Date;
        InvoiceDueDate: Date;
        CompanyInfo: Record 79;
        FormatAddr: Codeunit 365;
        CompanyAddr: array[8] of Text[50];
        CustAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        recCountry: Record 9;
        SalesShptLine: Record 111;
        TempSalesInvLine: Record 113 temporary;
        "Count": Integer;
        QtyToHandle: Decimal;

    procedure GetDestinationName(DestType: Option " ",Customer,Vendor,Location,Item,Family,"Sales Order"; DestNo: Code[20]): Text[50]
    var
        Vendor: Record 23;
        Customer: Record 18;
        Location: Record 14;
        Item: Record 27;
        Family: Record 99000773;
        SalesHeader: Record 36;
    begin
        CASE DestType OF
            DestType::Customer:
                IF Customer.GET(DestNo) THEN
                    EXIT(Customer.Name);
            DestType::Vendor:
                IF Vendor.GET(DestNo) THEN
                    EXIT(Vendor.Name);
            DestType::Location:
                IF Location.GET(DestNo) THEN
                    EXIT(Location.Name);
            DestType::Item:
                IF Item.GET(DestNo) THEN
                    EXIT(Item.Description);
            DestType::Family:
                IF Family.GET(DestNo) THEN
                    EXIT(Family.Description);
            DestType::"Sales Order":
                IF SalesHeader.GET(SalesHeader."Document Type"::Order, DestNo) THEN
                    EXIT(SalesHeader."Sell-to Customer Name");
        END;
    end;
}

