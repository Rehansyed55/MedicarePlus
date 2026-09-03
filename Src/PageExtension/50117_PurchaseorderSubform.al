pageextension 50117 "Purchase Order Subform Ext" extends "Purchase Order Subform"
{
    layout
    {
        // NAV field order check (NAV "Purchase Order Subform" repeater, anchors): Type -> No. -> ... -> Description ->
        // ... -> Location Code -> Bin Code(hidden) -> Quantity -> ... -> Unit of Measure Code -> ... -> Direct Unit Cost.
        // This already matches the standard BC "Purchase Order Subform" column order for the anchor fields
        // (Type, No., Description, Quantity, Direct Unit Cost), so no moveafter/movebefore statements are needed
        // for standard fields. The custom "Release Prod. Order No." field below (mapped to Rec."Prod. Order No.")
        // is a pre-existing extension insertion after "Bin Code" and is left in place per task constraints - in NAV
        // the underlying "Prod. Order No." field is a hidden field located much later (manufacturing section), but
        // since the extension deliberately re-exposes/relabels it here as a visible custom field, it is not moved.
        // Add changes to page layout here
        addafter("Bin Code")
        {
            field("Release Prod. Order No."; Rec."Prod. Order No.")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
        
}