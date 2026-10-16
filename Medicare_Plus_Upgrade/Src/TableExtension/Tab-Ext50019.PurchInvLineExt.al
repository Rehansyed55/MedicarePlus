tableextension 50019 "Purch. Inv. Line Ext" extends "Purch. Inv. Line"
{
    fields
    {
        field(50000; "PL No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = '//Upgradation Nav13';
            TableRelation = "Product License"."PL No.";
        }
        field(50001; "ECMA No."; Code[100])
        {
            DataClassification = ToBeClassified;
            Description = '//Upgradation Nav13';
            TableRelation = "Variant Product license line"."ECMA No." WHERE("PL No." = FIELD("PL No."),
                                                                             "Stock Code" = FIELD("No."),
                                                                             Status = FILTER('Certified'));
        }
        field(50002; "Rebox/Overlabel"; Option)
        {
            DataClassification = ToBeClassified;
            Description = '//Upgradation Nav13';
            OptionCaption = ' ,Rebox,Overlabel';
            OptionMembers = " ",Rebox,Overlabel;
        }

    }
}
