table 50034 "Web Order Temp Header"
{

    fields
    {
        field(1; "Order ID"; Integer)
        {
        }
        field(2; "Customer No"; Code[50])
        {
        }
        field(3; "Document No"; Code[50])
        {
        }
        field(4; "Document Date"; DateTime)
        {
        }
        field(5; "Shipment Date"; DateTime)
        {
        }
        field(6; "Order Status"; Integer)
        {
        }
        field(7; "Ship to Name"; Text[100])
        {
        }
        field(8; "Ship to Address"; Text[100])
        {
        }
        field(9; "Ship to Address2"; Text[100])
        {
        }
        field(10; "Ship to City"; Text[30])
        {
        }
        field(11; "Ship to Country"; Text[30])
        {
        }
        field(12; "Ship to Email"; Code[10])
        {
        }
        field(13; Comments; Text[30])
        {
        }
        field(14; CustomerOrderId; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Order ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

