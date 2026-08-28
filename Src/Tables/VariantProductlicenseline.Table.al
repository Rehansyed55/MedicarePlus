table 50010 "Variant Product license line"
{
    // DrillDownPageID = 50025;
    // LookupPageID = 50025;

    fields
    {
        field(10; "PL No."; Code[20])
        {
            TableRelation = "Product License";
        }
        field(11; "Stock Code"; Code[20])
        {
            Caption = 'Stock Code';
        }
        field(20; "BPR Version No."; Code[20])
        {
        }
        field(21; "ECMA No."; Code[100])
        {
        }
        field(40; Reason; Text[100])
        {
        }
        field(50; "Certified Date"; Date)
        {
        }
        field(60; "Certified By"; Code[50])
        {
        }
        field(100; Comments; Text[100])
        {
        }
        field(130; "Production BOM No."; Code[20])
        {
            TableRelation = "Production BOM Header";

            trigger OnValidate()
            begin
                IF ProdBomHeader.GET(ProdBomHeader."No.") THEN BEGIN
                    "BOM Description" := ProdBomHeader.Description;
                END;
            end;
        }
        field(140; "Production BOM Version No."; Code[20])
        {
            TableRelation = "Production BOM Version"."Version Code" WHERE("Production BOM No." = FIELD("Production BOM No."));

            trigger OnValidate()
            begin
                IF PrdBomHeaderVer.GET("Production BOM Version No.", "Production BOM No.") THEN BEGIN
                    "BOM Description" := PrdBomHeaderVer.Description;
                END;
            end;
        }
        field(150; "Routing No."; Code[20])
        {
            TableRelation = "Routing Header"."No.";
        }
        field(160; "Master Sample Upload"; BLOB)
        {
            SubType = Bitmap;
        }
        field(183; "PIP Code"; Code[20])
        {
        }
        field(184; "Manufacturer Address"; Text[250])
        {
        }
        field(188; "Last Date Modify"; Date)
        {
        }
        field(189; "Last Date Modify time"; Time)
        {
        }
        field(190; "Last Modify By"; Code[50])
        {
        }
        field(191; "Crated by"; Code[50])
        {
        }
        field(192; "Created Date"; Date)
        {
        }
        field(193; "Created time"; Time)
        {
        }
        field(194; Status; Option)
        {
            OptionCaption = 'New,Certified,Close';
            OptionMembers = New,Certified,Close;

            trigger OnValidate()
            begin
                //pravin---CAS-01955-J2V3F3----------------------04/06/2016----------------------
                IF ((USERID = UPPERCASE('CHEMILINES\Sonal.Jagmohandas')) OR (USERID = UPPERCASE('CHEMILINES\raffaele.misul')) OR (USERID = UPPERCASE('CHEMILINES\ZAFAR.KHAN')) OR (USERID = UPPERCASE('CHEMILINES\TIJOMON.JOSEPH'))
                     OR (USERID = UPPERCASE('CHEMILINES\Riddhi.Patel')) OR (USERID = UPPERCASE('CHEMILINES\Latha.souprayal')) OR (USERID = UPPERCASE('CHEMILINES\GRISHMA.DALAL'))
                     OR (USERID = UPPERCASE('CHEMILINES\parth.patel')) OR (USERID = UPPERCASE('CHEMILINES\mohammad.modan'))
                     OR (USERID = UPPERCASE('CHEMILINES\Akhilesh.Ameta')) OR (USERID = UPPERCASE('CHEMILINES\Vishva.Patel')) OR (USERID = UPPERCASE('CHEMILINES\DESISLAVA.KATSAROVA'))
                     OR (USERID = UPPERCASE('CHEMILINES\carmen.cibotariu')) OR (USERID = UPPERCASE('CHEMILINES\Abdul.Khakoo'))
                     OR (USERID = UPPERCASE('robosoft')) OR (USERID = UPPERCASE('CHEMILINES\SANDIP.PATEL')) OR (USERID = UPPERCASE('CHEMILINES\ashutosh.pradhan'))
                     OR (USERID = UPPERCASE('CHEMILINES\OMKAR.GULAVANI')) OR (USERID = UPPERCASE('CHEMILINES\VIJAYKUMAR.YADAV'))
                     OR (USERID = UPPERCASE('CHEMILINES\Antonio.Greco')) OR (USERID = UPPERCASE('CHEMILINES\Abhishek.Shah')) OR (USERID = UPPERCASE('CHEMILINES\ROBOSOFT2'))
                     OR (USERID = UPPERCASE('CHEMILINES\EGLE.KEMEZAITE')) OR (USERID = UPPERCASE('CHEMILINES\Sureena.gill')) OR (USERID = UPPERCASE('CHEMILINES\radhika.shah')) OR (USERID = UPPERCASE('CHEMILINES\naimish.vyas'))
                     OR (USERID = UPPERCASE('CHEMILINES\YATI.KALPESH'))
                     OR (USERID = UPPERCASE('CHEMILINES\MATTHEW.COMER'))
                     OR (USERID = UPPERCASE('CHEMILINES\RICHARD.TEMPLE'))
                     OR (USERID = UPPERCASE('CHEMILINES\HAKEEM.OSHIYEMI'))
                OR (USERID = UPPERCASE('CHEMILINES\SONAL.JAGMOHANDAS')) OR (USERID = UPPERCASE('CHEMILINES\GRISHMA.DALAL'))
                OR (USERID = UPPERCASE('CHEMILINES\JIGNASABEN.PATEL'))
                OR (USERID = UPPERCASE('CHEMILINES\KRISHNA.PATEL'))
                OR (USERID = UPPERCASE('CHEMILINES\NIKITA.BRAGANZA'))
                OR (USERID = UPPERCASE('CHEMILINES\JIGAR.PATEL'))
                OR (USERID = UPPERCASE('CHEMILINES\HETALBEN.PATEL'))
                     ) THEN BEGIN
                    IF xRec.Status = xRec.Status::Certified THEN
                        IF Status = Status::New THEN
                            ERROR('Please select only Closed OR Certified');
                END
                ELSE IF Rec.Status = Rec.Status::Certified THEN
                    ERROR('You do not have permission to change status');

                IF ((USERID = UPPERCASE('CHEMILINES\Sonal.Jagmohandas')) OR (USERID = UPPERCASE('CHEMILINES\raffaele.misul')) OR (USERID = UPPERCASE('CHEMILINES\ZAFAR.KHAN')) OR (USERID = UPPERCASE('CHEMILINES\GRISHMA.DALAL'))
                    OR (USERID = UPPERCASE('CHEMILINES\Riddhi.Patel')) OR (USERID = UPPERCASE('CHEMILINES\Latha.souprayal')) OR (USERID = UPPERCASE('CHEMILINES\TIJOMON.JOSEPH'))
                    OR (USERID = UPPERCASE('CHEMILINES\parth.patel')) OR (USERID = UPPERCASE('CHEMILINES\mohammad.modan'))
                    OR (USERID = UPPERCASE('CHEMILINES\Akhilesh.Ameta')) OR (USERID = UPPERCASE('CHEMILINES\Vishva.Patel')) OR (USERID = UPPERCASE('CHEMILINES\DESISLAVA.KATSAROVA'))
                    OR (USERID = UPPERCASE('CHEMILINES\carmen.cibotariu')) OR (USERID = UPPERCASE('CHEMILINES\Abdul.Khakoo'))
                    OR (USERID = UPPERCASE('CHEMILINES\OMKAR.GULAVANI')) OR (USERID = UPPERCASE('CHEMILINES\VIJAYKUMAR.YADAV'))
                    OR (USERID = UPPERCASE('robosoft')) OR (USERID = UPPERCASE('CHEMILINES\SANDIP.PATEL')) OR (USERID = UPPERCASE('CHEMILINES\ashutosh.pradhan')) OR (USERID = UPPERCASE('CHEMILINES\ROBOSOFT2')) OR (USERID = UPPERCASE('CHEMILINES\EGLE.KEMEZAITE'))
                    OR (USERID = UPPERCASE('CHEMILINES\Antonio.Greco')) OR (USERID = UPPERCASE('CHEMILINES\Abhishek.Shah')) OR (USERID = UPPERCASE('CHEMILINES\Sureena.gill'))
                    OR (USERID = UPPERCASE('CHEMILINES\radhika.shah')) OR (USERID = UPPERCASE('CHEMILINES\naimish.vyas'))
                    OR (USERID = UPPERCASE('CHEMILINES\YATI.KALPESH'))
                    OR (USERID = UPPERCASE('CHEMILINES\MATTHEW.COMER'))
                    OR (USERID = UPPERCASE('CHEMILINES\RICHARD.TEMPLE'))
                     OR (USERID = UPPERCASE('CHEMILINES\HAKEEM.OSHIYEMI'))
               OR (USERID = UPPERCASE('CHEMILINES\SONAL.JAGMOHANDAS')) OR (USERID = UPPERCASE('CHEMILINES\GRISHMA.DALAL'))
               OR (USERID = UPPERCASE('CHEMILINES\JIGNASABEN.PATEL'))
               OR (USERID = UPPERCASE('CHEMILINES\KRISHNA.PATEL'))
               OR (USERID = UPPERCASE('CHEMILINES\NIKITA.BRAGANZA'))
               OR (USERID = UPPERCASE('CHEMILINES\HETALBEN.PATEL'))
               OR (USERID = UPPERCASE('CHEMILINES\JIGAR.PATEL'))) THEN BEGIN
                    IF xRec.Status = xRec.Status::Close THEN
                        IF Status = Status::New THEN
                            ERROR('Please select only Closed OR Certified');
                END
                ELSE IF Rec.Status = Rec.Status::Close THEN
                    ERROR('You do not have permission to change status');

                //pravin---CAS-01955-J2V3F3---------------------04/06/2016-----------------------


                //Chem-474++
                // CLEAR(PGLicLog);
                // PGLicLog.License("PL No.", "Stock Code", "ECMA No.", "BPR Version No.");
                // PGLicLog.RUN;
                //Chem-474



                /*IF Status=Status::Certified THEN
                BEGIN
                TESTFIELD("Production BOM No.");
                TESTFIELD("Routing No.");
                TESTFIELD("ECMA No.");
                END;
                //anikEt++
                //Addtional code added by Avinash 2701
                IF Status=Status::Certified THEN
                BEGIN
                recProdBOMHeader.RESET;
                    IF recProdBOMHeader.GET("Production BOM No.") THEN
                    BEGIN
                    recProdBOMHeader.Status:=recProdBOMHeader.Status::Certified;
                    recProdBOMHeader.MODIFY;
                    END;
                END;
                IF Status=Status::Close THEN
                BEGIN
                recProdBOMHeader.RESET;
                    IF recProdBOMHeader.GET("Production BOM No.") THEN
                    BEGIN
                    recProdBOMHeader.Status:=recProdBOMHeader.Status::Closed;
                    recProdBOMHeader.MODIFY;
                    END;
                END;
                //anikEt--
                */
                IF Status = Status::Certified THEN BEGIN
                    TESTFIELD("Production BOM No.");
                    TESTFIELD("Routing No.");
                    TESTFIELD("ECMA No.");
                END;
                //anikEt++
                //Addtional code added by Avinash 2701
                IF Status = Status::Certified THEN BEGIN
                    recProdBOMHeader.RESET;
                    IF recProdBOMHeader.GET("Production BOM No.") THEN BEGIN
                        recProdBOMHeader.Status := recProdBOMHeader.Status::Certified;
                        recProdBOMHeader.MODIFY(TRUE);
                        COMMIT;
                    END;
                END;
                IF Status = Status::Close THEN BEGIN
                    recProdBOMHeader.RESET;
                    IF recProdBOMHeader.GET("Production BOM No.") THEN BEGIN
                        recProdBOMHeader.Status := recProdBOMHeader.Status::Closed;
                        recProdBOMHeader.MODIFY(TRUE);
                        COMMIT;
                    END;
                END;
                //anikEt--
                //ROBOCHEM 1.0 QEP-38 ++
                IF Status = 1 THEN BEGIN
                    RoutingHeader.RESET;
                    IF RoutingHeader.GET("Routing No.") THEN BEGIN
                        RoutingHeader.Status := 1;
                        RoutingHeader.MODIFY(TRUE);
                        COMMIT;
                    END;
                END;
                IF Status = 2 THEN BEGIN
                    RoutingHeader.RESET;
                    IF RoutingHeader.GET("Routing No.") THEN BEGIN
                        RoutingHeader.Status := 3;
                        RoutingHeader.MODIFY(TRUE);
                        COMMIT;

                    END;
                END;
                //ROBOCHEM 1.0 QEP-38--

            end;
        }
        field(50000; "Attachment No."; Integer)
        {
        }
        field(50001; "Product Desc"; Text[250])
        {
            Editable = true;
        }
        field(50002; "Product Size"; Text[30])
        {
            Editable = true;
        }
        field(50003; "Product Strength"; Text[30])
        {
            Editable = true;
        }
        field(50004; Country; Code[20])
        {
            Editable = true;
        }
        field(50005; "Version No."; Code[20])
        {
        }
        field(50006; "Manufacture Name"; Text[100])
        {
        }
        field(50007; "PLG Code"; Code[20])
        {
        }
        field(50008; "BOM Description"; Text[100])
        {
        }
        field(50009; "Product Desc1"; Text[250])
        {
        }
        field(50010; Blocked; Boolean)
        {
        }
        field(50011; "License Approved"; Boolean)
        {
        }
        field(50012; Approved; Boolean)
        {
            Description = 'Chem-473';

            trigger OnValidate()
            begin
                //Chem-473++
                IF Approved THEN BEGIN
                    "Approved By QP" := USERID;
                    "Approved By Date" := WORKDATE;
                END
                ELSE BEGIN
                    "Approved By QP" := '';
                    "Approved By Date" := 0D;

                END;
                //Chem-473--
            end;
        }
        field(50013; "Approved By QP"; Code[30])
        {
            Description = 'Chem-473';
        }
        field(50014; "Approved By Date"; Date)
        {
            Description = 'Chem-473';
        }
        field(50015; Compiled; Boolean)
        {
            Description = 'Chem-473';

            trigger OnValidate()
            begin
                //Chem-473++
                IF Compiled THEN BEGIN
                    "Compiled By" := USERID;
                    "Compiled By Date" := WORKDATE;
                END
                ELSE BEGIN
                    "Compiled By" := '';
                    "Compiled By Date" := 0D;
                END;
                //Chem-473--
            end;
        }
        field(50016; "Compiled By"; Code[30])
        {
            Description = 'Chem-473';
        }
        field(50017; "Compiled By Date"; Date)
        {
            Description = 'Chem-473';
        }
        field(50018; CCR; Code[30])
        {
            Description = 'Chem-473';
        }
        field(50019; "Master Sample"; Text[250])
        {
            Description = 'Chem-473';
        }
        field(50020; Superseded; Code[30])
        {
            Description = 'Chem-473';
        }
        field(50021; "Master Sample Upload 1"; BLOB)
        {
            Description = 'CHEM-485';
            SubType = Bitmap;
        }
        field(50022; "Master Sample Upload 2"; BLOB)
        {
            Description = 'CHEM-485';
            SubType = Bitmap;
        }
        field(50023; "Master Sample Upload 3"; BLOB)
        {
            Description = 'CHEM-485';
            SubType = Bitmap;
        }
        field(50024; "Master Sample Upload 4"; BLOB)
        {
            Description = 'CHEM-485';
            SubType = Bitmap;
        }
        field(50025; "Master Sample Upload 5"; BLOB)
        {
            Description = 'CHEM-485';
            SubType = Bitmap;
        }
        field(50026; FLRD; Date)
        {
            Description = 'CHEM-485';
        }
        field(50027; Certified; Boolean)
        {
            Description = 'CHEM-485';

            trigger OnValidate()
            begin
                //Chem-473++
                IF Certified THEN BEGIN
                    "Certified By" := USERID;
                    "Certified Date" := WORKDATE;
                END
                ELSE BEGIN
                    "Certified By" := '';
                    "Certified Date" := 0D;

                END;
                //Chem-473--
            end;
        }
        field(50028; "PLG Superseded"; Code[30])
        {
            Description = 'CHEM-485';
        }
        field(50029; QIDR; Code[50])
        {
            Description = 'CHEM-490';
        }
        field(50030; "License Position"; Option)
        {
            CalcFormula = Lookup("Product License"."License Position" WHERE("PL No." = FIELD("PL No."),
                                                                             "Stock Code" = FIELD("Stock Code")));
            Description = 'Chem-474';
            FieldClass = FlowField;
            OptionCaption = ' ,Initial,Active,Surrender';
            OptionMembers = " ",Initial,Active,Surrender;
        }
    }

    keys
    {
        key(Key1; "PL No.", "Stock Code", "ECMA No.", "BPR Version No.")
        {
            Clustered = true;
        }
        key(Key2; "Stock Code")
        {
        }
        key(Key3; "BPR Version No.")
        {
        }
        key(Key4; "Last Date Modify")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "PL No.", "Stock Code", "ECMA No.", Country, "BPR Version No.", Status, "Last Date Modify")
        {
        }
    }

    trigger OnInsert()
    begin

        IF ProdLicHeader.GET("PL No.", "Stock Code") THEN BEGIN
            "Product Desc" := ProdLicHeader."Item Description";
            IF ProdLicHeader."Pack Size" = '' THEN BEGIN
                "Product Size" := ProdLicHeader."Foreign Pack size";
            END ELSE BEGIN
                "Product Size" := ProdLicHeader."Pack Size";
            END;
            "Product Strength" := ProdLicHeader.Strength;
            Country := ProdLicHeader.Country;
            // "Manufacture Name":=ProdLicHeader."Manufacture Name";
        END;





        "Crated by" := USERID;
        "Created Date" := WORKDATE;
        "Created time" := TIME;
    end;

    trigger OnModify()
    begin

        "Last Date Modify" := WORKDATE;
        "Last Date Modify time" := TIME;
        "Last Modify By" := USERID;
        /*
        IF ProdLicHeader.GET("PL No.","Stock Code") THEN
        BEGIN
            "Product Desc":=ProdLicHeader."Item Description";
            IF  ProdLicHeader."Pack Size"='' THEN
            BEGIN
            "Product Size":= ProdLicHeader."Foreign Pack size";
            END ELSE
            BEGIN
             "Product Size":= ProdLicHeader."Pack Size";
            END;
                "Product Strength":=ProdLicHeader.Strength;
             Country:= ProdLicHeader.Country;
            "Manufacture Name":=ProdLicHeader."Manufacture Name";
        END;
         */

    end;

    var
        Item_Rec: Record 27;
        Prod_lic: Record 50008;
        ProdLicHeader: Record 50008;
        Text000: Label 'You have canceled the create process.';
        Text001: Label 'Replace existing attachment?';
        Text002: Label 'You have canceled the import process.';
        ProdBomHeader: Record 99000771;
        PrdBomHeaderVer: Record 99000779;
        recProdBOMHeader: Record 99000771;
        RoutingHeader: Record 99000763;
        recLicLog: Record 50026 temporary;
        // PGLicLog: Page 50090;
        prevstat: Option " ",STOP,OK;

    procedure AddItemVariant(Itemno: Code[20]; RecVariant: Code[20]; XRecVariant: Code[20]; Transtype: Integer)
    var
        ItemVariantRec: Record 5401;
    begin
        IF Transtype = 2 THEN BEGIN
            IF ItemVariantRec.GET(Itemno, XRecVariant) THEN BEGIN
                ItemVariantRec.DELETE(TRUE);
            END;
            IF ItemVariantRec.GET(Itemno, RecVariant) THEN BEGIN
            END ELSE BEGIN
                ItemVariantRec.VALIDATE("Item No.", Itemno);
                ItemVariantRec.VALIDATE(Code, RecVariant);
                ItemVariantRec.INSERT(TRUE);
            END;
        END;
        IF Transtype = 1 THEN BEGIN
            IF ItemVariantRec.GET(Itemno, RecVariant) THEN BEGIN
            END ELSE BEGIN
                ItemVariantRec.VALIDATE("Item No.", Itemno);
                ItemVariantRec.VALIDATE(Code, RecVariant);
                ItemVariantRec.INSERT(TRUE);
            END;
        END;
        IF Transtype = 3 THEN BEGIN
            IF ItemVariantRec.GET(Itemno, RecVariant) THEN BEGIN
                ItemVariantRec.DELETE(TRUE);
            END;


        END;
    end;

    procedure CheckDuplicate(PLNo: Code[20]; VariantNo: Code[20]; LineNo: Integer) Retvalue: Boolean
    var
        PLVariantLine: Record 50010;
    begin
        /*
       PLVariantLine.RESET;
       PLVariantLine.SETRANGE(PLVariantLine."PL No.",PLNo);
       PLVariantLine.SETRANGE(PLVariantLine."Variant No.",VariantNo);
       PLVariantLine.SETFILTER(PLVariantLine."Line No.",'<>%1',LineNo);
       IF  PLVariantLine.FINDFIRST THEN
       BEGIN
         ERROR('Version already exists!');
       //  RetValue:=True;

       END ELSE
       BEGIN

       //   Retvalue:=False;
       END;
         */

    end;

    procedure ShowLable_PIC()
    var
        VariantPLLine: Record 50010;
    // VariantPLLine_form: Page 50024;
    begin
        // TESTFIELD("PL No.");
        // TESTFIELD("Stock Code");
        // TESTFIELD("ECMA No.");
        // TESTFIELD("BPR Version No.");
        // VariantPLLine.RESET;
        // VariantPLLine.SETRANGE(VariantPLLine."PL No.", "PL No.");
        // VariantPLLine.SETRANGE(VariantPLLine."Stock Code", "Stock Code");
        // VariantPLLine.SETRANGE(VariantPLLine."ECMA No.", "ECMA No.");
        // VariantPLLine.SETRANGE(VariantPLLine."BPR Version No.", "BPR Version No.");
        // IF VariantPLLine.FINDFIRST THEN BEGIN
        //     VariantPLLine_form.SETTABLEVIEW(VariantPLLine);
        //     VariantPLLine_form.RUNMODAL;
        // END;
        /*
        //IF VariantPLLine.GET("PL No.","Item No.","ECMA No.","Version No.") THEN
        BEGIN
        VariantPLLine_form.SETTABLEVIEW(VariantPLLine);
        VariantPLLine_form.RUNMODAL;
        END;
         */

    end;


    // procedure CreateAttachment()
    // var
    //     Attachment: Record 5062;
    //     VariantLic: Record 50010;
    //     AttachmentManagement: Codeunit 5052;
    //     WordManagement: Codeunit 5054;
    //     NewAttachNo: Integer;
    // begin
    //     IF "Attachment No." <> 0 THEN BEGIN
    //         IF Attachment.GET("Attachment No.") THEN
    //             Attachment.TESTFIELD("Read Only", FALSE);
    //         IF NOT CONFIRM(Text001, FALSE) THEN
    //             EXIT;
    //     END;

    //     //IF AttachmentManagement.UseComServer('DOC',TRUE) THEN; //Commented as in NAV 2013 Dont Have Function UseComServer in Codeunit AttachmentManagement

    //     NewAttachNo := WordManagement.CreateWordAttachment("PL No." + ' ' + "Stock Code" + ' ' + "ECMA No." + ' ' + "BPR Version No.", 'ENG');
    //     IF NewAttachNo <> 0 THEN BEGIN
    //         IF "Attachment No." <> 0 THEN
    //             RemoveAttachment(FALSE);
    //         "Attachment No." := NewAttachNo;
    //         IF VariantLic.GET("PL No.", "Stock Code", "ECMA No.", "BPR Version No.") THEN
    //             MODIFY
    //         ELSE
    //             INSERT;
    //     END ELSE
    //         ERROR(Text000);
    // end;


    procedure OpenAttachment()
    var
        Attachment: Record 5062;
    begin
        IF "Attachment No." = 0 THEN
            EXIT;
        Attachment.GET("Attachment No.");
        Attachment.OpenAttachment("PL No." + ' ' + "Stock Code" + ' ' + "ECMA No." + ' ' + "BPR Version No.", FALSE, 'ENG');
    end;


    // procedure CopyFromAttachment()
    // var
    //     VariantLic: Record 50010;
    //     Attachment: Record 5062;
    //     AttachmentManagement: Codeunit 5052;
    //     NewAttachNo: Integer;
    // begin
    //     IF Attachment.GET("Attachment No.") THEN
    //         Attachment.TESTFIELD("Read Only", FALSE);

    //     IF "Attachment No." <> 0 THEN BEGIN
    //         IF NOT CONFIRM(Text001, FALSE) THEN
    //             EXIT;
    //         RemoveAttachment(FALSE);
    //         "Attachment No." := 0;
    //         MODIFY;
    //         COMMIT;
    //     END;

    //     VariantLic.SETFILTER("Attachment No.", '<>%1', 0);
    //     IF PAGE.RUNMODAL(0, VariantLic) = ACTION::LookupOK THEN BEGIN
    //         NewAttachNo := AttachmentManagement.InsertAttachment(VariantLic."Attachment No.");
    //         IF NewAttachNo <> 0 THEN BEGIN
    //             "Attachment No." := NewAttachNo;
    //             MODIFY;
    //         END;
    //     END;
    // end;


    // procedure ImportAttachment()
    // var
    //     Attachment: Record 5062;
    //     AttachmentManagement: Codeunit 5052;
    // begin
    //     IF "Attachment No." <> 0 THEN BEGIN
    //         IF Attachment.GET("Attachment No.") THEN
    //             Attachment.TESTFIELD("Read Only", FALSE);
    //         IF NOT CONFIRM(Text001, FALSE) THEN
    //             EXIT;
    //     END;
    //     IF Attachment.ImportAttachmentFromClientFile('', FALSE, FALSE) THEN BEGIN //Sofyan
    //                                                                               //IF Attachment.ImportAttachment('',FALSE,FALSE) THEN BEGIN

    //         "Attachment No." := Attachment."No.";
    //         MODIFY;
    //     END ELSE
    //         ERROR(Text002);
    // end;


    // procedure ExportAttachment()
    // var
    //     Attachment: Record 5062;
    //     ExportToFile: Text[260];
    // begin
    //     IF Attachment.GET("Attachment No.") THEN BEGIN
    //         Attachment.CALCFIELDS("Attachment File");
    //         Attachment.ExportAttachmentToClientFile(ExportToFile);
    //     END
    //     //Attachment.ExportAttachment(ExportToFile);
    // end;


    procedure RemoveAttachment(Prompt: Boolean)
    var
        Attachment: Record 5062;
    begin
        // IF Attachment.GET("Attachment No.") THEN
        //     IF Attachment.RemoveAttachment(Prompt) THEN BEGIN
        //         "Attachment No." := 0;
        //         MODIFY;
        //     END;
    end;


    procedure get_ECMAVersion()
    var
        VariantPLLine: Record 50010;
    // VariantPLLine_form: Page 50021;
    begin
    end;


    procedure GetBPRReport()
    var
        VariantLicLine: Record 50010;
    // BPRPreview: Report 50070;
    begin
        //Commented as Report is Yet to Migrate from NAV 5.0 to NAV 13

        // CLEAR(BPRPreview);
        VariantLicLine.SETRANGE(VariantLicLine."Stock Code", "Stock Code");
        VariantLicLine.SETRANGE(VariantLicLine."BPR Version No.", "BPR Version No.");
        VariantLicLine.SETRANGE(VariantLicLine."ECMA No.", "ECMA No.");
        // BPRPreview.SETTABLEVIEW(VariantLicLine);
        // BPRPreview.RUNMODAL();
    end;


    procedure TestImportAttachment(TFileName: Text[250])
    var
        Attachment: Record 5062;
        AttachmentManagement: Codeunit 5052;
    begin
        IF "Attachment No." <> 0 THEN BEGIN
            IF Attachment.GET("Attachment No.") THEN
                Attachment.TESTFIELD("Read Only", FALSE);
            //  IF NOT CONFIRM(Text001,FALSE) THEN
            //    EXIT;
        END;

        /*IF Attachment.ImportAttachment(TFileName,FALSE,FALSE) THEN BEGIN
          "Attachment No." := Attachment."No.";
          MODIFY;
        END ELSE
          ERROR(Text002);*/

    end;
}

