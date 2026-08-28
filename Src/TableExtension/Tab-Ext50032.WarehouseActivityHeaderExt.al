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
    }
}
