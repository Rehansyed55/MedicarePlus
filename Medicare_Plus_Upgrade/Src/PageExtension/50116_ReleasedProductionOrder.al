pageextension 50116 ReleasedProductionOrder extends "Released Production Order"
{
    layout
    {
        addlast(General)
        {

            field("ECMA No."; Rec."ECMA No.")
            {
                ApplicationArea = All;
            }
            field("Production BOM No."; Rec."Production BOM No.")
            {
                ApplicationArea = All;
            }
            field("Production BOM Version No."; Rec."Production BOM Version No.")
            {
                ApplicationArea = All;
            }
            field("WMS Receipt No."; Rec.WMSReceiptNo)
            {
                ApplicationArea = All;
            }
            field("BPR Version No."; Rec."BPR Version No.")
            {
                ApplicationArea = All;
            }
            field("PLPI No."; Rec."PLPI No.")
            {
                ApplicationArea = All;
            }
            field("Lot No."; Rec."Lot No.")
            {
                ApplicationArea = All;
            }
            field("Expiry Date"; Rec."Expiry Date")
            {
                ApplicationArea = All;
            }
            field("Posted Warehouse Receipt No."; Rec."Posted Warehouse Receipt No.")
            {
                ApplicationArea = All;
            }
            field("Posted Receipt No."; Rec."Posted Receipt No.")
            {
                ApplicationArea = All;
            }
            field("Routing No."; Rec."Routing No.")
            {
                ApplicationArea = All;
            }
            field("Firm Planned Order No."; rec."Firm Planned Order No.")
            {
                ApplicationArea = All;
            }
            field("PLPI Item Code"; Rec."PLPI Item Code")
            {
                ApplicationArea = All;
            }
            field("Rebox/Overlabel"; Rec."Rebox/Overlabel")
            {
                ApplicationArea = All;
            }
            field("Your Reference"; Rec."Your Reference")
            {
                ApplicationArea = All;
            }
            field("Supplier Code"; Rec."Supplier Code")
            {
                ApplicationArea = All;
            }
            field("BPR Checked"; Rec."BPR Checked")
            {
                ApplicationArea = All;
            }
            field("Technical Agreement No."; Rec."Technical Agreement No.")
            {
                ApplicationArea = All;
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