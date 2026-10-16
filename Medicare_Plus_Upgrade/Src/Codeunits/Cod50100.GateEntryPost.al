codeunit 50104 "Gate Entry-Post"
{
    // AL conversion of C/AL Codeunit 50000 "Gate Entry-Post"
    // Version List = NAVIN5.00.01

    TableNo = "Gate Entry Header 1";

    trigger OnRun()
    var
        ModifyHeader: Boolean;
    begin
        GateEntryHeader := Rec;

        GateEntryHeader.TESTFIELD("Posting Date");
        GateEntryHeader.TESTFIELD("Document Date");

        GateEntryLine.RESET();
        GateEntryLine.SETRANGE("Entry Type", GateEntryHeader."Entry Type");
        GateEntryLine.SETRANGE("Gate Entry No.", GateEntryHeader."No.");
        IF NOT GateEntryLine.FINDFIRST() THEN
            ERROR(Text16500);

        // If Source Type is set → Source No. is mandatory
        // If Source Type is blank → Description is mandatory
        IF GateEntryLine.FINDSET() THEN
            REPEAT
                IF GateEntryLine."Doc. Source Type" <> GateEntryLine."Doc. Source Type"::" " THEN
                    GateEntryLine.TESTFIELD("Doc. Source No.");
                IF GateEntryLine."Doc. Source Type" = GateEntryLine."Doc. Source Type"::" " THEN
                    GateEntryLine.TESTFIELD(Description);
            UNTIL GateEntryLine.NEXT() = 0;

        IF GUIALLOWED THEN BEGIN
            Window.OPEN(
                '#1###########################\\' +
                Text16501);
            Window.UPDATE(1, STRSUBSTNO('%1 %2', Text16502, GateEntryHeader."No."));
        END;

        IF GateEntryHeader."Posting No. Series" = '' THEN BEGIN
            GateEntryLocSetup.GET(GateEntryHeader."Entry Type", GateEntryHeader."Location Code");
            GateEntryHeader."Posting No. Series" := GateEntryLocSetup."Posting No. Series";
            GateEntryHeader.MODIFY();
            COMMIT();
        END;

        // Get next Posting No. from No. Series 
        IF GateEntryHeader."Posting No." = '' THEN BEGIN
            GateEntryHeader."Posting No." :=
                NoSeriesMgt.GetNextNo(
                    GateEntryHeader."Posting No. Series",
                    GateEntryHeader."Posting Date",
                    TRUE);
            ModifyHeader := TRUE;
        END;
        IF ModifyHeader THEN BEGIN
            GateEntryHeader.MODIFY();
            COMMIT();
        END;

        //Lock lines before writing
        GateEntryLine.LOCKTABLE();

        // 
        PostedGateEntryHeader.INIT();
        PostedGateEntryHeader.TRANSFERFIELDS(GateEntryHeader);
        PostedGateEntryHeader."No." := GateEntryHeader."Posting No.";
        PostedGateEntryHeader."No. Series" := GateEntryHeader."Posting No. Series";
        PostedGateEntryHeader."Gate Entry No." := GateEntryHeader."No.";
        // "Bin Code" (Gate Entry Header 1 field 21) and "Zone" (Posted Gate Entry Header 1 field 21)
        // share the same field number, so TRANSFERFIELDS copies Bin Code's value into Zone by mistake.
        // Gate Entry Header 1 has no Zone field, so Zone has no real source value here.
        PostedGateEntryHeader.Zone := '';
        PostedGateEntryHeader."Bin Code" := GateEntryHeader."Bin Code";

        IF GUIALLOWED THEN
            Window.UPDATE(1, STRSUBSTNO(Text16503, GateEntryHeader."No.", PostedGateEntryHeader."No."));

        PostedGateEntryHeader.INSERT();


        CopyCommentLines(
            GateEntryHeader."Entry Type",
            GateEntryHeader."Entry Type",
            GateEntryHeader."No.",
            PostedGateEntryHeader."No.");

        GateEntryLine.RESET();
        GateEntryLine.SETRANGE("Entry Type", GateEntryHeader."Entry Type");
        GateEntryLine.SETRANGE("Gate Entry No.", GateEntryHeader."No.");
        LineCount := 0;
        IF GateEntryLine.FINDSET() THEN
            REPEAT
                LineCount += 1;
                IF GUIALLOWED THEN
                    Window.UPDATE(2, LineCount);

                PostedGateEntryLine.INIT();
                PostedGateEntryLine.TRANSFERFIELDS(GateEntryLine);
                PostedGateEntryLine."Entry Type" := PostedGateEntryHeader."Entry Type";
                PostedGateEntryLine."Gate Entry No." := PostedGateEntryHeader."No.";
                PostedGateEntryLine.INSERT();
            UNTIL GateEntryLine.NEXT() = 0;

        // ── Delete source records ─────────────────────────────────────────────
        // Header deleted first — its OnDelete trigger removes comment lines
        // Lines deleted after
        GateEntryHeader.DELETE();
        GateEntryLine.RESET();
        GateEntryLine.SETRANGE("Entry Type", GateEntryHeader."Entry Type");
        GateEntryLine.SETRANGE("Gate Entry No.", GateEntryHeader."No.");
        GateEntryLine.DELETEALL();

        IF GUIALLOWED THEN
            Window.CLOSE();

        Rec := GateEntryHeader;
    end;

    procedure CopyCommentLines(
        FromEntryType: Integer;
        ToEntryType: Integer;
        FromNumber: Code[20];
        ToNumber: Code[20])
    begin
        GateEntryCommentLine.SETRANGE("Gate Entry Type", FromEntryType);
        GateEntryCommentLine.SETRANGE("No.", FromNumber);
        IF GateEntryCommentLine.FINDSET() THEN
            REPEAT
                GateEntryCommentLine2 := GateEntryCommentLine;
                GateEntryCommentLine2."Gate Entry Type" := ToEntryType;
                GateEntryCommentLine2."No." := ToNumber;
                GateEntryCommentLine2.INSERT();
            UNTIL GateEntryCommentLine.NEXT() = 0;
    end;


    var
        GateEntryHeader: Record "Gate Entry Header 1";
        GateEntryLine: Record "Gate Entry Line 1";
        PostedGateEntryHeader: Record "Posted Gate Entry Header 1";
        PostedGateEntryLine: Record "Posted Gate Entry Line 1";
        GateEntryLocSetup: Record "Gate Entry Location Setup 1";
        GateEntryCommentLine: Record "Gate Entry Comment Line1";
        GateEntryCommentLine2: Record "Gate Entry Comment Line1";
        NoSeriesMgt: Codeunit "No. Series";
        Window: Dialog;
        LineCount: Integer;
        Text16500: Label 'There is nothing to post.';
        Text16501: Label 'Posting Lines     #2######\';
        Text16502: Label 'Gate Entry.';
        Text16503: Label 'Gate Entry %1 -> Posted Gate Entry %2.';
}
