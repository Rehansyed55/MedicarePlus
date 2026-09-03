pageextension 50114 InvtPickSubformExt extends "Invt. Pick Subform"
{
    layout
    {
        // NAV field order check (NAV "Invt. Pick Subform" repeater): Item No. -> Description -> Location Code(hidden) ->
        // Bin Code -> Shelf No.(hidden) -> Quantity -> Qty. to Handle -> Qty. Handled -> Qty. Outstanding ->
        // Unit of Measure Code -> ... -> Process Status -> Pallet Number -> Box Number -> Total Unit/Box ->
        // Checked -> Checked By.
        // This already matches the standard BC "Invt. Pick Subform" column order for the anchor fields
        // (Item No., Description, Bin Code, Quantity), so no moveafter/movebefore statements are needed for
        // standard fields. The custom Process Status / Picked By User / Pallet Number / Box Number /
        // Total Unit/Box / Checked / Checked By fields below are a pre-existing extension insertion after
        // "Unit of Measure Code" (matching NAV placement) and are left in place per task constraints.
        // Note: "Picked By User" has no corresponding NAV field (BC-only addition) - left where it is.
        addafter("Unit of Measure Code")
        {
            field("Process Status"; Rec."Process Status")
            {
                ApplicationArea = all;
                Caption = 'Picked By';
            }
            field("Picked By User"; Rec."Picked By User")
            {
                ApplicationArea = all;
            }
            field("Pallet Number"; Rec."Pallet Number")
            {
                ApplicationArea = all;
            }
            field("Box Number"; Rec."Box Number")
            {
                ApplicationArea = all;
            }
            field("Total Unit/Box"; Rec."Total Unit/Box")
            {
                ApplicationArea = all;
            }
            field(Checked; Rec.Checked)
            {
                ApplicationArea = all;
                Caption = 'Checked By';

            }
            field("Checked By"; Rec."Checked By")
            {
                ApplicationArea = all;
                Caption = 'Checked By User';
            }


        }

    }
}