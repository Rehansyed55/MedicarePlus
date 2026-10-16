tableextension 50048 PostedInvtPickHeader extends "Posted Invt. Pick Header"
{
    fields
    {
        field(50100; "Shipping Method"; Code[10])
        {
            DataClassification = ToBeClassified;
        }

        field(50101; "Requested Delivery Date"; Date)
        {
            DataClassification = ToBeClassified;

        }

        field(50102; "Promised Delivery Date"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(50103; "Ship-to code"; code[10])
        {
            DataClassification = ToBeClassified;

        }
        field(50104; "Print Packing List"; Boolean)
        {
            Caption = 'Print Packing List';
            DataClassification = CustomerContent;
        }
        field(50105; "Ship-to Name"; Text[100])
        {
            Caption = 'Ship-to Name';
        }
        field(50106; "Ship-to Address"; Text[100])
        {
            Caption = 'Address';
        }
        field(50107; "Ship-to Address 2"; Text[100])
        {
            Caption = 'Address 2';
        }
        field(50108; "Ship-to City"; Text[50])
        {
            Caption = 'City';
        }
        field(50109; "Ship-to Post Code"; Code[20])
        {
            Caption = 'Post Code';
        }
        field(50110; "Ship-to Country/Region Code"; Code[20])
        {
            Caption = 'Country/Region Code';
        }
        field(50111; "Shipping Agent Code"; Code[10])
        {
            Caption = 'Shipping Agent Code';
        }
        field(50112; "Shipping Agent Service Code"; Code[10])
        {
            Caption = 'Shipping Agent Service Code';
        }



    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
}