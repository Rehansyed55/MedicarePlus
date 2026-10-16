tableextension 50005 "Vendor Ledger Entry Ext" extends "Vendor Ledger Entry"
{
    fields
    {
        field(50100; "Your Reference"; Text[35])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Purch. Inv. Header"."Your Reference" WHERE("Buy-from Vendor No." = FIELD("Vendor No."),
                                                                              "No." = FIELD("Document No.")));
            Description = '//Upgradation Nav13';
        }
    }
}
