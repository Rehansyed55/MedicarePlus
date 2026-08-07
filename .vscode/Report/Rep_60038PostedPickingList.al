report 60038 "Posted Picking List"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'PostedPickingList.rdl';
    Caption = 'Picking List';
    PaperSourceDefaultPage = Upper;

    dataset
    {
        dataitem("Posted Invt. Pick Header"; "Posted Invt. Pick Header")
        {
            //  CalcFields = "Shipping Method", "Requested Delivery Date", "Promised Delivery Date", "Ship-to code";
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "No. Printed";
            column(No_WhseActivHeader; "No.")
            {
            }
            column(DestinationNo; "Posted Invt. Pick Header"."Destination No.")
            {
            }
            column(ExternalDocNo; "Posted Invt. Pick Header"."External Document No.")
            {
            }
            column(ShiptoWarecode; "Posted Invt. Pick Header"."Ship-to code")
            {

            }
            // column(WMSMgt; WMSMgt.GetDestinationName("Warehouse Activity Header"."Destination Type", "Warehouse Activity Header"."Destination No."))
            // {
            // }
            column(WMSMgt; "Posted Invt. Pick Header"."Destination Type")
            {
            }
            column(ShipToCode; shiptocode)
            {
            }
            column(ShipToNAme; Shiptoname)
            {
            }
            column(shiptoaddress; shiptoaddress)
            {
            }
            column(Shiptoaddress2; Shiptoaddress2)
            {
            }
            column(shiptocity; shiptocity)
            {
            }
            column(ShiptoPostcode; ShiptoPostcode)
            {
            }
            column(AssignUserid; "Posted Invt. Pick Header"."Assigned User ID")
            {
            }
            column(ShippingMethod; "Posted Invt. Pick Header"."Shipping Method")
            {
            }
            column(Requeated_Delivery_Date; FORMAT("Posted Invt. Pick Header"."Requested Delivery Date"))
            {
            }

            column(Location_Code; "Posted Invt. Pick Header"."Location Code")
            {
            }
            column(Promised_Delivery_Date; FORMAT("Posted Invt. Pick Header"."Promised Delivery Date"))
            {
            }

            column(Qty2; Qty2)
            {
            }
            column(CompInfo_Picture; CompInfo.Picture)
            {
            }
            dataitem(DataItem5444; Integer)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = CONST(1));
                column(CompanyName; COMPANYNAME)
                {
                }
                column(TodayFormatted; FORMAT(TODAY, 0, 7))
                {
                }
                column(Time; TIME)
                {
                }
                column(PickFilter; PickFilter)
                {
                }
                column(DirectedPutAwayAndPick; Location."Directed Put-away and Pick")
                {
                }
                column(BinMandatory; Location."Bin Mandatory")
                {
                }
                column(InvtPick; InvtPick)
                {
                }
                column(ShowLotSN; ShowLotSN)
                {
                }
                column(SumUpLines; SumUpLines)
                {
                }
                column(No_WhseActivHeaderCaption; "Posted Invt. Pick Header".FIELDCAPTION("No."))
                {
                }
                column(WhseActivHeaderCaption; "Posted Invt. Pick Header".TABLECAPTION + ': ' + PickFilter)
                {
                }
                column(LoctnCode_WhseActivHeader; "Posted Invt. Pick Header"."Location Code")
                {
                }
                // column(SortingMtd_WhseActivHeader; "Posted Invt. Pick Header"."Sorting Method")
                // {
                // }
                column(SortingMtd_WhseActivHeader; SortingMethod)
                {
                }
                column(AssgUserID_WhseActivHeader; "Posted Invt. Pick Header"."Assigned User ID")
                {
                }
                column(SourcDocument_WhseActLine; "Posted Invt. Pick Line"."Source Document")
                {
                }
                column(LoctnCode_WhseActivHeaderCaption; "Posted Invt. Pick Header".FIELDCAPTION("Location Code"))
                {
                }
                // column(SortingMtd_WhseActivHeaderCaption; "Posted Invt. Pick Header".FIELDCAPTION("Sorting Method"))
                // {
                // }
                column(SortingMtd_WhseActivHeaderCaption; SortingMethod)
                {
                }
                column(AssgUserID_WhseActivHeaderCaption; "Posted Invt. Pick Header".FIELDCAPTION("Assigned User ID"))
                {
                }
                column(SourcDocument_WhseActLineCaption; "Posted Invt. Pick Line".FIELDCAPTION("Source Document"))
                {
                }
                column(SourceNo_WhseActLineCaption; PostedWhseLine.FIELDCAPTION("Source No."))
                {
                }
                column(ShelfNo_WhseActLineCaption; PostedWhseLine.FIELDCAPTION("Shelf No."))
                {
                }
                column(VariantCode_WhseActLineCaption; PostedWhseLine.FIELDCAPTION("Variant Code"))
                {
                }
                column(Description_WhseActLineCaption; PostedWhseLine.FIELDCAPTION(Description))
                {
                }
                column(ItemNo_WhseActLineCaption; PostedWhseLine.FIELDCAPTION("Item No."))
                {
                }
                column(UOMCode_WhseActLineCaption; PostedWhseLine.FIELDCAPTION("Unit of Measure Code"))
                {
                }
                // column(QtytoHandle_WhseActLineCaption; PostedWhseLine.FIELDCAPTION("Qty. to Handle"))
                // {
                // }
                column(QtytoHandle_WhseActLineCaption; QtytoHandleCaption)
                {
                }
                column(QtyBase_WhseActLineCaption; PostedWhseLine.FIELDCAPTION("Qty. (Base)"))
                {
                }
                column(DestinatnType_WhseActLineCaption; PostedWhseLine.FIELDCAPTION("Destination Type"))
                {
                }
                column(DestinationNo_WhseActLineCaption; PostedWhseLine.FIELDCAPTION("Destination No."))
                {
                }
                column(ZoneCode_WhseActLineCaption; PostedWhseLine.FIELDCAPTION("Zone Code"))
                {
                }
                column(BinCode_WhseActLineCaption; PostedWhseLine.FIELDCAPTION("Bin Code"))
                {
                }
                column(ActionType_WhseActLineCaption; PostedWhseLine.FIELDCAPTION("Action Type"))
                {
                }
                column(CurrReportPageNoCaption; CurrReportPageNoCaptionLbl)
                {
                }
                column(PickingListCaption; PickingListCaptionLbl)
                {
                }
                column(WhseActLineDueDateCaption; WhseActLineDueDateCaptionLbl)
                {
                }
                column(QtyHandledCaption; QtyHandledCaptionLbl)
                {
                }
                dataitem("Posted Invt. Pick Line"; "Posted Invt. Pick Line")
                {
                    DataItemLink = "No." = FIELD("No.");
                    DataItemLinkReference = "Posted Invt. Pick Header";
                    DataItemTableView = SORTING("Bin Code", "Location Code", "Action Type");

                    trigger OnAfterGetRecord()
                    begin
                        IF SumUpLines
                        //AND
                        //    ("Posted Invt. Pick Header"."Sorting Method" <>
                        //     "Posted Invt. Pick Header"."Sorting Method"::Document)
                        THEN BEGIN
                            IF TmpWhseActLine."No." = '' THEN BEGIN
                                TmpWhseActLine := "Posted Invt. Pick Line";
                                TmpWhseActLine.INSERT;
                                MARK(TRUE);
                            END ELSE BEGIN
                                // TmpWhseActLine.SETCURRENTKEY("Activity Type", "No.", "Bin Code", "Breakbulk No.", "Action Type");
                                // TmpWhseActLine.SETRANGE("Activity Type", "Activity Type");
                                TmpWhseActLine.SETRANGE("No.", "No.");
                                TmpWhseActLine.SETRANGE("Bin Code", "Bin Code");
                                TmpWhseActLine.SETRANGE("Item No.", "Item No.");
                                TmpWhseActLine.SETRANGE("Action Type", "Action Type");
                                TmpWhseActLine.SETRANGE("Variant Code", "Variant Code");
                                TmpWhseActLine.SETRANGE("Unit of Measure Code", "Unit of Measure Code");
                                TmpWhseActLine.SETRANGE("Due Date", "Due Date");
                                // IF "Posted Invt. Pick Header"."Sorting Method" =
                                //    "Posted Invt. Pick Header"."Sorting Method"::"Ship-To"
                                // THEN BEGIN
                                //     TmpWhseActLine.SETRANGE("Destination Type", "Destination Type");
                                //     TmpWhseActLine.SETRANGE("Destination No.", "Destination No.")
                                // END;
                                IF TmpWhseActLine.FINDFIRST THEN BEGIN
                                    TmpWhseActLine."Qty. (Base)" := TmpWhseActLine."Qty. (Base)" + "Qty. (Base)";
                                    // TmpWhseActLine."Qty. to Handle" := TmpWhseActLine."Qty. to Handle" + "Qty. to Handle";
                                    TmpWhseActLine."Source No." := '';
                                    // IF "Posted Invt. Pick Header"."Sorting Method" <>
                                    //    "Posted Invt. Pick Header"."Sorting Method"::"Ship-To"
                                    // THEN BEGIN
                                    //     TmpWhseActLine."Destination Type" := TmpWhseActLine."Destination Type"::" ";
                                    //     TmpWhseActLine."Destination No." := '';
                                    // END;
                                    TmpWhseActLine.MODIFY;
                                END ELSE BEGIN
                                    TmpWhseActLine := "Posted Invt. Pick Line";
                                    TmpWhseActLine.INSERT;
                                    MARK(TRUE);
                                END;
                            END;
                        END ELSE
                            MARK(TRUE);
                    end;

                    trigger OnPostDataItem()
                    begin
                        MARKEDONLY(TRUE);
                    end;

                    trigger OnPreDataItem()
                    begin
                        //TmpWhseActLine.SETRANGE("Activity Type", "Posted Invt. Pick Header".Type);
                        TmpWhseActLine.SETRANGE("No.", "Posted Invt. Pick Header"."No.");
                        TmpWhseActLine.DELETEALL;
                        IF BreakbulkFilter THEN
                            //TmpWhseActLine.SETRANGE("Original Breakbulk", FALSE);
                        CLEAR(TmpWhseActLine);
                    end;
                }
                dataitem(PostedWhseLine; "Posted Invt. Pick Line")
                {
                    DataItemLink = "No." = FIELD("No.");
                    DataItemLinkReference = "Posted Invt. Pick Header";
                    DataItemTableView = SORTING("Bin Code", "Location Code", "Action Type");
                    column(SourceNo_WhseActLine; "Source No.")
                    {
                    }
                    column(FormatSourcDocument_WhseActLine; FORMAT("Source Document"))
                    {
                    }
                    column(ShelfNo_WhseActLine; "Shelf No.")
                    {
                    }
                    column(ItemNo_WhseActLine; "Item No.")
                    {
                    }
                    column(Description_WhseActLine; Description)
                    {
                    }
                    column(VariantCode_WhseActLine; "Variant Code")
                    {
                    }
                    column(UOMCode_WhseActLine; "Unit of Measure Code")
                    {
                    }
                    column(DueDate_WhseActLine; FORMAT("Due Date"))
                    {
                    }
                    // column(QtytoHandle_WhseActLine; "Qty. to Handle")
                    // {
                    // }
                    column(QtytoHandle_WhseActLine; QtytoHandle)
                    {
                    }
                    column(QtyBase_WhseActLine; "Qty. (Base)")
                    {
                    }
                    column(DestinatnType_WhseActLine; "Destination Type")
                    {
                    }
                    column(DestinationNo_WhseActLine; "Destination No.")
                    {
                    }
                    column(ZoneCode_WhseActLine; "Zone Code")
                    {
                    }
                    column(BinCode_WhseActLine; "Bin Code")
                    {
                    }
                    column(ActionType_WhseActLine; "Action Type")
                    {
                    }
                    column(LotNo_WhseActLine; "Lot No.")
                    {
                    }
                    column(LotNo2_WhseActLine; Lotno2)
                    {
                    }
                    column(LotNocap_WhseActLine; Batch)
                    {
                    }
                    column(SerialNo; "Serial No.")
                    {
                    }
                    column(LotNo_WhseActLineCaption; FIELDCAPTION("Lot No."))
                    {
                    }
                    column(SerialNo_WhseActLineCaption; FIELDCAPTION("Serial No."))
                    {
                    }
                    column(LineNo_WhseActLine; "Line No.")
                    {
                    }
                    // column(BinRanking_WhseActLine; "Bin Ranking")
                    // {
                    // }
                    column(BinRanking_WhseActLine; BinRanking)
                    {
                    }
                    column(EmptyStringCaption; EmptyStringCaptionLbl)
                    {
                    }
                    column(LotNo; PostedWhseLine."Lot No.")
                    {
                    }
                    column(Expirationdate; PostedWhseLine."Expiration Date")
                    {
                    }
                    column("Count"; PostedWhseLine.COUNT)
                    {
                    }
                    column(Quantity_whactline; Quantity)
                    {
                    }
                    column(SumQty; Qty)
                    {
                    }
                    dataitem(PostWhseLine2; "Posted Invt. Pick Line")
                    {
                        DataItemLink = "No." = FIELD("No."),
                                       "Bin Code" = FIELD("Bin Code"),
                                       "Item No." = FIELD("Item No."),
                                       "Action Type" = FIELD("Action Type"),
                                       "Variant Code" = FIELD("Variant Code"),
                                       "Unit of Measure Code" = FIELD("Unit of Measure Code"),
                                       "Due Date" = FIELD("Due Date");
                        DataItemLinkReference = PostWhseLine2;
                        DataItemTableView = SORTING("No.", "Bin Code", "Action Type");
                        column(LotNo_WhseActLine2; "Lot No.")
                        {
                        }
                        column(SerialNo_WhseActLine2; "Serial No.")
                        {
                        }
                        column(QtyBase_WhseActLine2; "Qty. (Base)")
                        {
                        }
                        column(QtytoHandle_WhseActLine2; QtytoHandle)
                        {
                        }
                        column(LineNo_WhseActLine2; "Line No.")
                        {
                        }
                    }

                    trigger OnAfterGetRecord()
                    begin
                        IF SumUpLines THEN BEGIN
                            // TmpWhseActLine.GET("Activity Type", "No.", "Line No.");
                            // "Qty. (Base)" := TmpWhseActLine."Qty. (Base)";
                            // "Qty. to Handle" := TmpWhseActLine."Qty. to Handle";
                        END;
                        Lotno2 := "Posted Invt. Pick Line"."Lot No." + '-P';
                        Batch := 'Batch No.';

                        //Qty := 0 ;
                        Qty := Qty + "Posted Invt. Pick Line".Quantity;
                        //MESSAGE(FORMAT(Qty));
                        //Qty +=WhseActLine.Quantity;
                    end;

                    trigger OnPreDataItem()
                    begin
                        COPY("Posted Invt. Pick Line");
                        Counter := COUNT;
                        IF Counter = 0 THEN
                            CurrReport.BREAK;

                        IF BreakbulkFilter THEN begin
                            //SETRANGE("Original Breakbulk", FALSE);
                        end;

                    end;

                }
            }

            trigger OnAfterGetRecord()
            begin
                CompInfo.GET;
                CompInfo.CALCFIELDS(CompInfo.Picture);

                GetLocation("Location Code");
                // InvtPick := Type = Type::"Invt. Pick";

                // IF NOT CurrReport.PREVIEW THEN
                //     WhseCountPrinted.RUN("Posted Invt. Pick Header");


                IF Salesorder.GET(Salesorder."Document Type"::Order, "Posted Invt. Pick Header"."Source No.") THEN BEGIN
                    shiptocode := Salesorder."Ship-to Code";
                    Shiptoname := Salesorder."Ship-to Name";
                    shipmentdate := Salesorder."Shipment Date";
                    shiptoaddress := Salesorder."Ship-to Address";
                    Shiptoaddress2 := Salesorder."Ship-to Address 2";
                    ShiptoPostcode := Salesorder."Ship-to Post Code";
                    shiptocity := Salesorder."Ship-to City";
                END;
                Lineno := 10000;


                //Wrote code by avinash on 311014(JiraNo.-CHEM-392)//
                CLEAR(Qty2);
                recWhseActLine.RESET;
                //recWhseActLine.SETRANGE(recWhseActLine."Activity Type", recWhseActLine."Activity Type"::"Invt. Pick");
                recWhseActLine.SETRANGE(recWhseActLine."No.", "Posted Invt. Pick Header"."No.");
                IF recWhseActLine.FIND('-') THEN
                    REPEAT
                        Qty2 += recWhseActLine.Quantity;
                    //MESSAGE(FORMAT(Qty2),"Warehouse Activity Header"."No.");
                    UNTIL recWhseActLine.NEXT = 0;
                //Wrote code by avinash on 311014(JiraNo.-CHEM-392)//
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
                    field(Breakbulk; BreakbulkFilter)
                    {
                        Caption = 'Set Breakbulk Filter';
                        Editable = BreakbulkEditable;
                    }
                    field(SumUpLines; SumUpLines)
                    {
                        Caption = 'Sum up Lines';
                        Editable = SumUpLinesEditable;
                    }
                    field(LotSerialNo; ShowLotSN)
                    {
                        Caption = 'Show Serial/Lot Number';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            SumUpLinesEditable := TRUE;
            BreakbulkEditable := TRUE;
        end;

        trigger OnOpenPage()
        begin
            IF HideOptions THEN BEGIN
                BreakbulkEditable := FALSE;
                SumUpLinesEditable := FALSE;
            END;
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        PickFilter := "Posted Invt. Pick Header".GETFILTERS;
    end;

    var
        Location: Record 14;
        TmpWhseActLine: Record "Posted Invt. Pick Line" temporary;
        WhseCountPrinted: Codeunit 5779;
        PickFilter: Text[250];
        BreakbulkFilter: Boolean;
        SumUpLines: Boolean;
        HideOptions: Boolean;
        InvtPick: Boolean;
        ShowLotSN: Boolean;
        Counter: Integer;
        [InDataSet]
        BreakbulkEditable: Boolean;
        [InDataSet]
        SumUpLinesEditable: Boolean;
        CurrReportPageNoCaptionLbl: Label 'Page';
        PickingListCaptionLbl: Label 'Picking List';
        WhseActLineDueDateCaptionLbl: Label 'Due Date';
        QtyHandledCaptionLbl: Label 'Qty. Handled';
        EmptyStringCaptionLbl: Label '____________';
        WMSMgt: Codeunit 7302;
        shiptocode: Code[30];
        shipmentdate: Date;
        shiptoaddress: Text[50];
        Shiptoaddress2: Text[50];
        ShiptoPostcode: Code[10];
        shiptocity: Text[50];
        Shiptoname: Text[100];
        Salesorder: Record 36;
        Lineno: Integer;
        Lotno2: Code[30];
        Batch: Text[10];
        Qty: Decimal;
        i: Integer;
        QtytoHandleCaption: Label 'Quantity';

        SortingMethod: code[10];
        QtytoHandle: Decimal;
        BinRanking: integer;
        recWhseActLine: Record "Posted Invt. Pick Line";
        Qty2: Decimal;
        CompInfo: Record 79;
        abc: report "Inventory Picking List";
        abc1: report "Picking List";
        ShippingMethod: code[20];
        RequestedDeliveryDate: date;
        PromisedDeliveryDate: date;

    local procedure GetLocation(LocationCode: Code[10])
    begin
        IF LocationCode = '' THEN
            Location.INIT
        ELSE
            IF Location.Code <> LocationCode THEN
                Location.GET(LocationCode);
    end;

    procedure SetBreakbulkFilter(BreakbulkFilter2: Boolean)
    begin
        BreakbulkFilter := BreakbulkFilter2;
    end;

    procedure SetInventory(SetHideOptions: Boolean)
    begin
        HideOptions := SetHideOptions;
    end;

}

