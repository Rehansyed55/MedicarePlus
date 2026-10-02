pageextension 50131 LotNoInfoCardExt extends "Lot No. Information Card"
{
    layout
    {
        addafter(Blocked)
        {
            field(Remarks; Rec.Remarks)
            {
                applicationArea = all;
                caption = 'Boxes';
            }
            field("Expiration Date"; Rec."Expiration Date")
            {
                applicationArea = all;

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