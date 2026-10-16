table 50053 "Reclass Table_Old"
{

    fields
    {
        field(1; Entryno; Integer)
        {
        }
        field(2; "Item No."; Code[20])
        {
        }
        field(3; "Item Des"; Text[100])
        {
        }
        field(4; "Old Bin Code"; Code[10])
        {
        }
        field(5; "Batch No."; Code[20])
        {
        }
        field(6; "Expiration Date"; Date)
        {
        }
        field(7; Qty; Decimal)
        {
        }
        field(8; "Avg Cost"; Decimal)
        {
        }
        field(9; "Total Amt."; Decimal)
        {
        }
        field(10; "New Bin"; Code[10])
        {
        }
        field(11; "Req. Qty"; Decimal)
        {
        }
        field(12; "Bin Qty"; Decimal)
        {
        }
        field(13; "New QTy"; Decimal)
        {
        }
        field(14; "Total Qty"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; Entryno)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

