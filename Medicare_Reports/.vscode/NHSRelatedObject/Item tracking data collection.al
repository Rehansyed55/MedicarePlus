// codeunit 6501 "Item Tracking Data Collection"
// {
//     // version NAVW113.03

//     Permissions = TableData 6507=rd,
//                   TableData 6508=rd;

//     trigger OnRun()
//     begin
//     end;

//     var
//         Text004: Label 'Counting records...';
//         TempGlobalReservEntry: Record "337" temporary;
//         TempGlobalAdjustEntry: Record "337" temporary;
//         TempGlobalEntrySummary: Record "338" temporary;
//         TempGlobalChangedEntrySummary: Record "338" temporary;
//         CurrItemTrackingCode: Record "6502";
//         TempGlobalTrackingSpec: Record "336" temporary;
//         CurrBinCode: Code[20];
//         LastSummaryEntryNo: Integer;
//         LastReservEntryNo: Integer;
//         FullGlobalDataSetExists: Boolean;
//         AvailabilityWarningsMsg: Label 'The data used for availability calculation has been updated.\There are availability warnings on one or more lines.';
//         NoAvailabilityWarningsMsg: Label 'The data used for availability calculation has been updated.\There are no availability warnings.';
//         Text009: Label '%1 List';
//         Text010: Label '%1 %2 - Availability';
//         Text011: Label 'Item Tracking - Select Entries';
//         PartialGlobalDataSetExists: Boolean;
//         SkipLot: Boolean;
//         Text013: Label 'Neutralize consumption/output';
//         LotNoBySNNotFoundErr: Label 'A lot number could not be found for serial number %1.', Comment='%1 - serial number.';

//     [Scope('Personalization')]
//     procedure AssistEditTrackingNo(var TempTrackingSpecification: Record "336" temporary;SearchForSupply: Boolean;CurrentSignFactor: Integer;LookupMode: Option "Serial No.","Lot No.";MaxQuantity: Decimal)
//     var
//         ItemTrackingSummaryForm: Page "6500";
//         Window: Dialog;
//         AvailableQty: Decimal;
//         AdjustmentQty: Decimal;
//         QtyOnLine: Decimal;
//         QtyHandledOnLine: Decimal;
//         NewQtyOnLine: Decimal;
//     begin
//         OnBeforeAssistEditTrackingNo(TempTrackingSpecification,SearchForSupply,CurrentSignFactor,LookupMode,MaxQuantity);

//         Window.OPEN(Text004);

//         IF NOT FullGlobalDataSetExists THEN
//           RetrieveLookupData(TempTrackingSpecification,TRUE);

//         TempGlobalReservEntry.RESET;
//         TempGlobalEntrySummary.RESET;

//         // Select the proper key on form
//         TempGlobalEntrySummary.SETCURRENTKEY("Expiration Date");
//         TempGlobalEntrySummary.SETFILTER("Expiration Date",'<>%1',0D);
//         IF TempGlobalEntrySummary.ISEMPTY THEN
//           TempGlobalEntrySummary.SETCURRENTKEY("Lot No.","Serial No.");
//         TempGlobalEntrySummary.SETRANGE("Expiration Date");
//         ItemTrackingSummaryForm.SETTABLEVIEW(TempGlobalEntrySummary);

//         TempGlobalEntrySummary.SETCURRENTKEY("Lot No.","Serial No.");
//         CASE LookupMode OF
//           LookupMode::"Serial No.":
//             BEGIN
//               IF TempTrackingSpecification."Lot No." <> '' THEN
//                 TempGlobalEntrySummary.SETRANGE("Lot No.",TempTrackingSpecification."Lot No.");
//               TempGlobalEntrySummary.SETRANGE("Serial No.",TempTrackingSpecification."Serial No.");
//               IF TempGlobalEntrySummary.FINDFIRST THEN
//                 ItemTrackingSummaryForm.SETRECORD(TempGlobalEntrySummary);
//               TempGlobalEntrySummary.SETFILTER("Serial No.",'<>%1','');
//               TempGlobalEntrySummary.SETFILTER("Table ID",'<>%1',0);
//               ItemTrackingSummaryForm.CAPTION := STRSUBSTNO(Text009,TempGlobalReservEntry.FIELDCAPTION("Serial No."));
//             END;
//           LookupMode::"Lot No.":
//             BEGIN
//               IF TempTrackingSpecification."Serial No." <> '' THEN
//                 TempGlobalEntrySummary.SETRANGE("Serial No.",TempTrackingSpecification."Serial No.")
//               ELSE
//                 TempGlobalEntrySummary.SETRANGE("Serial No.",'');
//               TempGlobalEntrySummary.SETRANGE("Lot No.",TempTrackingSpecification."Lot No.");
//               IF TempGlobalEntrySummary.FINDFIRST THEN
//                 ItemTrackingSummaryForm.SETRECORD(TempGlobalEntrySummary);
//               TempGlobalEntrySummary.SETFILTER("Lot No.",'<>%1','');
//               ItemTrackingSummaryForm.CAPTION := STRSUBSTNO(Text009,TempGlobalEntrySummary.FIELDCAPTION("Lot No."));
//             END;
//         END;

//         ItemTrackingSummaryForm.SetCurrentBinAndItemTrkgCode(CurrBinCode,CurrItemTrackingCode);
//         ItemTrackingSummaryForm.SetSources(TempGlobalReservEntry,TempGlobalEntrySummary);
//         ItemTrackingSummaryForm.LOOKUPMODE(SearchForSupply);
//         ItemTrackingSummaryForm.SetSelectionMode(FALSE);

//         Window.CLOSE;
//         IF ItemTrackingSummaryForm.RUNMODAL = ACTION::LookupOK THEN BEGIN
//           ItemTrackingSummaryForm.GETRECORD(TempGlobalEntrySummary);

//           IF TempGlobalEntrySummary."Bin Active" THEN
//             AvailableQty := MinValueAbs(TempGlobalEntrySummary."Bin Content",TempGlobalEntrySummary."Total Available Quantity")
//           ELSE
//             AvailableQty := TempGlobalEntrySummary."Total Available Quantity";
//           QtyHandledOnLine := TempTrackingSpecification."Quantity Handled (Base)";
//           QtyOnLine := TempTrackingSpecification."Quantity (Base)" - QtyHandledOnLine;

//           IF CurrentSignFactor > 0 THEN BEGIN
//             AvailableQty := -AvailableQty;
//             QtyHandledOnLine := -QtyHandledOnLine;
//             QtyOnLine := -QtyOnLine;
//           END;

//           IF MaxQuantity < 0 THEN BEGIN
//             AdjustmentQty := MaxQuantity;
//             IF AvailableQty < 0 THEN
//               IF AdjustmentQty > AvailableQty THEN
//                 AdjustmentQty := AvailableQty;
//             IF QtyOnLine + AdjustmentQty < 0 THEN
//               AdjustmentQty := -QtyOnLine;
//           END ELSE BEGIN
//             AdjustmentQty := AvailableQty;
//             IF AvailableQty < 0 THEN BEGIN
//               IF QtyOnLine + AdjustmentQty < 0 THEN
//                 AdjustmentQty := -QtyOnLine;
//             END ELSE
//               AdjustmentQty := MinValueAbs(MaxQuantity,AvailableQty);
//           END;
//           IF LookupMode = LookupMode::"Serial No." THEN
//             TempTrackingSpecification.VALIDATE("Serial No.",TempGlobalEntrySummary."Serial No.");
//           TempTrackingSpecification.VALIDATE("Lot No.",TempGlobalEntrySummary."Lot No.");

//           TransferExpDateFromSummary(TempTrackingSpecification,TempGlobalEntrySummary);
//           IF TempTrackingSpecification.IsReclass THEN BEGIN
//             TempTrackingSpecification."New Serial No." := TempTrackingSpecification."Serial No.";
//             TempTrackingSpecification."New Lot No." := TempTrackingSpecification."Lot No.";
//           END;

//           NewQtyOnLine := QtyOnLine + AdjustmentQty + QtyHandledOnLine;
//           IF TempTrackingSpecification."Serial No." <> '' THEN
//             IF ABS(NewQtyOnLine) > 1 THEN
//               NewQtyOnLine := NewQtyOnLine / ABS(NewQtyOnLine); // Set to a signed value of 1.

//           TempTrackingSpecification.VALIDATE("Quantity (Base)",NewQtyOnLine);

//           OnAfterAssistEditTrackingNo(TempTrackingSpecification,TempGlobalEntrySummary);
//         END;
//     end;

//     [Scope('Personalization')]
//     procedure SelectMultipleTrackingNo(var TempTrackingSpecification: Record "336" temporary;MaxQuantity: Decimal;CurrentSignFactor: Integer)
//     var
//         TempEntrySummary: Record "338" temporary;
//         ItemTrackingSummaryForm: Page "6500";
//         Window: Dialog;
//         LookupMode: Option "Serial No.","Lot No.",All;
//     begin
//         CLEAR(ItemTrackingSummaryForm);
//         Window.OPEN(Text004);
//         LookupMode := LookupMode::All;
//         IF NOT FullGlobalDataSetExists THEN
//           RetrieveLookupData(TempTrackingSpecification,TRUE);

//         TempGlobalReservEntry.RESET;
//         TempGlobalEntrySummary.RESET;

//         // Swap sign if negative supply lines
//         IF CurrentSignFactor > 0 THEN
//           MaxQuantity := -MaxQuantity;

//         // Select the proper key
//         TempGlobalEntrySummary.SETCURRENTKEY("Expiration Date");
//         TempGlobalEntrySummary.SETFILTER("Expiration Date",'<>%1',0D);
//         IF TempGlobalEntrySummary.ISEMPTY THEN
//           TempGlobalEntrySummary.SETCURRENTKEY("Lot No.","Serial No.");
//         TempGlobalEntrySummary.SETRANGE("Expiration Date");

//         // Initialize form
//         ItemTrackingSummaryForm.CAPTION := Text011;
//         ItemTrackingSummaryForm.SETTABLEVIEW(TempGlobalEntrySummary);
//         TempGlobalEntrySummary.SETFILTER("Table ID",'<>%1',0); // Filter out summations
//         ItemTrackingSummaryForm.SetSources(TempGlobalReservEntry,TempGlobalEntrySummary);
//         ItemTrackingSummaryForm.SetSelectionMode(MaxQuantity <> 0);
//         ItemTrackingSummaryForm.LOOKUPMODE(TRUE);
//         ItemTrackingSummaryForm.SetMaxQuantity(MaxQuantity);
//         ItemTrackingSummaryForm.SetCurrentBinAndItemTrkgCode(CurrBinCode,CurrItemTrackingCode);

//         // Run preselection on form
//         ItemTrackingSummaryForm.AutoSelectTrackingNo;

//         Window.CLOSE;

//         IF NOT (ItemTrackingSummaryForm.RUNMODAL = ACTION::LookupOK) THEN
//           EXIT;
//         ItemTrackingSummaryForm.GetSelected(TempEntrySummary);
//         IF TempEntrySummary.ISEMPTY THEN
//           EXIT;

//         // Swap sign on the selected entries if parent is a negative supply line
//         IF CurrentSignFactor > 0 THEN // Negative supply lines
//           IF TempEntrySummary.FIND('-') THEN
//             REPEAT
//               TempEntrySummary."Selected Quantity" := -TempEntrySummary."Selected Quantity";
//               TempEntrySummary.MODIFY;
//             UNTIL TempEntrySummary.NEXT = 0;

//         // Modify the item tracking lines with the selected quantities
//         AddSelectedTrackingToDataSet(TempEntrySummary,TempTrackingSpecification,CurrentSignFactor);
//     end;

//     [Scope('Personalization')]
//     procedure LookupTrackingAvailability(var TempTrackingSpecification: Record "336" temporary;LookupMode: Option "Serial No.","Lot No.")
//     var
//         ItemTrackingSummaryForm: Page "6500";
//         Window: Dialog;
//     begin
//         CASE LookupMode OF
//           LookupMode::"Serial No.":
//             IF TempTrackingSpecification."Serial No." = '' THEN
//               EXIT;
//           LookupMode::"Lot No.":
//             IF TempTrackingSpecification."Lot No." = '' THEN
//               EXIT;
//         END;

//         CLEAR(ItemTrackingSummaryForm);
//         Window.OPEN(Text004);
//         TempGlobalChangedEntrySummary.RESET;

//         IF NOT (PartialGlobalDataSetExists OR FullGlobalDataSetExists) THEN
//           RetrieveLookupData(TempTrackingSpecification,TRUE);

//         TempGlobalEntrySummary.RESET;
//         TempGlobalEntrySummary.SETCURRENTKEY("Lot No.","Serial No.");

//         TempGlobalReservEntry.RESET;

//         CASE LookupMode OF
//           LookupMode::"Serial No.":
//             BEGIN
//               TempGlobalEntrySummary.SETRANGE("Serial No.",TempTrackingSpecification."Serial No.");
//               TempGlobalEntrySummary.SETFILTER("Table ID",'<>%1',0); // Filter out summations
//               TempGlobalReservEntry.SETRANGE("Serial No.",TempTrackingSpecification."Serial No.");
//               ItemTrackingSummaryForm.CAPTION := STRSUBSTNO(
//                   Text010,TempTrackingSpecification.FIELDCAPTION("Serial No."),TempTrackingSpecification."Serial No.");
//             END;
//           LookupMode::"Lot No.":
//             BEGIN
//               TempGlobalEntrySummary.SETRANGE("Serial No.",'');
//               TempGlobalEntrySummary.SETRANGE("Lot No.",TempTrackingSpecification."Lot No.");
//               TempGlobalReservEntry.SETRANGE("Lot No.",TempTrackingSpecification."Lot No.");
//               ItemTrackingSummaryForm.CAPTION := STRSUBSTNO(
//                   Text010,TempTrackingSpecification.FIELDCAPTION("Lot No."),TempTrackingSpecification."Lot No.");
//             END;
//         END;

//         ItemTrackingSummaryForm.SetSources(TempGlobalReservEntry,TempGlobalEntrySummary);
//         ItemTrackingSummaryForm.SetCurrentBinAndItemTrkgCode(CurrBinCode,CurrItemTrackingCode);
//         ItemTrackingSummaryForm.LOOKUPMODE(FALSE);
//         ItemTrackingSummaryForm.SetSelectionMode(FALSE);
//         Window.CLOSE;
//         ItemTrackingSummaryForm.RUNMODAL;
//     end;

//     [Scope('Personalization')]
//     procedure RetrieveLookupData(var TrackingSpecification: Record "336" temporary;FullDataSet: Boolean)
//     var
//         ItemLedgEntry: Record "32";
//         ReservEntry: Record "337";
//         TempReservEntry: Record "337" temporary;
//         xTrackingSpecification: Record "336" temporary;
//     begin
//         LastSummaryEntryNo := 0;
//         LastReservEntryNo := 0;
//         xTrackingSpecification := TrackingSpecification;
//         TempGlobalReservEntry.RESET;
//         TempGlobalReservEntry.DELETEALL;
//         TempGlobalEntrySummary.RESET;
//         TempGlobalEntrySummary.DELETEALL;

//         ReservEntry.RESET;
//         IF ReservEntry.FINDLAST THEN
//           LastReservEntryNo := ReservEntry."Entry No.";
//         ReservEntry.SETCURRENTKEY(
//           "Item No.","Variant Code","Location Code","Item Tracking","Reservation Status","Lot No.","Serial No.");
//         ReservEntry.SETRANGE("Item No.",TrackingSpecification."Item No.");
//         ReservEntry.SETRANGE("Variant Code",TrackingSpecification."Variant Code");
//         ReservEntry.SETRANGE("Location Code",TrackingSpecification."Location Code");
//         ReservEntry.SETFILTER("Item Tracking",'<>%1',ReservEntry."Item Tracking"::None);

//         IF ReservEntry.FINDSET THEN
//           REPEAT
//             TempReservEntry := ReservEntry;
//             IF CanIncludeReservEntryToTrackingSpec(TempReservEntry) THEN
//               TempReservEntry.INSERT;
//           UNTIL ReservEntry.NEXT = 0;

//         ItemLedgEntry.RESET;
//         ItemLedgEntry.SETCURRENTKEY("Item No.",Open,"Variant Code","Location Code","Item Tracking",
//           "Lot No.","Serial No.");
//         ItemLedgEntry.SETRANGE("Item No.",TrackingSpecification."Item No.");
//         ItemLedgEntry.SETRANGE("Variant Code",TrackingSpecification."Variant Code");
//         ItemLedgEntry.SETRANGE(Open,TRUE);
//         ItemLedgEntry.SETRANGE("Location Code",TrackingSpecification."Location Code");

//         IF FullDataSet THEN BEGIN
//           TransferReservEntryToTempRec(TempReservEntry,TrackingSpecification);
//           TransferItemLedgToTempRec(ItemLedgEntry,TrackingSpecification);
//         END ELSE BEGIN
//           IF TrackingSpecification.FINDSET THEN
//             REPEAT
//               ItemLedgEntry.ClearTrackingFilter;
//               TempReservEntry.ClearTrackingFilter;

//               IF TrackingSpecification."Lot No." <> '' THEN BEGIN
//                 ItemLedgEntry.SETRANGE("Lot No.",TrackingSpecification."Lot No.");
//                 TempReservEntry.SETRANGE("Lot No.",TrackingSpecification."Lot No.");
//                 TransferReservEntryToTempRec(TempReservEntry,TrackingSpecification);
//                 TransferItemLedgToTempRec(ItemLedgEntry,TrackingSpecification);
//               END;

//               IF TrackingSpecification."Serial No." <> '' THEN BEGIN
//                 ItemLedgEntry.SetTrackingFilterFromSpec(TrackingSpecification);
//                 TempReservEntry.SetTrackingFilterFromSpec(TrackingSpecification);
//                 TransferReservEntryToTempRec(TempReservEntry,TrackingSpecification);
//                 TransferItemLedgToTempRec(ItemLedgEntry,TrackingSpecification);
//               END;
//             UNTIL TrackingSpecification.NEXT = 0;
//         END;

//         TempGlobalEntrySummary.RESET;
//         UpdateCurrentPendingQty;
//         TrackingSpecification := xTrackingSpecification;

//         PartialGlobalDataSetExists := TRUE;
//         FullGlobalDataSetExists := FullDataSet;
//         AdjustForDoubleEntries;

//         OnAfterRetrieveLookupData(TrackingSpecification,FullDataSet,TempGlobalReservEntry,TempGlobalEntrySummary);
//     end;

//     local procedure TransferItemLedgToTempRec(var ItemLedgEntry: Record "32";var TrackingSpecification: Record "336" temporary)
//     var
//         IsHandled: Boolean;
//     begin
//         IF ItemLedgEntry.FINDSET THEN
//           REPEAT
//             IF ItemLedgEntry.TrackingExists AND
//                NOT TempGlobalReservEntry.GET(-ItemLedgEntry."Entry No.",ItemLedgEntry.Positive)
//             THEN BEGIN
//               TempGlobalReservEntry.INIT;
//               TempGlobalReservEntry."Entry No." := -ItemLedgEntry."Entry No.";
//               TempGlobalReservEntry."Reservation Status" := TempGlobalReservEntry."Reservation Status"::Surplus;
//               TempGlobalReservEntry.Positive := ItemLedgEntry.Positive;
//               TempGlobalReservEntry."Item No." := ItemLedgEntry."Item No.";
//               TempGlobalReservEntry."Location Code" := ItemLedgEntry."Location Code";
//               TempGlobalReservEntry."Quantity (Base)" := ItemLedgEntry."Remaining Quantity";
//               TempGlobalReservEntry."Source Type" := DATABASE::"Item Ledger Entry";
//               TempGlobalReservEntry."Source Ref. No." := ItemLedgEntry."Entry No.";
//               TempGlobalReservEntry."Serial No." := ItemLedgEntry."Serial No.";
//               TempGlobalReservEntry."Lot No." := ItemLedgEntry."Lot No.";
//               TempGlobalReservEntry."Variant Code" := ItemLedgEntry."Variant Code";

//               IF TempGlobalReservEntry.Positive THEN BEGIN
//                 TempGlobalReservEntry."Warranty Date" := ItemLedgEntry."Warranty Date";
//                 TempGlobalReservEntry."Expiration Date" := ItemLedgEntry."Expiration Date";
//                 TempGlobalReservEntry."Expected Receipt Date" := 0D
//               END ELSE
//                 TempGlobalReservEntry."Shipment Date" := DMY2DATE(31,12,9999);

//               IsHandled := FALSE;
//               OnTransferItemLedgToTempRecOnBeforeInsert(TempGlobalReservEntry,ItemLedgEntry,TrackingSpecification,IsHandled);
//               IF NOT IsHandled THEN BEGIN
//                 TempGlobalReservEntry.INSERT;
//                 CreateEntrySummary(TrackingSpecification,TempGlobalReservEntry);
//               END;
//             END;
//           UNTIL ItemLedgEntry.NEXT = 0;
//     end;

//     local procedure TransferReservEntryToTempRec(var TempReservEntry: Record "337" temporary;var TrackingSpecification: Record "336" temporary)
//     begin
//         IF TempReservEntry.FINDSET THEN
//           REPEAT
//             IF NOT TempGlobalReservEntry.GET(TempReservEntry."Entry No.",TempReservEntry.Positive) THEN BEGIN
//               TempGlobalReservEntry := TempReservEntry;
//               TempGlobalReservEntry."Transferred from Entry No." := 0;
//               OnAfterTransferReservEntryToTempRec(TempGlobalReservEntry,TempReservEntry);
//               TempGlobalReservEntry.INSERT;
//               CreateEntrySummary(TrackingSpecification,TempGlobalReservEntry);
//             END;
//           UNTIL TempReservEntry.NEXT = 0;
//     end;

//     local procedure CreateEntrySummary(TrackingSpecification: Record "336" temporary;TempReservEntry: Record "337" temporary)
//     var
//         LookupMode: Option "Serial No.","Lot No.";
//     begin
//         CreateEntrySummary2(TrackingSpecification,LookupMode::"Serial No.",TempReservEntry);
//         CreateEntrySummary2(TrackingSpecification,LookupMode::"Lot No.",TempReservEntry);

//         OnAfterCreateEntrySummary(TrackingSpecification,TempGlobalEntrySummary);
//     end;

//     local procedure CreateEntrySummary2(TrackingSpecification: Record "336" temporary;LookupMode: Option "Serial No.","Lot No.";TempReservEntry: Record "337" temporary)
//     var
//         DoInsert: Boolean;
//     begin
//         TempGlobalEntrySummary.RESET;
//         TempGlobalEntrySummary.SETCURRENTKEY("Lot No.","Serial No.");

//         // Set filters
//         CASE LookupMode OF
//           LookupMode::"Serial No.":
//             BEGIN
//               IF TempReservEntry."Serial No." = '' THEN
//                 EXIT;
//               TempGlobalEntrySummary.SetTrackingFilterFromReservEntry(TempReservEntry);
//             END;
//           LookupMode::"Lot No.":
//             BEGIN
//               TempGlobalEntrySummary.SetTrackingFilter('',TempReservEntry."Lot No.");
//               IF TempReservEntry."Serial No." <> '' THEN
//                 TempGlobalEntrySummary.SETRANGE("Table ID",0)
//               ELSE
//                 TempGlobalEntrySummary.SETFILTER("Table ID",'<>%1',0);
//             END;
//         END;

//         // If no summary exists, create new record
//         IF NOT TempGlobalEntrySummary.FINDFIRST THEN BEGIN
//           TempGlobalEntrySummary.INIT;
//           TempGlobalEntrySummary."Entry No." := LastSummaryEntryNo + 1;
//           LastSummaryEntryNo := TempGlobalEntrySummary."Entry No.";

//           IF (LookupMode = LookupMode::"Lot No.") AND (TempReservEntry."Serial No." <> '') THEN
//             TempGlobalEntrySummary."Table ID" := 0 // Mark as summation
//           ELSE
//             TempGlobalEntrySummary."Table ID" := TempReservEntry."Source Type";
//           IF LookupMode = LookupMode::"Serial No." THEN
//             TempGlobalEntrySummary."Serial No." := TempReservEntry."Serial No."
//           ELSE
//             TempGlobalEntrySummary."Serial No." := '';
//           TempGlobalEntrySummary."Lot No." := TempReservEntry."Lot No.";
//           TempGlobalEntrySummary."Bin Active" := CurrBinCode <> '';
//           OnBeforeUpdateBinContent(TempGlobalEntrySummary,TempReservEntry);
//           UpdateBinContent(TempGlobalEntrySummary);

//           // If consumption/output fill in double entry value here:
//           TempGlobalEntrySummary."Double-entry Adjustment" :=
//             MaxDoubleEntryAdjustQty(TrackingSpecification,TempGlobalEntrySummary);

//           DoInsert := TRUE;
//         END;

//         // Sum up values
//         IF TempReservEntry.Positive THEN BEGIN
//           TempGlobalEntrySummary."Warranty Date" := TempReservEntry."Warranty Date";
//           TempGlobalEntrySummary."Expiration Date" := TempReservEntry."Expiration Date";
//           IF TempReservEntry."Entry No." < 0 THEN // The record represents an Item ledger entry
//             TempGlobalEntrySummary."Total Quantity" += TempReservEntry."Quantity (Base)";
//           IF TempReservEntry."Reservation Status" = TempReservEntry."Reservation Status"::Reservation THEN
//             TempGlobalEntrySummary."Total Reserved Quantity" += TempReservEntry."Quantity (Base)";
//         END ELSE BEGIN
//           TempGlobalEntrySummary."Total Requested Quantity" -= TempReservEntry."Quantity (Base)";
//           IF TempReservEntry.HasSamePointerWithSpec(TrackingSpecification) THEN BEGIN
//             IF TempReservEntry."Reservation Status" = TempReservEntry."Reservation Status"::Reservation THEN
//               TempGlobalEntrySummary."Current Reserved Quantity" -= TempReservEntry."Quantity (Base)";
//             IF TempReservEntry."Entry No." > 0 THEN // The record represents a reservation entry
//               TempGlobalEntrySummary."Current Requested Quantity" -= TempReservEntry."Quantity (Base)";
//           END;
//         END;

//         // Update available quantity on the record
//         TempGlobalEntrySummary.UpdateAvailable;
//         IF DoInsert THEN
//           TempGlobalEntrySummary.INSERT
//         ELSE
//           TempGlobalEntrySummary.MODIFY;

//         OnAfterCreateEntrySummary2(TempGlobalEntrySummary,TempReservEntry);
//     end;

//     local procedure MinValueAbs(Value1: Decimal;Value2: Decimal): Decimal
//     begin
//         IF ABS(Value1) < ABS(Value2) THEN
//           EXIT(Value1);

//         EXIT(Value2);
//     end;

//     [Scope('Personalization')]
//     procedure AddSelectedTrackingToDataSet(var TempEntrySummary: Record "338" temporary;var TempTrackingSpecification: Record "336" temporary;CurrentSignFactor: Integer)
//     var
//         TrackingSpecification2: Record "336";
//         LastEntryNo: Integer;
//         ChangeType: Option Insert,Modify,Delete;
//     begin
//         TempEntrySummary.RESET;
//         TempEntrySummary.SETFILTER("Selected Quantity",'<>%1',0);
//         IF TempEntrySummary.ISEMPTY THEN
//           EXIT;

//         // To save general and pointer information
//         TrackingSpecification2.INIT;
//         TrackingSpecification2."Item No." := TempTrackingSpecification."Item No.";
//         TrackingSpecification2."Location Code" := TempTrackingSpecification."Location Code";
//         TrackingSpecification2."Source Type" := TempTrackingSpecification."Source Type";
//         TrackingSpecification2."Source Subtype" := TempTrackingSpecification."Source Subtype";
//         TrackingSpecification2."Source ID" := TempTrackingSpecification."Source ID";
//         TrackingSpecification2."Source Batch Name" := TempTrackingSpecification."Source Batch Name";
//         TrackingSpecification2."Source Prod. Order Line" := TempTrackingSpecification."Source Prod. Order Line";
//         TrackingSpecification2."Source Ref. No." := TempTrackingSpecification."Source Ref. No.";
//         TrackingSpecification2.Positive := TempTrackingSpecification.Positive;
//         TrackingSpecification2."Qty. per Unit of Measure" := TempTrackingSpecification."Qty. per Unit of Measure";
//         TrackingSpecification2."Variant Code" := TempTrackingSpecification."Variant Code";

//         TempTrackingSpecification.RESET;
//         IF TempTrackingSpecification.FINDLAST THEN
//           LastEntryNo := TempTrackingSpecification."Entry No.";

//         TempEntrySummary.FINDFIRST;
//         REPEAT
//           TempTrackingSpecification.SetTrackingFilterFromEntrySummary(TempEntrySummary);
//           IF TempTrackingSpecification.FINDFIRST THEN BEGIN
//             TempTrackingSpecification.VALIDATE("Quantity (Base)",
//               TempTrackingSpecification."Quantity (Base)" + TempEntrySummary."Selected Quantity");
//             TempTrackingSpecification."Buffer Status" := TempTrackingSpecification."Buffer Status"::MODIFY;
//             TransferExpDateFromSummary(TempTrackingSpecification,TempEntrySummary);
//             TempTrackingSpecification.MODIFY;
//             UpdateTrackingDataSetWithChange(TempTrackingSpecification,TRUE,CurrentSignFactor,ChangeType::Modify);
//           END ELSE BEGIN
//             TempTrackingSpecification := TrackingSpecification2;
//             TempTrackingSpecification."Entry No." := LastEntryNo + 1;
//             LastEntryNo := TempTrackingSpecification."Entry No.";
//             TempTrackingSpecification."Serial No." := TempEntrySummary."Serial No.";
//             TempTrackingSpecification."Lot No." := TempEntrySummary."Lot No.";
//             TempTrackingSpecification."Buffer Status" := TempTrackingSpecification."Buffer Status"::INSERT;
//             TransferExpDateFromSummary(TempTrackingSpecification,TempEntrySummary);
//             IF TempTrackingSpecification.IsReclass THEN BEGIN
//               TempTrackingSpecification."New Serial No." := TempTrackingSpecification."Serial No.";
//               TempTrackingSpecification."New Lot No." := TempTrackingSpecification."Lot No.";
//             END;
//             TempTrackingSpecification.VALIDATE("Quantity (Base)",TempEntrySummary."Selected Quantity");
//             OnBeforeTempTrackingSpecificationInsert(TempTrackingSpecification,TempEntrySummary);
//             TempTrackingSpecification.INSERT;
//             UpdateTrackingDataSetWithChange(TempTrackingSpecification,TRUE,CurrentSignFactor,ChangeType::Insert);
//           END;
//         UNTIL TempEntrySummary.NEXT = 0;

//         TempTrackingSpecification.RESET;
//     end;

//     [Scope('Personalization')]
//     procedure TrackingAvailable(TempTrackingSpecification: Record "336" temporary;LookupMode: Option "Serial No.","Lot No."): Boolean
//     begin
//         CurrItemTrackingCode.TESTFIELD(Code);
//         CASE LookupMode OF
//           LookupMode::"Serial No.":
//             IF (TempTrackingSpecification."Serial No." = '') OR (NOT CurrItemTrackingCode."SN Specific Tracking") THEN
//               EXIT(TRUE);
//           LookupMode::"Lot No.":
//             IF (TempTrackingSpecification."Lot No." = '') OR (NOT CurrItemTrackingCode."Lot Specific Tracking") THEN
//               EXIT(TRUE);
//         END;

//         IF NOT (PartialGlobalDataSetExists OR FullGlobalDataSetExists) THEN
//           RetrieveLookupData(TempTrackingSpecification,TRUE);

//         TempGlobalEntrySummary.RESET;
//         TempGlobalEntrySummary.SETCURRENTKEY("Lot No.","Serial No.");
//         TempGlobalEntrySummary.SetTrackingFilter(TempTrackingSpecification."Serial No.",TempTrackingSpecification."Lot No.");
//         TempGlobalEntrySummary.CALCSUMS("Total Available Quantity");
//         IF CheckJobInPurchLine(TempTrackingSpecification) THEN
//           EXIT(TempGlobalEntrySummary.FINDFIRST);
//         EXIT(TempGlobalEntrySummary."Total Available Quantity" >= 0);
//     end;

//     [Scope('Personalization')]
//     procedure UpdateTrackingDataSetWithChange(var TempTrackingSpecificationChanged: Record "336" temporary;LineIsDemand: Boolean;CurrentSignFactor: Integer;ChangeType: Option Insert,Modify,Delete)
//     var
//         LastEntryNo: Integer;
//     begin
//         IF NOT TempTrackingSpecificationChanged.TrackingExists THEN
//           EXIT;

//         LastEntryNo := UpdateTrackingGlobalChangeRec(TempTrackingSpecificationChanged,LineIsDemand,CurrentSignFactor,ChangeType);
//         TempGlobalChangedEntrySummary.GET(LastEntryNo);
//         UpdateTempSummaryWithChange(TempGlobalChangedEntrySummary);
//     end;

//     local procedure UpdateTrackingGlobalChangeRec(var TempTrackingSpecificationChanged: Record "336" temporary;LineIsDemand: Boolean;CurrentSignFactor: Integer;ChangeType: Option Insert,Modify,Delete): Integer
//     var
//         NewQuantity: Decimal;
//         LastEntryNo: Integer;
//     begin
//         IF (ChangeType = ChangeType::Delete) OR NOT LineIsDemand THEN
//           NewQuantity := 0
//         ELSE
//           NewQuantity := TempTrackingSpecificationChanged."Quantity (Base)" - TempTrackingSpecificationChanged."Quantity Handled (Base)";

//         IF CurrentSignFactor > 0 THEN // Negative supply lines
//           NewQuantity := -NewQuantity;

//         TempGlobalChangedEntrySummary.RESET;
//         TempGlobalChangedEntrySummary.SETCURRENTKEY("Lot No.","Serial No.");
//         TempGlobalChangedEntrySummary.SetTrackingFilterFromSpec(TempTrackingSpecificationChanged);
//         IF NOT TempGlobalChangedEntrySummary.FINDFIRST THEN BEGIN
//           TempGlobalChangedEntrySummary.RESET;
//           IF TempGlobalChangedEntrySummary.FINDLAST THEN
//             LastEntryNo := TempGlobalChangedEntrySummary."Entry No.";
//           TempGlobalChangedEntrySummary.INIT;
//           TempGlobalChangedEntrySummary."Entry No." := LastEntryNo + 1;
//           TempGlobalChangedEntrySummary."Lot No." := TempTrackingSpecificationChanged."Lot No.";
//           TempGlobalChangedEntrySummary."Serial No." := TempTrackingSpecificationChanged."Serial No.";
//           TempGlobalChangedEntrySummary."Current Pending Quantity" := NewQuantity;
//           IF TempTrackingSpecificationChanged."Serial No." <> '' THEN
//             TempGlobalChangedEntrySummary."Table ID" := DATABASE::"Tracking Specification"; // Not a summary line
//           OnBeforeTempGlobalChangedEntrySummaryInsert(TempGlobalChangedEntrySummary,TempTrackingSpecificationChanged);
//           TempGlobalChangedEntrySummary.INSERT;
//           PartialGlobalDataSetExists := FALSE; // The partial data set does not cover the new line
//         END ELSE
//           IF LineIsDemand THEN BEGIN
//             TempGlobalChangedEntrySummary."Current Pending Quantity" := NewQuantity;
//             TempGlobalChangedEntrySummary.MODIFY;
//           END;
//         EXIT(TempGlobalChangedEntrySummary."Entry No.");
//     end;

//     local procedure UpdateCurrentPendingQty()
//     var
//         TempLastGlobalEntrySummary: Record "338" temporary;
//     begin
//         TempGlobalChangedEntrySummary.RESET;
//         TempGlobalChangedEntrySummary.SETCURRENTKEY("Lot No.","Serial No.");
//         IF TempGlobalChangedEntrySummary.FINDSET THEN
//           REPEAT
//             IF TempGlobalChangedEntrySummary."Lot No." <> '' THEN BEGIN
//               // only last record with Lot Number updates Summary
//               IF TempGlobalChangedEntrySummary."Lot No." <> TempLastGlobalEntrySummary."Lot No." THEN
//                 FindLastGlobalEntrySummary(TempGlobalChangedEntrySummary,TempLastGlobalEntrySummary);
//               SkipLot := NOT (TempGlobalChangedEntrySummary."Entry No." = TempLastGlobalEntrySummary."Entry No.");
//             END;
//             UpdateTempSummaryWithChange(TempGlobalChangedEntrySummary);
//           UNTIL TempGlobalChangedEntrySummary.NEXT = 0;
//     end;

//     local procedure UpdateTempSummaryWithChange(var ChangedEntrySummary: Record "338" temporary)
//     var
//         LastEntryNo: Integer;
//         SumOfSNPendingQuantity: Decimal;
//         SumOfSNRequestedQuantity: Decimal;
//     begin
//         TempGlobalEntrySummary.RESET;
//         IF TempGlobalEntrySummary.FINDLAST THEN
//           LastEntryNo := TempGlobalEntrySummary."Entry No.";

//         TempGlobalEntrySummary.SETCURRENTKEY("Lot No.","Serial No.");
//         IF ChangedEntrySummary."Serial No." <> '' THEN BEGIN
//           TempGlobalEntrySummary.SetTrackingFilterFromEntrySummary(ChangedEntrySummary);
//           IF TempGlobalEntrySummary.FINDFIRST THEN BEGIN
//             TempGlobalEntrySummary."Current Pending Quantity" := ChangedEntrySummary."Current Pending Quantity" -
//               TempGlobalEntrySummary."Current Requested Quantity";
//             TempGlobalEntrySummary.UpdateAvailable;
//             TempGlobalEntrySummary.MODIFY;
//           END ELSE BEGIN
//             TempGlobalEntrySummary := ChangedEntrySummary;
//             TempGlobalEntrySummary."Entry No." := LastEntryNo + 1;
//             LastEntryNo := TempGlobalEntrySummary."Entry No.";
//             TempGlobalEntrySummary."Bin Active" := CurrBinCode <> '';
//             UpdateBinContent(TempGlobalEntrySummary);
//             TempGlobalEntrySummary.UpdateAvailable;
//             TempGlobalEntrySummary.INSERT;
//           END;

//           IF (ChangedEntrySummary."Lot No." <> '') AND NOT SkipLot THEN BEGIN
//             TempGlobalEntrySummary.SETFILTER("Serial No.",'<>%1','');
//             TempGlobalEntrySummary.SETRANGE("Lot No.",ChangedEntrySummary."Lot No.");
//             TempGlobalEntrySummary.CALCSUMS("Current Pending Quantity","Current Requested Quantity");
//             SumOfSNPendingQuantity := TempGlobalEntrySummary."Current Pending Quantity";
//             SumOfSNRequestedQuantity := TempGlobalEntrySummary."Current Requested Quantity";
//           END;
//         END;

//         IF (ChangedEntrySummary."Lot No." <> '') AND NOT SkipLot THEN BEGIN
//           TempGlobalEntrySummary.SetTrackingFilter('',ChangedEntrySummary."Lot No.");

//           IF ChangedEntrySummary."Serial No." <> '' THEN
//             TempGlobalEntrySummary.SETRANGE("Table ID",0)
//           ELSE
//             TempGlobalEntrySummary.SETFILTER("Table ID",'<>%1',0);

//           IF TempGlobalEntrySummary.FINDFIRST THEN BEGIN
//             IF ChangedEntrySummary."Serial No." <> '' THEN BEGIN
//               TempGlobalEntrySummary."Current Pending Quantity" := SumOfSNPendingQuantity;
//               TempGlobalEntrySummary."Current Requested Quantity" := SumOfSNRequestedQuantity;
//             END ELSE
//               TempGlobalEntrySummary."Current Pending Quantity" := ChangedEntrySummary."Current Pending Quantity" -
//                 TempGlobalEntrySummary."Current Requested Quantity";

//             TempGlobalEntrySummary.UpdateAvailable;
//             TempGlobalEntrySummary.MODIFY;
//           END ELSE BEGIN
//             TempGlobalEntrySummary := ChangedEntrySummary;
//             TempGlobalEntrySummary."Entry No." := LastEntryNo + 1;
//             TempGlobalEntrySummary."Serial No." := '';
//             IF ChangedEntrySummary."Serial No." <> '' THEN // Mark as summation
//               TempGlobalEntrySummary."Table ID" := 0
//             ELSE
//               TempGlobalEntrySummary."Table ID" := DATABASE::"Tracking Specification";
//             TempGlobalEntrySummary."Bin Active" := CurrBinCode <> '';
//             UpdateBinContent(TempGlobalEntrySummary);
//             TempGlobalEntrySummary.UpdateAvailable;
//             TempGlobalEntrySummary.INSERT;
//           END;
//         END;
//     end;

//     [Scope('Personalization')]
//     procedure RefreshTrackingAvailability(var TempTrackingSpecification: Record "336" temporary;ShowMessage: Boolean) AvailabilityOK: Boolean
//     var
//         TrackingSpecification2: Record "336";
//         LookupMode: Option "Serial No.","Lot No.";
//         PreviousLotNo: Code[50];
//     begin
//         AvailabilityOK := TRUE;
//         IF TempTrackingSpecification.Positive THEN
//           EXIT;

//         TrackingSpecification2.COPY(TempTrackingSpecification);
//         TempTrackingSpecification.RESET;
//         IF TempTrackingSpecification.ISEMPTY THEN BEGIN
//           TempTrackingSpecification.COPY(TrackingSpecification2);
//           EXIT;
//         END;

//         FullGlobalDataSetExists := FALSE;
//         PartialGlobalDataSetExists := FALSE;
//         RetrieveLookupData(TempTrackingSpecification,FALSE);

//         TempTrackingSpecification.SETCURRENTKEY("Lot No.","Serial No.");
//         TempTrackingSpecification.FIND('-');
//         LookupMode := LookupMode::"Serial No.";
//         REPEAT
//           IF TempTrackingSpecification."Lot No." <> PreviousLotNo THEN BEGIN
//             PreviousLotNo := TempTrackingSpecification."Lot No.";
//             LookupMode := LookupMode::"Lot No.";

//             IF NOT TrackingAvailable(TempTrackingSpecification,LookupMode) THEN
//               AvailabilityOK := FALSE;

//             LookupMode := LookupMode::"Serial No.";
//           END;

//           IF NOT TrackingAvailable(TempTrackingSpecification,LookupMode) THEN
//             AvailabilityOK := FALSE;
//         UNTIL TempTrackingSpecification.NEXT = 0;

//         IF ShowMessage THEN
//           IF AvailabilityOK THEN
//             MESSAGE(NoAvailabilityWarningsMsg)
//           ELSE
//             MESSAGE(AvailabilityWarningsMsg);

//         TempTrackingSpecification.COPY(TrackingSpecification2);
//     end;

//     [Scope('Personalization')]
//     procedure SetCurrentBinAndItemTrkgCode(BinCode: Code[20];ItemTrackingCode: Record "6502")
//     var
//         xBinCode: Code[20];
//     begin
//         xBinCode := CurrBinCode;
//         CurrBinCode := BinCode;
//         CurrItemTrackingCode := ItemTrackingCode;

//         IF xBinCode <> BinCode THEN
//           IF PartialGlobalDataSetExists THEN
//             RefreshBinContent(TempGlobalEntrySummary);
//     end;

//     local procedure UpdateBinContent(var TempEntrySummary: Record "338" temporary)
//     var
//         WarehouseEntry: Record "7312";
//     begin
//         IF CurrBinCode = '' THEN
//           EXIT;
//         CurrItemTrackingCode.TESTFIELD(Code);
//         WarehouseEntry.RESET;
//         WarehouseEntry.SETCURRENTKEY(
//           "Item No.","Bin Code","Location Code","Variant Code",
//           "Unit of Measure Code","Lot No.","Serial No.");
//         WarehouseEntry.SETRANGE("Item No.",TempGlobalReservEntry."Item No.");
//         WarehouseEntry.SETRANGE("Bin Code",CurrBinCode);
//         WarehouseEntry.SETRANGE("Location Code",TempGlobalReservEntry."Location Code");
//         WarehouseEntry.SETRANGE("Variant Code",TempGlobalReservEntry."Variant Code");
//         IF CurrItemTrackingCode."SN Warehouse Tracking" THEN
//           IF TempEntrySummary."Serial No." <> '' THEN
//             WarehouseEntry.SETRANGE("Serial No.",TempEntrySummary."Serial No.");
//         IF CurrItemTrackingCode."Lot Warehouse Tracking" THEN
//           IF TempEntrySummary."Lot No." <> '' THEN
//             WarehouseEntry.SETRANGE("Lot No.",TempEntrySummary."Lot No.");
//         WarehouseEntry.CALCSUMS("Qty. (Base)");

//         TempEntrySummary."Bin Content" := WarehouseEntry."Qty. (Base)";
//     end;

//     local procedure RefreshBinContent(var TempEntrySummary: Record "338" temporary)
//     begin
//         TempEntrySummary.RESET;
//         IF TempEntrySummary.FINDSET THEN
//           REPEAT
//             IF CurrBinCode <> '' THEN
//               UpdateBinContent(TempEntrySummary)
//             ELSE
//               TempEntrySummary."Bin Content" := 0;
//             TempEntrySummary.MODIFY;
//           UNTIL TempEntrySummary.NEXT = 0;
//     end;

//     local procedure TransferExpDateFromSummary(var TrackingSpecification: Record "336" temporary;var TempEntrySummary: Record "338" temporary)
//     begin
//         // Handle Expiration Date
//         IF TempEntrySummary."Total Quantity" <> 0 THEN BEGIN
//           TrackingSpecification."Buffer Status2" := TrackingSpecification."Buffer Status2"::"ExpDate blocked";
//           TrackingSpecification."Expiration Date" := TempEntrySummary."Expiration Date";
//           IF TrackingSpecification.IsReclass THEN
//             TrackingSpecification."New Expiration Date" := TrackingSpecification."Expiration Date"
//           ELSE
//             TrackingSpecification."New Expiration Date" := 0D;
//         END ELSE BEGIN
//           TrackingSpecification."Buffer Status2" := 0;
//           TrackingSpecification."Expiration Date" := 0D;
//           TrackingSpecification."New Expiration Date" := 0D;
//         END;

//         OnAfterTransferExpDateFromSummary(TrackingSpecification,TempEntrySummary);
//     end;

//     local procedure AdjustForDoubleEntries()
//     begin
//         TempGlobalAdjustEntry.RESET;
//         TempGlobalAdjustEntry.DELETEALL;

//         TempGlobalTrackingSpec.RESET;
//         TempGlobalTrackingSpec.DELETEALL;

//         // Check if there is any need to investigate:
//         TempGlobalReservEntry.RESET;
//         TempGlobalReservEntry.SETCURRENTKEY("Source ID","Source Ref. No.","Source Type","Source Subtype","Source Batch Name");
//         TempGlobalReservEntry.SETRANGE("Reservation Status",TempGlobalReservEntry."Reservation Status"::Prospect);
//         TempGlobalReservEntry.SETRANGE("Source Type",DATABASE::"Item Journal Line");
//         TempGlobalReservEntry.SETRANGE("Source Subtype",5,6); // Consumption, Output
//         IF TempGlobalReservEntry.ISEMPTY THEN  // No journal lines with consumption or output exist
//           EXIT;

//         TempGlobalReservEntry.RESET;
//         TempGlobalReservEntry.SETCURRENTKEY("Source ID","Source Ref. No.","Source Type","Source Subtype","Source Batch Name");
//         TempGlobalReservEntry.SETRANGE("Source Type",DATABASE::"Prod. Order Line");
//         TempGlobalReservEntry.SETRANGE("Source Subtype",3); // Released order
//         IF TempGlobalReservEntry.FINDSET THEN
//           REPEAT
//             // Sum up per prod. order line per lot/sn
//             SumUpTempTrkgSpec(TempGlobalTrackingSpec,TempGlobalReservEntry);
//           UNTIL TempGlobalReservEntry.NEXT = 0;

//         TempGlobalReservEntry.RESET;
//         TempGlobalReservEntry.SETCURRENTKEY("Source ID","Source Ref. No.","Source Type","Source Subtype","Source Batch Name");
//         TempGlobalReservEntry.SETRANGE("Source Type",DATABASE::"Prod. Order Component");
//         TempGlobalReservEntry.SETRANGE("Source Subtype",3); // Released order
//         IF TempGlobalReservEntry.FINDSET THEN
//           REPEAT
//             // Sum up per prod. order component per lot/sn
//             SumUpTempTrkgSpec(TempGlobalTrackingSpec,TempGlobalReservEntry);
//           UNTIL TempGlobalReservEntry.NEXT = 0;

//         TempGlobalReservEntry.RESET;
//         TempGlobalReservEntry.SETCURRENTKEY("Source ID","Source Ref. No.","Source Type","Source Subtype","Source Batch Name");
//         TempGlobalReservEntry.SETRANGE("Reservation Status",TempGlobalReservEntry."Reservation Status"::Prospect);
//         TempGlobalReservEntry.SETRANGE("Source Type",DATABASE::"Item Journal Line");
//         TempGlobalReservEntry.SETRANGE("Source Subtype",5,6); // Consumption, Output

//         IF TempGlobalReservEntry.FINDSET THEN
//           REPEAT
//             // Sum up per Component line per lot/sn
//             RelateJnlLineToTempTrkgSpec(TempGlobalReservEntry,TempGlobalTrackingSpec);
//           UNTIL TempGlobalReservEntry.NEXT = 0;

//         InsertAdjustmentEntries;
//     end;

//     local procedure SumUpTempTrkgSpec(var TempTrackingSpecification: Record "336" temporary;ReservEntry: Record "337")
//     var
//         ItemTrackingMgt: Codeunit "6500";
//     begin
//         TempTrackingSpecification.SetSourceFilter(
//           ReservEntry."Source Type",ReservEntry."Source Subtype",ReservEntry."Source ID",ReservEntry."Source Ref. No.",FALSE);
//         TempTrackingSpecification.SetSourceFilter2(ReservEntry."Source Batch Name",ReservEntry."Source Prod. Order Line");
//         TempTrackingSpecification.SetTrackingFilterFromReservEntry(ReservEntry);
//         IF TempTrackingSpecification.FINDFIRST THEN BEGIN
//           TempTrackingSpecification."Quantity (Base)" += ReservEntry."Quantity (Base)";
//           TempTrackingSpecification.MODIFY;
//         END ELSE BEGIN
//           ItemTrackingMgt.CreateTrackingSpecification(ReservEntry,TempTrackingSpecification);
//           IF NOT ReservEntry.Positive THEN               // To avoid inserting existing entry when both sides of the reservation
//             TempTrackingSpecification."Entry No." *= -1; // are handled.
//           TempTrackingSpecification.INSERT;
//         END;
//     end;

//     local procedure RelateJnlLineToTempTrkgSpec(var ReservEntry: Record "337";var TempTrackingSpecification: Record "336" temporary)
//     var
//         ItemJnlLine: Record "83";
//         RemainingQty: Decimal;
//         AdjustQty: Decimal;
//         QtyOnJnlLine: Decimal;
//     begin
//         // Pre-check
//         ReservEntry.TESTFIELD("Reservation Status",ReservEntry."Reservation Status"::Prospect);
//         ReservEntry.TESTFIELD("Source Type",DATABASE::"Item Journal Line");
//         IF NOT (ReservEntry."Source Subtype" IN [5,6]) THEN
//           ReservEntry.FIELDERROR("Source Subtype");

//         IF NOT ItemJnlLine.GET(ReservEntry."Source ID",
//              ReservEntry."Source Batch Name",ReservEntry."Source Ref. No.")
//         THEN
//           EXIT;

//         IF (ItemJnlLine."Order Type" <> ItemJnlLine."Order Type"::Production) OR
//            (ItemJnlLine."Order No." = '') OR
//            (ItemJnlLine."Order Line No." = 0)
//         THEN
//           EXIT;

//         // Buffer fields are used as follows:
//         // "Buffer Value1" : Summed up quantity on journal line(s)
//         // "Buffer Value2" : Adjustment needed to neutralize double entries

//         IF FindRelatedParentTrkgSpec(ItemJnlLine,TempTrackingSpecification,
//              ReservEntry."Serial No.",ReservEntry."Lot No.")
//         THEN BEGIN
//           RemainingQty := TempTrackingSpecification."Quantity (Base)" + TempTrackingSpecification."Buffer Value2";
//           QtyOnJnlLine := ReservEntry."Quantity (Base)";
//           ReservEntry."Transferred from Entry No." := ABS(TempTrackingSpecification."Entry No.");
//           ReservEntry.MODIFY;

//           IF (RemainingQty <> 0) AND (RemainingQty * QtyOnJnlLine > 0) THEN BEGIN
//             IF ABS(QtyOnJnlLine) <= ABS(RemainingQty) THEN
//               AdjustQty := -QtyOnJnlLine
//             ELSE
//               AdjustQty := -RemainingQty;
//           END;

//           TempTrackingSpecification."Buffer Value1" += QtyOnJnlLine;
//           TempTrackingSpecification."Buffer Value2" += AdjustQty;
//           TempTrackingSpecification.MODIFY;
//           AddToAdjustmentEntryDataSet(ReservEntry,AdjustQty);
//         END;
//     end;

//     local procedure FindRelatedParentTrkgSpec(ItemJnlLine: Record "83";var TempTrackingSpecification: Record "336" temporary;SerialNo: Code[50];LotNo: Code[50]): Boolean
//     begin
//         ItemJnlLine.TESTFIELD("Order Type",ItemJnlLine."Order Type"::Production);
//         TempTrackingSpecification.RESET;
//         CASE ItemJnlLine."Entry Type" OF
//           ItemJnlLine."Entry Type"::Consumption:
//             BEGIN
//               IF ItemJnlLine."Prod. Order Comp. Line No." = 0 THEN
//                 EXIT;
//               TempTrackingSpecification.SetSourceFilter(
//                 DATABASE::"Prod. Order Component",3,ItemJnlLine."Order No.",ItemJnlLine."Prod. Order Comp. Line No.",FALSE);
//               TempTrackingSpecification.SetSourceFilter2('',ItemJnlLine."Order Line No.");
//             END;
//           ItemJnlLine."Entry Type"::Output:
//             BEGIN
//               TempTrackingSpecification.SetSourceFilter(DATABASE::"Prod. Order Line",3,ItemJnlLine."Order No.",-1,FALSE);
//               TempTrackingSpecification.SetSourceFilter2('',ItemJnlLine."Order Line No.");
//             END;
//         END;
//         TempTrackingSpecification.SetTrackingFilter(SerialNo,LotNo);
//         EXIT(TempTrackingSpecification.FINDFIRST);
//     end;

//     local procedure AddToAdjustmentEntryDataSet(var ReservEntry: Record "337";AdjustQty: Decimal)
//     begin
//         IF AdjustQty = 0 THEN
//           EXIT;

//         TempGlobalAdjustEntry := ReservEntry;
//         TempGlobalAdjustEntry."Source Type" := -ReservEntry."Source Type";
//         TempGlobalAdjustEntry.Description := COPYSTR(Text013,1,MAXSTRLEN(TempGlobalAdjustEntry.Description));
//         TempGlobalAdjustEntry."Quantity (Base)" := AdjustQty;
//         TempGlobalAdjustEntry."Entry No." += LastReservEntryNo; // Use last entry no as offset to avoid inserting existing entry
//         TempGlobalAdjustEntry.INSERT;
//     end;

//     local procedure InsertAdjustmentEntries()
//     var
//         TempTrackingSpecification: Record "336" temporary;
//     begin
//         TempGlobalAdjustEntry.RESET;
//         IF NOT TempGlobalAdjustEntry.FINDSET THEN
//           EXIT;

//         TempTrackingSpecification.INIT;
//         TempTrackingSpecification.INSERT;
//         REPEAT
//           CreateEntrySummary(TempTrackingSpecification,TempGlobalAdjustEntry); // TrackingSpecification is a dummy record
//           TempGlobalReservEntry := TempGlobalAdjustEntry;
//           TempGlobalReservEntry.INSERT;
//         UNTIL TempGlobalAdjustEntry.NEXT = 0;
//     end;

//     local procedure MaxDoubleEntryAdjustQty(var TempItemTrackLineChanged: Record "336" temporary;var ChangedEntrySummary: Record "338" temporary): Decimal
//     var
//         ItemJnlLine: Record "83";
//     begin
//         IF NOT (TempItemTrackLineChanged."Source Type" = DATABASE::"Item Journal Line") THEN
//           EXIT;

//         IF NOT (TempItemTrackLineChanged."Source Subtype" IN [5,6]) THEN
//           EXIT;

//         IF NOT ItemJnlLine.GET(TempItemTrackLineChanged."Source ID",
//              TempItemTrackLineChanged."Source Batch Name",TempItemTrackLineChanged."Source Ref. No.")
//         THEN
//           EXIT;

//         TempGlobalTrackingSpec.RESET;

//         IF FindRelatedParentTrkgSpec(ItemJnlLine,TempGlobalTrackingSpec,
//              ChangedEntrySummary."Serial No.",ChangedEntrySummary."Lot No.")
//         THEN
//           EXIT(-TempGlobalTrackingSpec."Quantity (Base)" - TempGlobalTrackingSpec."Buffer Value2");
//     end;

//     [Scope('Personalization')]
//     procedure CurrentDataSetMatches(ItemNo: Code[20];VariantCode: Code[20];LocationCode: Code[10]): Boolean
//     begin
//         EXIT(
//           (TempGlobalReservEntry."Item No." = ItemNo) AND
//           (TempGlobalReservEntry."Variant Code" = VariantCode) AND
//           (TempGlobalReservEntry."Location Code" = LocationCode));
//     end;

//     local procedure CheckJobInPurchLine(TrackingSpecification: Record "336"): Boolean
//     var
//         PurchLine: Record "39";
//     begin
//         WITH TrackingSpecification DO BEGIN
//           IF ("Source Type" = DATABASE::"Purchase Line") AND ("Source Subtype" = "Source Subtype"::"3") THEN BEGIN
//             PurchLine.RESET;
//             PurchLine.SETRANGE("Document Type","Source Subtype");
//             PurchLine.SETRANGE("Document No.","Source ID");
//             PurchLine.SETRANGE("Line No.","Source Ref. No.");
//             IF PurchLine.FINDFIRST THEN
//               EXIT(PurchLine."Job No." <> '');
//           END;
//         END;
//     end;

//     [Scope('Personalization')]
//     procedure FindLotNoBySN(TrackingSpecification: Record "336"): Code[50]
//     var
//         LotNo: Code[50];
//     begin
//         IF FindLotNoBySNSilent(LotNo,TrackingSpecification) THEN
//           EXIT(LotNo);

//         ERROR(LotNoBySNNotFoundErr,TrackingSpecification."Serial No.");
//     end;

//     [Scope('Personalization')]
//     procedure FindLotNoBySNSilent(var LotNo: Code[50];TrackingSpecification: Record "336"): Boolean
//     begin
//         IF NOT (PartialGlobalDataSetExists OR FullGlobalDataSetExists) THEN
//           RetrieveLookupData(TrackingSpecification,TRUE);

//         TempGlobalEntrySummary.RESET;
//         TempGlobalEntrySummary.SETCURRENTKEY("Lot No.","Serial No.");
//         TempGlobalEntrySummary.SETRANGE("Serial No.",TrackingSpecification."Serial No.");
//         IF NOT TempGlobalEntrySummary.FINDFIRST THEN
//           EXIT(FALSE);

//         LotNo := TempGlobalEntrySummary."Lot No.";
//         EXIT(TRUE);
//     end;

//     [Scope('Personalization')]
//     procedure GetAvailableLotQty(TrackingSpecification: Record "336"): Decimal
//     begin
//         IF TrackingSpecification."Lot No." = '' THEN
//           EXIT(0);

//         IF NOT (PartialGlobalDataSetExists OR FullGlobalDataSetExists) THEN
//           RetrieveLookupData(TrackingSpecification,TRUE);

//         TempGlobalEntrySummary.RESET;
//         TempGlobalEntrySummary.SETCURRENTKEY("Lot No.","Serial No.");
//         TempGlobalEntrySummary.SETRANGE("Lot No.",TrackingSpecification."Lot No.");
//         TempGlobalEntrySummary.CALCSUMS("Total Available Quantity");
//         EXIT(TempGlobalEntrySummary."Total Available Quantity");
//     end;

//     [Scope('Personalization')]
//     procedure SetSkipLot(SkipLot2: Boolean)
//     begin
//         // only last record with Lot Number updates Summary.
//         SkipLot := SkipLot2;
//     end;

//     local procedure FindLastGlobalEntrySummary(var GlobalChangedEntrySummary: Record "338";var LastGlobalEntrySummary: Record "338")
//     var
//         TempGlobalChangedEntrySummary2: Record "338" temporary;
//     begin
//         TempGlobalChangedEntrySummary2 := GlobalChangedEntrySummary;
//         GlobalChangedEntrySummary.SETRANGE("Lot No.",GlobalChangedEntrySummary."Lot No.");
//         IF GlobalChangedEntrySummary.FINDLAST THEN
//           LastGlobalEntrySummary := GlobalChangedEntrySummary;
//         GlobalChangedEntrySummary.COPY(TempGlobalChangedEntrySummary2);
//     end;

//     procedure SelectMultipleLotSerialNo1(var TrackingSpecification: Record "336" temporary;MaxQuantity: Decimal;CurrentSignFactor: Integer;var FlagLookUp1: Boolean;var SelectedQty1: Decimal)
//     var
//         TempEntrySummary: Record "338" temporary;
//         ItemTrackingSummaryForm: Page "6500";
//         Window: Dialog;
//         LookupMode: Option "Serial No.","Lot No.",All;
//         CreateReservEntry: Codeunit "99000830";
//     begin
//         //It's Copy of SelectMultipleLotSerialNo
        
//         CLEAR(ItemTrackingSummaryForm);
//         Window.OPEN(Text004);
//         LookupMode := LookupMode::All;
//         IF NOT FullGlobalDataSetExists THEN
//           RetrieveLookupData(TrackingSpecification,TRUE);
        
//         TempGlobalReservEntry.RESET;
//         TempGlobalEntrySummary.RESET;
        
//         // Swap sign if negative supply lines
//         IF CurrentSignFactor > 0 THEN
//           MaxQuantity := -MaxQuantity;
        
//         // Select the proper key
//         TempGlobalEntrySummary.SETCURRENTKEY("Expiration Date");
//         TempGlobalEntrySummary.SETFILTER("Expiration Date",'<>%1',0D);
//         IF TempGlobalEntrySummary.ISEMPTY THEN
//           TempGlobalEntrySummary.SETCURRENTKEY("Lot No.","Serial No.");
//         TempGlobalEntrySummary.SETRANGE("Expiration Date");
        
//         // Initialize form
//         ItemTrackingSummaryForm.CAPTION := Text011;
//         ItemTrackingSummaryForm.SETTABLEVIEW(TempGlobalEntrySummary);
//         TempGlobalEntrySummary.SETFILTER("Table ID",'<>%1',0); // Filter out summations
//         ItemTrackingSummaryForm.SetSources(TempGlobalReservEntry,TempGlobalEntrySummary);
//         ItemTrackingSummaryForm.SetSelectionMode(TRUE);
//         ItemTrackingSummaryForm.LOOKUPMODE(TRUE);
//         ItemTrackingSummaryForm.SetMaxQuantity(MaxQuantity);
//         ItemTrackingSummaryForm.SetCurrentBinAndItemTrkgCode(CurrBinCode,CurrItemTrackingCode);
        
//         // Run preselection on form
//         ItemTrackingSummaryForm.AutoSelectLotSerialNo;
        
//         Window.CLOSE;
        
//         //Code Blocked by anikEt++
//         /*
//         IF NOT (ItemTrackingSummaryForm.RUNMODAL = ACTION::LookupOK) THEN
//          EXIT;
//         */
//         //Code Blocked by anikEt--
        
//         //Code Added by anikEt++
//         IF NOT (ItemTrackingSummaryForm.RUNMODAL = ACTION::LookupOK) THEN
//         FlagLookUp1:=FALSE
//         ELSE
//         FlagLookUp1:=TRUE;
        
//         IF FlagLookUp1=FALSE THEN
//           EXIT;
//         //Code Added by anikEt--
        
//         ItemTrackingSummaryForm.GetSelected(TempEntrySummary);
//         IF TempEntrySummary.ISEMPTY THEN
//           EXIT;
        
//         // Swap sign on the selected entries if parent is a negative supply line
//         IF CurrentSignFactor > 0 THEN // Negative supply lines
//           IF TempEntrySummary.FIND('-') THEN
//             REPEAT
//               TempEntrySummary."Selected Quantity" := -TempEntrySummary."Selected Quantity";
//               TempEntrySummary.MODIFY;
//             UNTIL TempEntrySummary.NEXT = 0;
        
//         // Modify the item tracking lines with the selected quantities
//         AddSelectedLotSNToDataSet(TempEntrySummary,TrackingSpecification,CurrentSignFactor);
        
//         //anikEt++
//         SelectedQty1:=TempEntrySummary."Selected Quantity";
//         //anikEt--

//     end;

//     local procedure CanIncludeReservEntryToTrackingSpec(TempReservEntry: Record "337" temporary): Boolean
//     var
//         SalesLine: Record "37";
//     begin
//         WITH TempReservEntry DO
//           IF ("Reservation Status" = "Reservation Status"::Prospect) AND
//              ("Source Type" = DATABASE::"Sales Line") AND
//              ("Source Subtype" = 2)
//           THEN BEGIN
//             SalesLine.GET("Source Subtype","Source ID","Source Ref. No.");
//             IF SalesLine."Shipment No." <> '' THEN
//               EXIT(FALSE);
//           END;

//         EXIT(TRUE);
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnBeforeAssistEditTrackingNo(var TempTrackingSpecification: Record "336" temporary;var SearchForSupply: Boolean;CurrentSignFactor: Integer;LookupMode: Option "Serial No.","Lot No.";MaxQuantity: Decimal)
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnAfterAssistEditTrackingNo(var TrackingSpecification: Record "336";var TempGlobalEntrySummary: Record "338" temporary)
//     begin
//     end;

//     procedure AutoSelectLotSerialNo(var TempEntrySummary: Record "338" temporary;SelectQty: Decimal)
//     var
//         AvailableQty: Decimal;
//     begin
//         BEGIN
//               IF SelectQty = 0 THEN
//                 EXIT;

//               IF TempEntrySummary.FINDSET THEN
//                 REPEAT
//                   IF TempEntrySummary."Bin Active" THEN
//                     AvailableQty := MinValueAbs(TempEntrySummary."Bin Content",TempEntrySummary."Total Available Quantity")
//                   ELSE
//                     AvailableQty := TempEntrySummary."Total Available Quantity";

//                   IF AvailableQty > 0 THEN BEGIN
//                     TempEntrySummary."Selected Quantity" := MinValueAbs(AvailableQty,SelectQty);
//                     SelectQty -= TempEntrySummary."Selected Quantity";
//                     TempEntrySummary.MODIFY;
//                   END;
//                 UNTIL (TempEntrySummary.NEXT = 0) OR (SelectQty <= 0);
//             END;
//     end;

//     procedure AddSelectedLotSNToDataSet(var TempEntrySummary: Record "338" temporary;var TrackingSpecification: Record "336" temporary;CurrentSignFactor: Integer)
//     var
//         TrackingSpecification2: Record "336" temporary;
//         LastEntryNo: Integer;
//         ChangeType: Option Insert,Modify,Delete;
//     begin
//         BEGIN
//               TempEntrySummary.RESET;
//               TempEntrySummary.SETFILTER("Selected Quantity",'<>%1',0);
//               IF TempEntrySummary.ISEMPTY THEN
//                 EXIT;

//               // To save general and pointer information
//               TrackingSpecification2."Item No." := TrackingSpecification."Item No.";
//               TrackingSpecification2."Location Code" := TrackingSpecification."Location Code";
//               TrackingSpecification2."Source Type" := TrackingSpecification."Source Type";
//               TrackingSpecification2."Source Subtype" := TrackingSpecification."Source Subtype";
//               TrackingSpecification2."Source ID" := TrackingSpecification."Source ID";
//               TrackingSpecification2."Source Batch Name" := TrackingSpecification."Source Batch Name";
//               TrackingSpecification2."Source Prod. Order Line" := TrackingSpecification."Source Prod. Order Line";
//               TrackingSpecification2."Source Ref. No." := TrackingSpecification."Source Ref. No.";
//               TrackingSpecification2.Positive := TrackingSpecification.Positive;
//               TrackingSpecification2."Qty. per Unit of Measure" := TrackingSpecification."Qty. per Unit of Measure";
//               TrackingSpecification2."Variant Code" := TrackingSpecification."Variant Code";

//               TrackingSpecification.RESET;
//               IF TrackingSpecification.FINDLAST THEN
//                 LastEntryNo := TrackingSpecification."Entry No.";

//               TempEntrySummary.FINDFIRST;
//               REPEAT
//                 TrackingSpecification.SETRANGE("Serial No.",TempEntrySummary."Serial No.");
//                 TrackingSpecification.SETRANGE("Lot No.",TempEntrySummary."Lot No.");
//                 IF TrackingSpecification.FINDFIRST THEN BEGIN
//                   TrackingSpecification.VALIDATE("Quantity (Base)",
//                     TrackingSpecification."Quantity (Base)" + TempEntrySummary."Selected Quantity");
//                   TrackingSpecification."Buffer Status" := TrackingSpecification."Buffer Status"::MODIFY;
//                   TransferExpDateFromSummary(TrackingSpecification,TempEntrySummary);
//                   TrackingSpecification.MODIFY;
//                   UpdateLotSNDataSetWithChange(TrackingSpecification,TRUE,CurrentSignFactor,ChangeType::Modify);
//                 END ELSE BEGIN
//                   TrackingSpecification := TrackingSpecification2;
//                   TrackingSpecification."Entry No." := LastEntryNo + 1;
//                   LastEntryNo := TrackingSpecification."Entry No.";
//                   TrackingSpecification."Serial No." := TempEntrySummary."Serial No.";
//                   TrackingSpecification."Lot No." := TempEntrySummary."Lot No.";
//                   TrackingSpecification."Buffer Status" := TrackingSpecification."Buffer Status"::INSERT;
//                   TransferExpDateFromSummary(TrackingSpecification,TempEntrySummary);
//                   IF TrackingSpecification.IsReclass THEN
//                     BEGIN
//                     TrackingSpecification."New Serial No." := TrackingSpecification."Serial No.";
//                     TrackingSpecification."New Lot No." := TrackingSpecification."Lot No.";
//                   END;
//                   TrackingSpecification.VALIDATE("Quantity (Base)",TempEntrySummary."Selected Quantity");
//                   TrackingSpecification.INSERT;
//                   UpdateLotSNDataSetWithChange(TrackingSpecification,TRUE,CurrentSignFactor,ChangeType::Insert);
//                 END;
//               UNTIL TempEntrySummary.NEXT = 0;

//               TrackingSpecification.RESET;
//             END;
//     end;

//     procedure UpdateLotSNDataSetWithChange(var TempItemTrackLineChanged: Record "336" temporary;LineIsDemand: Boolean;CurrentSignFactor: Integer;ChangeType: Option Insert,Modify,Delete)
//     var
//         LastEntryNo: Integer;
//     begin
//         BEGIN
//               IF (TempItemTrackLineChanged."Serial No." = '') AND (TempItemTrackLineChanged."Lot No." = '') THEN
//                 EXIT;
//               LastEntryNo := UpdateLotSNGlobalChangeRec(TempItemTrackLineChanged,LineIsDemand,CurrentSignFactor,ChangeType);
//               TempGlobalChangedEntrySummary.GET(LastEntryNo);
//               UpdateTempSummaryWithChange(TempGlobalChangedEntrySummary);
//             END;
//     end;

//     procedure UpdateLotSNGlobalChangeRec(var TempItemTrackLineChanged: Record "336" temporary;LineIsDemand: Boolean;CurrentSignFactor: Integer;ChangeType: Option Insert,Modify,Delete) ChangedEntryNo: Integer
//     var
//         NewQuantity: Decimal;
//         LastEntryNo: Integer;
//     begin
//         BEGIN
//               IF (ChangeType = ChangeType::Delete) OR NOT LineIsDemand THEN
//                 NewQuantity := 0
//               ELSE
//                 NewQuantity := TempItemTrackLineChanged."Quantity (Base)" - TempItemTrackLineChanged."Quantity Handled (Base)";

//               IF CurrentSignFactor > 0 THEN // Negative supply lines
//                 NewQuantity := -NewQuantity;

//               TempGlobalChangedEntrySummary.RESET;
//               TempGlobalChangedEntrySummary.SETCURRENTKEY("Lot No.","Serial No.");

//               TempGlobalChangedEntrySummary.SETRANGE("Serial No.",TempItemTrackLineChanged."Serial No.");
//               TempGlobalChangedEntrySummary.SETRANGE("Lot No.",TempItemTrackLineChanged."Lot No.");

//               IF TempGlobalChangedEntrySummary.FINDFIRST THEN BEGIN
//                 IF LineIsDemand THEN BEGIN
//                   TempGlobalChangedEntrySummary."Current Pending Quantity" := NewQuantity;
//                   TempGlobalChangedEntrySummary.MODIFY;
//                 END;
//               END ELSE BEGIN
//                 TempGlobalChangedEntrySummary.RESET;
//                 IF TempGlobalChangedEntrySummary.FINDLAST THEN
//                   LastEntryNo := TempGlobalChangedEntrySummary."Entry No.";
//                 TempGlobalChangedEntrySummary.INIT;
//                 TempGlobalChangedEntrySummary."Entry No." := LastEntryNo + 1;
//                 TempGlobalChangedEntrySummary."Lot No." := TempItemTrackLineChanged."Lot No.";
//                 TempGlobalChangedEntrySummary."Serial No." := TempItemTrackLineChanged."Serial No.";
//                 TempGlobalChangedEntrySummary."Current Pending Quantity" := NewQuantity;
//                 IF TempItemTrackLineChanged."Serial No." <> '' THEN
//                   TempGlobalChangedEntrySummary."Table ID" := DATABASE::"Tracking Specification"; // Not a summary line
//                 TempGlobalChangedEntrySummary.INSERT;
//                 PartialGlobalDataSetExists := FALSE; // The partial data set does not cover the new line
//               END;
//               EXIT(TempGlobalChangedEntrySummary."Entry No.");
//             END;
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnAfterCreateEntrySummary(TrackingSpecification: Record "336";var TempGlobalEntrySummary: Record "338" temporary)
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnAfterCreateEntrySummary2(var TempGlobalEntrySummary: Record "338" temporary;var TempGlobalReservEntry: Record "337" temporary)
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnAfterRetrieveLookupData(var TrackingSpecification: Record "336";FullDataSet: Boolean;var TempGlobalReservEntry: Record "337" temporary;var TempGlobalEntrySummary: Record "338" temporary)
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnAfterTransferExpDateFromSummary(var TrackingSpecification: Record "336";var TempEntrySummary: Record "338" temporary)
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnAfterTransferReservEntryToTempRec(var GlobalReservEntry: Record "337";ReservEntry: Record "337")
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnBeforeTempTrackingSpecificationInsert(var TempTrackingSpecification: Record "336" temporary;var TempEntrySummary: Record "338" temporary)
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnBeforeTempGlobalChangedEntrySummaryInsert(var TempGlobalChangedEntrySummary: Record "338" temporary;var TempTrackingSpecificationChanged: Record "336" temporary)
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnBeforeUpdateBinContent(var TempEntrySummary: Record "338" temporary;var TempReservationEntry: Record "337" temporary)
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnTransferItemLedgToTempRecOnBeforeInsert(var TempGlobalReservEntry: Record "337" temporary;ItemLedgerEntry: Record "32";TrackingSpecification: Record "336";var IsHandled: Boolean)
//     begin
//     end;
// }

