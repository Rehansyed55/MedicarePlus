// page 50085 NetEDI_Order_Line_New
// {
//     // version NAVW17.00

//     // Case No - CAS-05893-Q7W3X2
//     // Description - Sales person can only select Free or Chemiines Location

//     AutoSplitKey = true;
//     Caption = 'NetEDI_Order_Line_New';
//     DelayedInsert = true;
//     LinksAllowed = false;
//     MultipleNewLines = true;
//     PageType = ListPart;
//     SourceTable = 37;
//     SourceTableView = WHERE("Document Type"=FILTER(Order));

//     layout
//     {
//         area(content)
//         {
//             repeater()
//             {
//                 field(Type;Type)
//                 {

//                     trigger OnValidate()
//                     begin
//                         TypeOnAfterValidate;
//                     end;
//                 }
//                 field("Document No.";"Document No.")
//                 {
//                 }
//                 field("No.";"No.")
//                 {

//                     trigger OnValidate()
//                     begin
//                         ShowShortcutDimCode(ShortcutDimCode);
//                         NoOnAfterValidate;
//                     end;
//                 }
//                 field("Cross-Reference No.";"Cross-Reference No.")
//                 {
//                     Visible = false;

//                     trigger OnLookup(var Text: Text): Boolean
//                     begin
//                         CrossReferenceNoLookUp;
//                         InsertExtendedText(FALSE);
//                     end;

//                     trigger OnValidate()
//                     begin
//                         CrossReferenceNoOnAfterValidat;
//                     end;
//                 }
//                 field("IC Partner Code";"IC Partner Code")
//                 {
//                     Visible = false;
//                 }
//                 field("IC Partner Ref. Type";"IC Partner Ref. Type")
//                 {
//                     Visible = false;
//                 }
//                 field("IC Partner Reference";"IC Partner Reference")
//                 {
//                     Visible = false;
//                 }
//                 field("Variant Code";"Variant Code")
//                 {
//                     Visible = false;

//                     trigger OnValidate()
//                     begin
//                         VariantCodeOnAfterValidate;
//                     end;
//                 }
//                 field("Substitution Available";"Substitution Available")
//                 {
//                     Visible = false;
//                 }
//                 field("Purchasing Code";"Purchasing Code")
//                 {
//                     Visible = false;
//                 }
//                 field(Nonstock;Nonstock)
//                 {
//                     Visible = false;
//                 }
//                 field("VAT Prod. Posting Group";"VAT Prod. Posting Group")
//                 {
//                     Visible = false;
//                 }
//                 field(Description;Description)
//                 {
//                     QuickEntry = false;
//                 }
//                 field("Drop Shipment";"Drop Shipment")
//                 {
//                     Visible = false;
//                 }
//                 field("Special Order";"Special Order")
//                 {
//                     Visible = false;
//                 }
//                 field("Return Reason Code";"Return Reason Code")
//                 {
//                     Visible = false;
//                 }
//                 field("Location Code";"Location Code")
//                 {
//                     QuickEntry = false;

//                     trigger OnValidate()
//                     begin
//                         /*
//                         //CAS-04375-Z0H4D8//
//                         IF COMPANYNAME = 'Chemilines Limited' THEN
//                         BEGIN
//                           IF Type=2 THEN
//                           BEGIN
//                               IF("Location Code"<>'FREE') THEN
//                               ERROR(Text002);
//                           END;
//                         END;
//                         //CAS-04375-Z0H4D8//
//                         */
                        
//                         //CAS-05893-Q7W3X2 ++
//                         IF COMPANYNAME = 'Chemilines Limited' THEN
//                         BEGIN
//                           IF Type=2 THEN
//                           BEGIN
//                               IF ("Location Code"<>'FREE') AND ("Location Code"<>'CHEMILINES')  THEN
//                               ERROR(Text002);
//                           END;
//                         END;
//                         //CAS-05893-Q7W3X2--
                        
//                         LocationCodeOnAfterValidate;

//                     end;
//                 }
//                 field("Bin Code";"Bin Code")
//                 {
//                     Visible = false;
//                 }
//                 field(Reserve;Reserve)
//                 {
//                     Visible = false;

//                     trigger OnValidate()
//                     begin
//                         ReserveOnAfterValidate;
//                     end;
//                 }
//                 field(Quantity;Quantity)
//                 {
//                     BlankZero = true;

//                     trigger OnValidate()
//                     begin
//                         QuantityOnAfterValidate;
//                     end;
//                 }
//                 field("Batch Qty";"Batch Qty")
//                 {
//                     Visible = false;

//                     trigger OnAssistEdit()
//                     begin
                        
//                         //ReserveSalesLine.CallItemTracking(Rec);
//                         //anikEt++
//                         CLEAR(recTrackingSpecification);
//                         recTrackingSpecification.DELETEALL;//5Feb2014
//                         TotalItemTrackingLine.DELETEALL;//5Feb2014
//                         COMMIT;
//                         recTrackingSpecification.RESET;
                        
                        
//                         //MESSAGE('InitTracking Qty=%1 \ SL QTY=%2',recTrackingSpecification."Quantity (Base)",Quantity);
                        
                        
                        
//                         //MaxQuantity:=Quantity;
//                         //ItemTrackingDataCollection.SelectMultipleLotSerialNo1(recTrackingSpecification,MaxQuantity,0);
//                         //ItemTrackingDataCollection.SelectMultipleLotSerialNo(recTrackingSpecification,MaxQuantity,0);
//                         //MESSAGE('SelectMultiple \ Qty=%1 \ SL QTY=%2',recTrackingSpecification."Quantity (Base)",Quantity);
//                         CLEAR(SelectedQty);
//                         CLEAR(QTY);
//                         CLEAR(Qty_Old);
//                         CLEAR(recReservationEntry);
//                         recReservationEntry.RESET;
//                         recReservationEntry.SETRANGE(recReservationEntry."Item No.","No.");
//                         recReservationEntry.SETRANGE(recReservationEntry."Location Code","Location Code");
//                         recReservationEntry.SETRANGE(recReservationEntry."Source Type",37);
//                         recReservationEntry.SETRANGE(recReservationEntry."Source Subtype",1);
//                         recReservationEntry.SETRANGE(recReservationEntry."Source ID","Document No.");
//                         recReservationEntry.SETRANGE(recReservationEntry."Source Ref. No.","Line No.");
//                         IF recReservationEntry.FINDFIRST THEN
//                         BEGIN
//                         REPEAT
//                         //MESSAGE('Before %1',recReservationEntry.COUNT);
//                         //recReservationEntry.DELETEALL;
//                         Qty_Old+=ABS(recReservationEntry.Quantity);
//                         UNTIL recReservationEntry.NEXT=0;
//                         END;
                        
//                         //ReserveSalesLine.BindToPurchase(Rec,recTrackingSpecification);  //
                        
//                         //MESSAGE('After %1 \ Qty=%2 \ SL QTY=%3',recReservationEntry.COUNT,recTrackingSpecification."Quantity (Base)",Quantity);
                        
                        
//                         IF (Quantity-Qty_Old)>0 THEN
//                         QTY:=Quantity-Qty_Old;
                        
                        
                        
//                         //MESSAGE('%1',    recTrackingSpecification);
                        
//                         SelectEntries;
                        
                        
                        
//                         CurrPage.UPDATE(TRUE);
                        
                        
//                         //MESSAGE('%1',SelectedQty);
//                         //------------------------------------------------------------------
//                         //Blocked on 05Feb2014
//                         /*
//                         IF (FlagLookUp) AND (SelectedQty>0) THEN
//                         BEGIN
//                         CreateReservEntry.CreateReservEntryFor(
//                                 recTrackingSpecification."Source Type",
//                                 recTrackingSpecification."Source Subtype",
//                                 recTrackingSpecification."Source ID",
//                                 recTrackingSpecification."Source Batch Name",
//                                 recTrackingSpecification."Source Prod. Order Line",
//                                 recTrackingSpecification."Source Ref. No.",
//                                 recTrackingSpecification."Qty. per Unit of Measure",
//                                 0,
//                                 SelectedQty,
//                                 recTrackingSpecification."Serial No.",
//                                 recTrackingSpecification."Lot No.");
                        
                        
//                               CreateReservEntry.CreateEntry(recTrackingSpecification."Item No.",
//                                 recTrackingSpecification."Variant Code",
//                                 recTrackingSpecification."Location Code",
//                                 recTrackingSpecification.Description,
//                                 0D,
//                                 0D,0,2);
//                         END;
//                         */
//                         /*
//                         CreateReservEntry.CreateReservEntryFor(
//                                 OldTrackingSpecification."Source Type",
//                                 OldTrackingSpecification."Source Subtype",
//                                 OldTrackingSpecification."Source ID",
//                                 OldTrackingSpecification."Source Batch Name",
//                                 OldTrackingSpecification."Source Prod. Order Line",
//                                 OldTrackingSpecification."Source Ref. No.",
//                                 OldTrackingSpecification."Qty. per Unit of Measure",
//                                 0,
//                                 OldTrackingSpecification."Quantity (Base)",
//                                 OldTrackingSpecification."Serial No.",
//                                 OldTrackingSpecification."Lot No.");
                        
//                               CreateReservEntry.CreateEntry(OldTrackingSpecification."Item No.",
//                                 OldTrackingSpecification."Variant Code",
//                                 OldTrackingSpecification."Location Code",
//                                 OldTrackingSpecification.Description,
//                                 ExpectedReceiptDate,
//                                 ShipmentDate,0,CurrentEntryStatus);
//                         */
                        
                        
                        
                        
//                         //
                        
//                         //
                        
//                         //ItemTrackingDataCollection.RetrieveLookupData(recTrackingSpecification,TRUE);

//                     end;
//                 }
//                 field("Qty. to Assemble to Order";"Qty. to Assemble to Order")
//                 {
//                     BlankZero = true;
//                     Visible = false;

//                     trigger OnDrillDown()
//                     begin
//                         ShowAsmToOrderLines;
//                     end;

//                     trigger OnValidate()
//                     begin
//                         QtyToAsmToOrderOnAfterValidate;
//                     end;
//                 }
//                 field("Reserved Quantity";"Reserved Quantity")
//                 {
//                     BlankZero = true;
//                     QuickEntry = false;
//                 }
//                 field("Unit of Measure Code";"Unit of Measure Code")
//                 {
//                     QuickEntry = false;

//                     trigger OnValidate()
//                     begin
//                         UnitofMeasureCodeOnAfterValida;
//                     end;
//                 }
//                 field("Unit of Measure";"Unit of Measure")
//                 {
//                     Visible = false;
//                 }
//                 field("Unit Cost (LCY)";"Unit Cost (LCY)")
//                 {
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field(SalesPriceExist;PriceExists)
//                 {
//                     Caption = 'Sales Price Exists';
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("Unit Price";"Unit Price")
//                 {
//                     BlankZero = true;

//                     trigger OnValidate()
//                     var
//                         Item: Record "27";
//                     begin
//                         /*//JIRA Chem-343++
//                         Item.RESET;
//                         Item.SETRANGE(Item."No.","No.");
//                         IF Item.FINDFIRST THEN
//                         BEGIN
//                           IF "Unit Price"<Item."Unit Cost" THEN
//                             CASE  UPPERCASE(USERID) OF
//                             UPPERCASE('CHEMILINES\KASHYAP.KARIA'),UPPERCASE('CHEMILINES\KEITH.BEARD'),UPPERCASE('CHEMILINES\UMESH.PATEL'),UPPERCASE('CHEMILINES\ROSHNI.DAS'),
//                              UPPERCASE('CHEMILINES\MAHESH.PANDIT'),UPPERCASE('CHEMILINES\MATTHEW.THREADER'),UPPERCASE('CHEMILINES\VISHAL.KARIA'),UPPERCASE('CHEMILINES\JAGDISH.KARIA'),UPPERCASE('CHEMILINES\RAVI.KARIA'):
//                                 MESSAGE('Unit Price is less than Unit Cost');
//                              ELSE
//                               ERROR('Unit Price Cannot be less than Unit Cost');
//                             END;
//                         END
//                         //JIRA Chem-343--
//                          */

//                     end;
//                 }
//                 field("Line Amount";"Line Amount")
//                 {
//                     BlankZero = true;
//                     Editable = false;
//                 }
//                 field(SalesLineDiscExists;LineDiscExists)
//                 {
//                     Caption = 'Sales Line Disc. Exists';
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("Line Discount %";"Line Discount %")
//                 {
//                     BlankZero = true;
//                     Visible = false;
//                 }
//                 field("Line Discount Amount";"Line Discount Amount")
//                 {
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("Prepayment %";"Prepayment %")
//                 {
//                     Visible = false;
//                 }
//                 field("Prepmt. Line Amount";"Prepmt. Line Amount")
//                 {
//                     Visible = false;
//                 }
//                 field("Prepmt. Amt. Inv.";"Prepmt. Amt. Inv.")
//                 {
//                     Visible = false;
//                 }
//                 field("Allow Invoice Disc.";"Allow Invoice Disc.")
//                 {
//                     Visible = false;
//                 }
//                 field("Inv. Discount Amount";"Inv. Discount Amount")
//                 {
//                     Visible = false;
//                 }
//                 field("Qty. to Ship";"Qty. to Ship")
//                 {
//                     BlankZero = true;

//                     trigger OnValidate()
//                     begin
//                         IF "Qty. to Asm. to Order (Base)" <> 0 THEN BEGIN
//                           CurrPage.SAVERECORD;
//                           CurrPage.UPDATE(FALSE);
//                         END;
//                     end;
//                 }
//                 field("Quantity Shipped";"Quantity Shipped")
//                 {
//                     BlankZero = true;
//                     QuickEntry = false;
//                 }
//                 field("Qty. to Invoice";"Qty. to Invoice")
//                 {
//                     BlankZero = true;
//                 }
//                 field("Quantity Invoiced";"Quantity Invoiced")
//                 {
//                     BlankZero = true;
//                 }
//                 field("Prepmt Amt to Deduct";"Prepmt Amt to Deduct")
//                 {
//                     Visible = false;
//                 }
//                 field("Prepmt Amt Deducted";"Prepmt Amt Deducted")
//                 {
//                     Visible = false;
//                 }
//                 field("Allow Item Charge Assignment";"Allow Item Charge Assignment")
//                 {
//                     Visible = false;
//                 }
//                 field("Qty. to Assign";"Qty. to Assign")
//                 {
//                     BlankZero = true;
//                     QuickEntry = false;

//                     trigger OnDrillDown()
//                     begin
//                         CurrPage.SAVERECORD;
//                         ShowItemChargeAssgnt;
//                         UpdateForm(FALSE);
//                     end;
//                 }
//                 field("Qty. Assigned";"Qty. Assigned")
//                 {
//                     BlankZero = true;
//                     QuickEntry = false;

//                     trigger OnDrillDown()
//                     begin
//                         CurrPage.SAVERECORD;
//                         ShowItemChargeAssgnt;
//                         CurrPage.UPDATE(FALSE);
//                     end;
//                 }
//                 field("Requested Delivery Date";"Requested Delivery Date")
//                 {
//                     Visible = false;
//                 }
//                 field("Promised Delivery Date";"Promised Delivery Date")
//                 {
//                     Visible = false;
//                 }
//                 field("Planned Delivery Date";"Planned Delivery Date")
//                 {
//                     QuickEntry = false;
//                 }
//                 field("Planned Shipment Date";"Planned Shipment Date")
//                 {
//                 }
//                 field("Shipment Date";"Shipment Date")
//                 {
//                     QuickEntry = false;

//                     trigger OnValidate()
//                     begin
//                         ShipmentDateOnAfterValidate;
//                     end;
//                 }
//                 field("Shipping Agent Code";"Shipping Agent Code")
//                 {
//                     Visible = false;
//                 }
//                 field("Shipping Agent Service Code";"Shipping Agent Service Code")
//                 {
//                     Visible = false;
//                 }
//                 field("Shipping Time";"Shipping Time")
//                 {
//                     Visible = false;
//                 }
//                 field("Work Type Code";"Work Type Code")
//                 {
//                     Visible = false;
//                 }
//                 field("Whse. Outstanding Qty.";"Whse. Outstanding Qty.")
//                 {
//                     Visible = false;
//                 }
//                 field("Whse. Outstanding Qty. (Base)";"Whse. Outstanding Qty. (Base)")
//                 {
//                     Visible = false;
//                 }
//                 field("ATO Whse. Outstanding Qty.";"ATO Whse. Outstanding Qty.")
//                 {
//                     Visible = false;
//                 }
//                 field("ATO Whse. Outstd. Qty. (Base)";"ATO Whse. Outstd. Qty. (Base)")
//                 {
//                     Visible = false;
//                 }
//                 field("Outbound Whse. Handling Time";"Outbound Whse. Handling Time")
//                 {
//                     Visible = false;
//                 }
//                 field("Blanket Order No.";"Blanket Order No.")
//                 {
//                     Visible = false;
//                 }
//                 field("Blanket Order Line No.";"Blanket Order Line No.")
//                 {
//                     Visible = false;
//                 }
//                 field("FA Posting Date";"FA Posting Date")
//                 {
//                     Visible = false;
//                 }
//                 field("Depr. until FA Posting Date";"Depr. until FA Posting Date")
//                 {
//                     Visible = false;
//                 }
//                 field("Depreciation Book Code";"Depreciation Book Code")
//                 {
//                     Visible = false;
//                 }
//                 field("Use Duplication List";"Use Duplication List")
//                 {
//                     Visible = false;
//                 }
//                 field("Duplicate in Depreciation Book";"Duplicate in Depreciation Book")
//                 {
//                     Visible = false;
//                 }
//                 field("Appl.-from Item Entry";"Appl.-from Item Entry")
//                 {
//                     Visible = false;
//                 }
//                 field("Appl.-to Item Entry";"Appl.-to Item Entry")
//                 {
//                     Visible = false;
//                 }
//                 field("Shortcut Dimension 1 Code";"Shortcut Dimension 1 Code")
//                 {
//                     Visible = false;
//                 }
//                 field("Shortcut Dimension 2 Code";"Shortcut Dimension 2 Code")
//                 {
//                     Visible = false;
//                 }
//                 field(ShortcutDimCode[3];ShortcutDimCode[3])
//                 {
//                     CaptionClass = '1,2,3';
//                     Visible = false;

//                     trigger OnLookup(var Text: Text): Boolean
//                     begin
//                         LookupShortcutDimCode(3,ShortcutDimCode[3]);
//                     end;

//                     trigger OnValidate()
//                     begin
//                         ValidateShortcutDimCode(3,ShortcutDimCode[3]);
//                     end;
//                 }
//                 field(ShortcutDimCode[4];ShortcutDimCode[4])
//                 {
//                     CaptionClass = '1,2,4';
//                     Visible = false;

//                     trigger OnLookup(var Text: Text): Boolean
//                     begin
//                         LookupShortcutDimCode(4,ShortcutDimCode[4]);
//                     end;

//                     trigger OnValidate()
//                     begin
//                         ValidateShortcutDimCode(4,ShortcutDimCode[4]);
//                     end;
//                 }
//                 field(ShortcutDimCode[5];ShortcutDimCode[5])
//                 {
//                     CaptionClass = '1,2,5';
//                     Visible = false;

//                     trigger OnLookup(var Text: Text): Boolean
//                     begin
//                         LookupShortcutDimCode(5,ShortcutDimCode[5]);
//                     end;

//                     trigger OnValidate()
//                     begin
//                         ValidateShortcutDimCode(5,ShortcutDimCode[5]);
//                     end;
//                 }
//                 field(ShortcutDimCode[6];ShortcutDimCode[6])
//                 {
//                     CaptionClass = '1,2,6';
//                     Visible = false;

//                     trigger OnLookup(var Text: Text): Boolean
//                     begin
//                         LookupShortcutDimCode(6,ShortcutDimCode[6]);
//                     end;

//                     trigger OnValidate()
//                     begin
//                         ValidateShortcutDimCode(6,ShortcutDimCode[6]);
//                     end;
//                 }
//                 field(ShortcutDimCode[7];ShortcutDimCode[7])
//                 {
//                     CaptionClass = '1,2,7';
//                     Visible = false;

//                     trigger OnLookup(var Text: Text): Boolean
//                     begin
//                         LookupShortcutDimCode(7,ShortcutDimCode[7]);
//                     end;

//                     trigger OnValidate()
//                     begin
//                         ValidateShortcutDimCode(7,ShortcutDimCode[7]);
//                     end;
//                 }
//                 field(ShortcutDimCode[8];ShortcutDimCode[8])
//                 {
//                     CaptionClass = '1,2,8';
//                     Visible = false;

//                     trigger OnLookup(var Text: Text): Boolean
//                     begin
//                         LookupShortcutDimCode(8,ShortcutDimCode[8]);
//                     end;

//                     trigger OnValidate()
//                     begin
//                         ValidateShortcutDimCode(8,ShortcutDimCode[8]);
//                     end;
//                 }
//                 field("Line No.";"Line No.")
//                 {
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             group("&Line")
//             {
//                 Caption = '&Line';
//                 Image = Line;
//                 group("Item Availability by")
//                 {
//                     Caption = 'Item Availability by';
//                     Image = ItemAvailability;
//                     action("<Action3>")
//                     {
//                         Caption = 'Event';
//                         Image = "Event";

//                         trigger OnAction()
//                         begin
//                             ItemAvailFormsMgt.ShowItemAvailFromSalesLine(Rec,ItemAvailFormsMgt.ByEvent)
//                         end;
//                     }
//                     action(Period)
//                     {
//                         Caption = 'Period';
//                         Image = Period;

//                         trigger OnAction()
//                         begin
//                             ItemAvailFormsMgt.ShowItemAvailFromSalesLine(Rec,ItemAvailFormsMgt.ByPeriod)
//                         end;
//                     }
//                     action(Variant)
//                     {
//                         Caption = 'Variant';
//                         Image = ItemVariant;

//                         trigger OnAction()
//                         begin
//                             ItemAvailFormsMgt.ShowItemAvailFromSalesLine(Rec,ItemAvailFormsMgt.ByVariant)
//                         end;
//                     }
//                     action(Location)
//                     {
//                         Caption = 'Location';
//                         Image = Warehouse;

//                         trigger OnAction()
//                         begin
//                             ItemAvailFormsMgt.ShowItemAvailFromSalesLine(Rec,ItemAvailFormsMgt.ByLocation)
//                         end;
//                     }
//                     action("BOM Level")
//                     {
//                         Caption = 'BOM Level';
//                         Image = BOMLevel;

//                         trigger OnAction()
//                         begin
//                             ItemAvailFormsMgt.ShowItemAvailFromSalesLine(Rec,ItemAvailFormsMgt.ByBOM)
//                         end;
//                     }
//                 }
//                 action("Reservation Entries")
//                 {
//                     Caption = 'Reservation Entries';
//                     Image = ReservationLedger;

//                     trigger OnAction()
//                     begin
//                         ShowReservationEntries(TRUE);
//                     end;
//                 }
//                 action(ItemTrackingLines)
//                 {
//                     Caption = 'Item &Tracking Lines';
//                     Image = ItemTrackingLines;
//                     ShortCutKey = 'Shift+Ctrl+I';

//                     trigger OnAction()
//                     begin
//                         OpenItemTrackingLines;
//                     end;
//                 }
//                 action("Select Item Substitution")
//                 {
//                     Caption = 'Select Item Substitution';
//                     Image = SelectItemSubstitution;

//                     trigger OnAction()
//                     begin
//                         ShowItemSub;
//                     end;
//                 }
//                 action(Dimensions)
//                 {
//                     Caption = 'Dimensions';
//                     Image = Dimensions;
//                     ShortCutKey = 'Shift+Ctrl+D';

//                     trigger OnAction()
//                     begin
//                         ShowDimensions;
//                     end;
//                 }
//                 action("Co&mments")
//                 {
//                     Caption = 'Co&mments';
//                     Image = ViewComments;

//                     trigger OnAction()
//                     begin
//                         ShowLineComments;
//                     end;
//                 }
//                 action("Item Charge &Assignment")
//                 {
//                     Caption = 'Item Charge &Assignment';

//                     trigger OnAction()
//                     begin
//                         ItemChargeAssgnt;
//                     end;
//                 }
//                 action(OrderPromising)
//                 {
//                     Caption = 'Order &Promising';
//                     Image = OrderPromising;

//                     trigger OnAction()
//                     begin
//                         OrderPromisingLine;
//                     end;
//                 }
//                 action("Bin Contents")
//                 {

//                     trigger OnAction()
//                     begin

//                         //alok for open bin content form
//                         //CurrForm.SalesLines.FORM.Openbincontent;
//                         Openbincontent;
//                         //alok finish
//                     end;
//                 }
//                 group("Assemble to Order")
//                 {
//                     Caption = 'Assemble to Order';
//                     Image = AssemblyBOM;
//                     action(AssembleToOrderLines)
//                     {
//                         Caption = 'Assemble-to-Order Lines';

//                         trigger OnAction()
//                         begin
//                             ShowAsmToOrderLines;
//                         end;
//                     }
//                     action("Roll Up &Price")
//                     {
//                         Caption = 'Roll Up &Price';
//                         Ellipsis = true;

//                         trigger OnAction()
//                         begin
//                             RollupAsmPrice;
//                         end;
//                     }
//                     action("Roll Up &Cost")
//                     {
//                         Caption = 'Roll Up &Cost';
//                         Ellipsis = true;

//                         trigger OnAction()
//                         begin
//                             RollUpAsmCost;
//                         end;
//                     }
//                 }
//             }
//             group("F&unctions")
//             {
//                 Caption = 'F&unctions';
//                 Image = "Action";
//                 action(GetPrice)
//                 {
//                     Caption = 'Get Price';
//                     Ellipsis = true;
//                     Image = Price;

//                     trigger OnAction()
//                     begin
//                         ShowPrices;
//                     end;
//                 }
//                 action("Get Li&ne Discount")
//                 {
//                     Caption = 'Get Li&ne Discount';
//                     Ellipsis = true;
//                     Image = LineDiscount;

//                     trigger OnAction()
//                     begin
//                         ShowLineDisc
//                     end;
//                 }
//                 action(ExplodeBOM_Functions)
//                 {
//                     Caption = 'E&xplode BOM';
//                     Image = ExplodeBOM;

//                     trigger OnAction()
//                     begin
//                         ExplodeBOM;
//                     end;
//                 }
//                 action("Insert Ext. Texts")
//                 {
//                     Caption = 'Insert &Ext. Texts';
//                     Image = Text;

//                     trigger OnAction()
//                     begin
//                         InsertExtendedText(TRUE);
//                     end;
//                 }
//                 action(Reserve)
//                 {
//                     Caption = '&Reserve';
//                     Ellipsis = true;
//                     Image = Reserve;

//                     trigger OnAction()
//                     begin
//                         FIND;
//                         ShowReservation;
//                     end;
//                 }
//                 action(OrderTracking)
//                 {
//                     Caption = 'Order &Tracking';
//                     Image = OrderTracking;

//                     trigger OnAction()
//                     begin
//                         ShowTracking;
//                     end;
//                 }
//                 action("Nonstoc&k Items")
//                 {
//                     Caption = 'Nonstoc&k Items';
//                     Image = NonStockItem;

//                     trigger OnAction()
//                     begin
//                         ShowNonstockItems;
//                     end;
//                 }
//             }
//             group("O&rder")
//             {
//                 Caption = 'O&rder';
//                 Image = "Order";
//                 group("Dr&op Shipment")
//                 {
//                     Caption = 'Dr&op Shipment';
//                     Image = Delivery;
//                     action("Purchase &Order")
//                     {
//                         Caption = 'Purchase &Order';
//                         Image = Document;

//                         trigger OnAction()
//                         begin
//                             OpenPurchOrderForm;
//                         end;
//                     }
//                 }
//                 group("Speci&al Order")
//                 {
//                     Caption = 'Speci&al Order';
//                     Image = SpecialOrder;
//                     action(OpenSpecialPurchaseOrder)
//                     {
//                         Caption = 'Purchase &Order';
//                         Image = Document;

//                         trigger OnAction()
//                         begin
//                             OpenSpecialPurchOrderForm;
//                         end;
//                     }
//                 }
//             }
//         }
//     }

//     trigger OnAfterGetRecord()
//     begin
//         ShowShortcutDimCode(ShortcutDimCode);
//     end;

//     trigger OnDeleteRecord(): Boolean
//     var
//         ReserveSalesLine: Codeunit "99000832";
//     begin
//         IF (Quantity <> 0) AND ItemExists("No.") THEN BEGIN
//           COMMIT;
//           IF NOT ReserveSalesLine.DeleteLineConfirm(Rec) THEN
//             EXIT(FALSE);
//           ReserveSalesLine.DeleteLine(Rec);
//         END;
//     end;

//     trigger OnNewRecord(BelowxRec: Boolean)
//     begin
//         InitType;
//         CLEAR(ShortcutDimCode);
//     end;

//     var
//         SalesHeader: Record "36";
//         SalesPriceCalcMgt: Codeunit "7000";
//         TransferExtendedText: Codeunit "378";
//         ItemAvailFormsMgt: Codeunit "353";
//         ShortcutDimCode: array [8] of Code[20];
//         Text001: Label 'You cannot use the Explode BOM function because a prepayment of the sales order has been invoiced.';
//         [InDataSet]
//         ItemPanelVisible: Boolean;
//         ItemTrackingDataCollection: Codeunit "6501";
//         recTrackingSpecification: Record "336" temporary;
//         ReserveSalesLine: Codeunit "99000832";
//         CurrentSignFactor: Integer;
//         recReservationEntry: Record "337";
//         CreateReservEntry: Codeunit "99000830";
//         UndefinedQtyArray: array [3] of Decimal;
//         ForBinCode: Code[20];
//         TempItemTrackLineModify: Record "336" temporary;
//         TempItemTrackLineInsert: Record "336" temporary;
//         LastEntryNo: Integer;
//         TotalItemTrackingLine: Record "336";
//         SourceQuantityArray: array [5] of Decimal;
//         QTY: Decimal;
//         Qty_Old: Decimal;
//         FlagLookUp: Boolean;
//         SelectedQty: Decimal;
//         Text002: Label 'You can only select Free OR Chemilines Location';

//     procedure ApproveCalcInvDisc()
//     begin
//         CODEUNIT.RUN(CODEUNIT::"Sales-Disc. (Yes/No)",Rec);
//     end;

//     procedure CalcInvDisc()
//     begin
//         CODEUNIT.RUN(CODEUNIT::"Sales-Calc. Discount",Rec);
//     end;

//     procedure ExplodeBOM()
//     begin
//         IF "Prepmt. Amt. Inv." <> 0 THEN
//           ERROR(Text001);
//         CODEUNIT.RUN(CODEUNIT::"Sales-Explode BOM",Rec);
//     end;

//     procedure OpenPurchOrderForm()
//     var
//         PurchHeader: Record "38";
//         PurchOrder: Page "50";
//     begin
//         TESTFIELD("Purchase Order No.");
//         PurchHeader.SETRANGE("No.","Purchase Order No.");
//         PurchOrder.SETTABLEVIEW(PurchHeader);
//         PurchOrder.EDITABLE := FALSE;
//         PurchOrder.RUN;
//     end;

//     procedure OpenSpecialPurchOrderForm()
//     var
//         PurchHeader: Record "38";
//         PurchRcptHeader: Record "120";
//         PurchOrder: Page "50";
//     begin
//         TESTFIELD("Special Order Purchase No.");
//         PurchHeader.SETRANGE("No.","Special Order Purchase No.");
//         IF NOT PurchHeader.ISEMPTY THEN BEGIN
//           PurchOrder.SETTABLEVIEW(PurchHeader);
//           PurchOrder.EDITABLE := FALSE;
//           PurchOrder.RUN;
//         END ELSE BEGIN
//           PurchRcptHeader.SETRANGE("Order No.","Special Order Purchase No.");
//           IF PurchRcptHeader.COUNT = 1 THEN
//             PAGE.RUN(PAGE::"Posted Purchase Receipt",PurchRcptHeader)
//           ELSE
//             PAGE.RUN(PAGE::"Posted Purchase Receipts",PurchRcptHeader);
//         END;
//     end;

//     procedure InsertExtendedText(Unconditionally: Boolean)
//     begin
//         IF TransferExtendedText.SalesCheckIfAnyExtText(Rec,Unconditionally) THEN BEGIN
//           CurrPage.SAVERECORD;
//           COMMIT;
//           TransferExtendedText.InsertSalesExtText(Rec);
//         END;
//         IF TransferExtendedText.MakeUpdate THEN
//           UpdateForm(TRUE);
//     end;

//     procedure ShowNonstockItems()
//     begin
//         ShowNonstock;
//     end;

//     procedure ShowTracking()
//     var
//         TrackingForm: Page "99000822";
//     begin
//         TrackingForm.SetSalesLine(Rec);
//         TrackingForm.RUNMODAL;
//     end;

//     procedure ItemChargeAssgnt()
//     begin
//         ShowItemChargeAssgnt;
//     end;

//     procedure UpdateForm(SetSaveRecord: Boolean)
//     begin
//         CurrPage.UPDATE(SetSaveRecord);
//     end;

//     procedure ShowPrices()
//     begin
//         SalesHeader.GET("Document Type","Document No.");
//         CLEAR(SalesPriceCalcMgt);
//         SalesPriceCalcMgt.GetSalesLinePrice(SalesHeader,Rec);
//     end;

//     procedure ShowLineDisc()
//     begin
//         SalesHeader.GET("Document Type","Document No.");
//         CLEAR(SalesPriceCalcMgt);
//         SalesPriceCalcMgt.GetSalesLineLineDisc(SalesHeader,Rec);
//     end;

//     procedure OrderPromisingLine()
//     var
//         OrderPromisingLine: Record "99000880" temporary;
//         OrderPromisingLines: Page "99000959";
//     begin
//         OrderPromisingLine.SETRANGE("Source Type","Document Type");
//         OrderPromisingLine.SETRANGE("Source ID","Document No.");
//         OrderPromisingLine.SETRANGE("Source Line No.","Line No.");

//         OrderPromisingLines.SetSourceType(OrderPromisingLine."Source Type"::Sales);
//         OrderPromisingLines.SETTABLEVIEW(OrderPromisingLine);
//         OrderPromisingLines.RUNMODAL;
//     end;

//     local procedure TypeOnAfterValidate()
//     begin
//         ItemPanelVisible := Type = Type::Item;
//     end;

//     local procedure NoOnAfterValidate()
//     begin
//         InsertExtendedText(FALSE);
//         IF (Type = Type::"Charge (Item)") AND ("No." <> xRec."No.") AND
//            (xRec."No." <> '')
//         THEN
//           CurrPage.SAVERECORD;

//         SaveAndAutoAsmToOrder;

//         IF (Reserve = Reserve::Always) AND
//            ("Outstanding Qty. (Base)" <> 0) AND
//            ("No." <> xRec."No.")
//         THEN BEGIN
//           CurrPage.SAVERECORD;
//           AutoReserve;
//           CurrPage.UPDATE(FALSE);
//         END;
//     end;

//     local procedure CrossReferenceNoOnAfterValidat()
//     begin
//         InsertExtendedText(FALSE);
//     end;

//     local procedure VariantCodeOnAfterValidate()
//     begin
//         SaveAndAutoAsmToOrder;
//     end;

//     local procedure LocationCodeOnAfterValidate()
//     begin
//         SaveAndAutoAsmToOrder;

//         IF (Reserve = Reserve::Always) AND
//            ("Outstanding Qty. (Base)" <> 0) AND
//            ("Location Code" <> xRec."Location Code")
//         THEN BEGIN
//           CurrPage.SAVERECORD;
//           AutoReserve;
//           CurrPage.UPDATE(FALSE);
//         END;
//     end;

//     local procedure ReserveOnAfterValidate()
//     begin
//         IF (Reserve = Reserve::Always) AND ("Outstanding Qty. (Base)" <> 0) THEN BEGIN
//           CurrPage.SAVERECORD;
//           AutoReserve;
//           CurrPage.UPDATE(FALSE);
//         END;
//     end;

//     local procedure QuantityOnAfterValidate()
//     var
//         UpdateIsDone: Boolean;
//     begin
//         IF Type = Type::Item THEN
//           CASE Reserve OF
//             Reserve::Always:
//               BEGIN
//                 CurrPage.SAVERECORD;
//                 AutoReserve;
//                 CurrPage.UPDATE(FALSE);
//                 UpdateIsDone := TRUE;
//               END;
//             Reserve::Optional:
//               IF (Quantity < xRec.Quantity) AND (xRec.Quantity > 0) THEN BEGIN
//                 CurrPage.SAVERECORD;
//                 CurrPage.UPDATE(FALSE);
//                 UpdateIsDone := TRUE;
//               END;
//           END;

//         IF (Type = Type::Item) AND
//            (Quantity <> xRec.Quantity) AND
//            NOT UpdateIsDone
//         THEN
//           CurrPage.UPDATE(TRUE);
//     end;

//     local procedure QtyToAsmToOrderOnAfterValidate()
//     begin
//         CurrPage.SAVERECORD;
//         IF Reserve = Reserve::Always THEN
//           AutoReserve;
//         CurrPage.UPDATE(TRUE);
//     end;

//     local procedure UnitofMeasureCodeOnAfterValida()
//     begin
//         IF Reserve = Reserve::Always THEN BEGIN
//           CurrPage.SAVERECORD;
//           AutoReserve;
//           CurrPage.UPDATE(FALSE);
//         END;
//     end;

//     local procedure ShipmentDateOnAfterValidate()
//     begin
//         IF (Reserve = Reserve::Always) AND
//            ("Outstanding Qty. (Base)" <> 0) AND
//            ("Shipment Date" <> xRec."Shipment Date")
//         THEN BEGIN
//           CurrPage.SAVERECORD;
//           AutoReserve;
//           CurrPage.UPDATE(FALSE);
//         END;
//     end;

//     local procedure SaveAndAutoAsmToOrder()
//     begin
//         IF (Type = Type::Item) AND IsAsmToOrderRequired THEN BEGIN
//           CurrPage.SAVERECORD;
//           AutoAsmToOrder;
//           CurrPage.UPDATE(FALSE);
//         END;
//     end;

//     procedure Openbincontent()
//     var
//         BinContent: Record "7302";
//         ItemBinForm: Page "7379";
//     begin
//         //alok for opem bin content form on sales line
//         BinContent.RESET;
//         BinContent.SETRANGE(BinContent."Location Code",Rec."Location Code");
//         BinContent.SETRANGE(BinContent."Item No.",Rec."No.");
//         ItemBinForm.SETTABLEVIEW(BinContent);
//         ItemBinForm.RUN;
//         //alok finish
//     end;

//     procedure SelectEntries()
//     var
//         xTrackingSpec: Record "336";
//         MaxQuantity: Decimal;
//     begin
//         //05Feb2014++
//         TempItemTrackLineInsert.DELETEALL;
//         TempItemTrackLineModify.DELETEALL;
//         xTrackingSpec.DELETEALL;
//         recTrackingSpecification.DELETEALL;
//         //05Feb2014--
//         xTrackingSpec.COPYFILTERS(recTrackingSpecification);
//         MaxQuantity := UndefinedQtyArray[1];
//         IF MaxQuantity * CurrentSignFactor > 0 THEN
//           MaxQuantity := 0;
//         recTrackingSpecification."Bin Code" := ForBinCode;
//         //ItemTrackingDataCollection.SelectMultipleLotSerialNo(recTrackingSpecification,MaxQuantity,CurrentSignFactor);
//         ItemTrackingDataCollection.SelectMultipleLotSerialNo1(recTrackingSpecification,QTY,CurrentSignFactor,FlagLookUp,SelectedQty);
//         recTrackingSpecification."Bin Code" := '';
//         IF recTrackingSpecification.FINDSET THEN
//           REPEAT
//             CASE recTrackingSpecification."Buffer Status" OF
//               recTrackingSpecification."Buffer Status"::MODIFY:
//                 BEGIN
//                   IF TempItemTrackLineModify.GET(recTrackingSpecification."Entry No.") THEN
//                     TempItemTrackLineModify.DELETE;
//                   IF TempItemTrackLineInsert.GET(recTrackingSpecification."Entry No.") THEN BEGIN
//                     TempItemTrackLineInsert.TRANSFERFIELDS(recTrackingSpecification);
//                     TempItemTrackLineInsert.MODIFY;
//                   END ELSE BEGIN
//                     TempItemTrackLineModify.TRANSFERFIELDS(recTrackingSpecification);
//                     TempItemTrackLineModify.INSERT;
//                   END;
//                 END;
//               recTrackingSpecification."Buffer Status"::INSERT:
//                 BEGIN
//                   TempItemTrackLineInsert.TRANSFERFIELDS(recTrackingSpecification);
//                   TempItemTrackLineInsert.INSERT;
//                 END;
//             END;
//             recTrackingSpecification."Buffer Status" := 0;
//             recTrackingSpecification.MODIFY;
//             //MESSAGE('%1\%2',recTrackingSpecification."Lot No.",recTrackingSpecification."Quantity (Base)");
//         //added by anikEt on 05Feb2014
//         IF (FlagLookUp) AND (SelectedQty>0)  THEN
//         BEGIN
//         CreateReservEntry.CreateReservEntryFor(
//                 recTrackingSpecification."Source Type",
//                 recTrackingSpecification."Source Subtype",
//                 recTrackingSpecification."Source ID",
//                 recTrackingSpecification."Source Batch Name",
//                 recTrackingSpecification."Source Prod. Order Line",
//                 recTrackingSpecification."Source Ref. No.",
//                 recTrackingSpecification."Qty. per Unit of Measure",
//                 0,
//                 recTrackingSpecification."Quantity (Base)",
//                 recTrackingSpecification."Serial No.",
//                 recTrackingSpecification."Lot No.");


//               CreateReservEntry.CreateEntry(recTrackingSpecification."Item No.",
//                 recTrackingSpecification."Variant Code",
//                 recTrackingSpecification."Location Code",
//                 recTrackingSpecification.Description,
//                 0D,
//                 0D,0,2);
//         END;
//         //
//           UNTIL recTrackingSpecification.NEXT = 0;
//         LastEntryNo := recTrackingSpecification."Entry No.";
//         CalculateSums;
//         UpdateUndefinedQty;
//         recTrackingSpecification.COPYFILTERS(xTrackingSpec);
//         CurrPage.UPDATE(FALSE);
//     end;

//     local procedure CalculateSums()
//     var
//         xTrackingSpec: Record "336";
//     begin
//         xTrackingSpec.COPY(recTrackingSpecification);
//         recTrackingSpecification.RESET;
//         recTrackingSpecification.CALCSUMS("Quantity (Base)",
//           "Qty. to Handle (Base)",
//           "Qty. to Invoice (Base)");
//         TotalItemTrackingLine := recTrackingSpecification;
//         recTrackingSpecification.COPY(xTrackingSpec);

//         UpdateUndefinedQty;
//     end;

//     local procedure UpdateUndefinedQty() QtyIsValid: Boolean
//     begin
//         UndefinedQtyArray[1] := SourceQuantityArray[1] - TotalItemTrackingLine."Quantity (Base)";
//         UndefinedQtyArray[2] := SourceQuantityArray[2] - TotalItemTrackingLine."Qty. to Handle (Base)";
//         UndefinedQtyArray[3] := SourceQuantityArray[3] - TotalItemTrackingLine."Qty. to Invoice (Base)";

//         IF ABS(SourceQuantityArray[1]) < ABS(TotalItemTrackingLine."Quantity (Base)") THEN
//           QtyIsValid := FALSE
//         ELSE
//           QtyIsValid := TRUE;
//     end;
// }

