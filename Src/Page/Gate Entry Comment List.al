page 50101 "Gate Entry Comment List"
{
    // version NAVIN5.00.01

    Caption = 'Gate Entry Comment List';
    DataCaptionFields = "Gate Entry Type", "No.";
    Editable = false;
    PageType = Card;
    SourceTable = "Gate Entry Comment Line1";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                }
                field(Date; rec.Date)
                {
                    ApplicationArea = all;
                }
                field(Comment; rec.Comment)
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

