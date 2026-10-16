//Skipped the code where the condition is for chemilines since chemilines is in a different database now.

tableextension 50009 "Sales Line Ext" extends "Sales Line"
{
    fields
    {
        modify(Quantity)
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                //Upgradation for Nav13
                IF "Sales Original Qty" = 0 THEN BEGIN
                    "Sales Original Qty" := Quantity;
                END;
            end;
        }

        field(50000; "Sales Original Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = '//Upgradation for Nav13';
        }
        field(50001; "Batch Qty"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = - Sum("Reservation Entry".Quantity WHERE("Item No." = FIELD("No."),
                                                                   "Location Code" = FIELD("Location Code"),
                                                                   "Source ID" = FIELD("Document No."),
                                                                   "Source Ref. No." = FIELD("Line No."),
                                                                   "Source Type" = CONST(37),
                                                                   "Source Subtype" = CONST(1)));
            Description = '//Added by anikEt';
        }


    }


    trigger OnInsert()
    begin
        // PS18964
        // SalesSetup.GET;
        // GLSetup.GET;
        // IF GLSetup."Threshold applies" AND (CurrFieldNo = 0) AND ("Document Type" = "Document Type"::"Credit Memo") AND
        // (Type = Type::Item) AND rec."VAT Calculation Type"::"Reverse Charge VAT" AND
        // //    (Type = Type::Item) AND "Reverse Charge Item" AND
        //    ("VAT Bus. Posting Group" = SalesSetup."Domestic Customers")
        // THEN
        //     MESSAGE(Text1041000, "VAT Bus. Posting Group", FIELDCAPTION("VAT Bus. Posting Group"));
    end;

    trigger OnModify()
    begin
        // PS18964
        // SalesSetup.GET;
        // GLSetup.GET;
        // IF GLSetup."Threshold applies" AND (CurrFieldNo = 0) AND ("Document Type" = "Document Type"::"Credit Memo") AND
        // (Type = Type::Item) AND rec."VAT Calculation Type"::"Reverse Charge VAT" AND ("No." <> xRec."No.") AND
        // //    (Type = Type::Item) AND "Reverse Charge Item" AND ("No." <> xRec."No.") AND
        //    ("VAT Bus. Posting Group" = SalesSetup."Domestic Customers")
        // THEN
        //     MESSAGE(Text1041000, "VAT Bus. Posting Group", FIELDCAPTION("VAT Bus. Posting Group"));
    end;

    var
        GLSetup: Record "General Ledger Setup";
        Salesprice: Record "Sales Price";
        SalesSetup: record "Sales & Receivables Setup";
        Text1041000: Label 'Warning: You have selected an item that is subject to Reverse Charge VAT. Please check that the VAT Code %1 in the %2 field is correct. If necessary, update this field before posting the credit memo. ';
}
