codeunit 60045 "NHS Item Tracking Data Coll."
{
    // Replacement for the old NAV customization "SelectMultipleLotSerialNo1" (see commented-out
    // reference in "Item tracking data collection.al"), which extended codeunit 6501 directly.
    // BC's "Item Tracking Data Collection" is sealed, so instead this subscribes to the
    // publisher's own integration event to recover the same FlagLookUp/SelectedQty information
    // around a plain call to the standard SelectMultipleTrackingNo.

    var
        FlagLookUp: Boolean;
        SelectedQty: Decimal;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Tracking Data Collection", 'OnSelectMultipleTrackingNoOnBeforeAddSelectedTrackingToDataSet', '', false, false)]
    local procedure OnBeforeAddSelectedTrackingToDataSet(var TempEntrySummary: Record "Entry Summary" temporary; var TempTrackingSpecification: Record "Tracking Specification" temporary; CurrentSignFactor: Integer)
    begin
        FlagLookUp := true;
        SelectedQty := TempEntrySummary."Selected Quantity";
    end;

    procedure ResetState()
    begin
        Clear(FlagLookUp);
        Clear(SelectedQty);
    end;

    procedure GetFlagLookUp(): Boolean
    begin
        exit(FlagLookUp);
    end;

    procedure GetSelectedQty(): Decimal
    begin
        exit(SelectedQty);
    end;
}
