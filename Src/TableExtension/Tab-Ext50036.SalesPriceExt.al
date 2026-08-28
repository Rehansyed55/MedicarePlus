tableextension 50036 "Sales Price Ext" extends "Sales Price"
{
    fields
    {
        modify("Sales Code")
        {
            trigger OnAfterValidate()
            var
            begin
                case "Sales Type" of
                    "Sales Type"::"Customer Price Group":
                        begin
                            CustPriceGr.Get("Sales Code");
                            Competitor := CustPriceGr.Competitor; //Chem-280
                        end;
                end;
            end;
        }
        field(50000; Competitor; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Chem-280';
        }
        field(50001; Description; Text[100])
        {
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("Item No.")));
            FieldClass = FlowField;
        }


    }

    var
        CustPriceGr: Record "Customer Price Group";
}
