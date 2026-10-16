tableextension 50007 "Item Ledger Entry Ext" extends "Item Ledger Entry"
{
    fields
    {

        field(50002; "Unit Cost (FCY)"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Purch. Rcpt. Line"."Direct Unit Cost" WHERE("Document No." = FIELD("Document No.")));

        }
        field(50003; "Currency Code"; Code[10])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Purch. Rcpt. Header"."Currency Code" WHERE("No." = FIELD("Document No.")));

        }
        field(50004; "Your Reference"; Text[35])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Purch. Rcpt. Header"."Your Reference" WHERE("No." = FIELD("Document No.")));

        }
        field(50005; "PDN No."; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Purch. Rcpt. Header"."Order No." WHERE("No." = FIELD("Document No.")));

        }
        //field added by microsoft
        // field(50006; "Item Description"; Text[100]) 
        // {
        //     FieldClass = FlowField;
        //     CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("Item No.")));

        // }
    }
}
