table 50075 "WEB Order Line_Old"
{

    fields
    {
        field(1; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Customer No."; Code[20])
        {
        }
        field(3; "Document No."; Code[20])
        {
        }
        field(5; itemcatcode; Code[20])
        {
        }
        field(6; "Item No."; Code[20])
        {
            TableRelation = Item;
        }
        field(7; Description; Text[50])
        {
        }
        field(8; "Location Code"; Code[20])
        {
            TableRelation = Location;
        }
        field(9; "Unit of Measure"; Code[20])
        {
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("Item No."));
        }
        field(10; Quantity; Decimal)
        {
        }
        field(13; "Web Unit Price"; Decimal)
        {
        }
        field(14; "Unit Price"; Decimal)
        {
        }
        field(15; "Order Id"; Integer)
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

