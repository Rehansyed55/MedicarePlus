tableextension 50014 "Sales Shipment Header Ext" extends "Sales Shipment Header"
{
    fields
    {
        field(50000; "No. of records in Ledger"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Item Ledger Entry" WHERE("Document No." = FIELD("No."),
                                                           "Entry Type" = CONST(Sale),
                                                           "Document Type" = CONST("Item Ledger Document Type"::"Sales Shipment")));
            Description = '//Upgradation Nav13';
        }
        field(50001; "No. of records in Warehouse en"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Warehouse Entry" WHERE("Source No." = FIELD("No."),
                                                         "Reference Document" = CONST("Whse. Reference Document Type"::"Posted Shipment")));
            Description = '//Upgradation Nav13';
        }
    }
}
