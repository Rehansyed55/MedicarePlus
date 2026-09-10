pageextension 50130 ItemTrackingSummaryExt extends "Item Tracking Summary"
{
    layout
    {
        modify("Expiration Date")
        {
            applicationArea = all;
            visible = true;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}