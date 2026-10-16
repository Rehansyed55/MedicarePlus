table 50005 "Gate Entry Attachment1"
{
    Caption = 'Gate Entry Attachment';
    // LookupPageID = 50004;

    fields
    {
        field(1; "Source Type"; Option)
        {
            Caption = 'Source Type';
            OptionCaption = ' ,Sales Shipment,Sales Return Order,Purchase Order,Purchase Return Shipment,Transfer Receipt,Transfer Shipment';
            OptionMembers = " ","Sales Shipment","Sales Return Order","Purchase Order","Purchase Return Shipment","Transfer Receipt","Transfer Shipment";
        }
        field(2; "Source No."; Code[20])
        {
            Caption = 'Source No.';
        }
        field(3; "Entry Type"; Option)
        {
            Caption = 'Entry Type';
            OptionCaption = 'Inward,Outward';
            OptionMembers = Inward,Outward;
        }
        field(4; "Gate Entry No."; Code[20])
        {
            Caption = 'Gate Entry No.';
            // TableRelation = Table16555.Field2 WHERE(Field1 = FIELD("Entry Type"));
        }
        field(5; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(7; "Warehouse Recpt. No."; Code[20])
        {
            Caption = 'Warehouse Recpt. No.';
        }
        field(8; "Purchase Invoice No."; Code[20])
        {
            Caption = 'Purchase Invoice No.';
        }
        field(9; "Sales Credit Memo No."; Code[20])
        {
            Caption = 'Sales Credit Memo No.';
        }
    }

    keys
    {
        key(Key1; "Source Type", "Source No.", "Entry Type", "Gate Entry No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

