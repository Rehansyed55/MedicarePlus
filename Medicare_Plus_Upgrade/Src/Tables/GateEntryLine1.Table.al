table 50001 "Gate Entry Line 1"
{
    Caption = 'Gate Entry Line';

    fields
    {
        field(1; "Entry Type"; Option)
        {
            Caption = 'Entry Type';
            OptionCaption = 'Inward,Outward';
            OptionMembers = Inward,Outward;
        }
        field(2; "Gate Entry No."; Code[20])
        {
            Caption = 'Gate Entry No.';
            TableRelation = "Gate Entry Header 1"."No." WHERE("Entry Type" = FIELD("Entry Type"));
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(4; "Doc. Source Type"; Option)
        {
            Caption = 'Source Type';
            OptionCaption = ' ,Sales Shipment,Sales Return Order,Purchase Order,Purchase Return Shipment,Transfer Receipt,Transfer Shipment';
            OptionMembers = " ","Sales Shipment","Sales Return Order","Purchase Order","Purchase Return Shipment","Transfer Receipt","Transfer Shipment";

            trigger OnValidate()
            begin
                IF "Doc. Source Type" <> xRec."Doc. Source Type" THEN BEGIN
                    "Doc. Source No." := '';
                    "Source Name" := '';
                END;
            end;
        }
        field(5; "Doc. Source No."; Code[20])
        {
            Caption = 'Source No.';

            trigger OnLookup()
            begin

                GateEntryHeader.GET("Entry Type", "Gate Entry No.");
                CASE "Doc. Source Type" OF
                    "Doc. Source Type"::"Sales Shipment":
                        BEGIN
                            SalesShipHeader.RESET;
                            SalesShipHeader.FILTERGROUP(2);
                            SalesShipHeader.SETRANGE("Location Code", GateEntryHeader."Location Code");
                            SalesShipHeader.FILTERGROUP(0);
                            IF PAGE.RUNMODAL(0, SalesShipHeader) = ACTION::LookupOK THEN
                                VALIDATE("Doc. Source No.", SalesShipHeader."No.");
                        END;
                    "Doc. Source Type"::"Sales Return Order":
                        BEGIN
                            SalesHeader.RESET;
                            SalesHeader.FILTERGROUP(2);
                            SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::"Return Order");
                            SalesHeader.SETRANGE("Location Code", GateEntryHeader."Location Code");
                            SalesHeader.FILTERGROUP(0);
                            IF PAGE.RUNMODAL(0, SalesHeader) = ACTION::LookupOK THEN
                                VALIDATE("Doc. Source No.", SalesHeader."No.");
                        END;
                    "Doc. Source Type"::"Purchase Order":
                        BEGIN
                            PurchHeader.RESET;
                            PurchHeader.FILTERGROUP(2);
                            PurchHeader.SETRANGE("Document Type", PurchHeader."Document Type"::Order);
                            PurchHeader.SETRANGE("Location Code", GateEntryHeader."Location Code");
                            PurchHeader.FILTERGROUP(0);
                            IF PAGE.RUNMODAL(0, PurchHeader) = ACTION::LookupOK THEN
                                VALIDATE("Doc. Source No.", PurchHeader."No.");
                        END;
                    "Doc. Source Type"::"Purchase Return Shipment":
                        BEGIN
                            ReturnShipHeader.RESET;
                            ReturnShipHeader.FILTERGROUP(2);
                            ReturnShipHeader.SETRANGE("Location Code", GateEntryHeader."Location Code");
                            ReturnShipHeader.FILTERGROUP(0);
                            IF PAGE.RUNMODAL(0, ReturnShipHeader) = ACTION::LookupOK THEN
                                VALIDATE("Doc. Source No.", ReturnShipHeader."No.");
                        END;
                    "Doc. Source Type"::"Transfer Receipt":
                        BEGIN
                            TransHeader.RESET;
                            TransHeader.FILTERGROUP(2);
                            TransHeader.SETRANGE("Transfer-to Code", GateEntryHeader."Location Code");
                            TransHeader.FILTERGROUP(0);
                            IF PAGE.RUNMODAL(0, TransHeader) = ACTION::LookupOK THEN
                                VALIDATE("Doc. Source No.", TransHeader."No.");
                        END;
                    "Doc. Source Type"::"Transfer Shipment":
                        BEGIN
                            TransShptHeader.RESET;
                            TransShptHeader.FILTERGROUP(2);
                            TransShptHeader.SETRANGE("Transfer-from Code", GateEntryHeader."Location Code");
                            TransShptHeader.FILTERGROUP(0);
                            IF PAGE.RUNMODAL(0, TransShptHeader) = ACTION::LookupOK THEN
                                VALIDATE("Doc. Source No.", TransShptHeader."No.");
                        END
                END;
            end;

            trigger OnValidate()
            begin

                IF "Doc. Source Type" = "Doc. Source Type"::" " THEN
                    ERROR(Text16500, FIELDCAPTION("Line No."), "Line No.");

                IF "Doc. Source No." <> xRec."Doc. Source No." THEN
                    "Source Name" := '';
                IF "Doc. Source No." = '' THEN BEGIN
                    "Source Name" := '';
                    EXIT;
                END;
                CASE "Doc. Source Type" OF
                    "Doc. Source Type"::"Sales Shipment":
                        BEGIN
                            SalesShipHeader.GET("Doc. Source No.");
                            "Source Name" := SalesShipHeader."Bill-to Name";
                        END;
                    "Doc. Source Type"::"Sales Return Order":
                        BEGIN
                            SalesHeader.GET(SalesHeader."Document Type"::"Return Order", "Doc. Source No.");
                            "Source Name" := SalesHeader."Bill-to Name";
                        END;
                    "Doc. Source Type"::"Purchase Order":
                        BEGIN
                            PurchHeader.GET(PurchHeader."Document Type"::Order, "Doc. Source No.");
                            //kd - after upgrading 09/12/2019 ++
                            IF PurchHeader.Status <> PurchHeader.Status::Released THEN
                                ERROR('P.O. No. %1 not released', PurchHeader."No.")
                            ELSE
                                //kd - after upgrading 09/12/2019 --
                                "Source Name" := PurchHeader."Pay-to Name";
                        END;
                    "Doc. Source Type"::"Purchase Return Shipment":
                        BEGIN
                            ReturnShipHeader.GET("Doc. Source No.");
                            "Source Name" := ReturnShipHeader."Pay-to Name";
                        END;
                    "Doc. Source Type"::"Transfer Receipt":
                        BEGIN
                            TransHeader.GET("Doc. Source No.");
                            "Source Name" := TransHeader."Transfer-from Name";
                        END;
                    "Doc. Source Type"::"Transfer Shipment":
                        BEGIN
                            TransShptHeader.GET("Doc. Source No.");
                            "Source Name" := TransShptHeader."Transfer-to Name";
                        END
                END;
            end;
        }
        field(6; "Source Name"; Text[100])
        {
            Caption = 'Source Name';
            Editable = false;
        }
        field(7; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Open,Close';
            OptionMembers = Open,Close;
        }
        field(8; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(9; "Supplier Delivery Note"; Code[30])
        {
            Caption = 'Supplier Delivery Note';
        }
        field(10; "Supplier Delivery Date"; Date)
        {
            Caption = 'Supplier Delivery Date';
        }
    }

    keys
    {
        key(Key1; "Entry Type", "Gate Entry No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        PurchHeader: Record 38;
        SalesShipHeader: Record 110;
        TransHeader: Record 5740;
        SalesHeader: Record 36;
        ReturnShipHeader: Record 6650;
        TransShptHeader: Record 5744;
        GateEntryHeader: Record 50000;
        Text16500: Label 'Source Type must not be blank in %1 %2.';

    procedure ShowPackingDetails()
    var
        RecPackDetails: Record 50013;
        FromPackDetails: Page "Doc Wise Packing Details";
    begin
        TESTFIELD("Gate Entry No.");
        TESTFIELD("Line No.");
        RecPackDetails.SETRANGE(RecPackDetails."Document Type", RecPackDetails."Document Type"::GateEntryIn);
        RecPackDetails.SETRANGE("Document No.", "Gate Entry No.");
        RecPackDetails.SETRANGE("Line No./Item No.", FORMAT("Line No."));
        RecPackDetails.SETRANGE("Source no.", "Doc. Source No.");
        FromPackDetails.SETTABLEVIEW(RecPackDetails);
        FromPackDetails.RUNMODAL;
    end;
}

