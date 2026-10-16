page 60031 NetEDI_Order_Line_New
{
    // version NAVW17.00

    // Case No - CAS-05893-Q7W3X2
    // Description - Sales person can only select Free or Chemiines Location

    AutoSplitKey = true;
    Caption = 'NetEDI_Order_Line_New';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = 37;
    SourceTableView = WHERE("Document Type" = FILTER(Order));

    layout
    {
        area(content)
        {
            repeater(Lines)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        TypeOnAfterValidate;
                    end;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec.ShowShortcutDimCode(ShortcutDimCode);
                        NoOnAfterValidate;
                    end;
                }
                field("Cross-Reference No."; Rec."Item Reference No.")
                {
                    ApplicationArea = All;
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        // "Cross-Reference No." was replaced by "Item Reference No." in modern BC; lookup is now handled automatically via the field's own table relation, so the old CrossReferenceNoLookUp table method (removed by Microsoft) is no longer called here.
                        InsertExtendedText(FALSE);
                    end;

                    trigger OnValidate()
                    begin
                        CrossReferenceNoOnAfterValidat;
                    end;
                }
                field("IC Partner Code"; Rec."IC Partner Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("IC Partner Ref. Type"; Rec."IC Partner Ref. Type")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("IC Partner Reference"; Rec."IC Partner Reference")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        VariantCodeOnAfterValidate;
                    end;
                }
                field("Substitution Available"; Rec."Substitution Available")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Purchasing Code"; Rec."Purchasing Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Nonstock; Rec.Nonstock)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    QuickEntry = false;
                }
                field("Drop Shipment"; Rec."Drop Shipment")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Special Order"; Rec."Special Order")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Return Reason Code"; Rec."Return Reason Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    QuickEntry = false;

                    trigger OnValidate()
                    begin
                        /*
                        //CAS-04375-Z0H4D8//
                        IF COMPANYNAME = 'Chemilines Limited' THEN
                        BEGIN
                          IF Type=2 THEN
                          BEGIN
                              IF("Location Code"<>'FREE') THEN
                              ERROR(Text002);
                          END;
                        END;
                        //CAS-04375-Z0H4D8//
                        */

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
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Reserve; Rec.Reserve)
                {
                    ApplicationArea = All;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        ReserveOnAfterValidate;
                    end;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    BlankZero = true;

                    trigger OnValidate()
                    begin
                        QuantityOnAfterValidate;
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

                        //ReserveSalesLine.BindToPurchase(Rec,recTrackingSpecification);  //

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
                    ApplicationArea = All;
                    BlankZero = true;
                    Visible = false;

                    trigger OnDrillDown()
                    begin
                        rec.ShowAsmToOrderLines;
                    end;

                    trigger OnValidate()
                    begin
                        QtyToAsmToOrderOnAfterValidate;
                    end;
                }
                field("Reserved Quantity"; Rec."Reserved Quantity")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    QuickEntry = false;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                    QuickEntry = false;

                    trigger OnValidate()
                    begin
                        UnitofMeasureCodeOnAfterValida;
                    end;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field(SalesPriceExist; Rec.PriceExists)
                {
                    ApplicationArea = All;
                    Caption = 'Sales Price Exists';
                    Editable = false;
                    Visible = false;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                    BlankZero = true;

                    trigger OnValidate()
                    var
                        Item: Record Item;
                    begin
                        /*//JIRA Chem-343++
                        Item.RESET;
                        Item.SETRANGE(Item."No.","No.");
                        IF Item.FINDFIRST THEN
                        BEGIN
                          IF "Unit Price"<Item."Unit Cost" THEN
                            CASE  UPPERCASE(USERID) OF
                            UPPERCASE('CHEMILINES\KASHYAP.KARIA'),UPPERCASE('CHEMILINES\KEITH.BEARD'),UPPERCASE('CHEMILINES\UMESH.PATEL'),UPPERCASE('CHEMILINES\ROSHNI.DAS'),
                             UPPERCASE('CHEMILINES\MAHESH.PANDIT'),UPPERCASE('CHEMILINES\MATTHEW.THREADER'),UPPERCASE('CHEMILINES\VISHAL.KARIA'),UPPERCASE('CHEMILINES\JAGDISH.KARIA'),UPPERCASE('CHEMILINES\RAVI.KARIA'):
                                MESSAGE('Unit Price is less than Unit Cost');
                             ELSE
                              ERROR('Unit Price Cannot be less than Unit Cost');
                            END;
                        END
                        //JIRA Chem-343--
                         */

                    end;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    Editable = false;
                }
                field(SalesLineDiscExists; Rec.LineDiscExists)
                {
                    ApplicationArea = All;
                    Caption = 'Sales Line Disc. Exists';
                    Editable = false;
                    Visible = false;
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    Visible = false;
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Prepayment %"; Rec."Prepayment %")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Prepmt. Line Amount"; Rec."Prepmt. Line Amount")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Prepmt. Amt. Inv."; Rec."Prepmt. Amt. Inv.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Inv. Discount Amount"; Rec."Inv. Discount Amount")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Qty. to Ship"; Rec."Qty. to Ship")
                {
                    ApplicationArea = All;
                    BlankZero = true;

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
                    ApplicationArea = All;
                    BlankZero = true;
                    QuickEntry = false;
                }
                field("Qty. to Invoice"; Rec."Qty. to Invoice")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                }
                field("Quantity Invoiced"; Rec."Quantity Invoiced")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                }
                field("Prepmt Amt to Deduct"; Rec."Prepmt Amt to Deduct")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Prepmt Amt Deducted"; Rec."Prepmt Amt Deducted")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Allow Item Charge Assignment"; Rec."Allow Item Charge Assignment")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Qty. to Assign"; Rec."Qty. to Assign")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    QuickEntry = false;

                    trigger OnDrillDown()
                    begin
                        CurrPage.SAVERECORD;
                        Rec.ShowItemChargeAssgnt;
                        UpdateForm(FALSE);
                    end;
                }
                field("Qty. Assigned"; Rec."Qty. Assigned")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    QuickEntry = false;

                    trigger OnDrillDown()
                    begin
                        CurrPage.SAVERECORD;
                        Rec.ShowItemChargeAssgnt;
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                field("Requested Delivery Date"; Rec."Requested Delivery Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Promised Delivery Date"; Rec."Promised Delivery Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Planned Delivery Date"; Rec."Planned Delivery Date")
                {
                    ApplicationArea = All;
                    QuickEntry = false;
                }
                field("Planned Shipment Date"; Rec."Planned Shipment Date")
                {
                    ApplicationArea = All;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = All;
                    QuickEntry = false;

                    trigger OnValidate()
                    begin
                        ShipmentDateOnAfterValidate;
                    end;
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shipping Time"; Rec."Shipping Time")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Work Type Code"; Rec."Work Type Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Whse. Outstanding Qty."; Rec."Whse. Outstanding Qty.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Whse. Outstanding Qty. (Base)"; Rec."Whse. Outstanding Qty. (Base)")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("ATO Whse. Outstanding Qty."; Rec."ATO Whse. Outstanding Qty.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("ATO Whse. Outstd. Qty. (Base)"; Rec."ATO Whse. Outstd. Qty. (Base)")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Outbound Whse. Handling Time"; Rec."Outbound Whse. Handling Time")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Blanket Order No."; Rec."Blanket Order No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Blanket Order Line No."; Rec."Blanket Order Line No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("FA Posting Date"; Rec."FA Posting Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Depr. until FA Posting Date"; Rec."Depr. until FA Posting Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Depreciation Book Code"; Rec."Depreciation Book Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Use Duplication List"; Rec."Use Duplication List")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Duplicate in Depreciation Book"; Rec."Duplicate in Depreciation Book")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Appl.-from Item Entry"; Rec."Appl.-from Item Entry")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Appl.-to Item Entry"; Rec."Appl.-to Item Entry")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(ShortcutDimCode3; ShortcutDimCode[3])
                {
                    ApplicationArea = All;
                    CaptionClass = '1,2,3';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(3, ShortcutDimCode[3]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                    end;
                }
                field(ShortcutDimCode4; ShortcutDimCode[4])
                {
                    ApplicationArea = All;
                    CaptionClass = '1,2,4';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(4, ShortcutDimCode[4]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                    end;
                }
                field(ShortcutDimCode5; ShortcutDimCode[5])
                {
                    ApplicationArea = All;
                    CaptionClass = '1,2,5';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(5, ShortcutDimCode[5]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                    end;
                }
                field(ShortcutDimCode6; ShortcutDimCode[6])
                {
                    ApplicationArea = All;
                    CaptionClass = '1,2,6';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(6, ShortcutDimCode[6]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                    end;
                }
                field(ShortcutDimCode7; ShortcutDimCode[7])
                {
                    ApplicationArea = All;
                    CaptionClass = '1,2,7';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(7, ShortcutDimCode[7]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                    end;
                }
                field(ShortcutDimCode8; ShortcutDimCode[8])
                {
                    ApplicationArea = All;
                    CaptionClass = '1,2,8';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(8, ShortcutDimCode[8]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                group("Item Availability by")
                {
                    Caption = 'Item Availability by';
                    Image = ItemAvailability;
                    action("<Action3>")
                    {
                        ApplicationArea = All;
                        Caption = 'Event';
                        Image = "Event";

                        trigger OnAction()
                        begin
                            SalesAvailabilityMgt.ShowItemAvailabilityFromSalesLine(Rec, "Item Availability Type"::"Event");
                        end;
                    }
                    action(Period)
                    {
                        ApplicationArea = All;
                        Caption = 'Period';
                        Image = Period;

                        trigger OnAction()
                        begin
                            SalesAvailabilityMgt.ShowItemAvailabilityFromSalesLine(Rec, "Item Availability Type"::Period);
                        end;
                    }
                    action(Variant)
                    {
                        ApplicationArea = All;
                        Caption = 'Variant';
                        Image = ItemVariant;

                        trigger OnAction()
                        begin
                            SalesAvailabilityMgt.ShowItemAvailabilityFromSalesLine(Rec, "Item Availability Type"::Variant);
                        end;
                    }
                    action(Location)
                    {
                        ApplicationArea = All;
                        Caption = 'Location';
                        Image = Warehouse;

                        trigger OnAction()
                        begin
                            SalesAvailabilityMgt.ShowItemAvailabilityFromSalesLine(Rec, "Item Availability Type"::Location);
                        end;
                    }
                    action("BOM Level")
                    {
                        ApplicationArea = All;
                        Caption = 'BOM Level';
                        Image = BOMLevel;

                        trigger OnAction()
                        begin
                            SalesAvailabilityMgt.ShowItemAvailabilityFromSalesLine(Rec, "Item Availability Type"::BOM);
                        end;
                    }
                }
                action("Reservation Entries")
                {
                    ApplicationArea = All;
                    Caption = 'Reservation Entries';
                    Image = ReservationLedger;

                    trigger OnAction()
                    begin
                        Rec.ShowReservationEntries(TRUE);
                    end;
                }
                action(ItemTrackingLines)
                {
                    ApplicationArea = All;
                    Caption = 'Item &Tracking Lines';
                    Image = ItemTrackingLines;
                    ShortCutKey = 'Shift+Ctrl+I';

                    trigger OnAction()
                    begin
                        Rec.OpenItemTrackingLines;
                    end;
                }
                action("Select Item Substitution")
                {
                    ApplicationArea = All;
                    Caption = 'Select Item Substitution';
                    Image = SelectItemSubstitution;

                    trigger OnAction()
                    begin
                        Rec.ShowItemSub;
                    end;
                }
                action(Dimensions)
                {
                    ApplicationArea = All;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        Rec.ShowDimensions;
                    end;
                }
                action("Co&mments")
                {
                    ApplicationArea = All;
                    Caption = 'Co&mments';
                    Image = ViewComments;

                    trigger OnAction()
                    begin
                        Rec.ShowLineComments;
                    end;
                }
                action("Item Charge &Assignment")
                {
                    ApplicationArea = All;
                    Caption = 'Item Charge &Assignment';

                    trigger OnAction()
                    begin
                        ItemChargeAssgnt;
                    end;
                }
                action(OrderPromising)
                {
                    ApplicationArea = All;
                    Caption = 'Order &Promising';
                    Image = OrderPromising;

                    trigger OnAction()
                    begin
                        OrderPromisingLine;
                    end;
                }
                action("Bin Contents")
                {
                    ApplicationArea = All;

                    trigger OnAction()
                    begin

                        //alok for open bin content form
                        //CurrForm.SalesLines.FORM.Openbincontent;
                        Openbincontent;
                        //alok finish
                    end;
                }
                group("Assemble to Order")
                {
                    Caption = 'Assemble to Order';
                    Image = AssemblyBOM;
                    action(AssembleToOrderLines)
                    {
                        ApplicationArea = All;
                        Caption = 'Assemble-to-Order Lines';

                        trigger OnAction()
                        begin
                            Rec.ShowAsmToOrderLines;
                        end;
                    }
                    action("Roll Up &Price")
                    {
                        ApplicationArea = All;
                        Caption = 'Roll Up &Price';
                        Ellipsis = true;

                        trigger OnAction()
                        begin
                            Rec.RollupAsmPrice;
                        end;
                    }
                    action("Roll Up &Cost")
                    {
                        ApplicationArea = All;
                        Caption = 'Roll Up &Cost';
                        Ellipsis = true;

                        trigger OnAction()
                        begin
                            Rec.RollUpAsmCost;
                        end;
                    }
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action(GetPrice)
                {
                    ApplicationArea = All;
                    Caption = 'Get Price';
                    Ellipsis = true;
                    Image = Price;

                    trigger OnAction()
                    begin
                        ShowPrices;
                    end;
                }
                action("Get Li&ne Discount")
                {
                    ApplicationArea = All;
                    Caption = 'Get Li&ne Discount';
                    Ellipsis = true;
                    Image = LineDiscount;

                    trigger OnAction()
                    begin
                        ShowLineDisc
                    end;
                }
                action(ExplodeBOM_Functions)
                {
                    ApplicationArea = All;
                    Caption = 'E&xplode BOM';
                    Image = ExplodeBOM;

                    trigger OnAction()
                    begin
                        ExplodeBOM;
                    end;
                }
                action("Insert Ext. Texts")
                {
                    ApplicationArea = All;
                    Caption = 'Insert &Ext. Texts';
                    Image = Text;

                    trigger OnAction()
                    begin
                        InsertExtendedText(TRUE);
                    end;
                }
                action(R_Reserve)
                {
                    ApplicationArea = All;
                    Caption = '&Reserve';
                    Ellipsis = true;
                    Image = Reserve;

                    trigger OnAction()
                    begin
                        Rec.FIND;
                        Rec.ShowReservation;
                    end;
                }
                action(OrderTracking)
                {
                    ApplicationArea = All;
                    Caption = 'Order &Tracking';
                    Image = OrderTracking;

                    trigger OnAction()
                    begin
                        ShowTracking;
                    end;
                }
                action("Nonstoc&k Items")
                {
                    ApplicationArea = All;
                    Caption = 'Nonstoc&k Items';
                    Image = NonStockItem;

                    trigger OnAction()
                    begin
                        ShowNonstockItems;
                    end;
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
                        ApplicationArea = All;
                        Caption = 'Purchase &Order';
                        Image = Document;

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
                        ApplicationArea = All;
                        Caption = 'Purchase &Order';
                        Image = Document;

                        trigger OnAction()
                        begin
                            OpenSpecialPurchOrderForm;
                        end;
                    }
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
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
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.InitType;
        CLEAR(ShortcutDimCode);
    end;

    var
        SalesHeader: Record "Sales Header";
        SalesPriceCalcMgt: Codeunit "Sales Price Calc. Mgt.";
        TransferExtendedText: Codeunit "Transfer Extended Text";
        SalesAvailabilityMgt: Codeunit "Sales Availability Mgt.";
        ShortcutDimCode: array[8] of Code[20];
        Text001: Label 'You cannot use the Explode BOM function because a prepayment of the sales order has been invoiced.';
        [InDataSet]
        ItemPanelVisible: Boolean;
        ItemTrackingDataCollection: Codeunit "Item Tracking Data Collection";
        NHSItemTrackingDataColl: Codeunit "NHS Item Tracking Data Coll.";
        recTrackingSpecification: Record "Tracking Specification" temporary;
        ReserveSalesLine: Codeunit "Sales Line-Reserve";
        CurrentSignFactor: Integer;
        recReservationEntry: Record "Reservation Entry";
        ForReservEntry: Record "Reservation Entry";
        CreateReservEntry: Codeunit "Create Reserv. Entry";
        UndefinedQtyArray: array[3] of Decimal;
        ForBinCode: Code[20];
        TempItemTrackLineModify: Record "Tracking Specification" temporary;
        TempItemTrackLineInsert: Record "Tracking Specification" temporary;
        LastEntryNo: Integer;
        TotalItemTrackingLine: Record "Tracking Specification";
        SourceQuantityArray: array[5] of Decimal;
        QTY: Decimal;
        Qty_Old: Decimal;
        FlagLookUp: Boolean;
        SelectedQty: Decimal;
        Text002: Label 'You can only select Free OR Chemilines Location';

    procedure ApproveCalcInvDisc()
    begin
        CODEUNIT.RUN(CODEUNIT::"Sales-Disc. (Yes/No)", Rec);
    end;

    procedure CalcInvDisc()
    begin
        CODEUNIT.RUN(CODEUNIT::"Sales-Calc. Discount", Rec);
    end;

    procedure ExplodeBOM()
    begin
        IF Rec."Prepmt. Amt. Inv." <> 0 THEN
            ERROR(Text001);
        CODEUNIT.RUN(CODEUNIT::"Sales-Explode BOM", Rec);
    end;

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

    procedure InsertExtendedText(Unconditionally: Boolean)
    begin
        IF TransferExtendedText.SalesCheckIfAnyExtText(Rec, Unconditionally) THEN BEGIN
            CurrPage.SAVERECORD;
            COMMIT;
            TransferExtendedText.InsertSalesExtText(Rec);
        END;
        IF TransferExtendedText.MakeUpdate THEN
            UpdateForm(TRUE);
    end;

    procedure ShowNonstockItems()
    begin
        Rec.ShowNonstock;
    end;

    procedure ShowTracking()
    var
        TrackingForm: Page "Order Tracking";
    begin
        // SetSalesLine was replaced by the generic SetVariantRec in modern BC (all per-document overloads were consolidated into one method).
        TrackingForm.SetVariantRec(Rec, Rec."No.", Rec."Outstanding Qty. (Base)", Rec."Shipment Date", Rec."Shipment Date");
        TrackingForm.RUNMODAL;
    end;

    procedure ItemChargeAssgnt()
    begin
        Rec.ShowItemChargeAssgnt;
    end;

    procedure UpdateForm(SetSaveRecord: Boolean)
    begin
        CurrPage.UPDATE(SetSaveRecord);
    end;

    procedure ShowPrices()
    begin
        SalesHeader.GET(Rec."Document Type", Rec."Document No.");
        CLEAR(SalesPriceCalcMgt);
        SalesPriceCalcMgt.GetSalesLinePrice(SalesHeader, Rec);
    end;

    procedure ShowLineDisc()
    begin
        SalesHeader.GET(Rec."Document Type", Rec."Document No.");
        CLEAR(SalesPriceCalcMgt);
        SalesPriceCalcMgt.GetSalesLineLineDisc(SalesHeader, Rec);
    end;

    procedure OrderPromisingLine()
    var
        OrderPromisingLine: Record "Order Promising Line" temporary;
        OrderPromisingLines: Page "Order Promising Lines";
    begin
        OrderPromisingLine.SETRANGE("Source Type", "Order Promising Line Source Type"::Sales);
        OrderPromisingLine.SETRANGE("Source ID", Rec."Document No.");
        OrderPromisingLine.SETRANGE("Source Line No.", Rec."Line No.");

        OrderPromisingLines.SetSource("Order Promising Line Source Type"::Sales);
        OrderPromisingLines.SETTABLEVIEW(OrderPromisingLine);
        OrderPromisingLines.RUNMODAL;
    end;

    local procedure TypeOnAfterValidate()
    begin
        ItemPanelVisible := Rec.Type = Rec.Type::Item;
    end;

    local procedure NoOnAfterValidate()
    begin
        InsertExtendedText(FALSE);
        IF (Rec.Type = Rec.Type::"Charge (Item)") AND (Rec."No." <> xRec."No.") AND
           (xRec."No." <> '')
        THEN
            CurrPage.SAVERECORD;

        SaveAndAutoAsmToOrder;

        IF (Rec.Reserve = Rec.Reserve::Always) AND
           (Rec."Outstanding Qty. (Base)" <> 0) AND
           (Rec."No." <> xRec."No.")
        THEN BEGIN
            CurrPage.SAVERECORD;
            Rec.AutoReserve;
            CurrPage.UPDATE(FALSE);
        END;
    end;

    local procedure CrossReferenceNoOnAfterValidat()
    begin
        InsertExtendedText(FALSE);
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
            CurrPage.UPDATE(FALSE);
        END;
    end;

    local procedure QuantityOnAfterValidate()
    var
        UpdateIsDone: Boolean;
    begin
        IF Rec.Type = Rec.Type::Item THEN
            CASE Rec.Reserve OF
                Rec.Reserve::Always:
                    BEGIN
                        CurrPage.SAVERECORD;
                        Rec.AutoReserve;
                        CurrPage.UPDATE(FALSE);
                        UpdateIsDone := TRUE;
                    END;
                Rec.Reserve::Optional:
                    IF (Rec.Quantity < xRec.Quantity) AND (xRec.Quantity > 0) THEN BEGIN
                        CurrPage.SAVERECORD;
                        CurrPage.UPDATE(FALSE);
                        UpdateIsDone := TRUE;
                    END;
            END;

        IF (Rec.Type = Rec.Type::Item) AND
           (Rec.Quantity <> xRec.Quantity) AND
           NOT UpdateIsDone
        THEN
            CurrPage.UPDATE(TRUE);
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
        END;
    end;

    local procedure SaveAndAutoAsmToOrder()
    begin
        IF (Rec.Type = Rec.Type::Item) AND Rec.IsAsmToOrderRequired THEN BEGIN
            CurrPage.SAVERECORD;
            Rec.AutoAsmToOrder;
            CurrPage.UPDATE(FALSE);
        END;
    end;

    procedure Openbincontent()
    var
        BinContent: Record "Bin Content";
        ItemBinForm: Page "Bin Contents List";
    begin
        //alok for opem bin content form on sales line
        BinContent.RESET;
        BinContent.SETRANGE(BinContent."Location Code", Rec."Location Code");
        BinContent.SETRANGE(BinContent."Item No.", Rec."No.");
        ItemBinForm.SETTABLEVIEW(BinContent);
        ItemBinForm.RUN;
        //alok finish
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
        // SelectMultipleLotSerialNo1 (old NAV codeunit 6501 customization) is not portable to BC,
        // since Codeunit "Item Tracking Data Collection" can no longer be extended/modified directly.
        // NHSItemTrackingDataColl subscribes to the standard codeunit's own
        // OnSelectMultipleTrackingNoOnBeforeAddSelectedTrackingToDataSet event to recover the
        // FlagLookUp/SelectedQty information the old output parameters used to carry.
        NHSItemTrackingDataColl.ResetState();
        ItemTrackingDataCollection.SelectMultipleTrackingNo(recTrackingSpecification, QTY, CurrentSignFactor);
        FlagLookUp := NHSItemTrackingDataColl.GetFlagLookUp();
        SelectedQty := NHSItemTrackingDataColl.GetSelectedQty();
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
                // CreateReservEntryFor/CreateEntry signatures changed in modern BC:
                // - CreateReservEntryFor now carries Serial/Lot No. via a populated ForReservEntry
                //   record instead of loose Code values, and gained a non-base Quantity parameter.
                // - CreateEntry gained a Status: Enum "Reservation Status" parameter.
                IF (FlagLookUp) AND (SelectedQty > 0) THEN BEGIN
                    CLEAR(ForReservEntry);
                    ForReservEntry."Serial No." := recTrackingSpecification."Serial No.";
                    ForReservEntry."Lot No." := recTrackingSpecification."Lot No.";

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
                            ForReservEntry);


                    CreateReservEntry.CreateEntry(recTrackingSpecification."Item No.",
                      recTrackingSpecification."Variant Code",
                      recTrackingSpecification."Location Code",
                      recTrackingSpecification.Description,
                      0D,
                      0D, 0, Enum::"Reservation Status"::Reservation);
                END;
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