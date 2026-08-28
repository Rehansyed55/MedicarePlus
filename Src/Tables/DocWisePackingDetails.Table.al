table 50013 "Doc Wise Packing Details"
{
    // DrillDownPageID = 50026;
    // LookupPageID = 50026;

    fields
    {
        field(1; "Document No."; Code[20])
        {
        }
        field(2; "Line No./Item No."; Code[20])
        {
        }
        field(3; UOM; Code[10])
        {
            TableRelation = "Unit of Measure".Code;
        }
        field(4; "No of.Units"; Integer)
        {
        }
        field(5; Remarks; Text[100])
        {
        }
        field(6; "Entry Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(7; "Source no."; Code[20])
        {
        }
        field(8; "Document Type"; Option)
        {
            OptionCaption = 'GateEntryIn,Purchase Order';
            OptionMembers = GateEntryIn,"Purchase Order";
        }
        field(9; "No Of.Pack"; Integer)
        {
        }
        field(11; "Carrier Weight"; Decimal)
        {
        }
        field(12; "Company Weight"; Decimal)
        {
        }
        field(13; "Attachment No."; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Document Type", "Document No.", "Line No./Item No.", "Entry Line No", "Source no.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Text000: Label 'You have canceled the create process.';
        Text001: Label 'Replace existing attachment?';
        Text002: Label 'You have canceled the import process.';

    procedure CreateAttachment()
    var
        Attachment: Record 5062;
        VariantLic: Record 50013;
        AttachmentManagement: Codeunit 5052;
        // WordManagement: Codeunit 5054;
        NewAttachNo: Integer;
    begin
        IF "Attachment No." <> 0 THEN BEGIN
            IF Attachment.GET("Attachment No.") THEN
                Attachment.TESTFIELD("Read Only", FALSE);
            IF NOT CONFIRM(Text001, FALSE) THEN
                EXIT;
        END;

        //IF AttachmentManagement.UseComServer('DOC',TRUE) THEN; // Coomented by Parag as in NAV 2013 Dont Have Function UseComServer in Codeunit AttachmentManagement

        // NewAttachNo := WordManagement.CreateWordAttachment(FORMAT("Document Type") + ' ' + "Document No." + ' ' + "Line No./Item No." +
        // ' ' + FORMAT("Entry Line No") + ' ' + ' ' +
        // "Source no.", 'ENG');
        IF NewAttachNo <> 0 THEN BEGIN
            IF "Attachment No." <> 0 THEN
                RemoveAttachment(FALSE);
            "Attachment No." := NewAttachNo;
            IF Rec.GET("Document Type", "Document No.", "Line No./Item No.", "Entry Line No", "Source no.") THEN
                Rec.MODIFY
            ELSE
                Rec.INSERT;
        END ELSE
            ERROR(Text000);
    end;

    procedure OpenAttachment()
    var
        Attachment: Record 5062;
    begin
        IF "Attachment No." = 0 THEN
            EXIT;
        Attachment.GET("Attachment No.");
        Attachment.OpenAttachment(FORMAT("Document Type") + ' ' + "Document No." + ' ' + "Line No./Item No." + ' ' + FORMAT("Entry Line No") + ' ' +
        "Source no.", FALSE, 'ENG');
    end;


    procedure CopyFromAttachment()
    var
        VariantLic: Record 50013;
        Attachment: Record 5062;
        AttachmentManagement: Codeunit 5052;
        NewAttachNo: Integer;
    begin
        IF Attachment.GET("Attachment No.") THEN
            Attachment.TESTFIELD("Read Only", FALSE);

        IF "Attachment No." <> 0 THEN BEGIN
            IF NOT CONFIRM(Text001, FALSE) THEN
                EXIT;
            RemoveAttachment(FALSE);
            "Attachment No." := 0;
            Rec.MODIFY;
            COMMIT;
        END;

        VariantLic.SETFILTER("Attachment No.", '<>%1', 0);
        IF PAGE.RUNMODAL(0, VariantLic) = ACTION::LookupOK THEN BEGIN
            // NewAttachNo := AttachmentManagement.InsertAttachment(VariantLic."Attachment No.");
            IF NewAttachNo <> 0 THEN BEGIN
                "Attachment No." := NewAttachNo;
                Rec.MODIFY;
            END;
        END;
    end;

    procedure ImportAttachment()
    var
        Attachment: Record 5062;
        AttachmentManagement: Codeunit 5052;
    begin
        IF "Attachment No." <> 0 THEN BEGIN
            IF Attachment.GET("Attachment No.") THEN
                Attachment.TESTFIELD("Read Only", FALSE);
            IF NOT CONFIRM(Text001, FALSE) THEN
                EXIT;
        END;

        /*IF Attachment.ImportAttachment('',FALSE,FALSE) THEN BEGIN
          "Attachment No." := Attachment."No.";
          Rec.MODIFY;
        END ELSE
          ERROR(Text002);*/

    end;

    procedure ExportAttachment()
    var
        Attachment: Record 5062;
        ExportToFile: Text[260];
    begin
        /*IF Attachment.GET("Attachment No.") THEN
          Attachment.ExportAttachment(ExportToFile);*/

    end;

    procedure RemoveAttachment(Prompt: Boolean)
    var
        Attachment: Record 5062;
    begin
        // IF Attachment.GET("Attachment No.") THEN
        //     IF Attachment.RemoveAttachment(Prompt) THEN BEGIN
        //         "Attachment No." := 0;
        //         Rec.MODIFY;
        //     END;
    end;
}

