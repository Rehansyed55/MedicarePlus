codeunit 50103 "Gate Entry-Post (Yes/No)"
{
    TableNo = "Gate Entry Header 1";

    trigger OnRun()
    begin
        IF rec."Carrier/Courier" = '' THEN
            Rec.TESTFIELD("Carrier/Courier");

        IF Rec."Entry Type" = Rec."Entry Type"::Outward THEN BEGIN
            PackingDetail.RESET();
            PackingDetail.SETRANGE("Document Type", PackingDetail."Document Type"::GateEntryIn);  // Fix: was GateEntryIn
            PackingDetail.SETRANGE("Document No.", Rec."No.");
            IF PackingDetail.FINDFIRST() THEN BEGIN
                REPEAT
                    IF PackingDetail."Carrier Weight" = 0 THEN
                        PackingDetail.TESTFIELD("Carrier Weight");
                UNTIL PackingDetail.NEXT() = 0;
            END ELSE BEGIN
                ERROR(Text001, Rec."No.");
            END;
        END;

        GateEntryHeader.COPY(Rec);
        Code();
        Rec := GateEntryHeader;
    end;

    local procedure Code()
    begin
        IF NOT CONFIRM(Text16500, FALSE) THEN
            EXIT;
        GateEntryPost.RUN(GateEntryHeader);
        COMMIT();
        MESSAGE(Text16501);
    end;

    var
        Text16500: Label 'Do you want to Post the Gate Entry?';
        Text16501: Label 'Gate Entry Posted successfully.';
        Text001: Label 'You must specify Carrier Weight for Gate Entry No. %1.';
        GateEntryHeader: Record "Gate Entry Header 1";
        GateEntryPost: Codeunit 50104;
        PackingDetail: Record "Doc Wise Packing Details";
}
