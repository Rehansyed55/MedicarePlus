table 50029 "WEB Order Line"
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
            TableRelation = "Web Order Header"."Order ID" WHERE("Order ID" = FIELD("Order Id"));
        }
        field(16; Comment; Text[80])
        {
            Caption = 'Comment';
        }
        field(50001; "VAT Amount"; Decimal)
        {
            Description = 'B2B';
        }
        field(50002; "PIP Code"; Code[20])
        {
            Description = 'B2B';
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

