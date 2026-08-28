table 50033 "Web Order Temp"
{

    fields
    {
        field(1; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Customer No"; Code[20])
        {
        }
        field(3; "Document No"; Code[20])
        {
        }
        field(4; "Document Date"; DateTime)
        {
        }
        field(5; itemcatcode; Code[50])
        {
        }
        field(6; "Item No_"; Code[30])
        {
        }
        field(7; Description; Text[50])
        {
        }
        field(8; "Location Code"; Code[20])
        {
        }
        field(9; "Unit of Measure"; Code[10])
        {
        }
        field(10; Quantity; Decimal)
        {
        }
        field(11; "Shipment Date"; DateTime)
        {
        }
        field(12; "Order Status"; Integer)
        {
        }
        field(13; "Ship-to Name"; Code[50])
        {
        }
        field(14; "Ship-to Address"; Code[50])
        {
        }
        field(15; "Ship-to Address 2"; Code[50])
        {
        }
        field(16; "Ship-to City"; Code[30])
        {
        }
        field(17; "Ship-to Contact"; Code[10])
        {
        }
        field(18; "Ship-to Post Code"; Code[20])
        {
        }
        field(19; "Ship-to County"; Code[20])
        {
        }
        field(20; "Ship-to E-Mail"; Code[10])
        {
        }
        field(21; "Web Unit Price"; Decimal)
        {
        }
        field(22; "Unit Price"; Decimal)
        {
        }
        field(23; "Order Id"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

