pageextension 50114 InvtPickSubformExt extends "Invt. Pick Subform"
{
    layout
    {
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