codeunit 50103 "Gate Entry-Post (Yes/No)"
{
    // version NAVIN5.00.01

    TableNo = 50000;

    trigger OnRun()
    begin
        IF rec."Carrier/Courier" = '' THEN
            rec.TESTFIELD("Carrier/Courier");
        //IF "Supplier Code"='' THEN
        //TESTFIELD("Supplier Code");
        PackingDetail.RESET;
        PackingDetail.SETRANGE(PackingDetail."Document Type", PackingDetail."Document Type"::GateEntryIn);
        PackingDetail.SETRANGE(PackingDetail."Document No.", rec."No.");
        IF PackingDetail.FINDFIRST THEN BEGIN
            REPEAT
                IF PackingDetail."Carrier Weight" = 0 THEN
                    PackingDetail.TESTFIELD(PackingDetail."Carrier Weight");
            UNTIL PackingDetail.NEXT = 0;
        END ELSE BEGIN
            ERROR(Text001, rec."No.");
        END;

        GateEntryHeader.COPY(Rec);
        Code;
        Rec := GateEntryHeader;
        MESSAGE(Text16501);
        PoGEnHeader.RESET;
        PoGEnHeader.SETRANGE(PoGEnHeader."Gate Entry No.", GateEntryHeader."No.");
        IF PoGEnHeader.FINDLAST THEN
            REPORT.RUN(REPORT::"Goods Inward Note", FALSE, FALSE, PoGEnHeader); //Reports Need to Create
    end;

    var
        Text16500: Label 'Do you want to Post the Gate Entry?';
        GateEntryHeader: Record "Gate Entry Header 1";
        GateEntryPost: Codeunit 50104;
        Text16501: Label 'Gate Entry Posted successfully.';
        PoGEnHeader: Record 50003;
        PackingDetail: Record 50013;
        Text001: Label 'You must specify Carrier Weight for  Gate Entry No. %1';

    local procedure "Code"()
    begin
        IF NOT CONFIRM(Text16500, FALSE) THEN
            EXIT;
        GateEntryPost.RUN(GateEntryHeader);
        COMMIT;
        //MESSAGE(Text16501);
    end;
}

