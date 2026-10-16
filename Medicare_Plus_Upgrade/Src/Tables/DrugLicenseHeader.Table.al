table 50035 "Drug License-Header"
{

    fields
    {
        field(1; "License No"; Text[100])
        {

            trigger OnValidate()
            begin
                RecLiceLine.RESET;
                RecLiceLine.SETRANGE("License No", xRec."License No");
                RecLiceLine.SETRANGE("Company Type", "Company Type");
                RecLiceLine.SETRANGE("Company No", "Company No");
                IF NOT RecLiceLine.ISEMPTY THEN
                    ERROR(Text003, TABLECAPTION);
            end;
        }
        field(2; "License Type"; Option)
        {
            OptionCaption = ' ,WHOLESALER,PHARMACY,DOCTOR,VET,DENTIST,OTHER';
            OptionMembers = " ",WHOLESALER,PHARMACY,DOCTOR,VET,DENTIST,OTHER;
        }
        field(3; "Company Type"; Option)
        {
            OptionCaption = ' ,Customer,Supplier';
            OptionMembers = " ",Customer,Supplier;

            trigger OnValidate()
            begin
                CheckStatus;
                // Manish 20/01/2015 ++
                CLEAR("Company No");


                PurchSetup.GET;
                SalesSetup.GET;
                IF "Company Type" = "Company Type"::Customer THEN
                    "License Notification Type" := SalesSetup."License Notification Type";

                IF "Company Type" = "Company Type"::Supplier THEN
                    "License Notification Type" := PurchSetup."License Notification Type";
            end;
        }
        field(4; "Company No"; Code[20])
        {
            TableRelation = IF ("Company Type" = CONST(Customer)) Customer."No."
            ELSE IF ("Company Type" = CONST(Supplier)) Vendor."No.";

            trigger OnValidate()
            var
                RecCust: Record 18;
                L_Vend: Record 23;
                Rec_shiptoadd: Record 222;
                Rec_ordadd: Record 224;
            begin
                CheckStatus;
                CASE "Company Type" OF
                    "Company Type"::Customer:
                        BEGIN
                            //To add CustName and Address ++
                            IF RecCust.GET(Rec."Company No") THEN BEGIN
                                Rec.Name := RecCust.Name;
                                Rec.Address := RecCust.Address;
                                "Post Code" := RecCust."Post Code"; // Manish 20/11/2015 ++
                                "Country/Region Code" := RecCust."Country/Region Code"; // Manish ++
                            END;
                            //To add CustName and Address --
                            //To add Shipto code ++
                            CLEAR(Rec."Ship-to Code");
                            Rec_shiptoadd.SETRANGE(Rec_shiptoadd."Customer No.", Rec."Company No");
                            IF Rec_shiptoadd.FINDFIRST THEN BEGIN
                                IF Rec_shiptoadd.COUNT = 1 THEN
                                    Rec.VALIDATE("Ship-to Code", Rec_shiptoadd.Code);
                            END;
                            //To add Shipto code --
                        END;

                    "Company Type"::Supplier:
                        BEGIN
                            //To add VendName and Address ++
                            IF L_Vend.GET(Rec."Company No") THEN BEGIN
                                Rec.Name := L_Vend.Name;
                                Rec.Address := L_Vend.Address;
                                "Post Code" := L_Vend."Post Code";
                                "Country/Region Code" := L_Vend."Country/Region Code";// Manish ++
                                "License Notification Type" := PurchSetup."License Notification Type"; // Manish ++ CAS-05452-Z2R2X7
                            END;
                            //To add VendName and Address --

                            //To add OrderAddress Code ++
                            CLEAR(Rec."Ship-to Code");
                            Rec_ordadd.SETRANGE(Rec_ordadd."Vendor No.", Rec."Company No");
                            IF Rec_ordadd.FINDFIRST THEN BEGIN
                                IF Rec_ordadd.COUNT = 1 THEN
                                    Rec.VALIDATE("Ship-to Code", Rec_ordadd.Code);
                            END;
                            //To add OrderAddress Code --

                        END;

                END;

                // Manish ++ If company No is Blank
                IF "Company No" = '' THEN BEGIN
                    Type := '';
                    "Grant Date" := 0D;
                    "Expiry Date" := 0D;
                    Name := '';
                    Address := '';
                    "Ship-to Code" := '';
                    "Post Code" := '';
                    "Country/Region Code" := '';
                END;
                // Manish -- If company No is Blank
            end;
        }
        field(5; "Grant Date"; Date)
        {

            trigger OnValidate()
            var
                L_DrugLicLine: Record 50036;
            begin
                CheckStatus;
                IF Rec."Grant Date" <> 0D THEN BEGIN
                    IF "Expiry Date" <> 0D THEN BEGIN
                        IF "Grant Date" > "Expiry Date" THEN
                            ERROR('Grant Date Should be less than Expiry date');
                    END;
                END;



                IF Rec."Grant Date" <> 0D THEN BEGIN
                    RecLiceHdr.RESET;
                    RecLiceHdr.SETRANGE(RecLiceHdr."License Type", Rec."License Type");
                    RecLiceHdr.SETRANGE(RecLiceHdr."Company Type", Rec."Company Type");
                    RecLiceHdr.SETRANGE(RecLiceHdr."Company No", Rec."Company No");
                    RecLiceHdr.SETRANGE(RecLiceHdr.Type, Type);
                    IF RecLiceHdr.FINDFIRST THEN BEGIN
                        IF (RecLiceHdr."Expiry Date" >= Rec."Grant Date") THEN BEGIN
                            L_DrugLicLine.SETRANGE("License No", "License No");
                            L_DrugLicLine.SETRANGE("Company Type", "Company Type");
                            L_DrugLicLine.SETRANGE("Company No", "Company No");
                            IF L_DrugLicLine.FINDSET THEN
                                L_DrugLicLine.DELETEALL;
                            ERROR('Your earlier license has not yet expired, Please check!!');
                        END;
                    END;
                END;
            end;
        }
        field(6; "Expiry Date"; Date)
        {

            trigger OnValidate()
            begin
                CheckStatus;
                IF Rec."Expiry Date" <> 0D THEN BEGIN
                    IF Rec."Grant Date" > Rec."Expiry Date" THEN
                        ERROR('Expiry Date should be greater than Grant date');
                END;
            end;
        }
        field(7; Name; Code[50])
        {
            Editable = false;
        }
        field(8; Address; Code[50])
        {
            Editable = false;
        }
        field(9; Remark; Text[250])
        {

            trigger OnValidate()
            begin
                CheckStatus;
            end;
        }
        field(10; "Ship-to Code"; Code[20])
        {
            TableRelation = IF ("Company Type" = FILTER(Customer)) "Ship-to Address".Code WHERE("Customer No." = FIELD("Company No"))
            ELSE IF ("Company Type" = FILTER(Supplier)) "Order Address".Code WHERE("Vendor No." = FIELD("Company No"));

            trigger OnValidate()
            begin
                CheckStatus;
                // Manish 20/01/2016 ++
                //CLEAR("Post Code");
                IF "Company Type" = "Company Type"::Supplier THEN BEGIN
                    Rec_OrderAddress.RESET;
                    Rec_OrderAddress.SETRANGE(Rec_OrderAddress."Vendor No.", "Company No");
                    Rec_OrderAddress.SETRANGE(Rec_OrderAddress.Code, "Ship-to Code");
                    IF Rec_OrderAddress.FINDFIRST THEN BEGIN
                        "Post Code" := Rec_OrderAddress."Post Code";
                        "Country/Region Code" := Rec_OrderAddress."Country/Region Code";
                    END
                    ELSE BEGIN
                        IF Recsupplier.GET("Company No") THEN
                            "Post Code" := Recsupplier."Post Code";
                        "Country/Region Code" := Recsupplier."Country/Region Code";
                    END;

                END;

                IF "Company Type" = "Company Type"::Customer THEN BEGIN
                    RecShiptoAddress.RESET;
                    RecShiptoAddress.SETRANGE(RecShiptoAddress."Customer No.", "Company No");
                    RecShiptoAddress.SETRANGE(RecShiptoAddress.Code, "Ship-to Code");
                    IF RecShiptoAddress.FINDFIRST THEN BEGIN
                        "Post Code" := RecShiptoAddress."Post Code";
                        "Country/Region Code" := RecShiptoAddress."Country/Region Code";
                    END
                    ELSE BEGIN
                        IF Customer2.GET("Company No") THEN
                            "Post Code" := Customer2."Post Code";
                        "Country/Region Code" := Customer2."Country/Region Code";
                    END;
                END;
                // Manish 20/01/2016--
            end;
        }
        field(11; Type; Code[20])
        {
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('COMPANY TYPE'));

            trigger OnValidate()
            begin
                LineNo := 10000;
                FirstDeletion := TRUE;
                //Reccustomer.RESET;
                IF "Company Type" = "Company Type"::Customer THEN BEGIN
                    //Reccustomer.GET("Company No");
                    //Type :=Reccustomer."Company Type";
                    RecLicenseset.RESET;
                    RecLicenseset.SETRANGE(RecLicenseset."Company Type", Type);
                    IF RecLicenseset.FINDSET THEN
                        REPEAT

                            IF FirstDeletion = TRUE THEN BEGIN
                                // Manish ++ 20/01/2016 ++
                                Rec_LicenseLineOld.RESET;
                                Rec_LicenseLineOld.SETRANGE(Rec_LicenseLineOld."License No", "License No");
                                Rec_LicenseLineOld.SETRANGE("Company Type", "Company Type");//alok code added
                                Rec_LicenseLineOld.SETRANGE(Rec_LicenseLineOld."Company No", "Company No");
                                Rec_LicenseLineOld.DELETEALL;
                                IF NOT Rec_LicenseLineOld.ISEMPTY THEN
                                    Rec_LicenseLineOld.DELETEALL
                            END;
                            // Manish -- 20/01/2016 --
                            RecLicenseLine.INIT;
                            RecLicenseLine."License No" := "License No";
                            RecLicenseLine."Company Type" := "Company Type";
                            RecLicenseLine."Company No" := "Company No";
                            RecLicenseLine."Line no" := LineNo;//RecLicenseLine."Line no" + 1000;
                            RecLicenseLine."Class Type" := RecLicenseset.Class;
                            RecLicenseLine.Type := RecLicenseset.Type;
                            //RecLicenseLine."Warning Type" := RecLicenseset."Warning Type";//CAS-02139-C3D4Q0
                            RecLicenseLine.INSERT(TRUE);
                            LineNo := LineNo + 10000;
                            FirstDeletion := FALSE;
                        UNTIL RecLicenseset.NEXT = 0
                    ELSE BEGIN
                        Rec_LicenseLineOld.RESET;
                        Rec_LicenseLineOld.SETRANGE(Rec_LicenseLineOld."License No", "License No");
                        Rec_LicenseLineOld.SETRANGE("Company Type", "Company Type");//alok code added
                        Rec_LicenseLineOld.SETRANGE(Rec_LicenseLineOld."Company No", "Company No");
                        Rec_LicenseLineOld.DELETEALL;
                    END;

                    //END
                END
                ELSE IF "Company Type" = "Company Type"::Supplier THEN BEGIN
                    //Recsupplier.GET("Company No");
                    //Type :=Recsupplier."Company Type";
                    RecLicenseset.SETRANGE(RecLicenseset."Company Type", Type);
                    IF RecLicenseset.FINDSET THEN
                        REPEAT
                        BEGIN
                            // Manish ++ 20/01/2016 ++
                            IF FirstDeletion = TRUE THEN BEGIN
                                Rec_LicenseLineOld.RESET;
                                Rec_LicenseLineOld.SETRANGE(Rec_LicenseLineOld."License No", "License No");
                                Rec_LicenseLineOld.SETRANGE("Company Type", "Company Type");//alok code added
                                Rec_LicenseLineOld.SETRANGE(Rec_LicenseLineOld."Company No", "Company No");
                                IF NOT Rec_LicenseLineOld.ISEMPTY THEN
                                    Rec_LicenseLineOld.DELETEALL
                                ELSE
                                    Rec_LicenseLineOld.DELETEALL;
                            END;

                            // Manish -- 20/01/2016 --
                            RecLicenseLine.INIT;
                            RecLicenseLine."License No" := "License No";
                            RecLicenseLine."Company Type" := "Company Type";
                            RecLicenseLine."Company No" := "Company No";
                            RecLicenseLine."Line no" := LineNo;//RecLicenseLine."Line no" + 10000;
                            RecLicenseLine."Class Type" := RecLicenseset.Class;
                            RecLicenseLine.Type := RecLicenseset.Type;
                            //RecLicenseLine."Warning Type" := RecLicenseset."Warning Type";//CAS-02139-C3D4Q0
                            RecLicenseLine.INSERT(TRUE);
                            LineNo := LineNo + 10000;
                            FirstDeletion := FALSE;
                        END UNTIL RecLicenseset.NEXT = 0

                    ELSE BEGIN
                        Rec_LicenseLineOld.RESET;
                        Rec_LicenseLineOld.SETRANGE(Rec_LicenseLineOld."License No", "License No");
                        Rec_LicenseLineOld.SETRANGE("Company Type", "Company Type");//alok code added
                        Rec_LicenseLineOld.SETRANGE(Rec_LicenseLineOld."Company No", "Company No");
                        Rec_LicenseLineOld.DELETEALL;
                    END;
                END
            end;
        }
        field(16; "Post Code"; Code[20])
        {
            Description = '// Manish 20/01/2016';
            TableRelation = "Post Code";
        }
        field(18; "License Notification Type"; Option)
        {
            Caption = 'License Category';
            Description = 'CAS-05452-Z2R2X7';
            OptionCaption = 'Error,Warning';
            OptionMembers = Error,Warning;
        }
        field(19; "Country/Region Code"; Code[20])
        {
            Description = 'CAS-05452-Z2R2X7';
            Editable = false;
            TableRelation = "Country/Region";
        }
        field(20; "License Status"; Option)
        {
            Editable = false;
            OptionCaption = 'Open,Released';
            OptionMembers = Open,Released;
        }
    }

    keys
    {
        key(Key1; "License No", "Company Type", "Company No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        CheckStatus;
        RecLiceLine.RESET;
        RecLiceLine.SETRANGE("License No", "License No");
        RecLiceLine.SETRANGE("Company Type", "Company Type");
        RecLiceLine.SETRANGE("Company No", "Company No");
        IF RecLiceLine.FINDSET THEN
            RecLiceLine.DELETEALL(TRUE);
    end;

    trigger OnRename()
    begin
        ERROR(Text003, TABLECAPTION);//alok for bug fix
    end;

    var
        RecLiceHdr: Record 50035;
        Rec_OrderAddress: Record 224;
        RecShiptoAddress: Record 222;
        RecLiceLine: Record 50036;
        LineNo: Integer;
        FirstDeletion: Boolean;
        Reccustomer: Record 18;
        RecLicenseLine: Record 50036;
        source_no: Code[20];
        RecLicenseset: Record 50037;
        Recsupplier: Record 23;
        RecLicenseHeader: Record 50036;
        Rec_LicenseLineOld: Record 50036;
        Text003: Label 'You cannot rename a %1.';
        PurchSetup: Record 312;
        SalesSetup: Record 312;
        Customer2: Record 18;

    procedure CheckStatus()
    begin
        TESTFIELD("License Status", "License Status"::Open);
    end;
}

