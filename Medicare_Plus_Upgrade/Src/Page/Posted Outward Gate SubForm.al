page 50117 "Posted Outward Gate SubForm"
{
    // version NAVIN5.00.01

    AutoSplitKey = true;
    Caption = 'Posted Outward Gate SubForm';
    Editable = false;
    PageType = ListPart;
    SourceTable = "Posted Gate Entry Line 1";

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field("Supplier Delivery Note"; rec."Supplier Delivery Note")
                {
                    ApplicationArea = all;
                }
                field(Date; rec."Supplier Delivery Date")
                {
                    ApplicationArea = all;
                }
                field("Doc. Source Type"; rec."Doc. Source Type")
                {
                    // OptionCaption = ' ,Sales Shipment,,,Purchase Return Shipment,,Transfer Shipment';
                    ApplicationArea = all;
                }
                field("Doc. Source No."; rec."Doc. Source No.")
                {
                    ApplicationArea = all;
                }
                field("Source Name"; rec."Source Name")
                {
                    ApplicationArea = all;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Gate Entry")
            {
                Caption = '&Gate Entry';
                action("Packing Details")
                {
                    Caption = 'Packing Details';
                    ApplicationArea = all;
                    Enabled = false;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50015. Unsupported part was commented. Please check it.
                        /*CurrPage.InwardGateEntryline.PAGE.*/
                        // _ShowPackingdetails
                        _ShowPackingdetails();

                    end;
                }
            }
        }
    }
    procedure _ShowPackingdetails()
    begin
        Rec.ShowPackingDetails();
    end;
}

