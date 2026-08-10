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
                // Editable = false; 
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
        modify("TSRD Address Group")
        {
            Visible = false;
        }
        modify("TSRD Shipping")
        {
            Visible = false;
        }
        addlast(Content)
        {
            group(Shipping)
            {
                Caption = 'Shipping';

                group("Ship To Address")
                {
                    field("Ship-to Name"; Rec."Ship-to Name")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Ship-to Address"; Rec."Ship-to Address")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Ship-to Address 2"; Rec."Ship-to Address 2")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Ship-to City"; Rec."Ship-to City")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Ship-to Post Code"; Rec."Ship-to Post Code")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }

                }
                group("Shippings Method")
                {
                    Caption = 'Shipping Method';
                    field("Shipping Agent Code"; rec."Shipping Agent Code")
                    {
                        ApplicationArea = All;
                        Editable = false;

                    }
                    field("Shipping Agent Service Code"; rec."Shipping Agent Service Code")
                    {
                        ApplicationArea = All;
                        Editable = false;

                    }
                }
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