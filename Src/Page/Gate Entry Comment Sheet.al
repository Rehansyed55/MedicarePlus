page 50102 "Gate Entry Comment Sheet"
{
    // version NAVIN5.00.01

    AutoSplitKey = true;
    Caption = 'Gate Entry Comment Sheet';
    DataCaptionFields = "Gate Entry Type", "No.";
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = Worksheet;
    SourceTable = "Gate Entry Comment Line1";
   
    layout
    {
        area(content)
        {
            repeater(general)
            {
                field(Date; rec.Date)
                {
                    ApplicationArea = all;
                }
                field(Comment; rec.Comment)
                {
                    ApplicationArea = all;
                }
                field(Code; rec.Code)
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        rec.SetUpNewLine;
    end;
}

