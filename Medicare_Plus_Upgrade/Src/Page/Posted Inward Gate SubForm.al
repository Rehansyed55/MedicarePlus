page 50114 "Posted Inward Gate SubForm"
{
    // version NAVIN5.00.01

    Caption = 'Posted Inward Gate SubForm';
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
                    ApplicationArea = all;
                    //  OptionCaption = ' ,,Sales Return Order,Purchase Order,,Transfer Receipt';
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
                field(Status; rec.Status)
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
                    //Enabled = false;


                    trigger OnAction()
                    begin
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

