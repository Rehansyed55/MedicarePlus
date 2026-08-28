tableextension 50013 "User Setup Ext" extends "User Setup"
{
    fields
    {
        field(50000; "Allow Diff. Expiry Reclass"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'CHEM-285';
        }
        field(50001; "Allow on B2B"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'B2B';
        }
        field(50002; "Allow Invoice Posting"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Allow Lic. Qty."; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Allow Change Status"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
}
