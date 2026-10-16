tableextension 50032 "Warehouse Activity Header Ext" extends "Warehouse Activity Header"
{
    fields
    {
        field(50001; PrintReport; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Upgrade frm Nav5';
        }
        field(50002; "Invt. Pick Creation Time"; Time)
        {
            DataClassification = ToBeClassified;
            Description = 'Upgrade frm Nav5';
        }
        field(50003; "Pick Confirmed"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Upgrade frm Nav5';

            trigger OnValidate()
            begin
                /*
                WhseActivLine.RESET;
                WhseActivLine.SETRANGE(WhseActivLine."Activity Type", Type);
                WhseActivLine.SETRANGE(WhseActivLine."No.", "No.");
                IF WhseActivLine.FIND('-') THEN
                REPEAT
                  WhseActivLine.VALIDATE(WhseActivLine."Process Status", "Pick Confirmed");
                  WhseActivLine.VALIDATE(WhseActivLine.Checked, "Pick Confirmed");
                  WhseActivLine.MODIFY(TRUE);
                UNTIL WhseActivLine.NEXT = 0;
                */

            end;
        }
        field(50004; "For Sample"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Upgrade frm Nav5';
        }
        field(50005; Manully; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Upgrade frm Nav5';
        }
        field(50006; "Label Printed"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Upgrade frm Nav5';
        }
        field(50008; "Checking Status"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'Upgrade frm Nav5';
            OptionCaption = 'Not Started,In Process';
            OptionMembers = "Not Started","In Process";
        }
        field(50009; "Shipping Method"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Header"."Shipment Method Code" WHERE("No." = FIELD("Source No.")));
            Description = 'Upgrade frm Nav5';
        }
        field(50010; "Requested Delivery Date"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Header"."Requested Delivery Date" WHERE("No." = FIELD("Source No.")));
            Description = 'Upgrade frm Nav5';
        }
        field(50011; "Promised Delivery Date"; Date)
        {
            CalcFormula = Lookup("Sales Header"."Promised Delivery Date" WHERE("No." = FIELD("Source No.")));
            Description = 'Upgrade frm Nav5';
            FieldClass = FlowField;
        }

        field(50103; "Ship-to code"; code[10])
        {
            Caption = 'Ship to Code';
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
        field(50113; "Picked By User"; Code[50])
        {
            Caption = 'Picked By User';
            DataClassification = ToBeClassified;
        }
        field(50114; "Checked By"; Boolean)
        {
            Caption = 'Checked By';
            DataClassification = ToBeClassified;
        }
        field(50115; "Process Status"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Picked By';

        }
        field(50116; "Checked By User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
    }
}
