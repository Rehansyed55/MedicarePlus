pageextension 60033 "Posted Invt. Pick" extends "Posted Invt. Pick"
{
    layout
    {
        addlast(General)
        {
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
                ApplicationArea = All;
                Editable = false;
            }
            field("Ship-to code"; Rec."Ship-to code")
            {
                ApplicationArea = All;
                Editable = false;
            }
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
                    }
                    field("Ship-to Address"; Rec."Ship-to Address")
                    {
                        ApplicationArea = All;
                    }
                    field("Ship-to Address 2"; Rec."Ship-to Address 2")
                    {
                        ApplicationArea = All;
                    }
                    field("Ship-to City"; Rec."Ship-to City")
                    {
                        ApplicationArea = All;
                    }
                    field("Ship-to Post Code"; Rec."Ship-to Post Code")
                    {
                        ApplicationArea = All;
                    }
                    field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                    {
                        ApplicationArea = All;
                    }

                }
                group("Shippings Method")
                {
                    Caption = 'Shipping Method';
                    field("Shipping Agent Code"; rec."Shipping Agent Code")
                    {
                        ApplicationArea = All;

                    }
                    field("Shipping Agent Service Code"; rec."Shipping Agent Service Code")
                    {
                        ApplicationArea = All;

                    }
                }
            }
        }
    }
    actions
    {
        addlast(Reporting)
        {
            action(PickingList)
            {
                ApplicationArea = All;
                Caption = 'PickingList';
                Image = Print;
                Promoted = true;
                PromotedCategory = Report;

                trigger OnAction()
                var
                    PIV: Record "Posted Invt. Pick Header";
                begin
                    PIV.Copy(Rec);
                    PIV.SetRecFilter();
                    Report.RunModal(Report::"Posted Picking List", true, true, PIV);
                end;
            }
        }
    }

    var
        myInt: Integer;
}