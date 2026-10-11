pageextension 50132 ItemTrackingLineExt extends "Item Tracking Lines"
{
    layout
    {
        addafter("Appl.-from Item Entry")
        {
            // field(Remarks; Rec.Remarks)
            // {
            //     caption = 'Boxes';
            //     applicationArea = All;
            // }
            field(Boxes; Boxes)
            {
                caption = 'Boxes';
                applicationArea = All;
                editable = false;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
    trigger OnAfterGetRecord()
    begin
        //Parag//
        recLotNoInfo.RESET;
        recLotNoInfo.SETRANGE(recLotNoInfo."Item No.", rec."Item No.");
        recLotNoInfo.SETRANGE(recLotNoInfo."Variant Code", rec."Variant Code");
        recLotNoInfo.SETRANGE(recLotNoInfo."Lot No.", rec."Lot No.");
        IF recLotNoInfo.FINDFIRST THEN BEGIN
            Boxes := recLotNoInfo.Remarks;
        END;
    end;

    var
        Boxes: Text[250];
        recLotNoInfo: Record "Lot No. Information";
}