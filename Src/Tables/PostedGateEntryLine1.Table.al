table 50004 "Posted Gate Entry Line 1"
{
    Caption = 'Posted Gate Entry Line';
    // LookupPageID = 50003;

    fields
    {
        field(1; "Entry Type"; Option)
        {
            Caption = 'Entry Type';
            OptionCaption = 'Inward,Outward';
            OptionMembers = Inward,Outward;
        }
        field(2; "Gate Entry No."; Code[20])
        {
            Caption = 'Gate Entry No.';
            // TableRelation = Table16555.Field2 WHERE(Field1 = FIELD("Entry Type"));
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(4; "Doc. Source Type"; Option)
        {
            Caption = 'Source Type';
            OptionCaption = ' ,Sales Shipment,Sales Return Order,Purchase Order,Purchase Return Shipment,Transfer Receipt,Transfer Shipment';
            OptionMembers = " ","Sales Shipment","Sales Return Order","Purchase Order","Purchase Return Shipment","Transfer Receipt","Transfer Shipment";
        }
        field(5; "Doc. Source No."; Code[20])
        {
            Caption = 'Source No.';
        }
        field(6; "Source Name"; Text[100])
        {
            Caption = 'Source Name';
            Editable = false;
        }
        field(7; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Open,Close';
            OptionMembers = Open,Close;
        }
        field(8; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(9; "Supplier Delivery Note"; Code[30])
        {
            Caption = 'Supplier Delivery Note';
        }
        field(10; Date; Date)
        {
            Caption = 'Date';
        }
    }

    keys
    {
        key(Key1; "Entry Type", "Gate Entry No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Entry Type", "Doc. Source Type", "Doc. Source No.", Status)
        {
        }
    }

    fieldgroups
    {
    }

    var
        postedgateheader: Record 50003;

    procedure ShowPackingDetails()
    var
        RecPackDetails: Record 50013;
    // FromPackDetails: Page 50026;
    begin
        //alok
        // postedgateheader.GET("Entry Type", "Gate Entry No.");
        // TESTFIELD("Gate Entry No.");
        // TESTFIELD("Line No.");
        // RecPackDetails.SETRANGE(RecPackDetails."Document Type", RecPackDetails."Document Type"::GateEntryIn);
        // RecPackDetails.SETRANGE("Document No.", postedgateheader."Gate Entry No.");
        // RecPackDetails.SETRANGE("Line No./Item No.", FORMAT("Line No."));
        // RecPackDetails.SETRANGE("Source no.", "Doc. Source No.");
        // FromPackDetails.SETTABLEVIEW(RecPackDetails);
        // FromPackDetails.RUNMODAL;
    end;
}

