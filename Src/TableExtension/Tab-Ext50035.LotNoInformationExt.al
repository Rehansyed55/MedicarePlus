tableextension 50035 "Lot No. Information Ext" extends "Lot No. Information"
{
    fields
    {
        modify("Certificate Number")
        {
            TableRelation = "Variant Product license line"."ECMA No." WHERE("Stock Code" = FIELD("Item No."),
                                                                             Status = FILTER(Certified),
                                                                             Blocked = CONST(false));
        }
        field(50000; "Source ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Changed in Upgradation Just for ECMA No. Validation';
        }
        field(50001; Remarks; Text[250])
        {
            DataClassification = ToBeClassified;
            Description = 'Changed in Upgradation';
        }
    }
}
