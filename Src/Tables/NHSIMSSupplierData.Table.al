table 50022 "NHS-IMS-Supplier Data"
{
    // DrillDownPageID = 50092;
    // LookupPageID = 50092;

    fields
    {
        field(1; "PI No"; Code[30])
        {
        }
        field(2; "ECMA No"; Code[30])
        {
        }
        field(3; "Item No"; Code[30])
        {
        }
        field(4; "NHS Rank"; Code[30])
        {
        }
        field(5; "NHS Pack Sales"; Text[50])
        {
            Description = 'use data type as text bcause they will enter text as well in this column';
        }
        field(6; "NHS Generic"; Text[50])
        {
            Description = 'use data type as text bcause they will enter text as well in this column';
        }
        field(7; "OTC Spot Buy Sales"; Decimal)
        {
        }
        field(8; "OTC Spot Buy Sales Avg."; Decimal)
        {
        }
        field(9; "IMS Rank"; Code[30])
        {
        }
        field(10; "IMS Value"; Decimal)
        {
        }
        field(11; "IMS Units"; Text[50])
        {
            Description = 'use data type as text bcause they will enter text as well in this column';
        }
        field(12; "IMS Brand for Brand"; Text[50])
        {
            Description = 'use data type as text bcause they will enter text as well in this column';
        }
        field(13; "IMS Brand for Generic"; Text[50])
        {
            Description = 'use data type as text bcause they will enter text as well in this column';
        }
        field(14; "IMS Generic"; Text[50])
        {
            Description = 'use data type as text bcause they will enter text as well in this column';
        }
        field(15; "% Sales- Brand Prescrition"; Decimal)
        {
        }
        field(16; "Patient Staus"; Option)
        {
            OptionCaption = ' ,Off-Patent,Patented';
            OptionMembers = " ","Off-Patent",Patented;
        }
        field(17; "Patient Expiry"; Date)
        {
            Description = 'use data type as text bcause they will enter text as well in this column along with date';
        }
        field(18; "SPC Expiry"; Date)
        {
            Description = 'use data type as text bcause they will enter text as well in this column along with date';
        }
        field(19; "Last Modified Date"; Date)
        {
        }
        field(20; "Last Modified Time"; Time)
        {
        }
        field(21; "Created Date"; Date)
        {
        }
        field(22; "Created Time"; Time)
        {
        }
        field(23; "Total Production Qty 24 Month"; Decimal)
        {
            CalcFormula = Sum("Production Order".Quantity WHERE(Status = CONST("Finished"),
                                                                 "Source No." = FIELD("Item No"),
                                                                 "PLPI No." = FIELD("PI No"),
                                                                "Starting Date" = FIELD("Date Filter")));
            FieldClass = FlowField;
        }
        field(24; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(31; "EU Cost In Pound"; Decimal)
        {
        }
        field(32; "Percent of trade"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Item No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Created Date" := WORKDATE;
        "Created Time" := TIME;
    end;

    trigger OnModify()
    begin
        "Last Modified Date" := WORKDATE;
        "Last Modified Time" := TIME;
    end;
}

