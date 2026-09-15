page 50121 "NHS-IMS-Supplier List"
{
    // version CHEM-280

    Editable = false;
    PageType = List;
    SourceTable = "NHS-IMS-Supplier Data";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("PI No"; rec."PI No")
                {
                    Visible = false;
                }
                field("ECMA No"; rec."ECMA No")
                {
                    Visible = false;
                }
                field("Item No"; rec."Item No")
                {
                }
                field("NHS Rank"; rec."NHS Rank")
                {
                }
                field("NHS Pack Sales"; rec."NHS Pack Sales")
                {
                }
                field("NHS Generic"; rec."NHS Generic")
                {
                }
                field("OTC Spot Buy Sales"; rec."OTC Spot Buy Sales")
                {
                    Visible = false;
                }
                field("OTC Spot Buy Sales Avg."; rec."OTC Spot Buy Sales Avg.")
                {
                    Visible = false;
                }
                field("IMS Rank"; rec."IMS Rank")
                {
                    Visible = false;
                }
                field("IMS Value"; rec."IMS Value")
                {
                    Visible = false;
                }
                field("IMS Units"; rec."IMS Units")
                {
                    Visible = false;
                }
                field("IMS Brand for Brand"; rec."IMS Brand for Brand")
                {
                    Visible = false;
                }
                field("IMS Brand for Generic"; rec."IMS Brand for Generic")
                {
                    Visible = false;
                }
                field("IMS Generic"; rec."IMS Generic")
                {
                    Visible = false;
                }
                field("% Sales- Brand Prescrition"; rec."% Sales- Brand Prescrition")
                {
                    Caption = '% Sales- Brand Prescription';
                }
                field("Patient Staus"; rec."Patient Staus")
                {
                    Caption = 'Patent Status';
                }
                field("Patient Expiry"; rec."Patient Expiry")
                {
                    Caption = 'Patent Expiry';
                }
                field("SPC Expiry"; rec."SPC Expiry")
                {
                }
                field("Last Modified Date"; rec."Last Modified Date")
                {
                }
                field("Last Modified Time"; rec."Last Modified Time")
                {
                }
            }
        }
    }

    actions
    {
    }
}

