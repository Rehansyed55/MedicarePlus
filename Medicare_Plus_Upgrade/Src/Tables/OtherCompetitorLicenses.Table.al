table 50027 "Other Competitor Licenses"
{

    fields
    {
        field(1; "PLPI No"; Code[30])
        {
        }
        field(2; "Grant Date"; Text[30])
        {
            Description = 'make data type text beacuse user going to import some other text as well with date';
        }
        field(3; "Licence Holder"; Text[250])
        {

            trigger OnValidate()
            begin
                // recCustomerPriceGroup.RESET;
                // IF recCustomerPriceGroup.GET("Licence Holder") THEN;
                // "Licensed Name(s)" := recCustomerPriceGroup.Description;
            end;
        }
        field(4; "Licensed Name(s)"; Text[250])
        {
        }
        field(5; "Active Ingredient"; Text[250])
        {
        }
        field(6; "EU Name"; Text[250])
        {
        }
        field(7; Country; Code[100])
        {
        }
        field(8; ECMA; Code[100])
        {
        }
        field(9; "Chem.Lic.Oth.Country"; Code[250])
        {
        }
        field(10; "NHS Ranked"; Code[30])
        {
        }
        field(11; "NHS Pack Sales"; Text[250])
        {
        }
        field(12; "NHS Generic Sales"; Text[250])
        {
        }
        field(13; "Item No"; Code[30])
        {
            TableRelation = Item."No.";
        }
        field(14; "License Holder Code"; Code[100])
        {
        }
        field(15; "No Of Licenses"; Integer)
        {
            CalcFormula = Count("Product License" WHERE("Stock Code" = FIELD("Item No")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "PLPI No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        recCustomerPriceGroup: Record 6;
        recProdLic: Record 50008;
}

