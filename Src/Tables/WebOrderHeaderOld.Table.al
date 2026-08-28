table 50074 "Web Order Header_Old"
{
    // LookupPageID = 50103;

    fields
    {
        field(1; "Order ID"; Integer)
        {
            AutoIncrement = true;

            trigger OnValidate()
            begin
                IF "Order ID" = 0 THEN
                    ERROR('Please enter Order ID');
            end;
        }
        field(2; "Customer No"; Code[20])
        {
            TableRelation = "Customer"."No.";
        }
        field(3; "Document No"; Code[20])
        {
        }
        field(4; "Document Date"; Date)
        {
        }
        field(5; "Shipment Date"; Date)
        {
        }
        field(6; "Order Status"; Option)
        {
            Editable = false;
            OptionCaption = 'In Process,Confirm,Completed,On Hold';
            OptionMembers = "In Process",Confirm,Completed,"On Hold",UnConfirm,"Call Back";
        }
        field(7; Comments; Text[100])
        {
        }
        field(8; CustomerOrderId; Code[20])
        {
        }
        field(9; ShipToName; Text[50])
        {
        }
        field(10; ShipToAddress; Text[50])
        {
        }
        field(11; ShipToAddress2; Text[50])
        {
        }
        field(12; ShipToCity; Text[30])
        {
            TableRelation = "Post Code".Code;
        }
        field(13; ShipToCounty; Text[30])
        {
        }
        field(14; ShipToPostCode; Code[20])
        {
            TableRelation = "Post Code".Code;
        }
        field(15; ShipToContact; Text[30])
        {
        }
        field(16; ShipToPhone; Text[30])
        {
        }
        field(17; BillToName; Text[50])
        {
        }
        field(18; BillToAddress; Text[50])
        {
        }
        field(19; BillToAddress2; Text[50])
        {
        }
        field(20; BillToCity; Text[30])
        {
            TableRelation = "Post Code".Code;
        }
        field(21; BillToCounty; Text[30])
        {
        }
        field(22; BillToPostCode; Code[20])
        {
            TableRelation = "Post Code".Code;
        }
        field(23; BillToContact; Text[30])
        {
        }
        field(24; BillToPhone; Text[30])
        {
        }
        field(25; "Ship to Code"; Code[20])
        {
            TableRelation = "Ship-to Address".Code WHERE("Customer No." = FIELD("Customer No"));
        }
        field(26; "Web Order Id"; Code[20])
        {
            Editable = false;
        }
        field(27; "Requested Delivery Date"; DateTime)
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

