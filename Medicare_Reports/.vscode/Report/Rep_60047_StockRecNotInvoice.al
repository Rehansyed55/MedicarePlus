report 60047 "Stk Rece. not Invoice(vendor)"
{
    // version NAVGB5.00.01

    DefaultLayout = RDLC;
    RDLCLayout = './Stk Rece. not Invoice(vendor).rdl';
    Caption = 'Stock Received not Invoiced';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    dataset
    {
        dataitem(Vendor; Vendor)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(USERID; USERID)
            {
            }
            column(Vendor_TABLECAPTION__________VendorFilter; Vendor.TABLECAPTION + ': ' + Vendor.GETFILTERS)
            {
            }
            column(Vendor__No__; "No.")
            {
            }
            column(Vendor_Vendor_Name; Vendor.Name)
            {
            }
            column(Item_Ledger_Entry__Quantity____Item_Ledger_Entry___Invoiced_Quantity_; "Item Ledger Entry".Quantity - "Item Ledger Entry"."Invoiced Quantity")
            {
            }
            column(Item_Ledger_Entry__Quantity; "Item Ledger Entry".Quantity)
            {
            }
            column(Item_Ledger_Entry___Invoiced_Quantity_; "Item Ledger Entry"."Invoiced Quantity")
            {
            }
            column(Item_Ledger_Entry___Cost_Amount__Expected__; "Item Ledger Entry"."Cost Amount (Expected)")
            {
            }
            column(Value_Entry___Cost_Amount__Actual__; "Value Entry"."Cost Amount (Actual)")
            {
            }
            column(Item_Ledger_Entry___Cost_Amount__Expected___Control1040059; "Item Ledger Entry"."Cost Amount (Expected)")
            {
            }
            column(Value_Entry___Invoiced_Quantity_; "Value Entry"."Invoiced Quantity")
            {
            }
            column(Text1040005_________Vendor__No__; Text1040005 + ' ' + Vendor."No.")
            {
            }
            column(Item_Ledger_Entry__Quantity____Item_Ledger_Entry___Invoiced_Quantity__Control1040065; "Item Ledger Entry".Quantity - "Item Ledger Entry"."Invoiced Quantity")
            {
            }
            column(Item_Ledger_Entry__Quantity_Control1040066; "Item Ledger Entry".Quantity)
            {
            }
            column(Item_Ledger_Entry___Invoiced_Quantity__Control1040067; "Item Ledger Entry"."Invoiced Quantity")
            {
            }
            column(Item_Ledger_Entry___Cost_Amount__Expected___Control1040068; "Item Ledger Entry"."Cost Amount (Expected)")
            {
            }
            column(Item_Ledger_Entry___Cost_Amount__Expected___Control1040069; "Item Ledger Entry"."Cost Amount (Expected)")
            {
            }
            column(Value_Entry___Invoiced_Quantity__Control1040070; "Value Entry"."Invoiced Quantity")
            {
            }
            column(Value_Entry___Cost_Amount__Actual___Control1040071; "Value Entry"."Cost Amount (Actual)")
            {
            }
            column(Stock_Received_not_InvoicedCaption; Stock_Received_not_InvoicedCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Totals__Rec__not_invoiced_Caption; Totals__Rec__not_invoiced_CaptionLbl)
            {
            }
            column(ReceivedCaption; ReceivedCaptionLbl)
            {
            }
            column(InvoicedCaption; InvoicedCaptionLbl)
            {
            }
            column(Vendor_Vendor_NameCaption; FIELDCAPTION(Name))
            {
            }
            column(Vendor__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(Item_Ledger_Entry__Invoiced_Quantity_Caption; "Item Ledger Entry".FIELDCAPTION("Invoiced Quantity"))
            {
            }
            column(Item_Ledger_Entry_QuantityCaption; Item_Ledger_Entry_QuantityCaptionLbl)
            {
            }
            column(Control1040018Caption; Control1040018CaptionLbl)
            {
            }
            column(Item_Ledger_Entry__Item_Ledger_Entry___Item_No__Caption; "Item Ledger Entry".FIELDCAPTION("Item No."))
            {
            }
            column(Value_Entry__Cost_Amount__Actual__Caption; "Value Entry".FIELDCAPTION("Cost Amount (Actual)"))
            {
            }
            column(Value_Entry__Invoiced_Quantity_Caption; "Value Entry".FIELDCAPTION("Invoiced Quantity"))
            {
            }
            column(Item_Ledger_Entry__Cost_Amount__Expected__Caption; "Item Ledger Entry".FIELDCAPTION("Cost Amount (Expected)"))
            {
            }
            column(Item_Ledger_Entry__Quantity____Item_Ledger_Entry___Invoiced_Quantity__Control1040040Caption; Item_Ledger_Entry__Quantity____Item_Ledger_Entry___Invoiced_Quantity__Control1040040CaptionLbl)
            {
            }
            column(Item_Ledger_Entry___Cost_Amount__Expected___Control1040058Caption; Item_Ledger_Entry___Cost_Amount__Expected___Control1040058CaptionLbl)
            {
            }
            column(Vendor_NameCaption; Vendor_NameCaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(Invoiced_QuantityCaption; Invoiced_QuantityCaptionLbl)
            {
            }
            column(Received_QuantityCaption; Received_QuantityCaptionLbl)
            {
            }
            column(Adjusted_Cost__Expected_Caption; Adjusted_Cost__Expected_CaptionLbl)
            {
            }
            column(QuantityCaption; QuantityCaptionLbl)
            {
            }
            column(Adjusted_CostCaption; Adjusted_CostCaptionLbl)
            {
            }
            column(CostCaption; CostCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(Vendor_Date_Filter; "Date Filter")
            {
            }
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemLink = "Source No." = FIELD("No."),
                               "Posting Date" = FIELD("Date Filter");
                DataItemTableView = SORTING("Item No.", Positive, "Completely Invoiced", "Last Invoice Date", "Location Code", "Variant Code")
                                    WHERE("Completely Invoiced" = CONST(false),
                                          "Entry Type" = CONST("Purchase"),
                                          "Source Type" = FILTER("Vendor"));
                column(Item_Ledger_Entry__Posting_Date_; FORMAT("Posting Date"))
                {
                }
                column(Item_Ledger_Entry_Quantity; Quantity)
                {
                }
                column(Item_Ledger_Entry__Invoiced_Quantity_; "Invoiced Quantity")
                {
                }
                column(Item_Ledger_Entry__Item_Ledger_Entry___Item_No__; "Item Ledger Entry"."Item No.")
                {
                }
                column(Item_Ledger_Entry__Cost_Amount__Expected__; "Cost Amount (Expected)")
                {
                }
                column(Item_Ledger_Entry__Quantity____Item_Ledger_Entry___Invoiced_Quantity__Control1000000001; "Item Ledger Entry".Quantity - "Item Ledger Entry"."Invoiced Quantity")
                {
                }
                column(Item_Ledger_Entry__Item_Ledger_Entry___Cost_Amount__Expected__; "Item Ledger Entry"."Cost Amount (Expected)")
                {
                }
                column(Value_Entry___Invoiced_Quantity__Control1000000003; "Value Entry"."Invoiced Quantity")
                {
                }
                column(Value_Entry___Cost_Amount__Actual___Control1000000004; "Value Entry"."Cost Amount (Actual)")
                {
                }
                column(Item_Ledger_Entry__Item_Ledger_Entry__Quantity; "Item Ledger Entry".Quantity)
                {
                }
                column(Item_Ledger_Entry__Item_Ledger_Entry___Invoiced_Quantity_; "Item Ledger Entry"."Invoiced Quantity")
                {
                }
                column(Item_Ledger_Entry__Item_Ledger_Entry___Cost_Amount__Expected___Control1040076; "Item Ledger Entry"."Cost Amount (Expected)")
                {
                }
                column(Text1040005__________Item_Ledger_Entry___Item_No__; Text1040005 + ' ' + "Item Ledger Entry"."Item No.")
                {
                }
                column(Item_Ledger_Entry__Quantity____Item_Ledger_Entry___Invoiced_Quantity__Control1040080; "Item Ledger Entry".Quantity - "Item Ledger Entry"."Invoiced Quantity")
                {
                }
                column(Item_Ledger_Entry__Item_Ledger_Entry___Cost_Amount__Expected___Control1040081; "Item Ledger Entry"."Cost Amount (Expected)")
                {
                }
                column(Item_Ledger_Entry_Entry_No_; "Entry No.")
                {
                }
                column(Item_Ledger_Entry_Source_No_; "Source No.")
                {
                }
                dataitem("Value Entry"; "Value Entry")
                {
                    DataItemLink = "Item Ledger Entry No." = FIELD("Entry No.");
                    DataItemTableView = SORTING("Item Ledger Entry No.", "Expected Cost", "Document No.", "Partial Revaluation", "Entry Type", "Variance Type")
                                        WHERE("Inventoriable" = CONST(true),
                                              "Expected Cost" = CONST(false));
                    column(Value_Entry__Posting_Date_; "Posting Date")
                    {
                    }
                    column(Value_Entry__Document_No__; "Document No.")
                    {
                    }
                    column(Value_Entry_Description; Description)
                    {
                    }
                    column(Value_Entry__Invoiced_Quantity_; "Invoiced Quantity")
                    {
                    }
                    column(Value_Entry__Cost_Amount__Actual__; "Cost Amount (Actual)")
                    {
                    }
                    column(Value_Entry_Entry_No_; "Entry No.")
                    {
                    }
                    column(Value_Entry_Item_Ledger_Entry_No_; "Item Ledger Entry No.")
                    {
                    }

                    trigger OnPreDataItem()
                    begin
                        CurrReport.CREATETOTALS("Cost Amount (Actual)", "Invoiced Quantity");
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    NoOfItems := NoOfItems + 1;
                    CurrReport.CREATETOTALS(Quantity, "Invoiced Quantity", "Cost Amount (Expected)");
                    CurrReport.CREATETOTALS("Value Entry"."Cost Amount (Actual)", "Value Entry"."Invoiced Quantity");

                    //MESSAGE('%1***%2',"Item Ledger Entry"."Item No.","Item Ledger Entry".Quantity);
                end;

                trigger OnPreDataItem()
                begin
                    //IF EndDate <> 0D THEN
                    //SETRANGE("Posting Date",0D,Item."Date Filter");//EndDate);
                end;
            }
            dataitem(ItemTotal; Integer)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = CONST(1));
                column(Item_Ledger_Entry__Quantity_Control1040032; "Item Ledger Entry".Quantity)
                {
                }
                column(Item_Ledger_Entry___Invoiced_Quantity__Control1040034; "Item Ledger Entry"."Invoiced Quantity")
                {
                }
                column(Item_Ledger_Entry___Cost_Amount__Expected___Control1040035; "Item Ledger Entry"."Cost Amount (Expected)")
                {
                }
                column(Value_Entry___Invoiced_Quantity__Control1040036; "Value Entry"."Invoiced Quantity")
                {
                }
                column(Value_Entry___Cost_Amount__Actual___Control1040044; "Value Entry"."Cost Amount (Actual)")
                {
                }
                column(Text1040005__________Item_Ledger_Entry___Item_No___Control1040029; Text1040005 + ' ' + "Item Ledger Entry"."Item No.")
                {
                }
                column(Item_Ledger_Entry__Quantity____Item_Ledger_Entry___Invoiced_Quantity__Control1040040; "Item Ledger Entry".Quantity - "Item Ledger Entry"."Invoiced Quantity")
                {
                }
                column(Item_Ledger_Entry___Cost_Amount__Expected___Control1040058; "Item Ledger Entry"."Cost Amount (Expected)")
                {
                }
                column(ItemTotal_Number; Number)
                {
                }

                trigger OnPreDataItem()
                begin
                    //IF NoOfItems <= 1 THEN //anikEt
                    CurrReport.BREAK;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                NoOfItems := 0;
            end;

            trigger OnPreDataItem()
            begin
                CurrReport.CREATETOTALS(
                  "Item Ledger Entry".Quantity, "Item Ledger Entry"."Invoiced Quantity", "Item Ledger Entry"."Cost Amount (Expected)");
                CurrReport.CREATETOTALS("Value Entry"."Cost Amount (Actual)", "Value Entry"."Invoiced Quantity");
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
        ReceivedValue: Decimal;
        ReceivedQty: Decimal;
        EndDate: Date;
        VendorFilter: Text[250];
        PrintDetails: Boolean;
        Text1040005: Label 'Received not invoiced for Vendor';
        NoOfItems: Integer;
        Stock_Received_not_InvoicedCaptionLbl: Label 'Stock Received not Invoiced';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Totals__Rec__not_invoiced_CaptionLbl: Label 'Totals (Rec. not invoiced)';
        ReceivedCaptionLbl: Label 'Received';
        InvoicedCaptionLbl: Label 'Invoiced';
        Item_Ledger_Entry_QuantityCaptionLbl: Label 'Received Quantity';
        Control1040018CaptionLbl: Label 'Label1040018';
        Item_Ledger_Entry__Quantity____Item_Ledger_Entry___Invoiced_Quantity__Control1040040CaptionLbl: Label 'Quantity';
        Item_Ledger_Entry___Cost_Amount__Expected___Control1040058CaptionLbl: Label 'Cost';
        Vendor_NameCaptionLbl: Label 'Vendor Name';
        No_CaptionLbl: Label 'No.';
        Invoiced_QuantityCaptionLbl: Label 'Invoiced Quantity';
        Received_QuantityCaptionLbl: Label 'Received Quantity';
        Adjusted_Cost__Expected_CaptionLbl: Label 'Adjusted Cost (Expected)';
        QuantityCaptionLbl: Label 'Quantity';
        Adjusted_CostCaptionLbl: Label 'Adjusted Cost';
        CostCaptionLbl: Label 'Cost';
        TotalCaptionLbl: Label 'Total';
}

