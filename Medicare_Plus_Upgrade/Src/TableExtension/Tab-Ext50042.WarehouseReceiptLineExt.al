tableextension 50042 "Warehouse Receipt Line Ext" extends "Warehouse Receipt Line"
{
    fields
    {
        field(50000; "Create Production Order"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Upgrade frm Nav5';

            trigger OnValidate()
            begin
                "Create Production Order" := FALSE;
            end;
        }
        field(50001; "Foreign Name"; Code[100])
        {
            DataClassification = ToBeClassified;
            Description = 'Upgrade frm Nav5';
        }
        field(50002; Checked; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Upgrade frm Nav5';

            trigger OnValidate()
            begin
                IF xRec.Checked = TRUE THEN BEGIN
                    Checked := TRUE;
                END;

                /*IF "Checked By"='' THEN
                VALIDATE("Checked By",USERID);
                 *///// code commented as per user request(Chem-23)

            end;
        }
        field(50003; "Checked By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Description = 'Upgrade frm Nav5';
        }
        field(50004; Subcontracting; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = '//kd - added field for subcontracting';
        }
    }
}
