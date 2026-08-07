pageextension 60032 InventoryPick extends "Inventory Pick"
{
    layout
    {
        addlast(General)
        {
            field("Print Packing List"; Rec."Print Packing List")
            {
                ApplicationArea = all;
                Caption = 'Print Packing List';
            }


            field("Shipping Method"; Rec."Shipping Method")
            {
                ApplicationArea = All;
            }

            field("Requested Delivery Date"; Rec."Requested Delivery Date")
            {
                ApplicationArea = All;
                Editable = false;
            }

            field("Promised Delivery Date"; Rec."Promised Delivery Date")
            {
                ApplicationArea = All;
            }
            field("Ship-to code"; Rec."Ship-to code")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        modify("P&ost")
        {
            trigger OnBeforeAction()
            begin
                InvPick := Rec."No.";
                PrintPackingList := Rec."Print Packing List";

            end;

            trigger OnAfterAction()
            begin
                PrintPackingListIfRequested();
            end;
        }

    }


    local procedure PrintPackingListIfRequested()
    var
        PostedInvtPickHeader: Record "Posted Invt. Pick Header";
    begin
        if not PrintPackingList then
            exit;

        PostedInvtPickHeader.Reset();
        PostedInvtPickHeader.SetRange("Invt Pick No.", InvPick);
        if PostedInvtPickHeader.FindFirst() then
            Report.RunModal(Report::"Posted Picking List", false, false, PostedInvtPickHeader);
    end;



    var
        // DefaultSetup: Record 50012;
        CompName: Text[50];
        InvPick: Code[20];
        UserSetup: Record "User Setup";
        PrintPackingList: Boolean;



}