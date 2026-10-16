report 60033 "Picking List New"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Picking List.rdl';
    Caption = 'Picking List';
    PaperSourceDefaultPage = Upper;

    dataset
    {
        dataitem("Warehouse Activity Header"; "Warehouse Activity Header")
        {
            DataItemTableView = SORTING(Type, "No.")
                                WHERE(Type = FILTER(Pick | "Invt. Pick"));



            RequestFilterFields = "No.", "No. Printed";
            column(No_WhseActivHeader; "No.")
            {
            }
            column(DestinationNo; "Warehouse Activity Header"."Destination No.")
            {
            }
            column(ExternalDocNo; "Warehouse Activity Header"."External Document No.")
            {
            }
            column(ShiptoWarecode; "Warehouse Activity Header"."Ship-to code")
            {

            }
            // column(WMSMgt; WMSMgt.GetDestinationName("Warehouse Activity Header"."Destination Type", "Warehouse Activity Header"."Destination No."))
            // {
            // }
            column(WMSMgt; "Warehouse Activity Header"."Destination Type")
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
            column(AssignUserid; "Warehouse Activity Header"."Assigned User ID")
            {
            }
            column(ShippingMethod; "Warehouse Activity Header"."Shipping Method")
            {
            }
            column(Requeated_Delivery_Date; FORMAT("Warehouse Activity Header"."Requested Delivery Date"))
            {
            }

            column(Location_Code; "Warehouse Activity Header"."Location Code")
            {
            }
            column(Promised_Delivery_Date; FORMAT("Warehouse Activity Header"."Promised Delivery Date"))
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
                column(No_WhseActivHeaderCaption; "Warehouse Activity Header".FIELDCAPTION("No."))
                {
                }
                column(WhseActivHeaderCaption; "Warehouse Activity Header".TABLECAPTION + ': ' + PickFilter)
                {
                }
                column(LoctnCode_WhseActivHeader; "Warehouse Activity Header"."Location Code")
                {
                }
                column(SortingMtd_WhseActivHeader; "Warehouse Activity Header"."Sorting Method")
                {
                }
                column(AssgUserID_WhseActivHeader; "Warehouse Activity Header"."Assigned User ID")
                {
                }
                column(SourcDocument_WhseActLine; "Warehouse Activity Line"."Source Document")
                {
                }
                column(LoctnCode_WhseActivHeaderCaption; "Warehouse Activity Header".FIELDCAPTION("Location Code"))
                {
                }
                column(SortingMtd_WhseActivHeaderCaption; "Warehouse Activity Header".FIELDCAPTION("Sorting Method"))
                {
                }
                column(AssgUserID_WhseActivHeaderCaption; "Warehouse Activity Header".FIELDCAPTION("Assigned User ID"))
                {
                }
                column(SourcDocument_WhseActLineCaption; "Warehouse Activity Line".FIELDCAPTION("Source Document"))
                {
                }
                column(SourceNo_WhseActLineCaption; WhseActLine.FIELDCAPTION("Source No."))
                {
                }
                column(ShelfNo_WhseActLineCaption; WhseActLine.FIELDCAPTION("Shelf No."))
                {
                }
                column(VariantCode_WhseActLineCaption; WhseActLine.FIELDCAPTION("Variant Code"))
                {
                }
                column(Description_WhseActLineCaption; WhseActLine.FIELDCAPTION(Description))
                {
                }
                column(ItemNo_WhseActLineCaption; WhseActLine.FIELDCAPTION("Item No."))
                {
                }
                column(UOMCode_WhseActLineCaption; WhseActLine.FIELDCAPTION("Unit of Measure Code"))
                {
                }
                column(QtytoHandle_WhseActLineCaption; WhseActLine.FIELDCAPTION("Qty. to Handle"))
                {
                }
                column(QtyBase_WhseActLineCaption; WhseActLine.FIELDCAPTION("Qty. (Base)"))
                {
                }
                column(DestinatnType_WhseActLineCaption; WhseActLine.FIELDCAPTION("Destination Type"))
                {
                }
                column(DestinationNo_WhseActLineCaption; WhseActLine.FIELDCAPTION("Destination No."))
                {
                }
                column(ZoneCode_WhseActLineCaption; WhseActLine.FIELDCAPTION("Zone Code"))
                {
                }
                column(BinCode_WhseActLineCaption; WhseActLine.FIELDCAPTION("Bin Code"))
                {
                }
                column(ActionType_WhseActLineCaption; WhseActLine.FIELDCAPTION("Action Type"))
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
                dataitem("Warehouse Activity Line"; "Warehouse Activity Line")
                {
                    DataItemLink = "Activity Type" = FIELD(Type),
                                   "No." = FIELD("No.");
                    DataItemLinkReference = "Warehouse Activity Header";
                    DataItemTableView = SORTING("Bin Code", "Location Code", "Action Type", "Breakbulk No.");

                    trigger OnAfterGetRecord()
                    begin
                        IF SumUpLines AND
                           ("Warehouse Activity Header"."Sorting Method" <>
                            "Warehouse Activity Header"."Sorting Method"::Document)
                        THEN BEGIN
                            IF TmpWhseActLine."No." = '' THEN BEGIN
                                TmpWhseActLine := "Warehouse Activity Line";
                                TmpWhseActLine.INSERT;
                                MARK(TRUE);
                            END ELSE BEGIN
                                TmpWhseActLine.SETCURRENTKEY("Activity Type", "No.", "Bin Code", "Breakbulk No.", "Action Type");
                                TmpWhseActLine.SETRANGE("Activity Type", "Activity Type");
                                TmpWhseActLine.SETRANGE("No.", "No.");
                                TmpWhseActLine.SETRANGE("Bin Code", "Bin Code");
                                TmpWhseActLine.SETRANGE("Item No.", "Item No.");
                                TmpWhseActLine.SETRANGE("Action Type", "Action Type");
                                TmpWhseActLine.SETRANGE("Variant Code", "Variant Code");
                                TmpWhseActLine.SETRANGE("Unit of Measure Code", "Unit of Measure Code");
                                TmpWhseActLine.SETRANGE("Due Date", "Due Date");
                                IF "Warehouse Activity Header"."Sorting Method" =
                                   "Warehouse Activity Header"."Sorting Method"::"Ship-To"
                                THEN BEGIN
                                    TmpWhseActLine.SETRANGE("Destination Type", "Destination Type");
                                    TmpWhseActLine.SETRANGE("Destination No.", "Destination No.")
                                END;
                                IF TmpWhseActLine.FINDFIRST THEN BEGIN
                                    TmpWhseActLine."Qty. (Base)" := TmpWhseActLine."Qty. (Base)" + "Qty. (Base)";
                                    TmpWhseActLine."Qty. to Handle" := TmpWhseActLine."Qty. to Handle" + "Qty. to Handle";
                                    TmpWhseActLine."Source No." := '';
                                    IF "Warehouse Activity Header"."Sorting Method" <>
                                       "Warehouse Activity Header"."Sorting Method"::"Ship-To"
                                    THEN BEGIN
                                        TmpWhseActLine."Destination Type" := TmpWhseActLine."Destination Type"::" ";
                                        TmpWhseActLine."Destination No." := '';
                                    END;
                                    TmpWhseActLine.MODIFY;
                                END ELSE BEGIN
                                    TmpWhseActLine := "Warehouse Activity Line";
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
                        TmpWhseActLine.SETRANGE("Activity Type", "Warehouse Activity Header".Type);
                        TmpWhseActLine.SETRANGE("No.", "Warehouse Activity Header"."No.");
                        TmpWhseActLine.DELETEALL;
                        IF BreakbulkFilter THEN
                            TmpWhseActLine.SETRANGE("Original Breakbulk", FALSE);
                        CLEAR(TmpWhseActLine);
                    end;
                }
                dataitem(WhseActLine; "Warehouse Activity Line")
                {
                    DataItemLink = "Activity Type" = FIELD(Type),
                                  "No." = FIELD("No.");
                    DataItemLinkReference = "Warehouse Activity Header";
                    DataItemTableView = SORTING("Bin Code", "Location Code", "Action Type", "Breakbulk No.");
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
                    column(QtytoHandle_WhseActLine; "Qty. to Handle")
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
                    column(BinRanking_WhseActLine; "Bin Ranking")
                    {
                    }
                    column(EmptyStringCaption; EmptyStringCaptionLbl)
                    {
                    }
                    column(LotNo; WhseActLine."Lot No.")
                    {
                    }
                    column(Expirationdate; WhseActLine."Expiration Date")
                    {
                    }
                    column("Count"; WhseActLine.COUNT)
                    {
                    }
                    column(Quantity_whactline; Quantity)
                    {
                    }
                    column(SumQty; Qty)
                    {
                    }
                    dataitem(WhseActLine2; 5767)
                    {
                        DataItemLink = "Activity Type" = FIELD("Activity Type"),
                                       "No." = FIELD("No."),
                                       "Bin Code" = FIELD("Bin Code"),
                                       "Item No." = FIELD("Item No."),
                                       "Action Type" = FIELD("Action Type"),
                                       "Variant Code" = FIELD("Variant Code"),
                                       "Unit of Measure Code" = FIELD("Unit of Measure Code"),
                                       "Due Date" = FIELD("Due Date");
                        DataItemLinkReference = WhseActLine;
                        DataItemTableView = SORTING("Activity Type", "No.", "Bin Code", "Breakbulk No.", "Action Type");
                        column(LotNo_WhseActLine2; "Lot No.")
                        {
                        }
                        column(SerialNo_WhseActLine2; "Serial No.")
                        {
                        }
                        column(QtyBase_WhseActLine2; "Qty. (Base)")
                        {
                        }
                        column(QtytoHandle_WhseActLine2; "Qty. to Handle")
                        {
                        }
                        column(LineNo_WhseActLine2; "Line No.")
                        {
                        }
                    }

                    trigger OnAfterGetRecord()
                    begin
                        IF SumUpLines THEN BEGIN
                            TmpWhseActLine.GET("Activity Type", "No.", "Line No.");
                            "Qty. (Base)" := TmpWhseActLine."Qty. (Base)";
                            "Qty. to Handle" := TmpWhseActLine."Qty. to Handle";
                        END;
                        Lotno2 := "Warehouse Activity Line"."Lot No." + '-P';
                        Batch := 'Batch No.';

                        //Qty := 0 ;
                        Qty := Qty + "Warehouse Activity Line".Quantity;
                        //MESSAGE(FORMAT(Qty));
                        //Qty +=WhseActLine.Quantity;
                    end;

                    trigger OnPreDataItem()
                    begin
                        COPY("Warehouse Activity Line");
                        Counter := COUNT;
                        IF Counter = 0 THEN
                            CurrReport.BREAK;

                        IF BreakbulkFilter THEN
                            SETRANGE("Original Breakbulk", FALSE);
                    end;
                }
            }

            trigger OnAfterGetRecord()
            begin
                CompInfo.GET;
                CompInfo.CALCFIELDS(CompInfo.Picture);

                GetLocation("Location Code");
                InvtPick := Type = Type::"Invt. Pick";

                IF NOT CurrReport.PREVIEW THEN
                    WhseCountPrinted.RUN("Warehouse Activity Header");

                // Calculate after Whse.-Printed: its Find() re-reads the record and clears FlowFields
                CALCFIELDS("Shipping Method", "Requested Delivery Date", "Promised Delivery Date");


                IF Salesorder.GET(Salesorder."Document Type"::Order, "Warehouse Activity Header"."Source No.") THEN BEGIN
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
                recWhseActLine.SETRANGE(recWhseActLine."Activity Type", recWhseActLine."Activity Type"::"Invt. Pick");
                recWhseActLine.SETRANGE(recWhseActLine."No.", "Warehouse Activity Header"."No.");
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
                        ApplicationArea = All;
                        Caption = 'Set Breakbulk Filter';
                        Editable = BreakbulkEditable;
                    }
                    field(SumUpLines; SumUpLines)
                    {
                        ApplicationArea = All;
                        Caption = 'Sum up Lines';
                        Editable = SumUpLinesEditable;
                    }
                    field(LotSerialNo; ShowLotSN)
                    {
                        ApplicationArea = All;
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
        PickFilter := "Warehouse Activity Header".GETFILTERS;
    end;

    var
        Location: Record 14;
        TmpWhseActLine: Record 5767 temporary;
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
        recWhseActLine: Record 5767;
        Qty2: Decimal;
        CompInfo: Record 79;
        abc: report "Inventory Picking List";
        abc1: report "Picking List";
        ShippingMethod: code[20];
        RequestedDeliveryDate: date;
        PromisedDeliveryDate: date;
        R:Report 7303;

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

