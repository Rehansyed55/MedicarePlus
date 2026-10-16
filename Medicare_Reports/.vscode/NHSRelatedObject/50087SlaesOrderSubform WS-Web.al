page 60030 "Sales Order Subform WS-Web"
{
    // version NAVW113.07

    AutoSplitKey = true;
    Caption = 'Lines';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Sales Line";
    SourceTableView = WHERE("Document Type" = FILTER(Order));

    layout
    {
        area(content)
        {
            repeater(lines)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the type of entity that will be posted for this sales line, such as Item, Resource, or G/L Account.';

                    trigger OnValidate()
                    begin
                        NoOnAfterValidate;
                        SetLocationCodeMandatory;
                        UpdateEditableOnRow;
                        UpdateTypeText;
                        DeltaUpdateTotals;
                    end;
                }
                field(FilteredTypeField; TypeAsText)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Type';
                    Editable = CurrPageIsEditable;
                    LookupPageID = "Option Lookup List";
                    TableRelation = "Option Lookup Buffer"."Option Caption" WHERE("Lookup Type" = CONST(Sales));
                    ToolTip = 'Specifies the type of transaction that will be posted with the document line. If you select Comment, then you can enter any text in the Description field, such as a message to a customer. ';
                    Visible = IsFoundation;

                    trigger OnValidate()
                    begin
                        TempOptionLookupBuffer.SetCurrentType(Rec.Type);
                        IF TempOptionLookupBuffer.AutoCompleteLookup(TypeAsText, TempOptionLookupBuffer."Lookup Type"::Sales) THEN
                            Rec.VALIDATE(Type, TempOptionLookupBuffer.ID);
                        TempOptionLookupBuffer.ValidateOption(TypeAsText);
                        UpdateEditableOnRow;
                        UpdateTypeText;
                        DeltaUpdateTotals;
                    end;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = NOT IsCommentLine;
                    ToolTip = 'Specifies the number of a general ledger account, item, resource, additional cost, or fixed asset, depending on the contents of the Type field.';

                    trigger OnValidate()
                    begin
                        NoOnAfterValidate;
                        UpdateEditableOnRow;
                        Rec.ShowShortcutDimCode(ShortcutDimCode);

                        QuantityOnAfterValidate;
                        UpdateTypeText;
                        DeltaUpdateTotals;
                    end;
                }
                field("Cross-Reference No."; Rec."Item Reference No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the cross-referenced item number. If you enter a cross reference between yours and your vendor''s or customer''s item number, then this number will override the standard item number when you enter the cross-reference number on a sales or purchase document.';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        // "Cross-Reference No." was replaced by "Item Reference No." in modern BC; lookup is now handled automatically via the field's own table relation, so the old CrossReferenceNoLookUp table method (removed by Microsoft) is no longer called here.
                        NoOnAfterValidate;
                        OnCrossReferenceNoOnLookup(Rec);
                    end;

                    trigger OnValidate()
                    begin
                        NoOnAfterValidate;
                    end;
                }
                field("IC Partner Code"; Rec."IC Partner Code")
                {
                    ApplicationArea = Intercompany;
                    ToolTip = 'Specifies the code of the intercompany partner that the transaction is related to if the entry was created from an intercompany transaction.';
                    Visible = false;
                }
                field("IC Partner Ref. Type"; Rec."IC Partner Ref. Type")
                {
                    ApplicationArea = Intercompany;
                    ToolTip = 'Specifies the item or account in your IC partner''s company that corresponds to the item or account on the line.';
                    Visible = false;
                }
                field("IC Partner Reference"; Rec."IC Partner Reference")
                {
                    ApplicationArea = Intercompany;
                    ToolTip = 'Specifies the IC partner. If the line is being sent to one of your intercompany partners, this field is used together with the IC Partner Ref. Type field to indicate the item or account in your partner''s company that corresponds to the line.';
                    Visible = false;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = Planning;
                    ToolTip = 'Specifies the variant of the item on the line.';
                    Visible = false;

                    trigger OnValidate()
                    begin
                        VariantCodeOnAfterValidate;
                    end;
                }
                field("Substitution Available"; Rec."Substitution Available")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies that a substitute is available for the item on the sales line.';
                    Visible = false;
                }
                field("Purchasing Code"; Rec."Purchasing Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies which purchaser is assigned to the vendor.';
                    Visible = false;
                }
                field(Nonstock; Rec.Nonstock)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies that this item is a catalog item.';
                    Visible = false;
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the VAT product posting group. Links business transactions made for the item, resource, or G/L account with the general ledger, to account for VAT amounts resulting from trade with that record.';
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    QuickEntry = false;
                    ShowMandatory = NOT IsCommentLine;
                    ToolTip = 'Specifies a description of the entry of the product to be sold. To add a non-transactional text line, fill in the Description field only.';

                    trigger OnValidate()
                    begin
                        UpdateEditableOnRow;

                        IF Rec."No." = xRec."No." THEN
                            EXIT;

                        NoOnAfterValidate;
                        Rec.ShowShortcutDimCode(ShortcutDimCode);
                        UpdateTypeText;
                        DeltaUpdateTotals;
                    end;
                }
                field("Drop Shipment"; Rec."Drop Shipment")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies if your vendor ships the items directly to your customer.';
                    Visible = false;
                }
                field("Special Order"; Rec."Special Order")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies that the item on the sales line is a special-order item.';
                    Visible = false;
                }
                field("Return Reason Code"; Rec."Return Reason Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the code explaining why the item was returned.';
                    Visible = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = Location;
                    Editable = NOT IsCommentLine;
                    Enabled = NOT IsCommentLine;
                    QuickEntry = false;
                    ShowMandatory = LocationCodeMandatory;
                    ToolTip = 'Specifies the inventory location from which the items sold should be picked and where the inventory decrease is registered.';
                    Visible = LocationCodeVisible;

                    trigger OnValidate()
                    begin

                        //CAS-05893-Q7W3X2 ++
                        IF COMPANYNAME = 'Chemilines Limited' THEN BEGIN
                            IF Rec.Type = 2 THEN BEGIN
                                IF (Rec."Location Code" <> 'FREE') AND (Rec."Location Code" <> 'CHEMILINES') THEN
                                    ERROR(Text002);
                            END;
                        END;
                        //CAS-05893-Q7W3X2--

                        LocationCodeOnAfterValidate;
                    end;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = Warehouse;
                    ToolTip = 'Specifies the bin where the items are picked or put away.';
                    Visible = false;
                }
                field(Reserve; Rec.Reserve)
                {
                    ApplicationArea = Reservation;
                    ToolTip = 'Specifies whether a reservation can be made for items on this line.';
                    Visible = false;

                    trigger OnValidate()
                    begin
                        ReserveOnAfterValidate;
                    end;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = Basic, Suite;
                    BlankZero = true;
                    Editable = NOT IsCommentLine;
                    Enabled = NOT IsCommentLine;
                    ShowMandatory = (NOT IsCommentLine) AND (Rec."No." <> '');
                    ToolTip = 'Specifies how many units are being sold.';

                    trigger OnValidate()
                    begin
                        QuantityOnAfterValidate;
                        DeltaUpdateTotals;
                    end;
                }
                field("Batch Qty"; Rec."Batch Qty")
                {
                    ApplicationArea = All;
                    Visible = false;

                    trigger OnAssistEdit()
                    begin

                        //ReserveSalesLine.CallItemTracking(Rec);
                        //anikEt++
                        CLEAR(recTrackingSpecification);
                        recTrackingSpecification.DELETEALL;//5Feb2014
                        TotalItemTrackingLine.DELETEALL;//5Feb2014
                        COMMIT;
                        recTrackingSpecification.RESET;


                        //MESSAGE('InitTracking Qty=%1 \ SL QTY=%2',recTrackingSpecification."Quantity (Base)",Quantity);



                        //MaxQuantity:=Quantity;
                        //ItemTrackingDataCollection.SelectMultipleLotSerialNo1(recTrackingSpecification,MaxQuantity,0);
                        //ItemTrackingDataCollection.SelectMultipleLotSerialNo(recTrackingSpecification,MaxQuantity,0);
                        //MESSAGE('SelectMultiple \ Qty=%1 \ SL QTY=%2',recTrackingSpecification."Quantity (Base)",Quantity);
                        CLEAR(SelectedQty);
                        CLEAR(QTY);
                        CLEAR(Qty_Old);
                        CLEAR(recReservationEntry);
                        recReservationEntry.RESET;
                        recReservationEntry.SETRANGE(recReservationEntry."Item No.", Rec."No.");
                        recReservationEntry.SETRANGE(recReservationEntry."Location Code", Rec."Location Code");
                        recReservationEntry.SETRANGE(recReservationEntry."Source Type", 37);
                        recReservationEntry.SETRANGE(recReservationEntry."Source Subtype", 1);
                        recReservationEntry.SETRANGE(recReservationEntry."Source ID", Rec."Document No.");
                        recReservationEntry.SETRANGE(recReservationEntry."Source Ref. No.", Rec."Line No.");
                        IF recReservationEntry.FINDFIRST THEN BEGIN
                            REPEAT
                                //MESSAGE('Before %1',recReservationEntry.COUNT);
                                //recReservationEntry.DELETEALL;
                                Qty_Old += ABS(recReservationEntry.Quantity);
                            UNTIL recReservationEntry.NEXT = 0;
                        END;

                        //ReserveSalesLine.InitTrackingSpecification(Rec,recTrackingSpecification);  //Sofyan

                        //MESSAGE('After %1 \ Qty=%2 \ SL QTY=%3',recReservationEntry.COUNT,recTrackingSpecification."Quantity (Base)",Quantity);


                        IF (Rec.Quantity - Qty_Old) > 0 THEN
                            QTY := Rec.Quantity - Qty_Old;



                        //MESSAGE('%1',    recTrackingSpecification);

                        SelectEntries;



                        CurrPage.UPDATE(TRUE);


                        //MESSAGE('%1',SelectedQty);
                        //------------------------------------------------------------------
                        //Blocked on 05Feb2014
                        /*
                        IF (FlagLookUp) AND (SelectedQty>0) THEN
                        BEGIN
                        CreateReservEntry.CreateReservEntryFor(
                                recTrackingSpecification."Source Type",
                                recTrackingSpecification."Source Subtype",
                                recTrackingSpecification."Source ID",
                                recTrackingSpecification."Source Batch Name",
                                recTrackingSpecification."Source Prod. Order Line",
                                recTrackingSpecification."Source Ref. No.",
                                recTrackingSpecification."Qty. per Unit of Measure",
                                0,
                                SelectedQty,
                                recTrackingSpecification."Serial No.",
                                recTrackingSpecification."Lot No.");
                        
                        
                              CreateReservEntry.CreateEntry(recTrackingSpecification."Item No.",
                                recTrackingSpecification."Variant Code",
                                recTrackingSpecification."Location Code",
                                recTrackingSpecification.Description,
                                0D,
                                0D,0,2);
                        END;
                        */
                        /*
                        CreateReservEntry.CreateReservEntryFor(
                                OldTrackingSpecification."Source Type",
                                OldTrackingSpecification."Source Subtype",
                                OldTrackingSpecification."Source ID",
                                OldTrackingSpecification."Source Batch Name",
                                OldTrackingSpecification."Source Prod. Order Line",
                                OldTrackingSpecification."Source Ref. No.",
                                OldTrackingSpecification."Qty. per Unit of Measure",
                                0,
                                OldTrackingSpecification."Quantity (Base)",
                                OldTrackingSpecification."Serial No.",
                                OldTrackingSpecification."Lot No.");
                        
                              CreateReservEntry.CreateEntry(OldTrackingSpecification."Item No.",
                                OldTrackingSpecification."Variant Code",
                                OldTrackingSpecification."Location Code",
                                OldTrackingSpecification.Description,
                                ExpectedReceiptDate,
                                ShipmentDate,0,CurrentEntryStatus);
                        */




                        //

                        //

                        //ItemTrackingDataCollection.RetrieveLookupData(recTrackingSpecification,TRUE);

                    end;
                }
                field("Qty. to Assemble to Order"; Rec."Qty. to Assemble to Order")
                {
                    ApplicationArea = Assembly;
                    BlankZero = true;
                    ToolTip = 'Specifies how many units of the sales line quantity that you want to supply by assembly.';
                    Visible = false;

                    trigger OnDrillDown()
                    begin
                        Rec.ShowAsmToOrderLines;
                    end;

                    trigger OnValidate()
                    begin
                        QtyToAsmToOrderOnAfterValidate;
                    end;
                }
                field("Reserved Quantity"; Rec."Reserved Quantity")
                {
                    ApplicationArea = Reservation;
                    BlankZero = true;
                    QuickEntry = false;
                    ToolTip = 'Specifies how many units of the item on the line have been reserved.';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = UnitofMeasureCodeIsChangeable;
                    Enabled = UnitofMeasureCodeIsChangeable;
                    QuickEntry = false;
                    ToolTip = 'Specifies how each unit of the item or resource is measured, such as in pieces or hours. By default, the value in the Base Unit of Measure field on the item or resource card is inserted.';

                    trigger OnValidate()
                    begin
                        UnitofMeasureCodeOnAfterValida;
                    end;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the unit of measure for the item or resource on the sales line.';
                    Visible = false;
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the unit cost of the item on the line.';
                    Visible = false;
                }
                field(SalesPriceExist; rec.PriceExists)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Price Exists';
                    Editable = false;
                    ToolTip = 'Specifies that there is a specific price for this customer.';
                    Visible = false;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = Basic, Suite;
                    BlankZero = true;
                    Editable = NOT IsCommentLine;
                    Enabled = NOT IsCommentLine;
                    ShowMandatory = (NOT IsCommentLine) AND (Rec."No." <> '');
                    ToolTip = 'Specifies the price for one unit on the sales line.';

                    trigger OnValidate()
                    begin
                        DeltaUpdateTotals;
                    end;
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    ApplicationArea = Basic, Suite;
                    BlankZero = true;
                    Editable = false;
                    Enabled = NOT IsCommentLine;
                    ToolTip = 'Specifies the discount percentage that is granted for the item on the line.';
                    Visible = false;

                    trigger OnValidate()
                    begin
                        DeltaUpdateTotals;
                    end;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = Basic, Suite;
                    BlankZero = true;
                    Editable = NOT IsCommentLine;
                    Enabled = NOT IsCommentLine;
                    ShowMandatory = (NOT IsCommentLine) AND (Rec."No." <> '');
                    ToolTip = 'Specifies the net amount, excluding any invoice discount amount, that must be paid for products on the line.';

                    trigger OnValidate()
                    begin
                        DeltaUpdateTotals;
                    end;
                }
                field(SalesLineDiscExists; rec.LineDiscExists)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Line Disc. Exists';
                    Editable = false;
                    ToolTip = 'Specifies that there is a specific discount for this customer.';
                    Visible = false;
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the discount amount that is granted for the item on the line.';
                    Visible = false;

                    trigger OnValidate()
                    begin
                        DeltaUpdateTotals;
                    end;
                }
                field("Prepayment %"; Rec."Prepayment %")
                {
                    ApplicationArea = Prepayments;
                    ToolTip = 'Specifies the prepayment percentage to use to calculate the prepayment for sales.';
                    Visible = false;
                }
                field("Prepmt. Line Amount"; Rec."Prepmt. Line Amount")
                {
                    ApplicationArea = Prepayments;
                    ToolTip = 'Specifies the prepayment amount of the line in the currency of the sales document if a prepayment percentage is specified for the sales line.';
                    Visible = false;
                }
                field("Prepmt. Amt. Inv."; Rec."Prepmt. Amt. Inv.")
                {
                    ApplicationArea = Prepayments;
                    ToolTip = 'Specifies the prepayment amount that has already been invoiced to the customer for this sales line.';
                    Visible = false;
                }
                field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies if the invoice line is included when the invoice discount is calculated.';
                    Visible = false;

                    trigger OnValidate()
                    begin
                        CurrPage.SAVERECORD;
                        AmountWithDiscountAllowed := DocumentTotals.CalcTotalSalesAmountOnlyDiscountAllowed(Rec);
                        InvoiceDiscountAmount := ROUND(AmountWithDiscountAllowed * InvoiceDiscountPct / 100, Currency."Amount Rounding Precision");
                        ValidateInvoiceDiscountAmount;
                    end;
                }
                field("Inv. Discount Amount"; Rec."Inv. Discount Amount")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the total calculated invoice discount amount for the line.';
                    Visible = false;
                }
                field("Inv. Disc. Amount to Invoice"; Rec."Inv. Disc. Amount to Invoice")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the actual invoice discount amount that will be posted for the line in next invoice.';
                    Visible = false;
                }
                field("Qty. to Ship"; Rec."Qty. to Ship")
                {
                    ApplicationArea = Basic, Suite;
                    BlankZero = true;
                    ToolTip = 'Specifies the quantity of items that remain to be shipped.';

                    trigger OnValidate()
                    begin
                        IF Rec."Qty. to Asm. to Order (Base)" <> 0 THEN BEGIN
                            CurrPage.SAVERECORD;
                            CurrPage.UPDATE(FALSE);
                        END;
                    end;
                }
                field("Quantity Shipped"; Rec."Quantity Shipped")
                {
                    ApplicationArea = Basic, Suite;
                    BlankZero = true;
                    QuickEntry = false;
                    ToolTip = 'Specifies how many units of the item on the line have been posted as shipped.';
                }
                field("Qty. to Invoice"; Rec."Qty. to Invoice")
                {
                    ApplicationArea = Basic, Suite;
                    BlankZero = true;
                    ToolTip = 'Specifies the quantity that remains to be invoiced. It is calculated as Quantity - Qty. Invoiced.';
                }
                field("Quantity Invoiced"; Rec."Quantity Invoiced")
                {
                    ApplicationArea = Basic, Suite;
                    BlankZero = true;
                    ToolTip = 'Specifies how many units of the item on the line have been posted as invoiced.';
                }
                field("Prepmt Amt to Deduct"; Rec."Prepmt Amt to Deduct")
                {
                    ApplicationArea = Prepayments;
                    ToolTip = 'Specifies the prepayment amount that has already been deducted from ordinary invoices posted for this sales order line.';
                    Visible = false;
                }
                field("Prepmt Amt Deducted"; Rec."Prepmt Amt Deducted")
                {
                    ApplicationArea = Prepayments;
                    ToolTip = 'Specifies the prepayment amount that has already been deducted from ordinary invoices posted for this sales order line.';
                    Visible = false;
                }
                field("Allow Item Charge Assignment"; Rec."Allow Item Charge Assignment")
                {
                    ApplicationArea = ItemCharges;
                    ToolTip = 'Specifies that you can assign item charges to this line.';
                    Visible = false;
                }
                field("Qty. to Assign"; Rec."Qty. to Assign")
                {
                    ApplicationArea = ItemCharges;
                    QuickEntry = false;
                    StyleExpr = ItemChargeStyleExpression;
                    ToolTip = 'Specifies how many units of the item charge will be assigned to the line.';

                    trigger OnDrillDown()
                    begin
                        CurrPage.SAVERECORD;
                        Rec.ShowItemChargeAssgnt;
                        UpdateForm(FALSE);
                    end;
                }
                field("Qty. Assigned"; Rec."Qty. Assigned")
                {
                    ApplicationArea = ItemCharges;
                    BlankZero = true;
                    QuickEntry = false;
                    ToolTip = 'Specifies the quantity of the item charge that was assigned to a specified item when you posted this sales line.';

                    trigger OnDrillDown()
                    begin
                        CurrPage.SAVERECORD;
                        Rec.ShowItemChargeAssgnt;
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                field("Requested Delivery Date"; Rec."Requested Delivery Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the date that the customer has asked for the order to be delivered.';
                    Visible = false;

                    trigger OnValidate()
                    begin
                        UpdateForm(TRUE);
                    end;
                }
                field("Promised Delivery Date"; Rec."Promised Delivery Date")
                {
                    ApplicationArea = OrderPromising;
                    ToolTip = 'Specifies the date that you have promised to deliver the order, as a result of the Order Promising function.';
                    Visible = false;

                    trigger OnValidate()
                    begin
                        UpdateForm(TRUE);
                    end;
                }
                field("Planned Delivery Date"; Rec."Planned Delivery Date")
                {
                    ApplicationArea = Planning;
                    QuickEntry = false;
                    ToolTip = 'Specifies the planned date that the shipment will be delivered at the customer''s address. If the customer requests a delivery date, the program calculates whether the items will be available for delivery on this date. If the items are available, the planned delivery date will be the same as the requested delivery date. If not, the program calculates the date that the items are available for delivery and enters this date in the Planned Delivery Date field.';

                    trigger OnValidate()
                    begin
                        UpdateForm(TRUE);
                    end;
                }
                field("Planned Shipment Date"; Rec."Planned Shipment Date")
                {
                    ApplicationArea = Planning;
                    ToolTip = 'Specifies the date that the shipment should ship from the warehouse. If the customer requests a delivery date, the program calculates the planned shipment date by subtracting the shipping time from the requested delivery date. If the customer does not request a delivery date or the requested delivery date cannot be met, the program calculates the content of this field by adding the shipment time to the shipping date.';

                    trigger OnValidate()
                    begin
                        UpdateForm(TRUE);
                    end;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = Basic, Suite;
                    QuickEntry = false;
                    ToolTip = 'Specifies when items on the document are shipped or were shipped. A shipment date is usually calculated from a requested delivery date plus lead time.';

                    trigger OnValidate()
                    begin
                        ShipmentDateOnAfterValidate;
                    end;
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the code for the shipping agent who is transporting the items.';
                    Visible = false;
                }
                field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the code for the service, such as a one-day delivery, that is offered by the shipping agent.';
                    Visible = false;
                }
                field("Shipping Time"; Rec."Shipping Time")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies how long it takes from when the items are shipped from the warehouse to when they are delivered.';
                    Visible = false;
                }
                field("Work Type Code"; Rec."Work Type Code")
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies which work type the resource applies to when the sale is related to a job.';
                    Visible = false;
                }
                field("Whse. Outstanding Qty."; Rec."Whse. Outstanding Qty.")
                {
                    ApplicationArea = Warehouse;
                    ToolTip = 'Specifies how many units on the sales order line remain to be handled in warehouse documents.';
                    Visible = false;
                }
                field("Whse. Outstanding Qty. (Base)"; Rec."Whse. Outstanding Qty. (Base)")
                {
                    ApplicationArea = Warehouse;
                    ToolTip = 'Specifies how many units on the sales order line remain to be handled in warehouse documents.';
                    Visible = false;
                }
                field("ATO Whse. Outstanding Qty."; Rec."ATO Whse. Outstanding Qty.")
                {
                    ApplicationArea = Warehouse;
                    ToolTip = 'Specifies how many assemble-to-order units on the sales order line need to be assembled and handled in warehouse documents.';
                    Visible = false;
                }
                field("ATO Whse. Outstd. Qty. (Base)"; Rec."ATO Whse. Outstd. Qty. (Base)")
                {
                    ApplicationArea = Warehouse;
                    ToolTip = 'Specifies how many assemble-to-order units on the sales order line remain to be assembled and handled in warehouse documents.';
                    Visible = false;
                }
                field("Outbound Whse. Handling Time"; Rec."Outbound Whse. Handling Time")
                {
                    ApplicationArea = Warehouse;
                    ToolTip = 'Specifies a date formula for the time it takes to get items ready to ship from this location. The time element is used in the calculation of the delivery date as follows: Shipment Date + Outbound Warehouse Handling Time = Planned Shipment Date + Shipping Time = Planned Delivery Date.';
                    Visible = false;
                }
                field("Blanket Order No."; Rec."Blanket Order No.")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the number of the blanket order that the record originates from.';
                    Visible = false;
                }
                field("Blanket Order Line No."; Rec."Blanket Order Line No.")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the number of the blanket order line that the record originates from.';
                    Visible = false;
                }
                field("FA Posting Date"; Rec."FA Posting Date")
                {
                    ApplicationArea = FixedAssets;
                    ToolTip = 'Specifies the date that will be used on related fixed asset ledger entries.';
                    Visible = false;
                }
                field("Depr. until FA Posting Date"; Rec."Depr. until FA Posting Date")
                {
                    ApplicationArea = FixedAssets;
                    ToolTip = 'Specifies if depreciation was calculated until the FA posting date of the line.';
                    Visible = false;
                }
                field("<Depr. until FA Posting Date>"; Rec."Depreciation Book Code")
                {
                    ApplicationArea = FixedAssets;
                    ToolTip = 'Specifies the code for the depreciation book to which the line will be posted if you have selected Fixed Asset in the Type field for this line.';
                    Visible = false;
                }
                field("Use Duplication List"; Rec."Use Duplication List")
                {
                    ApplicationArea = FixedAssets;
                    ToolTip = 'Specifies, if the type is Fixed Asset, that information on the line is to be posted to all the assets defined depreciation books. ';
                    Visible = false;
                }
                field("Duplicate in Depreciation Book"; Rec."Duplicate in Depreciation Book")
                {
                    ApplicationArea = FixedAssets;
                    ToolTip = 'Specifies a depreciation book code if you want the journal line to be posted to that depreciation book, as well as to the depreciation book in the Depreciation Book Code field.';
                    Visible = false;
                }
                field("Appl.-from Item Entry"; Rec."Appl.-from Item Entry")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number of the item ledger entry that the document or journal line is applied from.';
                    Visible = false;
                }
                field("Appl.-to Item Entry"; Rec."Appl.-to Item Entry")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number of the item ledger entry that the document or journal line is applied -to.';
                    Visible = false;
                }
                field("Deferral Code"; Rec."Deferral Code")
                {
                    ApplicationArea = Suite;
                    Enabled = (Rec.Type <> Rec.Type::"Fixed Asset") AND (Rec.Type <> Rec.Type::" ");
                    TableRelation = "Deferral Template"."Deferral Code";
                    ToolTip = 'Specifies the deferral template that governs how revenue earned with this sales document is deferred to the different accounting periods when the good or service was delivered.';
                    Visible = false;

                    trigger OnAssistEdit()
                    begin
                        Rec.ShowDeferralSchedule;
                    end;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                    Visible = false;
                }
                field(ShortcutDimCode3; ShortcutDimCode[3])
                {
                    ApplicationArea = Suite;
                    CaptionClass = '1,2,3';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                    end;
                }
                field(ShortcutDimCode4; ShortcutDimCode[4])
                {
                    ApplicationArea = Suite;
                    CaptionClass = '1,2,4';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(4),
                                                                  "Dimension Value Type"=CONST(Standard),
                                                                  Blocked=CONST(false));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        rec.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                    end;
                }
                field(ShortcutDimCode5; ShortcutDimCode[5])
                {
                    ApplicationArea = Suite;
                    CaptionClass = '1,2,5';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(5),
                                                                  "Dimension Value Type"=CONST(Standard),
                                                                  Blocked=CONST(false));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        rec.ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                    end;
                }
                field(ShortcutDimCode6; ShortcutDimCode[6])
                {
                    ApplicationArea = Suite;
                    CaptionClass = '1,2,6';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(6),
                                                                  "Dimension Value Type"=CONST(Standard),
                                                                  Blocked=CONST(false));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        rec.ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                    end;
                }
                field(ShortcutDimCode7; ShortcutDimCode[7])
                {
                    ApplicationArea = Suite;
                    CaptionClass = '1,2,7';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(7),
                                                                  "Dimension Value Type"=CONST(Standard),
                                                                  Blocked=CONST(false));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        rec.ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                    end;
                }
                field(ShortcutDimCode8; ShortcutDimCode[8])
                {
                    ApplicationArea = Suite;
                    CaptionClass = '1,2,8';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(8),
                                                                  "Dimension Value Type"=CONST(Standard),
                                                                  Blocked=CONST(false));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        rec.ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the document number.';
                    Visible = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the line number.';
                    Visible = false;
                }
            }
            group(DiscountGroup)
            {
                Visible = false;
                group(InvoiceDiscount)
                {
                    Visible = false;
                    field("Invoice Discount Amount"; InvoiceDiscountAmount)
                    {
                        ApplicationArea = Basic, Suite;
                        AutoFormatExpression = rec."Currency Code";
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetInvoiceDiscAmountWithVATAndCurrencyCaption(rec.FIELDCAPTION("Inv. Discount Amount"), Currency.Code);
                        Caption = 'Invoice Discount Amount';
                        Editable = InvDiscAmountEditable;
                        ToolTip = 'Specifies a discount amount that is deducted from the value in the Total Incl. VAT field. You can enter or change the amount manually.';

                        trigger OnValidate()
                        begin
                            DocumentTotals.SalesDocTotalsNotUpToDate;
                            ValidateInvoiceDiscountAmount;
                        end;
                    }
                    field("Invoice Disc. Pct."; InvoiceDiscountPct)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Invoice Discount %';
                        DecimalPlaces = 0 : 3;
                        Editable = InvDiscAmountEditable;
                        ToolTip = 'Specifies a discount percentage that is granted if criteria that you have set up for the customer are met.';

                        trigger OnValidate()
                        begin
                            DocumentTotals.SalesDocTotalsNotUpToDate;
                            AmountWithDiscountAllowed := DocumentTotals.CalcTotalSalesAmountOnlyDiscountAllowed(Rec);
                            InvoiceDiscountAmount := ROUND(AmountWithDiscountAllowed * InvoiceDiscountPct / 100, Currency."Amount Rounding Precision");
                            ValidateInvoiceDiscountAmount;
                        end;
                    }
                }
                // group()
                // {
                //     Visible = false;
                // }
            }
            group(UpdateTotalsGroup)
            {
                Visible = false;
                field(UpdateTotalsMessage; '')
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ShowCaption = false;
                }
                field(UpdateTotals; '')
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ShowCaption = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(SelectMultiItems)
            {
                AccessByPermission = TableData 27 = R;
                ApplicationArea = Basic, Suite;
                Caption = 'Select items';
                Ellipsis = true;
                Image = NewItem;
                ToolTip = 'Add two or more items from the full list of your inventory items.';

                trigger OnAction()
                begin
                    Rec.SelectMultipleItems;
                end;
            }
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                group("F&unctions")
                {
                    Caption = 'F&unctions';
                    Image = "Action";
                    action(GetPrice)
                    {
                        AccessByPermission = TableData 7002 = R;
                        ApplicationArea = Basic, Suite;
                        Caption = 'Get Price';
                        Ellipsis = true;
                        Image = Price;
                        ToolTip = 'Insert the lowest possible price in the Unit Price field according to any special price that you have set up.';

                        trigger OnAction()
                        begin
                            ShowPrices;
                        end;
                    }
                    action("Get Li&ne Discount")
                    {
                        AccessByPermission = TableData 7004 = R;
                        ApplicationArea = Basic, Suite;
                        Caption = 'Get Li&ne Discount';
                        Ellipsis = true;
                        Image = LineDiscount;
                        ToolTip = 'Insert the best possible discount in the Line Discount field according to any special discounts that you have set up.';

                        trigger OnAction()
                        begin
                            ShowLineDisc
                        end;
                    }
                    action(ExplodeBOM_Functions)
                    {
                        AccessByPermission = TableData 90 = R;
                        ApplicationArea = Suite;
                        Caption = 'E&xplode BOM';
                        Image = ExplodeBOM;
                        ToolTip = 'Insert new lines for the components on the bill of materials, for example to sell the parent item as a kit. CAUTION: The line for the parent item will be deleted and represented by a description only. To undo, you must delete the component lines and add a line the parent item again.';

                        trigger OnAction()
                        begin
                            ExplodeBOM;
                        end;
                    }
                    action("Insert Ext. Texts")
                    {
                        AccessByPermission = TableData 279 = R;
                        ApplicationArea = Basic, Suite;
                        Caption = 'Insert &Ext. Texts';
                        Image = Text;
                        ToolTip = 'Insert the extended item description that is set up for the item that is being processed on the line.';

                        trigger OnAction()
                        begin
                            InsertExtendedText(TRUE);
                        end;
                    }
                    action(A_Reserve)
                    {
                        ApplicationArea = Reservation;
                        Caption = '&Reserve';
                        Ellipsis = true;
                        Image = Reserve;
                        ToolTip = 'Reserve the quantity that is required on the document line that you opened this window for.';

                        trigger OnAction()
                        begin
                            Rec.FIND;
                            Rec.ShowReservation;
                        end;
                    }
                    action(OrderTracking)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Order &Tracking';
                        Image = OrderTracking;
                        ToolTip = 'Tracks the connection of a supply to its corresponding demand. This can help you find the original demand that created a specific production order or purchase order.';

                        trigger OnAction()
                        begin
                            ShowTracking;
                        end;
                    }
                    action("Select Nonstoc&k Items")
                    {
                        AccessByPermission = TableData 5718 = R;
                        ApplicationArea = Basic, Suite;
                        Caption = 'Select Ca&talog Items';
                        Image = NonStockItem;
                        ToolTip = 'View the list of catalog items that exist in the system. ';

                        trigger OnAction()
                        begin
                            ShowNonstockItems;
                        end;
                    }
                }
                group("Item Availability by")
                {
                    Caption = 'Item Availability by';
                    Image = ItemAvailability;
                    action("<Action3>")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Event';
                        Image = "Event";
                        ToolTip = 'View how the actual and the projected available balance of an item will develop over time according to supply and demand events.';

                        trigger OnAction()
                        begin
                            SalesAvailabilityMgt.ShowItemAvailabilityFromSalesLine(Rec, "Item Availability Type"::"Event")
                        end;
                    }
                    action(ItemAvailabilityByPeriod)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Period';
                        Image = Period;
                        ToolTip = 'Show the projected quantity of the item over time according to time periods, such as day, week, or month.';

                        trigger OnAction()
                        begin
                            SalesAvailabilityMgt.ShowItemAvailabilityFromSalesLine(Rec, "Item Availability Type"::Period)
                        end;
                    }
                    action(ItemAvailabilityByVariant)
                    {
                        ApplicationArea = Planning;
                        Caption = 'Variant';
                        Image = ItemVariant;
                        ToolTip = 'View or edit the item''s variants. Instead of setting up each color of an item as a separate item, you can set up the various colors as variants of the item.';

                        trigger OnAction()
                        begin
                            SalesAvailabilityMgt.ShowItemAvailabilityFromSalesLine(Rec, "Item Availability Type"::Variant)
                        end;
                    }
                    action(ItemAvailabilityByLocation)
                    {
                        AccessByPermission = TableData 14 = R;
                        ApplicationArea = Location;
                        Caption = 'Location';
                        Image = Warehouse;
                        ToolTip = 'View the actual and projected quantity of the item per location.';

                        trigger OnAction()
                        begin
                            SalesAvailabilityMgt.ShowItemAvailabilityFromSalesLine(Rec, "Item Availability Type"::Location)
                        end;
                    }
                    action("BOM Level")
                    {
                        AccessByPermission = TableData 5870 = R;
                        ApplicationArea = Assembly;
                        Caption = 'BOM Level';
                        Image = BOMLevel;
                        ToolTip = 'View availability figures for items on bills of materials that show how many units of a parent item you can make based on the availability of child items.';

                        trigger OnAction()
                        begin
                            SalesAvailabilityMgt.ShowItemAvailabilityFromSalesLine(Rec, "Item Availability Type"::BOM)
                        end;
                    }
                }
                group("Related Information")
                {
                    Caption = 'Related Information';
                    action("Reservation Entries")
                    {
                        AccessByPermission = TableData 27 = R;
                        ApplicationArea = Reservation;
                        Caption = 'Reservation Entries';
                        Image = ReservationLedger;
                        ToolTip = 'View the entries for every reservation that is made, either manually or automatically.';

                        trigger OnAction()
                        begin
                            Rec.ShowReservationEntries(TRUE);
                        end;
                    }
                    action(ItemTrackingLines)
                    {
                        ApplicationArea = ItemTracking;
                        Caption = 'Item &Tracking Lines';
                        Image = ItemTrackingLines;
                        ShortCutKey = 'Shift+Ctrl+I';
                        ToolTip = 'View or edit serial numbers and lot numbers that are assigned to the item on the document or journal line.';

                        trigger OnAction()
                        begin
                            Rec.OpenItemTrackingLines;
                        end;
                    }
                    action(SelectItemSubstitution)
                    {
                        AccessByPermission = TableData 5715 = R;
                        ApplicationArea = Suite;
                        Caption = 'Select Item Substitution';
                        Image = SelectItemSubstitution;
                        ToolTip = 'Select another item that has been set up to be sold instead of the original item if it is unavailable.';

                        trigger OnAction()
                        begin
                            CurrPage.SAVERECORD;
                            Rec.ShowItemSub;
                            CurrPage.UPDATE(TRUE);
                            Rec.AutoReserve;
                        end;
                    }
                    action(Dimensions)
                    {
                        AccessByPermission = TableData 348 = R;
                        ApplicationArea = Dimensions;
                        Caption = 'Dimensions';
                        Image = Dimensions;
                        ShortCutKey = 'Shift+Ctrl+D';
                        ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                        trigger OnAction()
                        begin
                            Rec.ShowDimensions;
                        end;
                    }
                    action("Co&mments")
                    {
                        ApplicationArea = Comments;
                        Caption = 'Co&mments';
                        Image = ViewComments;
                        ToolTip = 'View or add comments for the record.';

                        trigger OnAction()
                        begin
                            Rec.ShowLineComments;
                        end;
                    }
                    action("Item Charge &Assignment")
                    {
                        AccessByPermission = TableData 5800 = R;
                        ApplicationArea = ItemCharges;
                        Caption = 'Item Charge &Assignment';
                        Image = ItemCosts;
                        ToolTip = 'Assign additional direct costs, for example for freight, to the item on the line.';

                        trigger OnAction()
                        begin
                            ItemChargeAssgnt;
                            SetItemChargeFieldsStyle;
                        end;
                    }
                    action(OrderPromising)
                    {
                        AccessByPermission = TableData 99000880 = R;
                        ApplicationArea = OrderPromising;
                        Caption = 'Order &Promising';
                        Image = OrderPromising;
                        ToolTip = 'Calculate the shipment and delivery dates based on the item''s known and expected availability dates, and then promise the dates to the customer.';

                        trigger OnAction()
                        begin
                            OrderPromisingLine;
                        end;
                    }
                    action(DocAttach)
                    {
                        ApplicationArea = All;
                        Caption = 'Attachments';
                        Image = Attach;
                        ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                        trigger OnAction()
                        var
                            DocumentAttachmentDetails: Page "Document Attachment Details";
                            RecRef: RecordRef;
                        begin
                            RecRef.GETTABLE(Rec);
                            DocumentAttachmentDetails.OpenForRecRef(RecRef);
                            DocumentAttachmentDetails.RUNMODAL;
                        end;
                    }
                    group("Assemble to Order")
                    {
                        Caption = 'Assemble to Order';
                        Image = AssemblyBOM;
                        action(AssembleToOrderLines)
                        {
                            AccessByPermission = TableData 90 = R;
                            ApplicationArea = Assembly;
                            Caption = 'Assemble-to-Order Lines';
                            ToolTip = 'View any linked assembly order lines if the documents represents an assemble-to-order sale.';

                            trigger OnAction()
                            begin
                                Rec.ShowAsmToOrderLines;
                            end;
                        }
                        action("Roll Up &Price")
                        {
                            AccessByPermission = TableData 90 = R;
                            ApplicationArea = Assembly;
                            Caption = 'Roll Up &Price';
                            Ellipsis = true;
                            ToolTip = 'Update the unit price of the assembly item according to any changes that you have made to the assembly components.';

                            trigger OnAction()
                            begin
                                Rec.RollupAsmPrice;
                            end;
                        }
                        action("Roll Up &Cost")
                        {
                            AccessByPermission = TableData 90 = R;
                            ApplicationArea = Assembly;
                            Caption = 'Roll Up &Cost';
                            Ellipsis = true;
                            ToolTip = 'Update the unit cost of the assembly item according to any changes that you have made to the assembly components.';

                            trigger OnAction()
                            begin
                                Rec.RollUpAsmCost;
                            end;
                        }
                    }
                    action(DocumentLineTracking)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Document &Line Tracking';
                        Image = Navigate;
                        ToolTip = 'View related open, posted, or archived documents or document lines. ';

                        trigger OnAction()
                        begin
                            ShowDocumentLineTracking;
                        end;
                    }
                    action(DeferralSchedule)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Deferral Schedule';
                        Enabled = Rec."Deferral Code" <> '';
                        Image = PaymentPeriod;
                        ToolTip = 'View or edit the deferral schedule that governs how revenue made with this sales document is deferred to different accounting periods when the document is posted.';

                        trigger OnAction()
                        begin
                            Rec.ShowDeferralSchedule;
                        end;
                    }
                }
            }
            group("O&rder")
            {
                Caption = 'O&rder';
                Image = "Order";
                group("Dr&op Shipment")
                {
                    Caption = 'Dr&op Shipment';
                    Image = Delivery;
                    action("Purchase &Order")
                    {
                        AccessByPermission = TableData 120 = R;
                        ApplicationArea = Suite;
                        Caption = 'Purchase &Order';
                        Image = Document;
                        ToolTip = 'View the purchase order that is linked to the sales order, for drop shipment or special order.';

                        trigger OnAction()
                        begin
                            OpenPurchOrderForm;
                        end;
                    }
                }
                group("Speci&al Order")
                {
                    Caption = 'Speci&al Order';
                    Image = SpecialOrder;
                    action(OpenSpecialPurchaseOrder)
                    {
                        AccessByPermission = TableData 120 = R;
                        ApplicationArea = Basic, Suite;
                        Caption = 'Purchase &Order';
                        Image = Document;
                        ToolTip = 'View the purchase order that is linked to the sales order, for drop shipment or special order.';

                        trigger OnAction()
                        begin
                            OpenSpecialPurchOrderForm;
                        end;
                    }
                }
                action(BlanketOrder)
                {
                    ApplicationArea = Suite;
                    Caption = 'Blanket Order';
                    Image = BlanketOrder;
                    ToolTip = 'View the blanket sales order.';

                    trigger OnAction()
                    var
                        SalesHeader: Record "Sales Header";
                        BlanketSalesOrder: Page "Blanket Sales Order";
                    begin
                        Rec.TESTFIELD("Blanket Order No.");
                        SalesHeader.SETRANGE("No.", Rec."Blanket Order No.");
                        IF NOT SalesHeader.ISEMPTY THEN BEGIN
                            BlanketSalesOrder.SETTABLEVIEW(SalesHeader);
                            BlanketSalesOrder.EDITABLE := FALSE;
                            BlanketSalesOrder.RUN;
                        END;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        GetTotalSalesHeader;
        CalculateTotals;
        SetLocationCodeMandatory;
        UpdateEditableOnRow;
        UpdateTypeText;
        SetItemChargeFieldsStyle;
    end;

    trigger OnAfterGetRecord()
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
        UpdateTypeText;
        SetItemChargeFieldsStyle;
    end;

    trigger OnDeleteRecord(): Boolean
    var
        ReserveSalesLine: Codeunit "Sales Line-Reserve";
    begin
        IF (Rec.Quantity <> 0) AND Rec.ItemExists(Rec."No.") THEN BEGIN
            COMMIT;
            IF NOT ReserveSalesLine.DeleteLineConfirm(Rec) THEN
                EXIT(FALSE);
            ReserveSalesLine.DeleteLine(Rec);
        END;
        DocumentTotals.SalesDocTotalsNotUpToDate;
    end;

    trigger OnFindRecord(Which: Text): Boolean
    begin
        DocumentTotals.SalesCheckAndClearTotals(Rec, xRec, TotalSalesLine, VATAmount, InvoiceDiscountAmount, InvoiceDiscountPct);
        EXIT(Rec.FIND(Which));
    end;

    trigger OnInit()
    var
        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
    begin
        SalesSetup.GET;
        InventorySetup.GET;
        Currency.InitRoundingPrecision;
        TempOptionLookupBuffer.FillLookupBuffer(TempOptionLookupBuffer."Lookup Type"::Sales);
        IsFoundation := ApplicationAreaMgmtFacade.IsFoundationEnabled;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        //DocumentTotals.SalesCheckIfDocumentChanged(Rec,xRec);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        /*
        InitType;
        
        // Default to Item for the first line and to previous line type for the others
        IF ApplicationAreaMgmtFacade.IsFoundationEnabled THEN
          IF xRec."Document No." = '' THEN
            Type := Type::Item;
        CLEAR(ShortcutDimCode);
        UpdateTypeText;
        */

    end;

    trigger OnOpenPage()
    var
        Location: Record Location;
    begin
        IF Location.READPERMISSION THEN
            LocationCodeVisible := NOT Location.ISEMPTY;
    end;

    var
        Currency: Record Currency;
        TotalSalesHeader: Record "Sales Header";
        TotalSalesLine: Record "Sales Line";
        SalesHeader: Record "Sales Header";
        SalesSetup: Record "Sales & Receivables Setup";
        InventorySetup: Record "Inventory Setup";
        TempOptionLookupBuffer: Record "Option Lookup Buffer" temporary;
        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
        SalesPriceCalcMgt: Codeunit "Sales Price Calc. Mgt.";
        TransferExtendedText: Codeunit "Transfer Extended Text";
        SalesAvailabilityMgt: Codeunit "Sales Availability Mgt.";
        SalesCalcDiscountByType: Codeunit "Sales - Calc Discount By Type";
        DocumentTotals: Codeunit "Document Totals";
        VATAmount: Decimal;
        AmountWithDiscountAllowed: Decimal;
        ShortcutDimCode: array[8] of Code[20];
        Text001: Label 'You cannot use the Explode BOM function because a prepayment of the sales order has been invoiced.';
        LocationCodeMandatory: Boolean;
        InvDiscAmountEditable: Boolean;
        UnitofMeasureCodeIsChangeable: Boolean;
        LocationCodeVisible: Boolean;
        IsFoundation: Boolean;
        IsCommentLine: Boolean;
        CurrPageIsEditable: Boolean;
        InvoiceDiscountAmount: Decimal;
        InvoiceDiscountPct: Decimal;
        UpdateInvDiscountQst: Label 'One or more lines have been invoiced. The discount distributed to invoiced lines will not be taken into account.\\Do you want to update the invoice discount?';
        ItemChargeStyleExpression: Text;
        TypeAsText: Text[30];
        Text002: Label 'You can only select Free OR Chemilines Location';
        recTrackingSpecification: Record "Tracking Specification" temporary;
        TotalItemTrackingLine: Record "Tracking Specification";
        QTY: Decimal;
        Qty_Old: Decimal;
        FlagLookUp: Boolean;
        SelectedQty: Decimal;
        recReservationEntry: Record "Reservation Entry";
        ReserveSalesLine: Codeunit "Sales Line-Reserve";
        TempItemTrackLineModify: Record "Tracking Specification" temporary;
        TempItemTrackLineInsert: Record "Tracking Specification" temporary;
        LastEntryNo: Integer;
        UndefinedQtyArray: array[3] of Decimal;
        CurrentSignFactor: Integer;
        ForBinCode: Code[20];
        ItemTrackingDataCollection: Codeunit "Item Tracking Data Collection";
        CreateReservEntry: Codeunit "Create Reserv. Entry";
        SourceQuantityArray: array[5] of Decimal;

    [Scope('Personalization')]
    procedure ApproveCalcInvDisc()
    begin
        CODEUNIT.RUN(CODEUNIT::"Sales-Disc. (Yes/No)", Rec);
        DocumentTotals.SalesDocTotalsNotUpToDate;
    end;

    local procedure ValidateInvoiceDiscountAmount()
    var
        SalesHeader: Record "Sales Header";
    begin
        SalesHeader.GET(Rec."Document Type", Rec."Document No.");
        IF SalesHeader.InvoicedLineExists THEN
            // ConfirmManagement: Codeunit "27" no longer exists in this BC version (no replacement codeunit with a ConfirmProcess-style method was found). Using the built-in global Confirm(), which is what ConfirmManagement.ConfirmProcess used to wrap.
            IF NOT CONFIRM(UpdateInvDiscountQst, TRUE) THEN
                EXIT;

        SalesCalcDiscountByType.ApplyInvDiscBasedOnAmt(InvoiceDiscountAmount, SalesHeader);
        DocumentTotals.SalesDocTotalsNotUpToDate;
        CurrPage.UPDATE(FALSE);
    end;

    [Scope('Personalization')]
    procedure CalcInvDisc()
    var
        SalesCalcDiscount: Codeunit "Sales-Calc. Discount";
    begin
        SalesCalcDiscount.CalculateInvoiceDiscountOnLine(Rec);
        DocumentTotals.SalesDocTotalsNotUpToDate;
    end;

    [Scope('Personalization')]
    procedure ExplodeBOM()
    begin
        IF Rec."Prepmt. Amt. Inv." <> 0 THEN
            ERROR(Text001);
        CODEUNIT.RUN(CODEUNIT::"Sales-Explode BOM", Rec);
        DocumentTotals.SalesDocTotalsNotUpToDate;
    end;

    [Scope('Personalization')]
    procedure OpenPurchOrderForm()
    var
        PurchHeader: Record "Purchase Header";
        PurchOrder: Page "Purchase Order";
    begin
        Rec.TESTFIELD("Purchase Order No.");
        PurchHeader.SETRANGE("No.", Rec."Purchase Order No.");
        PurchOrder.SETTABLEVIEW(PurchHeader);
        PurchOrder.EDITABLE := FALSE;
        PurchOrder.RUN;
    end;

    [Scope('Personalization')]
    procedure OpenSpecialPurchOrderForm()
    var
        PurchHeader: Record "Purchase Header";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        PurchOrder: Page "Purchase Order";
    begin
        Rec.TESTFIELD("Special Order Purchase No.");
        PurchHeader.SETRANGE("No.", Rec."Special Order Purchase No.");
        IF NOT PurchHeader.ISEMPTY THEN BEGIN
            PurchOrder.SETTABLEVIEW(PurchHeader);
            PurchOrder.EDITABLE := FALSE;
            PurchOrder.RUN;
        END ELSE BEGIN
            PurchRcptHeader.SETRANGE("Order No.", Rec."Special Order Purchase No.");
            IF PurchRcptHeader.COUNT = 1 THEN
                PAGE.RUN(PAGE::"Posted Purchase Receipt", PurchRcptHeader)
            ELSE
                PAGE.RUN(PAGE::"Posted Purchase Receipts", PurchRcptHeader);
        END;
    end;

    [Scope('Personalization')]
    procedure InsertExtendedText(Unconditionally: Boolean)
    begin
        OnBeforeInsertExtendedText(Rec);
        IF TransferExtendedText.SalesCheckIfAnyExtText(Rec, Unconditionally) THEN BEGIN
            CurrPage.SAVERECORD;
            COMMIT;
            TransferExtendedText.InsertSalesExtText(Rec);
        END;
        IF TransferExtendedText.MakeUpdate THEN
            UpdateForm(TRUE);
    end;

    [Scope('Personalization')]
    procedure ShowNonstockItems()
    begin
        Rec.ShowNonstock;
    end;

    [Scope('Personalization')]
    procedure ShowTracking()
    var
        TrackingForm: Page "Order Tracking";
    begin
        // SetSalesLine was replaced by the generic SetVariantRec in modern BC (all per-document overloads were consolidated into one method).
        TrackingForm.SetVariantRec(Rec, Rec."No.", Rec."Outstanding Qty. (Base)", Rec."Shipment Date", Rec."Shipment Date");
        TrackingForm.RUNMODAL;
    end;

    [Scope('Personalization')]
    procedure ItemChargeAssgnt()
    begin
        Rec.ShowItemChargeAssgnt;
    end;

    [Scope('Personalization')]
    procedure UpdateForm(SetSaveRecord: Boolean)
    begin
        CurrPage.UPDATE(SetSaveRecord);
    end;

    [Scope('Personalization')]
    procedure ShowPrices()
    begin
        SalesHeader.GET(Rec."Document Type", Rec."Document No.");
        CLEAR(SalesPriceCalcMgt);
        SalesPriceCalcMgt.GetSalesLinePrice(SalesHeader, Rec);
    end;

    [Scope('Personalization')]
    procedure ShowLineDisc()
    begin
        SalesHeader.GET(Rec."Document Type", Rec."Document No.");
        CLEAR(SalesPriceCalcMgt);
        SalesPriceCalcMgt.GetSalesLineLineDisc(SalesHeader, Rec);
    end;

    [Scope('Personalization')]
    procedure OrderPromisingLine()
    var
        OrderPromisingLine: Record "Order Promising Line" temporary;
        OrderPromisingLines: Page "Order Promising Lines";
    begin
        // TODO: "Source Type" on Order Promising Line is now Enum "Order Promising Line Source Type", while "Document Type" is a Sales Header/Sales Line enum ("Sales Document Type") with a different, unrelated member set - AL does not allow implicit conversion between distinct enums, so this SETRANGE will not compile as written, not merely a logic bug to revisit later. This looks like a pre-existing copy-paste bug, not something introduced by this migration. Left as the original (Rec-qualified) comparison pending a decision on whether it should instead be corrected to "Order Promising Line Source Type"::Sales, matching the SetSource call below.
        OrderPromisingLine.SETRANGE("Source Type", Rec."Document Type");
        OrderPromisingLine.SETRANGE("Source ID", Rec."Document No.");
        OrderPromisingLine.SETRANGE("Source Line No.", Rec."Line No.");

        OrderPromisingLines.SetSource("Order Promising Line Source Type"::Sales);
        OrderPromisingLines.SETTABLEVIEW(OrderPromisingLine);
        OrderPromisingLines.RUNMODAL;
    end;

    local procedure NoOnAfterValidate()
    begin
        InsertExtendedText(FALSE);
        IF (Rec.Type = Rec.Type::"Charge (Item)") AND (Rec."No." <> xRec."No.") AND
           (xRec."No." <> '')
        THEN
            CurrPage.SAVERECORD;

        SaveAndAutoAsmToOrder;

        IF Rec.Reserve = Rec.Reserve::Always THEN BEGIN
            CurrPage.SAVERECORD;
            IF (Rec."Outstanding Qty. (Base)" <> 0) AND (Rec."No." <> xRec."No.") THEN BEGIN
                Rec.AutoReserve;
                CurrPage.UPDATE(FALSE);
            END;
        END;
    end;

    local procedure VariantCodeOnAfterValidate()
    begin
        SaveAndAutoAsmToOrder;
    end;

    local procedure LocationCodeOnAfterValidate()
    begin
        SaveAndAutoAsmToOrder;

        IF (Rec.Reserve = Rec.Reserve::Always) AND
           (Rec."Outstanding Qty. (Base)" <> 0) AND
           (Rec."Location Code" <> xRec."Location Code")
        THEN BEGIN
            CurrPage.SAVERECORD;
            Rec.AutoReserve;
            CurrPage.UPDATE(FALSE);
        END;
    end;

    local procedure ReserveOnAfterValidate()
    begin
        IF (Rec.Reserve = Rec.Reserve::Always) AND (Rec."Outstanding Qty. (Base)" <> 0) THEN BEGIN
            CurrPage.SAVERECORD;
            Rec.AutoReserve;
        END;
    end;

    local procedure QuantityOnAfterValidate()
    begin
        IF Rec.Type = Rec.Type::Item THEN
            CASE Rec.Reserve OF
                Rec.Reserve::Always:
                    BEGIN
                        CurrPage.SAVERECORD;
                        Rec.AutoReserve;
                    END;
            END;

        OnAfterQuantityOnAfterValidate(Rec, xRec);
    end;

    local procedure QtyToAsmToOrderOnAfterValidate()
    begin
        CurrPage.SAVERECORD;
        IF Rec.Reserve = Rec.Reserve::Always THEN
            Rec.AutoReserve;
        CurrPage.UPDATE(TRUE);
    end;

    local procedure UnitofMeasureCodeOnAfterValida()
    begin
        DeltaUpdateTotals;
        IF Rec.Reserve = Rec.Reserve::Always THEN BEGIN
            CurrPage.SAVERECORD;
            Rec.AutoReserve;
            CurrPage.UPDATE(FALSE);
        END;
    end;

    local procedure ShipmentDateOnAfterValidate()
    begin
        IF (Rec.Reserve = Rec.Reserve::Always) AND
           (Rec."Outstanding Qty. (Base)" <> 0) AND
           (Rec."Shipment Date" <> xRec."Shipment Date")
        THEN BEGIN
            CurrPage.SAVERECORD;
            Rec.AutoReserve;
            CurrPage.UPDATE(FALSE);
        END ELSE
            CurrPage.UPDATE(TRUE);
    end;

    local procedure SaveAndAutoAsmToOrder()
    begin
        IF (Rec.Type = Rec.Type::Item) AND Rec.IsAsmToOrderRequired THEN BEGIN
            CurrPage.SAVERECORD;
            Rec.AutoAsmToOrder;
            CurrPage.UPDATE(FALSE);
        END;
    end;

    [Scope('Personalization')]
    procedure ShowDocumentLineTracking()
    var
        DocumentLineTracking: Page "Document Line Tracking";
    begin
        CLEAR(DocumentLineTracking);
        // TODO: SetDoc was renamed to SetSourceDoc in this BC version, and its 1st parameter changed from a numeric/option value to Enum "Document Line Source Type". Updated to the matching enum value ("Document Line Source Type"::"Sales Order", ordinal 0) to preserve the original behavior of this sales order subform; please confirm this is the intended source type.
        DocumentLineTracking.SetSourceDoc("Document Line Source Type"::"Sales Order", Rec."Document No.", Rec."Line No.", Rec."Blanket Order No.", Rec."Blanket Order Line No.", '', 0);
        DocumentLineTracking.RUNMODAL;
    end;

    local procedure SetLocationCodeMandatory()
    begin
        LocationCodeMandatory := InventorySetup."Location Mandatory" AND (Rec.Type = Rec.Type::Item);
    end;

    local procedure GetTotalSalesHeader()
    begin
        DocumentTotals.GetTotalSalesHeaderAndCurrency(Rec, TotalSalesHeader, Currency);
    end;

    local procedure CalculateTotals()
    begin
        DocumentTotals.SalesCheckIfDocumentChanged(Rec, xRec);
        DocumentTotals.CalculateSalesSubPageTotals(TotalSalesHeader, TotalSalesLine, VATAmount, InvoiceDiscountAmount, InvoiceDiscountPct);
        DocumentTotals.RefreshSalesLine(Rec);
    end;

    local procedure DeltaUpdateTotals()
    begin
        DocumentTotals.SalesDeltaUpdateTotals(Rec, xRec, TotalSalesLine, VATAmount, InvoiceDiscountAmount, InvoiceDiscountPct);
        CurrPage.SAVERECORD;
    end;

    local procedure UpdateEditableOnRow()
    begin
        IsCommentLine := NOT Rec.HasTypeToFillMandatoryFields;
        UnitofMeasureCodeIsChangeable := NOT IsCommentLine;

        CurrPageIsEditable := CurrPage.EDITABLE;
        InvDiscAmountEditable := CurrPageIsEditable AND NOT SalesSetup."Calc. Inv. Discount";
    end;

    local procedure UpdateTypeText()
    var
        RecRef: RecordRef;
    begin
        IF NOT IsFoundation THEN
            EXIT;
        RecRef.GETTABLE(Rec);
        TypeAsText := TempOptionLookupBuffer.FormatOption(RecRef.FIELD(rec.FIELDNO(Type)));
    end;

    local procedure SetItemChargeFieldsStyle()
    begin
        ItemChargeStyleExpression := '';
        IF Rec.AssignedItemCharge AND (Rec."Qty. Assigned" <> Rec.Quantity) THEN
            ItemChargeStyleExpression := 'Unfavorable';
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterQuantityOnAfterValidate(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeInsertExtendedText(var SalesLine: Record "Sales Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnCrossReferenceNoOnLookup(var SalesLine: Record "Sales Line")
    begin
    end;

    procedure SelectEntries()
    var
        xTrackingSpec: Record "Tracking Specification";
        MaxQuantity: Decimal;
    begin
        //05Feb2014++
        TempItemTrackLineInsert.DELETEALL;
        TempItemTrackLineModify.DELETEALL;
        xTrackingSpec.DELETEALL;
        recTrackingSpecification.DELETEALL;
        //05Feb2014--
        xTrackingSpec.COPYFILTERS(recTrackingSpecification);
        MaxQuantity := UndefinedQtyArray[1];
        IF MaxQuantity * CurrentSignFactor > 0 THEN
            MaxQuantity := 0;
        recTrackingSpecification."Bin Code" := ForBinCode;
        //ItemTrackingDataCollection.SelectMultipleLotSerialNo(recTrackingSpecification,MaxQuantity,CurrentSignFactor);
        // TODO: SelectMultipleLotSerialNo1 was removed in this BC version. Its replacement, Codeunit "Item Tracking Data Collection".SelectMultipleTrackingNo(var TempTrackingSpecification: Record "Tracking Specification"; MaxQuantity: Decimal; CurrentSignFactor: Integer), only has 3 parameters - it dropped the FlagLookUp (var Boolean) and SelectedQty (var Decimal) output parameters used below. No replacement field/mechanism carrying that same information was found on Tracking Specification or the codeunit. FlagLookUp/SelectedQty are therefore no longer being set by this call, so the FlagLookUp/SelectedQty-gated block further down (around "IF (FlagLookUp) AND (SelectedQty>0) THEN" - the CreateReservEntry.CreateReservEntryFor/CreateEntry reservation-creation logic) needs a real redesign, not a mechanical fix. Left unresolved pending that decision. Commented out below (does not compile against the current signature) until that redesign happens.
        //ItemTrackingDataCollection.SelectMultipleLotSerialNo1(recTrackingSpecification,QTY,CurrentSignFactor,FlagLookUp,SelectedQty);
        recTrackingSpecification."Bin Code" := '';
        IF recTrackingSpecification.FINDSET THEN
            REPEAT
                CASE recTrackingSpecification."Buffer Status" OF
                    recTrackingSpecification."Buffer Status"::MODIFY:
                        BEGIN
                            IF TempItemTrackLineModify.GET(recTrackingSpecification."Entry No.") THEN
                                TempItemTrackLineModify.DELETE;
                            IF TempItemTrackLineInsert.GET(recTrackingSpecification."Entry No.") THEN BEGIN
                                TempItemTrackLineInsert.TRANSFERFIELDS(recTrackingSpecification);
                                TempItemTrackLineInsert.MODIFY;
                            END ELSE BEGIN
                                TempItemTrackLineModify.TRANSFERFIELDS(recTrackingSpecification);
                                TempItemTrackLineModify.INSERT;
                            END;
                        END;
                    recTrackingSpecification."Buffer Status"::INSERT:
                        BEGIN
                            TempItemTrackLineInsert.TRANSFERFIELDS(recTrackingSpecification);
                            TempItemTrackLineInsert.INSERT;
                        END;
                END;
                recTrackingSpecification."Buffer Status" := 0;
                recTrackingSpecification.MODIFY;
            //MESSAGE('%1\%2',recTrackingSpecification."Lot No.",recTrackingSpecification."Quantity (Base)");
            //added by anikEt on 05Feb2014
            // TODO: part of the same SelectMultipleLotSerialNo1 redesign flagged above. Both calls below no longer match the current BC API and need real redesign, not a mechanical fix:
            // - CreateReservEntryFor: last 2 args (SerialNo: Code, LotNo: Code) were replaced by a single ForReservEntry: Record "Reservation Entry" parameter - the serial/lot info now needs to be carried via a populated Reservation Entry record instead of loose values.
            // - CreateEntry: gained an 8th parameter, Status: Enum "Reservation Status" - the old trailing "0,2" (7 args) needs an explicit enum value for the 8th param; the correct status here has not been confirmed.
            // Commented out below (does not compile against the current signatures) until that redesign happens, consistent with the identical block already blocked out above (around line 306).
            /*
            IF (FlagLookUp) AND (SelectedQty>0)  THEN
            BEGIN
            CreateReservEntry.CreateReservEntryFor(
                    recTrackingSpecification."Source Type",
                    recTrackingSpecification."Source Subtype",
                    recTrackingSpecification."Source ID",
                    recTrackingSpecification."Source Batch Name",
                    recTrackingSpecification."Source Prod. Order Line",
                    recTrackingSpecification."Source Ref. No.",
                    recTrackingSpecification."Qty. per Unit of Measure",
                    0,
                    recTrackingSpecification."Quantity (Base)",
                    recTrackingSpecification."Serial No.",
                    recTrackingSpecification."Lot No.");


                  CreateReservEntry.CreateEntry(recTrackingSpecification."Item No.",
                    recTrackingSpecification."Variant Code",
                    recTrackingSpecification."Location Code",
                    recTrackingSpecification.Description,
                    0D,
                    0D,0,2);
            END;
            */
            //
            UNTIL recTrackingSpecification.NEXT = 0;
        LastEntryNo := recTrackingSpecification."Entry No.";
        CalculateSums;
        UpdateUndefinedQty;
        recTrackingSpecification.COPYFILTERS(xTrackingSpec);
        CurrPage.UPDATE(FALSE);
    end;

    local procedure CalculateSums()
    var
        xTrackingSpec: Record "Tracking Specification";
    begin
        xTrackingSpec.COPY(recTrackingSpecification);
        recTrackingSpecification.RESET;
        recTrackingSpecification.CALCSUMS("Quantity (Base)",
          "Qty. to Handle (Base)",
          "Qty. to Invoice (Base)");
        TotalItemTrackingLine := recTrackingSpecification;
        recTrackingSpecification.COPY(xTrackingSpec);

        UpdateUndefinedQty;
    end;

    local procedure UpdateUndefinedQty() QtyIsValid: Boolean
    begin
        UndefinedQtyArray[1] := SourceQuantityArray[1] - TotalItemTrackingLine."Quantity (Base)";
        UndefinedQtyArray[2] := SourceQuantityArray[2] - TotalItemTrackingLine."Qty. to Handle (Base)";
        UndefinedQtyArray[3] := SourceQuantityArray[3] - TotalItemTrackingLine."Qty. to Invoice (Base)";

        IF ABS(SourceQuantityArray[1]) < ABS(TotalItemTrackingLine."Quantity (Base)") THEN
            QtyIsValid := FALSE
        ELSE
            QtyIsValid := TRUE;
    end;
}

