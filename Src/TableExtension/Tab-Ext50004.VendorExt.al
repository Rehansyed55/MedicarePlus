tableextension 50004 "Vendor Ext" extends Vendor
{
    fields
    {
        field(50000; "EC Member"; Code[10])
        {
            Description = '//Upgradation Nav13';
        }
        field(50001; Address3; Text[50])
        {
            Description = '//Upgradation Nav13';
        }
        field(50002; "Mobile No."; Text[20])
        {
            Description = '//Upgradation Nav13';
        }
        field(50003; "Technical agreement"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('TA REFERENCE'));
        }
        field(50004; "WDL No"; Code[30])
        {
            DataClassification = ToBeClassified;
            Description = 'CAS-04125-V3M1R5';
        }
        field(50008; "WDA Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "CD Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "CD No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
         field(50100; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,Released;
        }
    }
}
