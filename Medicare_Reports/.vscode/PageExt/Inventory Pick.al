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
                Editable = false;
            }

            field("Requested Delivery Date"; Rec."Requested Delivery Date")
            {
                ApplicationArea = All;
                Editable = false;
            }

            field("Promised Delivery Date"; Rec."Promised Delivery Date")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Ship-to code"; Rec."Ship-to code")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
        // modify("TSRD Address Group")
        // {
        //     Visible = false;
        // }
        // modify("TSRD Shipping")
        // {
        //     Visible = false;
        // }
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
                SavePickStateBeforePosting(false);
            end;

            trigger OnAfterAction()
            begin
                PrintPackingListIfRequested();
            end;
        }
        modify(PostAndPrint)
        {
            trigger OnBeforeAction()
            begin
                SavePickStateBeforePosting(true);
            end;

            trigger OnAfterAction()
            begin
                PrintPackingListIfRequested();
            end;
        }

    }


    local procedure SavePickStateBeforePosting(HoldBackInvoicePrint: Boolean)
    var
        PostedInvtPickHeader: Record "Posted Invt. Pick Header";
    begin
        InvPick := Rec."No.";
        PrintPackingList := Rec."Print Packing List";

        // Remember the latest posted pick that already exists, so a cancelled post doesn't reprint it
        LastPostedInvtPickNo := '';
        PostedInvtPickHeader.SetRange("Invt Pick No.", InvPick);
        if PostedInvtPickHeader.FindLast() then
            LastPostedInvtPickNo := PostedInvtPickHeader."No.";

        // Drop any binding/state left over from a previous post on this page that ended in an error
        if UnbindSubscription(PackingListPrint) then;
        Clear(PackingListPrint);

        // Post and Print: hold back the standard invoice print so it can be merged with the packing list
        if PrintPackingList and HoldBackInvoicePrint then begin
            PackingListPrint.SetSalesOrderNo(Rec."Source No.");
            BindSubscription(PackingListPrint);
        end;
    end;

    local procedure PrintPackingListIfRequested()
    var
        PostedInvtPickHeader: Record "Posted Invt. Pick Header";
    begin
        if not PrintPackingList then
            exit;
        if UnbindSubscription(PackingListPrint) then;

        PostedInvtPickHeader.SetRange("Invt Pick No.", InvPick);
        if PostedInvtPickHeader.FindLast() then
            if PostedInvtPickHeader."No." <> LastPostedInvtPickNo then begin
                PostedInvtPickHeader.SetRecFilter();
                PackingListPrint.PrintInvoiceWithPackingList(PostedInvtPickHeader);
                exit;
            end;

        // No new posted pick found - still make sure a held back invoice is printed
        PackingListPrint.PrintHeldBackInvoice();
    end;



    var
        // DefaultSetup: Record 50012;
        CompName: Text[50];
        InvPick: Code[20];
        UserSetup: Record "User Setup";
        PrintPackingList: Boolean;
        LastPostedInvtPickNo: Code[20];
        PackingListPrint: Codeunit "Invt. Pick Packing List Print";



}