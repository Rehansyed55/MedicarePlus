tableextension 50012 "Item Jrnl. Line Ext" extends "Item Journal Line"
{
    fields
    {
        modify("Output Quantity")
        {
            trigger OnAfterValidate()
            var
            begin
                //Upgraded Code from NAV 5.0
                //=====================================================================================
                IF ("Entry Type" = "Entry Type"::Output) THEN BEGIN
                    IF DefaultSetup.GET() THEN // Not able to get default Setup
                    BEGIN
                        DefaultSetup.InsertAutoLotNoInOut("Order No.", "Item No.", "Variant Code", "Posting Date",
                        "Journal Template Name", "Journal Batch Name", "Line No.", "Output Quantity", "Operation No.");
                    END;
                END;
                //=====================================================================================

            end;
        }
    }

    var
        DefaultSetup: Record 50012;
}
