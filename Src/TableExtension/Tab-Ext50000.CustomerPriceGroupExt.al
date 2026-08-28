tableextension 50000 "Customer Price Group Ext" extends "Customer Price Group"
{
    fields
    {
        field(50000; Competitor; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Chem-280';
        }
        field(50001; Web; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'B2B';
        }
    }
}
