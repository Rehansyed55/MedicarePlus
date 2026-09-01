tableextension 50010 "Purchase Header Ext" extends "Purchase Header"
{
    fields
    {
        modify("Pay-to Vendor No.")
        {
            trigger OnAfterValidate()
            var
                LVendor: Record vendor;
            begin
                LVendor.RESET();
                LVendor.GET(Rec."Pay-to Vendor No.");
                Rec."Technical agreement" := LVendor."Technical agreement";
            end;
        }
        modify("Payment Terms Code")
        {
            trigger OnAfterValidate()
            begin
                //CF0001.begin
                UpdatePmtDiscDate;
                //CF0001.end
            end;
        }
        modify(Status)
        {
            trigger OnAfterValidate()
            var
                recPurchLine: Record "Purchase Line";
            begin
                recPurchLine.RESET;
                recPurchLine.SETRANGE(recPurchLine."Document Type", "Document Type");
                recPurchLine.SETRANGE(recPurchLine."Document No.", "No.");
                IF recPurchLine.FIND('-') THEN
                    REPEAT
                        //recPurchLine.VALIDATE(recPurchLine.Status, Status);
                        recPurchLine.MODIFY(TRUE);
                    UNTIL recPurchLine.NEXT = 0;
            end;
        }
        field(50000; "WhseRcptHeader No."; Code[20])
        {
            Description = '//Upgradation for Nav13';
        }
        field(50001; "Freight Company"; Text[100])
        {
            Description = '//Upgradation for Nav13';
        }
        field(50002; "Forwarder Name"; Text[30])
        {
            Description = '//Upgradation for Nav13';
        }
        field(50003; "Technical agreement"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Emailed On"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Emailed By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50100; "Technical Agreement No."; Code[50])
        {
            Caption = 'Technical Agreement No.';
            TableRelation = "Dimension Value".Code
                WHERE("Dimension Code" = CONST('TA REFERENCE'),
                      Blocked = CONST(false));
        }

    }
    keys
    {
        key(Key50000; "Buy-from Vendor No.", "No.")
        {
        }
    }

    trigger OnInsert()
    begin
        //For getting order date (Uncommented by Aditi)
        IF ("Order Date" = 0D) THEN
            "Order Date" := TODAY;
    end;

    procedure UpdatePmtDiscDate()
    begin
        //CF0001.begin
        // Updates the payment discount date to due date if discount % is zero
        IF "Payment Discount %" = 0 THEN
            //CF0002.begin
            // credit memo and return order behave different
            IF NOT ("Document Type" IN ["Document Type"::"Credit Memo", "Document Type"::"Return Order"]) THEN
                //CF0002.end
                "Pmt. Discount Date" := "Due Date";
        //CF0001.end
    end;
}
