page 50103 "Gate Entry Location Setup"
{
    // version NAVIN5.00.01

    Caption = 'Gate Entry Location Setup';
    PageType = Card;
    SourceTable = "Gate Entry Location Setup 1";
    ApplicationArea = all;
    UsageCategory = Administration;


    layout
    {
        area(content)
        {
            repeater(general)
            {
                field("Entry Type"; rec."Entry Type")
                {
                    ApplicationArea = all;
                }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field("Posting No. Series"; rec."Posting No. Series")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

