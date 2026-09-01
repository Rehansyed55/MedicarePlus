tableextension 50041 "Warehouse Receipt Header Ext" extends "Warehouse Receipt Header"
{
    fields
    {
        field(50001; "Select All"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Upgrade frm Nav5';
            trigger OnValidate()
            begin
                if "Select All" then begin
                    TestField("Gate Entry No.");
                    //FetchGateEntryLines();
                end;
            end;
        }
        field(50002; "Gate Entry No."; Code[20])
        {
            Caption = 'Gate Entry No.';
            DataClassification = ToBeClassified;
            TableRelation = "Posted Gate Entry Header 1"."No." where(
    "Entry Type" = const(Inward),
    "Location Code" = field("Location Code"),
    "Bin Code" = field("Bin Code"));
            trigger OnValidate()
            begin
                if "Gate Entry No." <> xRec."Gate Entry No." then
                    "Select All" := false;
            end;
        }
    }
}
