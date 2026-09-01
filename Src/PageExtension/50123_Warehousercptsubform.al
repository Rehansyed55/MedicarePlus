pageextension 50123 "Whse. Receipt Subform EXT" extends "Whse. Receipt Subform"
{
    layout
    {
        addafter(Quantity)
        {
            field("Create Production Order"; Rec."Create Production Order")
            {
                ApplicationArea = all;
            }
            field(Checked; Rec.Checked)
            {
                ApplicationArea = all;
                trigger OnValidate()
                var
                    myInt: Integer;
                begin
                    /////PARAG/////
                    IF rec.Checked = TRUE THEN
                        CheckedEdit := FALSE
                    ELSE
                        CheckedEdit := TRUE;
                    /////PARAG/////

                    ////avinash//////
                    IF rec.Checked = TRUE THEN
                        rec."Checked By" := USERID
                    ELSE
                        rec."Checked By" := '';
                    ///////avinash//////
                    // code commented as per user request(Chem-23)
                    // code uncommented as per user request(Chem-328)
                end;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    trigger OnAfterGetRecord()
    var
        WarehouseReceiptHeader: Record "Warehouse Receipt Header";
    begin
        // for insert value in Create Production Order feild
        warehousereceiptheader.GET(Rec."No.");
        IF warehousereceiptheader.GET(Rec."No.") THEN BEGIN
            IF (warehousereceiptheader."Select All" = TRUE) AND (Rec."Create Production Order" = FALSE) THEN
                Rec."Create Production Order" := TRUE
            ELSE IF (warehousereceiptheader."Select All" = TRUE) AND (Rec."Create Production Order" = TRUE) THEN
                Rec."Create Production Order" := TRUE
            ELSE IF (warehousereceiptheader."Select All" = FALSE) AND (Rec."Create Production Order" = TRUE) THEN
                Rec."Create Production Order" := TRUE
            ELSE IF (warehousereceiptheader."Select All" = FALSE) AND (Rec."Create Production Order" = FALSE) THEN
                Rec."Create Production Order" := FALSE
        END;

        /////PARAG/////
        IF Rec.Checked = TRUE THEN
            CheckedEdit := FALSE
        ELSE
            CheckedEdit := TRUE;
        /////PARAG/////
    end;

    var
        CheckedEdit: Boolean;
}
