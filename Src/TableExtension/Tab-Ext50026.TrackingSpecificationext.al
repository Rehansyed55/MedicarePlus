tableextension 50026 "Tracking Specification ext" extends "Tracking Specification"
{
    fields
    {
        modify("Lot No.")
        {
            trigger OnAfterValidate()
            begin
                IF ("Source Type" = 39) AND ("Source Subtype" = 1) THEN BEGIN
                    i := 0;
                    j := 0;
                    IF "Lot No." <> '' THEN BEGIN
                        ItemledgerEntry_Rec.RESET;
                        //ItemledgerEntry_Rec.SETRANGE(ItemledgerEntry_Rec."Entry Type",ItemledgerEntry_Rec."Entry Type"::Purchase);
                        ItemledgerEntry_Rec.SETRANGE(ItemledgerEntry_Rec."Item No.", "Item No.");
                        ItemledgerEntry_Rec.SETRANGE(ItemledgerEntry_Rec."Variant Code", "Variant Code");
                        ItemledgerEntry_Rec.SETRANGE(ItemledgerEntry_Rec."Location Code", "Location Code");
                        ItemledgerEntry_Rec.SETFILTER(ItemledgerEntry_Rec."Lot No.", FORMAT("Lot No." + '*'));
                        ItemledgerEntry_Rec.SETFILTER("Document Type", '<>%1', ItemledgerEntry_Rec."Document Type"::"Sales Return Receipt");
                        IF ItemledgerEntry_Rec.FINDSET THEN
                            REPEAT
                                IF COPYSTR(ItemledgerEntry_Rec."Lot No.", STRLEN(ItemledgerEntry_Rec."Lot No.") - 1, STRLEN(ItemledgerEntry_Rec."Lot No.")) <> '-P' THEN BEGIN
                                    //EVALUATE(i,COPYSTR(ItemledgerEntry_Rec."Lot No.",STRPOS(ItemledgerEntry_Rec."Lot No.",'/')+1,STRPOS(ItemledgerEntry_Rec."Lot No.",'/')+3));
                                    temptext := COPYSTR(ItemledgerEntry_Rec."Lot No.", STRLEN(ItemledgerEntry_Rec."Lot No.") - 1, STRLEN(ItemledgerEntry_Rec."Lot No."));
                                    //Message(COPYSTR(ItemledgerEntry_Rec."Lot No.",STRLEN(ItemledgerEntry_Rec."Lot No.")-1,STRLEN(ItemledgerEntry_Rec."Lot No.")));
                                    IF COPYSTR(ItemledgerEntry_Rec."Lot No.", STRLEN(ItemledgerEntry_Rec."Lot No."), STRLEN(ItemledgerEntry_Rec."Lot No.")) <> 'P' THEN BEGIN
                                        EVALUATE(i, COPYSTR(ItemledgerEntry_Rec."Lot No.", STRLEN(ItemledgerEntry_Rec."Lot No.") - 2, STRLEN(ItemledgerEntry_Rec."Lot No.")));
                                    END;
                                    IF i > j THEN
                                        j := i;
                                END;
                            UNTIL ItemledgerEntry_Rec.NEXT = 0;

                        RecResEntry.RESET;
                        RecResEntry.SETRANGE(RecResEntry."Item No.", "Item No.");
                        RecResEntry.SETRANGE(RecResEntry."Location Code", "Location Code");
                        RecResEntry.SETRANGE(RecResEntry."Variant Code", "Variant Code");
                        RecResEntry.SETFILTER(RecResEntry."Lot No.", FORMAT("Lot No." + '*'));
                        IF RecResEntry.FINDSET THEN
                            REPEAT
                                IF COPYSTR(RecResEntry."Lot No.", STRLEN(RecResEntry."Lot No.") - 1, STRLEN(RecResEntry."Lot No.")) <> '-P' THEN BEGIN
                                    temptext := COPYSTR(RecResEntry."Lot No.", STRLEN(RecResEntry."Lot No.") - 1, STRLEN(RecResEntry."Lot No."));
                                    IF COPYSTR(RecResEntry."Lot No.", STRLEN(RecResEntry."Lot No."), STRLEN(RecResEntry."Lot No.")) <> 'P' THEN BEGIN
                                        //EVALUATE(i,COPYSTR(RecResEntry."Lot No.",STRPOS(RecResEntry."Lot No.",'/')+1,STRPOS(RecResEntry."Lot No.",'/')+3));
                                        EVALUATE(i, COPYSTR(RecResEntry."Lot No.", STRLEN(RecResEntry."Lot No.") - 2, STRLEN(RecResEntry."Lot No.")));
                                    END;

                                    IF i > j THEN
                                        j := i;
                                END;

                            UNTIL RecResEntry.NEXT = 0;
                        IF j <= 9 THEN
                            "Lot No." := "Lot No." + '/00' + FORMAT(j + 1)
                        ELSE
                            "Lot No." := "Lot No." + '/0' + FORMAT(j + 1);




                    END;
                end;
            end;
        }
        field(50000; "ECMA No."; Code[100])
        {
            DataClassification = ToBeClassified;
            Description = '//Upgradation Nav13';
            TableRelation = "Variant Product license line"."ECMA No." WHERE("Stock Code" = FIELD("Item No."),
                                                                             Status = FILTER(Certified),
                                                                             Blocked = CONST(false));
            ValidateTableRelation = false;
        }
        field(50001; Remarks; Text[250])
        {
            DataClassification = ToBeClassified;
            Description = '//Upgradation Nav13';
        }
        field(50002; istrue; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = '//Upgradation Nav13';
        }
    }

    var
        i: Integer;
        j: Integer;
        ItemledgerEntry_Rec: Record 32;
        temptext: Text;
        RecResEntry: Record 337;
}
