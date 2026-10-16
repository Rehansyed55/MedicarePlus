page 50119 "Doc Wise Packing Details"
{
    Caption = 'Doc Wise Packing Details';
    PageType = List;
    SourceTable = "Doc Wise Packing Details";
    AutoSplitKey = false;

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field("Entry Line No"; Rec."Entry Line No")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(UOM; Rec.UOM)
                {
                    ApplicationArea = All;
                    Caption = 'UOM';
                }
                field("No of.Units"; Rec."No of.Units")
                {
                    ApplicationArea = All;
                    Caption = 'No of Units';
                    Visible = NoOfUnitsVisible;
                }
                field("No Of.Pack"; Rec."No Of.Pack")
                {
                    ApplicationArea = All;
                    Caption = 'No Of Pack';
                    Visible = NoOfPackVisible;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("Company Weight"; Rec."Company Weight")
                {
                    ApplicationArea = All;
                }
                field("Carrier Weight"; Rec."Carrier Weight")
                {
                    ApplicationArea = All;
                }
            }
        }

        area(FactBoxes)
        {

            part(AttachmentFactBox; "Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                SubPageLink =
                    "Table ID" = const(50120),
                    "No." = field("Document No."),
                    "Line No." = field("Entry Line No");
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            group(Attachment)
            {
                Caption = '&Attachment';

                action(OpenAttachment)
                {
                    ApplicationArea = All;
                    Caption = 'Open';
                    ShortCutKey = Return;
                    Image = Open;

                    trigger OnAction()
                    begin
                        Rec.OpenAttachment();
                    end;
                }
                action(CreateAttachment)
                {
                    ApplicationArea = All;
                    Caption = 'Create';
                    Ellipsis = true;
                    Image = New;

                    trigger OnAction()
                    begin
                        Rec.CreateAttachment();
                        CurrPage.Update();
                        CurrPage.AttachmentFactBox.Page.Update();
                    end;
                }
                action(CopyFromAttachment)
                {
                    ApplicationArea = All;
                    Caption = 'Copy &from';
                    Ellipsis = true;
                    Image = Copy;

                    trigger OnAction()
                    begin
                        Rec.CopyFromAttachment();
                        CurrPage.Update();
                        CurrPage.AttachmentFactBox.Page.Update();
                    end;
                }
                action(ImportAttachment)
                {
                    ApplicationArea = All;
                    Caption = 'Import';
                    Ellipsis = true;
                    Image = Import;

                    trigger OnAction()
                    begin
                        Rec.ImportAttachment();
                        CurrPage.Update();
                        CurrPage.AttachmentFactBox.Page.Update();
                    end;
                }
                action(ExportAttachment)
                {
                    ApplicationArea = All;
                    Caption = 'E&xport';
                    Ellipsis = true;
                    Image = Export;

                    trigger OnAction()
                    begin
                        Rec.ExportAttachment();
                    end;
                }
                action(RemoveAttachment)
                {
                    ApplicationArea = All;
                    Caption = 'Remove';
                    Ellipsis = true;
                    Image = Delete;

                    trigger OnAction()
                    begin
                        Rec.RemoveAttachment(true);
                        CurrPage.Update();
                        CurrPage.AttachmentFactBox.Page.Update();
                    end;
                }
            }
        }
    }

    trigger OnInit()
    begin
        NoOfUnitsVisible := true;
        NoOfPackVisible := true;
    end;

    trigger OnOpenPage()
    begin

        SetFieldVisibilityFromFilter();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        SetFieldVisibility(Rec."Document Type");
    end;

    var
        NoOfPackVisible: Boolean;
        NoOfUnitsVisible: Boolean;

    local procedure SetFieldVisibilityFromFilter()
    var
        FilterRec: Record "Doc Wise Packing Details";
    begin
        FilterRec.CopyFilters(Rec);

        if FilterRec.GetFilter("Document Type") <> '' then
            SetFieldVisibility(Rec."Document Type"::GateEntryIn)  // default safe value
        else
            SetFieldVisibility(Rec."Document Type"::GateEntryIn);
        // OnAfterGetCurrRecord will immediately refine once first row is loaded
    end;

    local procedure SetFieldVisibility(DocType: Option)
    begin
        case DocType of
            Rec."Document Type"::GateEntryIn:
                begin
                    NoOfUnitsVisible := true;
                    NoOfPackVisible := false;
                end;
            Rec."Document Type"::"Purchase Order":
                begin
                    NoOfUnitsVisible := false;
                    NoOfPackVisible := true;
                end;
            else begin

                NoOfUnitsVisible := true;
                NoOfPackVisible := true;
            end;
        end;
    end;
}
