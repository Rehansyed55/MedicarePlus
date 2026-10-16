tableextension 50008 "Sales Header Ext" extends "Sales Header"
{
    fields
    {
        modify("Ship-to Code")
        {
            trigger OnAfterValidate()
            var
                ShipToAddr: Record "Ship-to Address";
            begin
                //Copy the same address as the Sell-to Customer No. Code
                //Upgradation
                IF ("Document Type" = "Document Type"::Order) AND
                  ("Ship-to Code" = '') THEN BEGIN
                    IF ShipToAddr.GET("Sell-to Customer No.", "Sell-to Customer No.") THEN BEGIN
                        "Ship-to Code" := ShipToAddr.Code;
                        "Ship-to Name" := ShipToAddr.Name;
                        "Ship-to Name 2" := ShipToAddr."Name 2";
                        "Ship-to Address" := ShipToAddr.Address;
                        "Ship-to Address 2" := ShipToAddr."Address 2";
                        "Ship-to City" := ShipToAddr.City;
                        "Ship-to Post Code" := ShipToAddr."Post Code";
                        "Ship-to County" := ShipToAddr.County;
                        VALIDATE("Ship-to Country/Region Code", ShipToAddr."Country/Region Code");
                        "Ship-to Contact" := ShipToAddr.Contact;
                        "Shipment Method Code" := ShipToAddr."Shipment Method Code";
                        "Tax Area Code" := ShipToAddr."Tax Area Code";
                        "Tax Liable" := ShipToAddr."Tax Liable";
                        IF ShipToAddr."Location Code" <> '' THEN
                            VALIDATE("Location Code", ShipToAddr."Location Code");
                        "Shipping Agent Code" := ShipToAddr."Shipping Agent Code";
                        "Shipping Agent Service Code" := ShipToAddr."Shipping Agent Service Code";
                    END;
                END;
                //Upgradation
            end;
        }

        modify("Payment Terms Code")
        {
            trigger OnAfterValidate()
            begin
                UpdatePmtDiscDate;
                //CF0001.end
            end;
        }
        modify("Payment Discount %")
        {
            trigger OnAfterValidate()
            begin
                UpdatePmtDiscDate;
                //CF0001.end
            end;
        }
        modify("Pmt. Discount Date")
        {
            trigger OnAfterValidate()
            begin
                UpdatePmtDiscDate;
                //CF0001.end
            end;
        }
        modify("Requested Delivery Date")
        {

            trigger OnAfterValidate()
            begin
                //..........................Vikash.........................//
                /*
                 IF COMPANYNAME='Medicareplus International' THEN
                   BEGIN
                     IF ("Document Type" IN["Document Type"::Order]) THEN
                     IF Rec."Requested Delivery Date"<>0D THEN
                       BEGIN
                         "Promised Delivery Date":=Rec."Requested Delivery Date";
                         IF "Promised Delivery Date"<>xRec."Promised Delivery Date" THEN
                         UpdateSalesLinesByFieldNo(FIELDNO("Promised Delivery Date"),CurrFieldNo <> 0);
                     END;
                   END;
                   */
                //..........................Vikash.........................//
            end;
        }
        field(50001; "Adv. No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = '//Upgradation Nav13';
        }
        field(50012; "Released By"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

    }
    trigger OnInsert()
    var
        myInt: Integer;
    begin
        "Assigned User ID" := USERID;//Robo upgrades
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
