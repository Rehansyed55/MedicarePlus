tableextension 50038 "Warehouse Employee Ext" extends "Warehouse Employee"
{
    fields
    {
        field(50001; "Assign To Pick"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Upgrade frm Nav5';
        }
        field(50002; "No of picks Assigned"; Integer)
        {
            CalcFormula = Count("Warehouse Activity Header" WHERE("Assigned User ID" = FIELD("User ID"),
                                                                   "No. of Lines" = FILTER(> 0),
                                                                   "Location Code" = FIELD("Location Code"),
                                                                   "Pick Confirmed" = CONST(false),
                                                                   Type = CONST("Warehouse Activity Type"::"Invt. Pick")));
            Description = 'Upgrade frm Nav5';
            FieldClass = FlowField;
        }
        field(50003; "Assign To Put away"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Upgrade frm Nav5';
        }
        field(50004; "No of putaway Assigned"; Integer)
        {
            CalcFormula = Count("Warehouse Activity Header" WHERE("Assigned User ID" = FIELD("User ID"),
                                                                   "No. of Lines" = FILTER(> 0),
                                                                   "Location Code" = FIELD("Location Code"),
                                                                   Type = CONST("Warehouse Activity Type"::"Put-away")));
            Description = 'Upgrade frm Nav5';
            FieldClass = FlowField;
        }
        field(50005; "Pick and Putaway User"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Upgrade frm Nav5';
        }
    }
}
