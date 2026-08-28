table 50012 "Default Setup"
{
    Caption = 'Default Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Default Company Code"; Code[20])
        {
        }
        field(3; "IS Firm&Relesed Order No.Same"; Boolean)
        {
        }
        field(4; "New ECMA Request Email ID"; Text[250])
        {
        }
        field(5; "Not Check Item Tracking"; Boolean)
        {
        }
        field(6; "Stock Hold on Zone"; Code[20])
        {
            TableRelation = Zone.Code;
        }
        field(7; "Stock Hold on Bin"; Code[20])
        {
            TableRelation = Bin.Code WHERE("Zone Code" = FIELD("Stock Hold on Zone"));
        }
        field(8; "Gate Inward Location"; Code[20])
        {
            TableRelation = Location;
        }
        field(9; "Gate Inward Bin"; Code[20])
        {
            TableRelation = Bin.Code WHERE("Location Code" = FIELD("Gate Inward Location"));
        }
        field(10; "Issue Component User Email ID"; Text[250])
        {
        }
        field(11; "Sales Free Zone"; Code[20])
        {
            TableRelation = Zone.Code;
        }
        field(12; "Addon No."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(13; "Export File Path"; Text[250])
        {
        }
        field(50000; "Production BN"; Boolean)
        {
        }
        field(50001; "Stock On Hold BN"; Boolean)
        {
        }
        field(50002; "Process Batch no. Sufix"; Text[50])
        {

            trigger OnValidate()
            begin
                //alok for adding * on Sufix in bin
                "Process Batch no. Sufix" := '*' + "Process Batch no. Sufix";
            end;
        }
        field(50003; "Bin code"; Code[50])
        {
            TableRelation = Zone.Code;
        }
        field(50004; "From Bin code"; Code[50])
        {
            TableRelation = Bin.Code;
        }
        field(50005; "To Bin Code"; Code[50])
        {
            TableRelation = Bin.Code;
        }
        field(50006; "Company name"; Text[250])
        {
        }
        field(50009; "B2B Order String"; Code[10])
        {
        }
        field(50010; "B2B Last Order No"; Integer)
        {
        }
        field(50011; "Web order no. series"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        ProdStockOnHold_Rec: Record 50014;
        Text001: Label 'Firmed Planned Production Order No. : %1 \Created Successfully for Item : %2';

    procedure SendECMAMail(Subject: Text[80]; ToMail: Text[80]; CCMail: Text[80]; ItemID: Code[20]; PONo: Code[20]; ECMANo: Code[100])
    var
        // SendMail: Codeunit 397;
        Email: codeunit Email;
        EmailMessage: codeunit "Email Message";
        defaultSetup: Record 50012;
        Txt: Text[80];
        Txt1: Text[80];
        Txt2: Text[80];
        Txt3: Text[80];
        Txt4: Text[80];
        Txt5: Text[80];
        Item_Rec: Record 27;
        ProdLic_Rec: Record 50008;
        PurchaseOrder: Record 38;
        EmailType: Enum "Email Recipient Type";
    begin
        IF defaultSetup.GET() THEN BEGIN
            defaultSetup.TESTFIELD("New ECMA Request Email ID");
            IF Item_Rec.GET(ItemID) THEN BEGIN
                Txt := 'Item Details : ' + Item_Rec."No." + ' \ ' + Item_Rec.Description;
            END;
            ProdLic_Rec.RESET;
            ProdLic_Rec.SETRANGE(ProdLic_Rec."Stock Code", ItemID);
            IF ProdLic_Rec.FINDFIRST THEN BEGIN
                Txt2 := 'PL/PI No. : ' + ProdLic_Rec."PL No.";
                Txt3 := 'EU Trade Name :' + ProdLic_Rec."EU Trade";
                Txt4 := 'Strength : ' + ProdLic_Rec.Strength;
                Txt5 := 'Pack Size : ' + ProdLic_Rec."Pack Size";
            END;
            IF PurchaseOrder.GET(1, PONo) THEN BEGIN
                Txt1 := 'Vendor Details : ' + PurchaseOrder."Buy-from Vendor No." + '\ ' + PurchaseOrder."Buy-from Vendor Name";
            END;


            EmailMessage.AppendToBody(Txt);
            EmailMessage.AppendToBody(Txt1);
            EmailMessage.AppendToBody(Txt2);
            EmailMessage.AppendToBody(Txt3);
            EmailMessage.AppendToBody(Txt4);
            EmailMessage.AppendToBody(Txt5);

            EmailMessage.SetSubject(Subject);
            EmailMessage.AddRecipient(EmailType::"To", defaultSetup."New ECMA Request Email ID");
            Email.Send(EmailMessage);
            // SendMail.NewMessage(defaultSetup."New ECMA Request Email ID", CCMail, Subject, '', '', '', FALSE);
            MESSAGE('Message Sent Successfully!')
        END;
    end;

    procedure CallNewFormforECMA(var NewEcmaNo: Code[100]; var ItemCode: Code[20])
    var
        // NewEcmaNoForm: Page 50027;
        ProductLic_Rec: Record 50008;
        ProductLic_Rec1: Record 50008;
    begin
        ProductLic_Rec.RESET;
        ProductLic_Rec.SETRANGE(ProductLic_Rec."Stock Code", ItemCode);
        ProductLic_Rec.SETRANGE(ProductLic_Rec."ECMA No.", NewEcmaNo);
        IF NOT ProductLic_Rec.FINDFIRST THEN BEGIN
            ProductLic_Rec1.RESET;
            ProductLic_Rec1.SETRANGE(ProductLic_Rec1."Stock Code", ItemCode);
            IF ProductLic_Rec1.FINDFIRST THEN BEGIN
                ProductLic_Rec1."ECMA No." := NewEcmaNo;
                ProductLic_Rec1.MODIFY;
                COMMIT;
                // NewEcmaNoForm.SETTABLEVIEW(ProductLic_Rec1);
                // NewEcmaNoForm.RUNMODAL;
            END;
        END;
    end;


    procedure MakeFirmPlanProdOrder(WhseReceiptLine_Rec: Record 7317)
    var
        WMSReceiptLine1: Record 7317;
        Prodorder: Record 5405;
        "Tracking Specification": Record 336;
        PurchRcptHeader: Record 120;
        ItemledgerEntry: Record 32;
        Countprod: Integer;
        PostedWMSRecieptHeader: Record 7318;
        PostedWMSReceiptNo: Code[20];
        VairantProdLic_Rec: Record 50010;
        Text000: Label 'ECMA No. %1 does not exists in our Ecma List. Do you want to notifiy RA department ?';
        TempBatchNo: Code[20];
        PurchRcptLine: Record 121;
        Item: Record 27;
        LotNoInfo: Record 6505;
        ECMANo: Code[100];
    begin
        Countprod := 0;
        TempBatchNo := '';
        ECMANo := '';
        IF WhseReceiptLine_Rec."Create Production Order" = TRUE THEN BEGIN
            PurchRcptHeader.RESET;
            PurchRcptHeader.SETRANGE(PurchRcptHeader."WhseRcptHeader No.", WhseReceiptLine_Rec."No.");
            PurchRcptHeader.SETRANGE(PurchRcptHeader."Order No.", WhseReceiptLine_Rec."Source No.");
            IF PurchRcptHeader.FINDLAST THEN BEGIN
                PostedWMSReceiptNo := '';
                PostedWMSRecieptHeader.RESET;
                PostedWMSRecieptHeader.SETRANGE(PostedWMSRecieptHeader."Whse. Receipt No.", WhseReceiptLine_Rec."No.");
                IF PostedWMSRecieptHeader.FINDLAST THEN BEGIN
                    PostedWMSReceiptNo := PostedWMSRecieptHeader."No.";
                END;
                ItemledgerEntry.RESET;
                ItemledgerEntry.SETRANGE(ItemledgerEntry."Document No.", PurchRcptHeader."No.");
                ItemledgerEntry.SETRANGE(ItemledgerEntry."Entry Type", ItemledgerEntry."Entry Type"::Purchase);
                ItemledgerEntry.SETRANGE(ItemledgerEntry."Item No.", WhseReceiptLine_Rec."Item No.");
                ItemledgerEntry.SETRANGE(ItemledgerEntry."Document Line No.", WhseReceiptLine_Rec."Source Line No.");//alok
                                                                                                                     //WhseReceiptLine_Rec."Line No.");//alok
                ItemledgerEntry.SETFILTER(ItemledgerEntry."Lot No.", '<>%1', '');
                //ItemledgerEntry.SETFILTER(ItemledgerEntry."ECMA No.",'<>%1',''); // Commented for Upgradation
                IF ItemledgerEntry.FINDFIRST THEN BEGIN
                    REPEAT
                        //Code for Getting ECMA No.
                        LotNoInfo.RESET;
                        LotNoInfo.SETRANGE(LotNoInfo."Item No.", WhseReceiptLine_Rec."Item No.");
                        LotNoInfo.SETRANGE(LotNoInfo."Lot No.", ItemledgerEntry."Lot No.");
                        IF LotNoInfo.FINDFIRST THEN
                            ECMANo := LotNoInfo."Certificate Number";
                        //Code for checking ECMAno
                        VairantProdLic_Rec.RESET;
                        VairantProdLic_Rec.SETRANGE(VairantProdLic_Rec."Stock Code", WhseReceiptLine_Rec."Item No.");
                        VairantProdLic_Rec.SETRANGE(VairantProdLic_Rec."ECMA No.", ECMANo);
                        //VairantProdLic_Rec.SETRANGE(VairantProdLic_Rec."ECMA No.",ItemledgerEntry."ECMA No.");
                        VairantProdLic_Rec.SETRANGE(VairantProdLic_Rec.Status, VairantProdLic_Rec.Status::Certified);
                        IF VairantProdLic_Rec.FINDFIRST THEN BEGIN
                            Prodorder.SETRANGE(Prodorder.WMSReceiptNo, WhseReceiptLine_Rec."No.");
                            Prodorder.SETRANGE(Prodorder."Source Type", Prodorder."Source Type"::Item);
                            Prodorder.SETRANGE(Prodorder."Source No.", WhseReceiptLine_Rec."Item No.");
                            Prodorder.SETRANGE(Prodorder."Lot No.", ItemledgerEntry."Lot No.");
                            Prodorder.SETRANGE(Prodorder."Purchase order", WhseReceiptLine_Rec."Source No.");
                            IF NOT Prodorder.FINDFIRST THEN BEGIN
                                Prodorder.INIT;
                                Prodorder.VALIDATE(Prodorder.Status, 2);
                                Prodorder.VALIDATE(Prodorder."No.", '');
                                Prodorder.VALIDATE(Prodorder."Source Type", Prodorder."Source Type"::Item);
                                Prodorder.VALIDATE(Prodorder."Source No.", WhseReceiptLine_Rec."Item No.");
                                Prodorder.VALIDATE(Prodorder.Quantity, ItemledgerEntry.Quantity);
                                Prodorder.VALIDATE(Prodorder."ECMA No.", ECMANo); // Certificate Number is Used as ECMA No. Field
                                                                                  //Prodorder.VALIDATE(Prodorder."ECMA No.",ItemledgerEntry."ECMA No."); // Commented for Upgradation
                                Prodorder.VALIDATE(Prodorder.WMSReceiptNo, WhseReceiptLine_Rec."No.");
                                Prodorder.VALIDATE(Prodorder."Location Code", ItemledgerEntry."Location Code");
                                Prodorder.VALIDATE(Prodorder."Lot No.", ItemledgerEntry."Lot No.");
                                Prodorder.VALIDATE(Prodorder."Purchase order", WhseReceiptLine_Rec."Source No.");
                                Prodorder.VALIDATE(Prodorder."Expriy Date", ItemledgerEntry."Expiration Date");
                                Prodorder.VALIDATE(Prodorder."Location Code", ItemledgerEntry."Location Code");
                                Prodorder.VALIDATE(Prodorder."Posted Warehouse Receipt No.", PostedWMSReceiptNo);
                                Prodorder.VALIDATE(Prodorder."Posted Receipt No.", PurchRcptHeader."No.");
                                Prodorder.VALIDATE(Prodorder."PLPI No.", VairantProdLic_Rec."PL No.");
                                Prodorder.VALIDATE(Prodorder."Room No.", '');
                                IF Item.GET(Prodorder."Source No.") THEN
                                    Prodorder."PIP Code" := Item."No. 2";

                                PurchRcptLine.RESET;
                                PurchRcptLine.SETRANGE(PurchRcptLine."Document No.", PurchRcptHeader."No.");
                                PurchRcptLine.SETRANGE(PurchRcptLine.Type, PurchRcptLine.Type::Item);
                                PurchRcptLine.SETRANGE(PurchRcptLine."No.", WhseReceiptLine_Rec."Item No.");
                                PurchRcptLine.SETRANGE(PurchRcptLine."Location Code", ItemledgerEntry."Location Code");
                                IF PurchRcptLine.FINDFIRST THEN BEGIN
                                    Prodorder.VALIDATE(Prodorder."Rebox/Overlabel", PurchRcptLine."Rebox/Overlabel");
                                    //Prodorder.VALIDATE(Prodorder."PLPI No.",PurchRcptLine."PL No.");
                                END;
                                Prodorder.INSERT(TRUE);
                                Countprod := 1;
                            END ELSE BEGIN
                                IF ItemledgerEntry."Document Line No." = WhseReceiptLine_Rec."Line No." THEN BEGIN//alok
                                    Prodorder.VALIDATE(Prodorder.Quantity, Prodorder.Quantity + ItemledgerEntry.Quantity);
                                    Prodorder.MODIFY(TRUE);
                                END;//alok
                            END
                        END ELSE BEGIN
                            PurchRcptLine.RESET;
                            PurchRcptLine.SETRANGE(PurchRcptLine."Document No.", PurchRcptHeader."No.");
                            PurchRcptLine.SETRANGE(PurchRcptLine.Type, PurchRcptLine.Type::Item);
                            PurchRcptLine.SETRANGE(PurchRcptLine."No.", ItemledgerEntry."Item No.");
                            PurchRcptLine.SETRANGE(PurchRcptLine."Location Code", ItemledgerEntry."Location Code");
                            IF PurchRcptLine.FINDFIRST THEN BEGIN
                                CreateStockOnHold(ItemledgerEntry."Item No."
                                   , ECMANo, WhseReceiptLine_Rec."Source No.",
                                    WhseReceiptLine_Rec."No.", WhseReceiptLine_Rec."Line No.", ItemledgerEntry."Location Code", ItemledgerEntry."Lot No."
                                    , 0, 0, '', '', 1, PurchRcptHeader."No.", ItemledgerEntry."Expiration Date", PurchRcptHeader."Posting Date"
                                    , PurchRcptLine."PL No.");//VairantProdLic_Rec."PL No.");
                            END;
                        END;
                        TempBatchNo := ItemledgerEntry."Lot No.";
                        //alok
                        IF Countprod = 1 THEN BEGIN
                            MESSAGE(Text001, Prodorder."No.", WhseReceiptLine_Rec."Item No.")
                        END;
                    //alok finish
                    UNTIL ItemledgerEntry.NEXT = 0;
                END ELSE BEGIN
                    PurchRcptLine.RESET;
                    PurchRcptLine.SETRANGE(PurchRcptLine."Document No.", PurchRcptHeader."No.");
                    PurchRcptLine.SETRANGE(PurchRcptLine.Type, PurchRcptLine.Type::Item);
                    PurchRcptLine.SETRANGE(PurchRcptLine."No.", ItemledgerEntry."Item No.");
                    PurchRcptLine.SETRANGE(PurchRcptLine."Location Code", ItemledgerEntry."Location Code");
                    VairantProdLic_Rec.RESET;
                    VairantProdLic_Rec.SETRANGE(VairantProdLic_Rec."Stock Code", WhseReceiptLine_Rec."Item No.");
                    VairantProdLic_Rec.SETRANGE(VairantProdLic_Rec."ECMA No.", ECMANo);
                    IF PurchRcptLine.FINDFIRST THEN BEGIN
                        CreateStockOnHold(ItemledgerEntry."Item No.", ECMANo, WhseReceiptLine_Rec."Source No.",
                           WhseReceiptLine_Rec."No.", WhseReceiptLine_Rec."Line No.", ItemledgerEntry."Location Code", ItemledgerEntry."Lot No."
                           , 0, 0, '', '', 1, PurchRcptHeader."No.", ItemledgerEntry."Expiration Date", PurchRcptHeader."Posting Date"
                           , PurchRcptLine."PL No.");//VairantProdLic_Rec."PL No.");
                    END;
                END;
            END;
        END;

        //UNTIL WhseReceiptLine_Rec.NEXT=0;
        //===========================================================================================
        /*IF Countprod=1 THEN
        BEGIN
            MESSAGE(Text001,Prodorder."No.",WhseReceiptLine_Rec."Item No.")
        
        
        END;*/

    end;

    procedure SplitPostedWhseRcptLine_New(PostedWhseRcptLine: Record 7319; var TempPostedWhseRcptlLine: Record 7319 temporary)
    var
        WhseItemEntryRelation: Record 6509;
        ItemLedgEntry: Record 32;
        LineNo: Integer;
        WhseSNRequired: Boolean;
        WhseLNRequired: Boolean;
        CrossDockQty: Decimal;
        CrossDockQtyBase: Decimal;
        defaultsetup: Record 50012;
        VariantProdLic_Rec: Record 50010;
        LotNoInfo: Record 6505;
        ECMANo: Code[20];
    begin
        ECMANo := '';
        TempPostedWhseRcptlLine.RESET;
        TempPostedWhseRcptlLine.DELETEALL;

        WhseItemEntryRelation.RESET;
        WhseItemEntryRelation.SETCURRENTKEY(
          "Source ID", "Source Type", "Source Subtype", "Source Ref. No.");
        WhseItemEntryRelation.SETRANGE("Source ID", PostedWhseRcptLine."No.");
        WhseItemEntryRelation.SETRANGE("Source Type", DATABASE::"Posted Whse. Receipt Line");
        WhseItemEntryRelation.SETRANGE("Source Subtype", 0);
        WhseItemEntryRelation.SETRANGE("Source Ref. No.", PostedWhseRcptLine."Line No.");
        IF WhseItemEntryRelation.FINDSET THEN BEGIN
            REPEAT
                LineNo += 10000;
                ItemLedgEntry.GET(WhseItemEntryRelation."Item Entry No.");
                //Code for Getting ECMA No.
                LotNoInfo.RESET;
                LotNoInfo.SETRANGE(LotNoInfo."Item No.", PostedWhseRcptLine."Item No.");
                LotNoInfo.SETRANGE(LotNoInfo."Lot No.", ItemLedgEntry."Lot No.");
                IF LotNoInfo.FINDFIRST THEN
                    ECMANo := LotNoInfo."Certificate Number";

                TempPostedWhseRcptlLine := PostedWhseRcptLine;
                TempPostedWhseRcptlLine."Line No." := LineNo;
                TempPostedWhseRcptlLine."Serial No." := WhseItemEntryRelation."Serial No.";
                TempPostedWhseRcptlLine."Lot No." := WhseItemEntryRelation."Lot No.";
                TempPostedWhseRcptlLine."Warranty Date" := ItemLedgEntry."Warranty Date";
                TempPostedWhseRcptlLine."Expiration Date" := ItemLedgEntry."Expiration Date";
                TempPostedWhseRcptlLine."Qty. (Base)" := ItemLedgEntry.Quantity;
                VariantProdLic_Rec.RESET;
                VariantProdLic_Rec.SETRANGE(VariantProdLic_Rec."Stock Code", ItemLedgEntry."Item No.");
                VariantProdLic_Rec.SETRANGE(VariantProdLic_Rec."ECMA No.", ECMANo);
                //VariantProdLic_Rec.SETRANGE(VariantProdLic_Rec."ECMA No.",ItemLedgEntry."ECMA No."); // Commented for Upgradation
                IF VariantProdLic_Rec.FINDFIRST THEN BEGIN
                    //TempPostedWhseRcptlLine."ECMA No.":=ItemLedgEntry."ECMA No.";
                    //TempPostedWhseRcptlLine."ECMA Status":=TempPostedWhseRcptlLine."ECMA Status"::Avaliable;
                END
                ELSE BEGIN
                    // TempPostedWhseRcptlLine."ECMA No.":=ItemLedgEntry."ECMA No.";
                    // TempPostedWhseRcptlLine."ECMA Status":=TempPostedWhseRcptlLine."ECMA Status"::"Not Avaliable";
                END;
                TempPostedWhseRcptlLine.Quantity :=
                  ROUND(TempPostedWhseRcptlLine."Qty. (Base)" / TempPostedWhseRcptlLine."Qty. per Unit of Measure", 0.00001);
                IF WhseSNRequired THEN BEGIN
                    IF CrossDockQty < PostedWhseRcptLine."Qty. Cross-Docked" THEN BEGIN
                        TempPostedWhseRcptlLine."Qty. Cross-Docked" := TempPostedWhseRcptlLine.Quantity;
                        TempPostedWhseRcptlLine."Qty. Cross-Docked (Base)" := TempPostedWhseRcptlLine."Qty. (Base)";
                    END ELSE BEGIN
                        TempPostedWhseRcptlLine."Qty. Cross-Docked" := 0;
                        TempPostedWhseRcptlLine."Qty. Cross-Docked (Base)" := 0;
                    END;
                    CrossDockQty := CrossDockQty + TempPostedWhseRcptlLine.Quantity;
                END ELSE BEGIN
                    IF PostedWhseRcptLine."Qty. Cross-Docked" > 0 THEN BEGIN
                        IF TempPostedWhseRcptlLine.Quantity <=
                           PostedWhseRcptLine."Qty. Cross-Docked" - CrossDockQty
                        THEN BEGIN
                            TempPostedWhseRcptlLine."Qty. Cross-Docked" := TempPostedWhseRcptlLine.Quantity;
                            TempPostedWhseRcptlLine."Qty. Cross-Docked (Base)" := TempPostedWhseRcptlLine."Qty. (Base)";
                        END ELSE BEGIN
                            TempPostedWhseRcptlLine."Qty. Cross-Docked" := PostedWhseRcptLine."Qty. Cross-Docked" - CrossDockQty;
                            TempPostedWhseRcptlLine."Qty. Cross-Docked (Base)" :=
                              PostedWhseRcptLine."Qty. Cross-Docked (Base)" - CrossDockQtyBase;
                        END;
                        CrossDockQty := CrossDockQty + TempPostedWhseRcptlLine."Qty. Cross-Docked";
                        CrossDockQtyBase := CrossDockQtyBase + TempPostedWhseRcptlLine."Qty. Cross-Docked (Base)";
                        IF CrossDockQty >= PostedWhseRcptLine."Qty. Cross-Docked" THEN BEGIN
                            PostedWhseRcptLine."Qty. Cross-Docked" := 0;
                            PostedWhseRcptLine."Qty. Cross-Docked (Base)" := 0;
                        END;
                    END;
                END;
                TempPostedWhseRcptlLine.INSERT;
            UNTIL WhseItemEntryRelation.NEXT = 0;
        END ELSE BEGIN
            TempPostedWhseRcptlLine := PostedWhseRcptLine;
            TempPostedWhseRcptlLine.INSERT;
        END
    end;

    procedure CreateEntryForStockOnHold(var WarehouseActLine: Record 5767)
    var
        WarehouseEntry: Record 7312;
        ProdStockonholdRec: Record 50014;
        ProdLicHeader: Record 50008;
        RegWhseActivityHdr: Record 5772;
        PostedPurchasOrder: Record 120;
        PurchRcptLine: Record 121;
    begin
        IF WarehouseActLine."Stock On Hold" = TRUE THEN BEGIN
            RegWhseActivityHdr.RESET;
            RegWhseActivityHdr.SETRANGE(RegWhseActivityHdr.Type, RegWhseActivityHdr.Type::"Put-away");
            RegWhseActivityHdr.SETRANGE(RegWhseActivityHdr."Location Code", WarehouseActLine."Location Code");
            RegWhseActivityHdr.SETRANGE(RegWhseActivityHdr."Whse. Activity No.", WarehouseActLine."No.");
            IF RegWhseActivityHdr.FINDFIRST THEN BEGIN
                WarehouseEntry.RESET;
                WarehouseEntry.SETRANGE(WarehouseEntry."Location Code", WarehouseActLine."Location Code");
                WarehouseEntry.SETRANGE(WarehouseEntry."Zone Code", WarehouseActLine."Zone Code");
                WarehouseEntry.SETRANGE(WarehouseEntry."Bin Code", WarehouseActLine."Bin Code");
                WarehouseEntry.SETRANGE(WarehouseEntry."Item No.", WarehouseActLine."Item No.");
                WarehouseEntry.SETRANGE(WarehouseEntry."Source Type", WarehouseActLine."Source Type");
                WarehouseEntry.SETRANGE(WarehouseEntry."Source Subtype", WarehouseActLine."Source Subtype");
                WarehouseEntry.SETRANGE(WarehouseEntry."Source No.", WarehouseActLine."Source No.");
                WarehouseEntry.SETRANGE(WarehouseEntry."Source Line No.", WarehouseActLine."Source Line No.");
                WarehouseEntry.SETRANGE(WarehouseEntry."Whse. Document No.", WarehouseActLine."Whse. Document No.");
                WarehouseEntry.SETRANGE(WarehouseEntry."Whse. Document Type", WarehouseActLine."Whse. Document Type");
                WarehouseEntry.SETRANGE(WarehouseEntry."Whse. Document Line No.", WarehouseActLine."Whse. Document Line No.");
                WarehouseEntry.SETRANGE(WarehouseEntry."Entry Type", WarehouseEntry."Entry Type"::Movement);
                WarehouseEntry.SETRANGE(WarehouseEntry."Reference Document", WarehouseEntry."Reference Document"::"Put-away");
                WarehouseEntry.SETRANGE(WarehouseEntry."Reference No.", RegWhseActivityHdr."No.");
                IF WarehouseEntry.FINDFIRST THEN BEGIN

                    PurchRcptLine.RESET;
                    PurchRcptLine.SETRANGE(PurchRcptLine."Document No.", RegWhseActivityHdr."No.");
                    PurchRcptLine.SETRANGE(PurchRcptLine.Type, PurchRcptLine.Type::Item);
                    PurchRcptLine.SETRANGE(PurchRcptLine."No.", WarehouseActLine."Item No.");
                    PurchRcptLine.SETRANGE(PurchRcptLine."Location Code", WarehouseActLine."Location Code");
                    IF PurchRcptLine.FINDFIRST THEN BEGIN
                        CreateStockOnHold(WarehouseEntry."Item No.", WarehouseActLine."ECMA No.", WarehouseEntry."Source No.",
                       WarehouseEntry."Whse. Document No.", WarehouseEntry."Whse. Document Line No."
                       , WarehouseEntry."Location Code", WarehouseEntry."Lot No."
                       , WarehouseEntry."Source Line No.", WarehouseEntry."Entry No.", WarehouseEntry."Bin Code", WarehouseEntry."Zone Code"
                       , 0, WarehouseEntry."Reference No.", 0D, 0D, PurchRcptLine."PL No.");
                    END;
                END;
            END;
        END;
    end;

    procedure CreateStockOnHold("Item No.": Code[20]; "ECMA No.": Code[100]; "Source No.": Code[20]; "Whse. Document No.": Code[20]; "Whse. Document Line No.": Integer; "Location code": Code[20]; "Lot No.": Code[20]; "Source Line No.": Integer; "Entry No.": Integer; "Bin Code": Code[20]; "Zone Code": Code[20]; Type: Integer; "Posted Purchase Recipt No.": Code[20]; "Expiration Date": Date; "Posting Date": Date; "PLPINo.": Code[20])
    var
        ProdLicHeader: Record 50008;
        ProdStockonholdRec: Record 50014;
        PostedPurchasOrder: Record 120;
        Text000: Label 'Item No.: %1 \';
        ItemRec: Record 27;
        Text001: Label 'Item Desc : %2 \';
        Text002: Label 'Batch No : %3 \';
        Text003: Label 'ECMA No. %4 does not exists in our ECMA List. Do you want to notifiy RA department ?';
        PurchRcptLine: Record 121;
    // NewEcmaNoForm: Page 50028;
    begin
        ProdLicHeader.RESET;
        ProdLicHeader.SETRANGE(ProdLicHeader."PL No.", "PLPINo.");
        ProdLicHeader.SETRANGE(ProdLicHeader."Stock Code", "Item No.");
        IF ProdLicHeader.FINDFIRST THEN BEGIN
            ProdStockonholdRec.RESET;
            ProdStockonholdRec.SETRANGE(ProdStockonholdRec."PL No.", ProdLicHeader."PL No.");
            ProdStockonholdRec.SETRANGE(ProdStockonholdRec."Stock Code", "Item No.");
            ProdStockonholdRec.SETRANGE(ProdStockonholdRec."ECMA No.", "ECMA No.");
            IF NOT ProdStockonholdRec.FINDFIRST THEN BEGIN
                IF ItemRec.GET("Item No.") THEN BEGIN
                    IF CONFIRM(Text000 + Text001 + Text002 + Text003, FALSE, "Item No.", ItemRec.Description, "Lot No.", "ECMA No.") THEN //fornotcome properly
                    BEGIN
                        ProdStockonholdRec."PL No." := ProdLicHeader."PL No.";
                        ProdStockonholdRec."Stock Code" := "Item No.";
                        ProdStockonholdRec."ECMA No." := "ECMA No.";
                        ProdStockonholdRec."Purchase Order No." := "Source No.";
                        PostedPurchasOrder.RESET;
                        PostedPurchasOrder.SETRANGE(PostedPurchasOrder."Order No.", "Source No.");
                        IF PostedPurchasOrder.FINDFIRST THEN BEGIN
                            ProdStockonholdRec."Supplier Name" := PostedPurchasOrder."Buy-from Vendor Name";
                        END;
                        ProdStockonholdRec."Warehouse Receipt No." := "Whse. Document No.";
                        ProdStockonholdRec."Warehouse Receipt Line No." := "Whse. Document Line No.";
                        ProdStockonholdRec."Location Code" := "Location code";
                        ProdStockonholdRec."Posted Purchse Recipt No" := "Posted Purchase Recipt No.";
                        ProdStockonholdRec."Batch No." := "Lot No.";
                        ProdStockonholdRec."Expiration Date" := "Expiration Date";
                        ProdStockonholdRec."Posting Date" := "Posting Date";
                        ProdStockonholdRec.Status := ProdStockonholdRec.Status::"Stock on Hold";
                        //ProdStockonholdRec."Zone Code":="Zone Code";
                        //alok for stock on hold bin set
                        ProdStockonholdRec."Bin Code" := "Stock Hold on Bin";//"Bin Code"
                        ProdStockonholdRec."Warehouse Entry No." := "Entry No.";
                        ProdStockonholdRec."Source Line No." := "Source Line No.";
                        PurchRcptLine.RESET;
                        PurchRcptLine.SETRANGE(PurchRcptLine."Document No.", "Posted Purchase Recipt No.");
                        PurchRcptLine.SETRANGE(PurchRcptLine.Type, PurchRcptLine.Type::Item);
                        PurchRcptLine.SETRANGE(PurchRcptLine."No.", "Item No.");
                        PurchRcptLine.SETRANGE(PurchRcptLine."Location Code", "Location code");
                        IF PurchRcptLine.FINDFIRST THEN BEGIN
                            ProdStockonholdRec.VALIDATE(ProdStockonholdRec."Rebox/Overlabel", PurchRcptLine."Rebox/Overlabel");
                        END;
                        ProdStockonholdRec.INSERT;
                        IF Type = 1 THEN BEGIN
                            COMMIT;
                            //Commented as Page Required 50028(NewEcmaNoForm)(Request For New ECMA No.) is missing as Found in Upgradation
                            // NewEcmaNoForm.SETTABLEVIEW(ProdStockonholdRec);
                            // NewEcmaNoForm.RUNMODAL;
                        END;
                    END;
                END;
            END
            ELSE BEGIN
                ProdStockonholdRec.Status := ProdStockonholdRec.Status::"Stock on Hold";
                ProdStockonholdRec."Zone Code" := "Zone Code";
                ProdStockonholdRec."Bin Code" := "Bin Code";
                ProdStockonholdRec."Warehouse Entry No." := "Entry No.";
                ProdStockonholdRec."Source Line No." := "Source Line No.";
                ProdStockonholdRec.MODIFY();
            END;
        END;
    end;


    procedure "ChangeBin&ZoneForStockonHold"()
    var
        WMSActLine_Rec: Record 5767;
        DefualtSetup_Rec: Record 50012;
    begin
        IF DefualtSetup_Rec.GET() THEN BEGIN
            WMSActLine_Rec.RESET;
            WMSActLine_Rec.SETRANGE(WMSActLine_Rec."Stock On Hold", TRUE);
            IF WMSActLine_Rec.FINDFIRST THEN
                REPEAT
                    //WMSActLine_Rec."Zone Code":=DefualtSetup_Rec."Stock Hold on Zone";//alok
                    WMSActLine_Rec."Bin Code" := DefualtSetup_Rec."Stock Hold on Bin";
                    WMSActLine_Rec.MODIFY;
                UNTIL WMSActLine_Rec.NEXT = 0;
        END;
    end;


    procedure InsertAutoLotNoInComponentLine("Prod. Order No.": Code[20]; "Item No.": Code[20]; "Posted Receipt No.": Code[20]; "Lot No.": Code[20]; "Location Code": Code[20])
    var
        ProdOrder_Rec: Record 5405;
        Item_Rec: Record 27;
        ItemTrackingCode_Rec: Record 6502;
        ReservEntry: Record 337;
        ReservEntry1: Record 337;
        EntryNo: Integer;
        ProdOrderRtngLine: Record 5409;
        ItemLedgerEntry: Record 32;
        ProdOrderComponent: Record 5407;
        ProdOrderLine: Record 5406;
        ProdOrder_Rec1: Record 5405;
        StatusType: Integer;
        Temporderdetail: Record 50019;
    begin
        //Add by hiren for insert lotno and serial no
        ProdOrder_Rec1.RESET;
        ProdOrder_Rec1.SETRANGE(ProdOrder_Rec1."No.", "Prod. Order No.");
        IF ProdOrder_Rec1.FINDFIRST THEN BEGIN
            StatusType := ProdOrder_Rec1.Status;
        END;

        ProdOrderComponent.RESET;
        ProdOrderComponent.SETRANGE(ProdOrderComponent."Prod. Order No.", "Prod. Order No.");
        //IF Temporderdetail.FINDFIRST THEN
        IF ProdOrderComponent.FINDFIRST THEN
            REPEAT
                IF Item_Rec.GET(ProdOrderComponent."Item No.") THEN BEGIN
                    IF ItemTrackingCode_Rec.GET(Item_Rec."Item Tracking Code") THEN BEGIN
                        IF (ItemTrackingCode_Rec."Lot Manuf. Inbound Tracking" = TRUE) THEN BEGIN
                            ItemLedgerEntry.RESET;
                            ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
                            ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Document No.", "Posted Receipt No.");
                            ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Location Code", "Location Code");
                            ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item No.", "Item No.");
                            ItemLedgerEntry.SETRANGE(ItemLedgerEntry.Open, TRUE);//add by alok today
                            ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Lot No.", "Lot No.");
                            IF ItemLedgerEntry.FINDFIRST THEN
                                REPEAT
                                    EntryNo := 0;
                                    ReservEntry.RESET;
                                    IF ReservEntry.FINDLAST THEN BEGIN
                                        EntryNo := ReservEntry."Entry No." + 1;
                                    END;
                                    IF EntryNo = 0 THEN BEGIN
                                        EntryNo := 1;
                                    END;

                                    ReservEntry1.RESET;
                                    ReservEntry1.VALIDATE(ReservEntry1."Entry No.", EntryNo);
                                    ReservEntry1.VALIDATE(ReservEntry1.Positive, FALSE);
                                    ReservEntry1.VALIDATE(ReservEntry1."Item No.", ItemLedgerEntry."Item No.");
                                    ReservEntry1.VALIDATE(ReservEntry1."Location Code", ItemLedgerEntry."Location Code");
                                    ReservEntry1.VALIDATE(ReservEntry1."Qty. per Unit of Measure",
                                    ProdOrderComponent."Qty. per Unit of Measure");
                                    ReservEntry1.VALIDATE(ReservEntry1."Quantity (Base)", ItemLedgerEntry.Quantity * -1);
                                    ReservEntry1.VALIDATE(ReservEntry1."Reservation Status", ReservEntry1."Reservation Status"::Surplus);
                                    ReservEntry1.VALIDATE(ReservEntry1."Creation Date", ProdOrderComponent."Due Date" + 1);
                                    ReservEntry1.VALIDATE(ReservEntry1."Source Type", 5407);
                                    ReservEntry1.VALIDATE(ReservEntry1."Source Subtype", StatusType);
                                    ReservEntry1.VALIDATE(ReservEntry1."Source ID", "Prod. Order No.");
                                    ReservEntry1.VALIDATE(ReservEntry1."Source Prod. Order Line",
                                    ProdOrderComponent."Prod. Order Line No.");
                                    ReservEntry1.VALIDATE(ReservEntry1."Source Ref. No.", ProdOrderComponent."Line No.");
                                    //ReservEntry1.VALIDATE(ReservEntry1."Created By",DATABASE.USERID);
                                    ReservEntry1."Created By" := DATABASE.USERID;
                                    //ReservEntry1.VALIDATE(ReservEntry1."ECMA No.",ItemLedgerEntry."ECMA No."); //Commented for Upgradation
                                    ReservEntry1.VALIDATE(ReservEntry1."Lot No.", ItemLedgerEntry."Lot No.");
                                    ReservEntry1.VALIDATE(ReservEntry1."Serial No.", ItemLedgerEntry."Serial No.");
                                    ReservEntry1.VALIDATE(ReservEntry1."Expiration Date", ItemLedgerEntry."Expiration Date");
                                    ReservEntry1.VALIDATE(ReservEntry1."Item Tracking", ReservEntry1."Item Tracking"::"Lot and Serial No.");
                                    ReservEntry1.INSERT(TRUE);
                                UNTIL ItemLedgerEntry.NEXT = 0;

                        END;
                    END;
                END;
            UNTIL ProdOrderComponent.NEXT = 0;
    end;


    procedure InsertAutoLotNoInOut("Prod. Order No.": Code[20]; "Item No.": Code[20]; "Variant Code": Code[20]; "Posting Date": Date; "Journal Template Name": Code[20]; "Journal Batch Name": Code[20]; "Line No.": Integer; OutPutQty: Decimal; "Operation No.": Code[20])
    var
        ProdOrder_Rec: Record 5405;
        Item_Rec: Record 27;
        ItemTrackingCode_Rec: Record 6502;
        ReservEntry: Record 337;
        ReservEntry1: Record 337;
        EntryNo: Integer;
        ProdOrderRtngLine: Record 5409;
        ItemLedgerEntry: Record 32;
        ProdOrderComponent: Record 5407;
        ProdOrderLine: Record 5406;
        ReservEntry2: Record 337;
        ProdOrder_Rec1: Record 5405;
        StatusType: Integer;
        TempQTy: Decimal;
        ProdOrderRoutingLine: Record 5409;
        ReservationEntry4: Record 337;
        Tempproductdetail: Record 50019;
    begin
        //Add by hiren for insert lotno and serial no
        //-----------------------------------------------
        ProdOrder_Rec1.RESET;
        ProdOrder_Rec1.SETRANGE(ProdOrder_Rec1."No.", "Prod. Order No.");
        ProdOrder_Rec1.SETRANGE(ProdOrder_Rec1."PLPI Item Code", TRUE);
        //Tempproductdetail.SETRANGE(Tempproductdetail."Production Order No.","Prod. Order No.");
        //Tempproductdetail.SETRANGE(Tempproductdetail."Production Order No.","Prod. Order No.");
        //IF Tempproductdetail.FINDFIRST THEN
        ProdOrder_Rec1.SETRANGE(ProdOrder_Rec1."PLPI Item Code", TRUE);
        IF ProdOrder_Rec1.FINDFIRST THEN BEGIN
            StatusType := ProdOrder_Rec1.Status;
            ProdOrderLine.RESET;
            ProdOrderLine.SETRANGE(ProdOrderLine."Prod. Order No.", "Prod. Order No.");
            IF ProdOrderLine.FINDFIRST THEN
                REPEAT
                    ProdOrderRoutingLine.RESET;
                    IF ProdOrderRoutingLine.GET(ProdOrder_Rec1.Status, "Prod. Order No.", ProdOrderLine."Line No.",
                    ProdOrderLine."Routing No.", "Operation No.") THEN BEGIN
                        IF ProdOrderRoutingLine."Next Operation No." = '' THEN BEGIN
                            IF Item_Rec.GET(ProdOrderLine."Item No.") THEN BEGIN
                                IF ItemTrackingCode_Rec.GET(Item_Rec."Item Tracking Code") THEN BEGIN
                                    IF (ItemTrackingCode_Rec."Lot Manuf. Outbound Tracking" = TRUE) THEN BEGIN
                                        ItemLedgerEntry.RESET;
                                        /*ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Entry Type",ItemLedgerEntry."Entry Type"::Purchase);
                                        ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Document No.","Prod. Order No.");
                                        ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Prod. Order No.","Prod. Order No.");
                                        ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Location Code",ProdOrder_Rec1."Location Code");
                                        ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item No.","Item No.");
                                        ItemLedgerEntry.SETRANGE(ItemLedgerEntry.Open,FALSE);
                                        ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Lot No.",ProdOrder_Rec1."Lot No.");*/

                                        ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
                                        ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Document No.", ProdOrder_Rec1."Posted Receipt No.");
                                        ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Location Code", ProdOrder_Rec1."Location Code");
                                        ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item No.", "Item No.");
                                        ItemLedgerEntry.SETRANGE(ItemLedgerEntry.Open, TRUE);
                                        ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Lot No.", ProdOrder_Rec1."Lot No.");

                                        IF ItemLedgerEntry.FINDFIRST THEN
                                            REPEAT
                                                EntryNo := 0;
                                                ReservEntry.RESET;
                                                IF ReservEntry.FINDLAST THEN BEGIN
                                                    EntryNo := ReservEntry."Entry No." + 1;
                                                END;
                                                IF EntryNo = 0 THEN BEGIN
                                                    EntryNo := 1;
                                                END;
                                                IF OutPutQty <> 0 THEN BEGIN

                                                    IF OutPutQty >= ItemLedgerEntry.Quantity THEN BEGIN
                                                        TempQTy := ItemLedgerEntry.Quantity;
                                                        OutPutQty := OutPutQty - ItemLedgerEntry.Quantity;
                                                    END ELSE BEGIN
                                                        TempQTy := OutPutQty;
                                                        OutPutQty := 0;
                                                    END;

                                                    ReservEntry1.INIT;
                                                    ReservEntry1.VALIDATE(ReservEntry1."Entry No.", EntryNo);
                                                    ReservEntry1.VALIDATE(ReservEntry1.Positive, TRUE);
                                                    ReservEntry1.VALIDATE(ReservEntry1."Item No.", ItemLedgerEntry."Item No.");
                                                    ReservEntry1.VALIDATE(ReservEntry1."Variant Code", "Variant Code");
                                                    ReservEntry1.VALIDATE(ReservEntry1."Location Code", ItemLedgerEntry."Location Code");
                                                    //ReservEntry1.VALIDATE(ReservEntry1."Qty. per Unit of Measure",
                                                    //ProdOrderLine."Qty. per Unit of Measure");
                                                    ReservEntry1.VALIDATE(ReservEntry1."Quantity (Base)", TempQTy);
                                                    //ReservEntry1.VALIDATE(ReservEntry1."Quantity (Base)",OutPutQty);
                                                    ReservEntry1.VALIDATE(ReservEntry1."Reservation Status", ReservEntry1."Reservation Status"::Prospect);
                                                    ReservEntry1.VALIDATE(ReservEntry1."Creation Date", "Posting Date");
                                                    ReservEntry1.VALIDATE(ReservEntry1."Source Type", 83);
                                                    ReservEntry1.VALIDATE(ReservEntry1."Source Subtype", 6);
                                                    ReservEntry1.VALIDATE(ReservEntry1."Source ID", "Journal Template Name");
                                                    ReservEntry1.VALIDATE(ReservEntry1."Source Batch Name", "Journal Batch Name");
                                                    ReservEntry1.VALIDATE(ReservEntry1."Source Ref. No.", "Line No.");
                                                    //ReservEntry1.VALIDATE(ReservEntry1."Created By",DATABASE.USERID);
                                                    ReservEntry1."Created By" := DATABASE.USERID;
                                                    //ReservEntry1.VALIDATE(ReservEntry1."ECMA No.",ItemLedgerEntry."ECMA No.");  //Commented for Upgradation
                                                    //ReservEntry1.VALIDATE(ReservEntry1."Serial No.",ItemLedgerEntry."Serial No.");
                                                    //alok for adding sufix on lot no in output jounral
                                                    ReservEntry1.VALIDATE(ReservEntry1."Lot No.", (ItemLedgerEntry."Lot No." +
                                                                          DELSTR("Process Batch no. Sufix", 1, 1)));
                                                    ReservEntry1.VALIDATE(ReservEntry1."Expected Receipt Date", "Posting Date");
                                                    ReservEntry1.VALIDATE(ReservEntry1."Expiration Date", ItemLedgerEntry."Expiration Date");
                                                    //Tempproductdetail."Expire Date");
                                                    ReservEntry1.VALIDATE(ReservEntry1."Item Tracking", ReservEntry1."Item Tracking"::"Lot No.");
                                                    ReservEntry1.INSERT(TRUE);
                                                END ELSE BEGIN
                                                    EXIT;
                                                END;
                                            UNTIL ItemLedgerEntry.NEXT = 0;
                                    END;
                                END;
                            END;
                        END;
                    END;
                UNTIL ProdOrderLine.NEXT = 0;
            //-------------------------------------------------
        END;

    end;

    procedure CreNewECMAFromProd(ProdctionOrder: Record 5405)
    var
        ProdLicHeader: Record 50008;
        ProdStockonholdRec: Record 50014;
        PostedPurchasOrder: Record 120;
        ProdVarLicRec: Record 50010;
    begin
        ProdVarLicRec.RESET;
        IF NOT ProdVarLicRec.GET(ProdctionOrder."PLPI No.", ProdctionOrder."Source No.", ProdctionOrder."ECMA No.",
        ProdctionOrder."BPR Version No.") THEN BEGIN
            CreateStockOnHold(ProdctionOrder."Source No.", ProdctionOrder."ECMA No.", ProdctionOrder."Purchase order",
            ProdctionOrder."Posted Warehouse Receipt No.", 0, ProdctionOrder."Location Code", ProdctionOrder."Lot No.", 0, 0,
            ProdctionOrder."Bin Code", '', 1, ProdctionOrder."Posted Receipt No.", ProdctionOrder."Expriy Date", ProdctionOrder."Starting Date",
            ProdctionOrder."PLPI No.");
        END;
    end;

    procedure CreateCompMail(ProdOrder: Code[20])
    var
        ProductionOrder: Record 5405;
        // SendMail: Codeunit 397;
        Email: codeunit Email;
        EmailMessage: codeunit "Email Message";
        DefaultSetupRec: Record 50012;
        CText: Text[100];
        CText1: Text[100];
        CText2: Text[100];
        CText3: Text[100];
        CText4: Text[100];
        CText5: Text[100];
        CSubject: Text[100];
        ProductionComp: Record 5407;
        ItemRec: Record 27;
        ProdLicRec: Record 50008;
        CCMail: Code[20];
        CText6: Text[100];
        CText7: Text[100];
        EmailType: Enum "Email Recipient Type";
    begin
        IF DefaultSetupRec.GET() THEN BEGIN
            ProductionOrder.RESET;
            ProductionOrder.SETRANGE(ProductionOrder."No.", ProdOrder);
            IF ProductionOrder.FINDFIRST THEN BEGIN
                CText := 'Pl/PI No: ' + ProductionOrder."PLPI No.";
                CText1 := 'EU Trade Name : ' + ProdLicRec."EU Trade";
                CText2 := 'Strength : ' + ProdLicRec.Strength;
                CText3 := 'Pack Size : ' + ProdLicRec."Pack Size";
                CText5 := 'Production BOM : ' + ProductionOrder."Production BOM No.";
                CText6 := 'Batch No : ' + ProductionOrder."Lot No.";


                EmailMessage.AppendToBody(CText);
                EmailMessage.AppendToBody(CText1);
                EmailMessage.AppendToBody(CText2);
                EmailMessage.AppendToBody(CText3);
                EmailMessage.AppendToBody(CText5);
                EmailMessage.AppendToBody(CText6);

                CSubject := 'Component Issue For Job No. : ' + ProdOrder;
                ProductionComp.RESET;
                ProductionComp.SETRANGE(ProductionComp."Prod. Order No.", ProdOrder);
                ProductionComp.SETFILTER(ProductionComp."Item No.", '<>%1', ProductionOrder."Source No.");
                IF ProductionComp.FINDFIRST THEN
                    REPEAT
                        IF ItemRec.GET(ProductionComp."Item No.") THEN BEGIN
                            IF ProdLicRec.GET(ProductionOrder."PLPI No.", ProductionOrder."Source No.") THEN BEGIN

                                CText4 := 'Item Details : ' + FORMAT(ProductionComp."Item No.") + ' / ' + ItemRec.Description;
                                CText5 := 'Required Qty : ' + FORMAT(ProductionComp."Expected Quantity");

                                EmailMessage.AppendToBody(CText4);
                                EmailMessage.AppendToBody(CText5);

                            END;
                        END;
                    UNTIL ProductionComp.NEXT = 0;
            END;
            CCMail := '';
            EmailMessage.AddRecipient(EmailType::"To", DefaultSetupRec."Issue Component User Email ID");
            EmailMessage.SetSubject(CSubject);
            Email.send(EmailMessage);

            // SendMail.NewMessage(DefaultSetupRec."Issue Component User Email ID", CCMail, CSubject, '', '', '', FALSE);
        END;
    end;

    procedure SendStckonholdECMAMail(Subject: Text[80]; ItemID: Code[20]; PONo: Code[20]; ECMANo: Code[100]; "Batch No": Code[20]; Qty: Decimal; Comment: Text[150]; "Comment 1": Text[150])
    var
        // SendMail: Codeunit 397;
        defaultSetup: Record 50012;
        Txt: Text[80];
        Txt1: Text[80];
        Txt2: Text[80];
        Txt3: Text[80];
        Txt4: Text[80];
        Txt5: Text[80];
        Item_Rec: Record 27;
        ProdLic_Rec: Record 50008;
        PurchaseOrder: Record 38;
        Vendor: Record 23;
        tomail: Text[100];
        CCMail: Text[30];
        Txt6: Text[150];
        Txt7: Text[150];
        EmailType: Enum "Email Recipient Type";
        Email: codeunit Email;
        EmailMessage: codeunit "Email Message";
    begin
        IF Item_Rec.GET(ItemID) THEN BEGIN
            Txt := 'Item Details : ' + Item_Rec."No." + ' \ ' + Item_Rec.Description;
        END;

        Txt2 := 'PO No. : ' + PONo;
        Txt3 := 'Batch No. :' + "Batch No";
        Txt4 := 'ECMA No. : ' + ECMANo;
        Txt5 := 'Qty : ' + FORMAT(Qty);
        Txt6 := Comment;
        Txt7 := "Comment 1";
        IF PurchaseOrder.GET(1, PONo) THEN BEGIN

            Txt1 := 'Vendor Details : ' + PurchaseOrder."Buy-from Vendor No." + '\ ' + PurchaseOrder."Buy-from Vendor Name";
            IF Vendor.GET(PurchaseOrder."Buy-from Vendor No.") THEN BEGIN
                tomail := Vendor."E-Mail";
            END;
        END;

        IF tomail <> '' THEN BEGIN
            EmailMessage.AppendToBody(Txt);
            EmailMessage.AppendToBody(Txt1);
            EmailMessage.AppendToBody(Txt2);
            EmailMessage.AppendToBody(Txt3);
            EmailMessage.AppendToBody(Txt4);
            EmailMessage.AppendToBody(Txt5);
            EmailMessage.AppendToBody(Txt6);
            EmailMessage.AppendToBody(Txt7);
            EmailMessage.AddRecipient(EmailType::"To", tomail);
            EmailMessage.SetSubject(Subject);
            email.Send(EmailMessage);

            // SendMail.NewMessage(tomail, CCMail, Subject, '', '', '', FALSE);
            MESSAGE('Message Sent Successfully!')
        END ELSE BEGIN
            ERROR('Email Address is not defined for this supplier');

        END;
    end;


    procedure Createputawayheader("Docno.": Code[30]; FromBin: Code[10]; ToBin: Code[10]; "Prod. Order": Record 5405; Flag: Integer)
    var
        warehouseactivityheader: Record 5766;
        AssignedID: Code[30];
    begin

        //ProdOrderLine1.SETRANGE(ProdOrderLine1.Status,ProdOrderHeader.Status);
        //ProdOrderLine1.SETRANGE(ProdOrderLine1."Prod. Order No.",ProdOrderHeader."No.");
        /*IF ProdOrderLine1.FINDFIRST THEN;
         IF warehousesetup.GET THEN BEGIN
         warehousesetup.TESTFIELD(warehousesetup."Whse. Put-away Nos.");
         NoSeriesMg.TestManual(warehousesetup."Whse. Put-away Nos.");
         END;
         OrderNo := NoSeriesMg.GetNextNo(warehousesetup."Whse. Put-away Nos.",TODAY,TRUE);
         */

        warehouseactivityheader.INIT;
        warehouseactivityheader.VALIDATE(warehouseactivityheader.Type, warehouseactivityheader.Type::"Put-away");
        warehouseactivityheader.VALIDATE(warehouseactivityheader."No.", "Docno.");
        warehouseactivityheader.VALIDATE(warehouseactivityheader."Location Code", "Prod. Order"."Location Code");
        warehouseactivityheader."No. Series" := 'WHPE';
        IF Flag <> 1 THEN
            AssignedID := Assignuser(warehouseactivityheader."Location Code");
        warehouseactivityheader.VALIDATE(warehouseactivityheader."Assigned User ID", AssignedID);
        warehouseactivityheader.INSERT(TRUE);
        CASE "Prod. Order".Status OF
            "Prod. Order".Status::Finished:
                Createputawayline_Finish(FromBin, ToBin, "Prod. Order", warehouseactivityheader);
            "Prod. Order".Status::Released:
                BEGIN
                    IF Flag = 2 THEN
                        Createputawayline_Release(FromBin, ToBin, "Prod. Order", warehouseactivityheader)
                    ELSE
                        IF Flag = 1 THEN
                            Createputawayline_jnl(FromBin, ToBin, "Prod. Order", warehouseactivityheader);
                END
        END;

    end;


    procedure Createputawayline_jnl(FromBin: Code[10]; ToBin: Code[10]; "Prod. Order": Record 5405; warehouseactivityheader: Record 5766)
    var
        Itemledgerentry: Record 32;
        warehouseactivityline: Record 5767;
        lineno: Integer;
        ProdOrderLine1: Record 5406;
        warehouseentry: Record 7312;
    begin
        ProdOrderLine1.RESET;
        ProdOrderLine1.SETRANGE(ProdOrderLine1.Status, ProdOrderLine1.Status::Released);
        ProdOrderLine1.SETRANGE(ProdOrderLine1."Prod. Order No.", "Prod. Order"."No.");
        IF ProdOrderLine1.FINDFIRST THEN;

        warehouseentry.RESET;
        warehouseentry.SETCURRENTKEY("Item No.", "Source No.", "Source Document");
        warehouseentry.SETRANGE(warehouseentry."Item No.", "Prod. Order"."Source No.");
        warehouseentry.SETRANGE(warehouseentry."Source No.", "Prod. Order"."No.");
        warehouseentry.SETRANGE(warehouseentry."Source Document", warehouseentry."Source Document"::"Output Jnl.");
        IF warehouseentry.FINDFIRST THEN BEGIN
            REPEAT
                warehouseactivityline.RESET;
                warehouseactivityline.SETRANGE(warehouseactivityline."Activity Type", warehouseactivityline."Activity Type"::"Put-away");
                warehouseactivityline.SETRANGE(warehouseactivityline."No.", warehouseactivityheader."No.");
                IF warehouseactivityline.FINDLAST THEN
                    lineno := warehouseactivityline."Line No." + 10000
                ELSE
                    lineno := 10000;
                warehouseactivityline.RESET;
                warehouseactivityline.INIT;
                warehouseactivityline.VALIDATE(warehouseactivityline."Activity Type", warehouseactivityline."Activity Type"::"Put-away");
                warehouseactivityline.VALIDATE(warehouseactivityline."No.", warehouseactivityheader."No.");
                warehouseactivityline."Source Type" := 39;
                warehouseactivityline."Source Subtype" := 1;
                warehouseactivityline."Source Document" := warehouseactivityline."Source Document"::"Prod. Consumption";
                warehouseactivityline.VALIDATE(warehouseactivityline."Location Code", warehouseentry."Location Code");
                warehouseactivityline.VALIDATE(warehouseactivityline."Source No.", ProdOrderLine1."Prod. Order No.");
                warehouseactivityline.VALIDATE(warehouseactivityline."Item No.", ProdOrderLine1."Item No.");
                warehouseactivityline.VALIDATE(warehouseactivityline.Quantity, warehouseentry.Quantity); //
                warehouseactivityline.VALIDATE(warehouseactivityline."Due Date", "Prod. Order"."Due Date");
                warehouseactivityline.VALIDATE(warehouseactivityline."Action Type", warehouseactivityline."Action Type"::Take);
                warehouseactivityline.VALIDATE(warehouseactivityline."Bin Code", warehouseentry."Bin Code");
                warehouseactivityline.VALIDATE(warehouseactivityline."Lot No.", warehouseentry."Lot No.");
                warehouseactivityline.VALIDATE(warehouseactivityline."Expiration Date", warehouseentry."Expiration Date");
                warehouseactivityline."Line No." := lineno;
                warehouseactivityline."Source Line No." := warehouseactivityline."Source Line No." + 10000;
                warehouseactivityline.VALIDATE(warehouseactivityline."Variant Code", warehouseentry."Variant Code");
                warehouseactivityline.INSERT(TRUE);
                warehouseactivityline.RESET;
                warehouseactivityline.SETRANGE(warehouseactivityline."No.", warehouseactivityheader."No.");
                IF warehouseactivityline.FINDLAST THEN
                    lineno := warehouseactivityline."Line No." + 10000
                ELSE
                    lineno := 10000;
                warehouseactivityline.RESET;
                warehouseactivityline.INIT;
                warehouseactivityline.VALIDATE(warehouseactivityline."Activity Type", warehouseactivityline."Activity Type"::"Put-away");
                warehouseactivityline.VALIDATE(warehouseactivityline."No.", warehouseactivityheader."No.");
                warehouseactivityline."Source Type" := 39;
                warehouseactivityline."Source Subtype" := 1;
                warehouseactivityline."Source Document" := warehouseactivityline."Source Document"::"Prod. Consumption";
                warehouseactivityline.VALIDATE(warehouseactivityline."Source No.", ProdOrderLine1."Prod. Order No.");
                warehouseactivityline.VALIDATE(warehouseactivityline."Item No.", ProdOrderLine1."Item No.");
                warehouseactivityline.VALIDATE(warehouseactivityline.Quantity, warehouseentry.Quantity);//
                warehouseactivityline.VALIDATE(warehouseactivityline."Due Date", "Prod. Order"."Due Date");
                warehouseactivityline.VALIDATE(warehouseactivityline."Action Type", warehouseactivityline."Action Type"::Place);
                IF Itemledgerentry."Variant Code" = '' THEN BEGIN
                    warehouseactivityline.VALIDATE(warehouseactivityline."Location Code", 'CHEMILINES');
                    warehouseactivityline.VALIDATE(warehouseactivityline."Bin Code", 'QP ');
                END
                ELSE BEGIN
                    warehouseactivityline.VALIDATE(warehouseactivityline."Location Code", 'CHEMILINES');
                    warehouseactivityline.VALIDATE(warehouseactivityline."Bin Code", 'QP');
                END;
                warehouseactivityline.VALIDATE(warehouseactivityline."Lot No.", warehouseentry."Lot No.");
                warehouseactivityline.VALIDATE(warehouseactivityline."Expiration Date", warehouseentry."Expiration Date");
                warehouseactivityline."Line No." := lineno;
                warehouseactivityline."Source Line No." := warehouseactivityline."Source Line No." + 10000;
                warehouseactivityline.VALIDATE(warehouseactivityline."Variant Code", warehouseentry."Variant Code");

                warehouseactivityline.INSERT(TRUE);
            UNTIL warehouseentry.NEXT = 0;
        END;
        //Createputaway_variant("Prod. Order");
    end;

    procedure Assignuser(Loc: Code[10]) CUser: Code[30]
    var
        WarHosEmp: Record 7301;
        NoPickAssign: Integer;
    begin
        WarHosEmp.RESET;
        WarHosEmp.SETFILTER(WarHosEmp."Assign To Put away", '=%1', TRUE);
        WarHosEmp.SETFILTER(WarHosEmp."Location Code", Loc);
        IF WarHosEmp.FINDFIRST THEN BEGIN
            CUser := WarHosEmp."User ID";
            WarHosEmp.CALCFIELDS(WarHosEmp."No of putaway Assigned");
            NoPickAssign := WarHosEmp."No of putaway Assigned";
            WarHosEmp.NEXT(1);
            REPEAT
                WarHosEmp.CALCFIELDS(WarHosEmp."No of putaway Assigned");
                IF NoPickAssign <= WarHosEmp."No of putaway Assigned" THEN
                    CUser := CUser
                ELSE
                    IF NoPickAssign > WarHosEmp."No of putaway Assigned" THEN BEGIN
                        CUser := WarHosEmp."User ID";
                        NoPickAssign := WarHosEmp."No of putaway Assigned"
                    END
            UNTIL WarHosEmp.NEXT = 0
        END;
    end;


    procedure Createputawayline_Release(FromBin: Code[10]; ToBin: Code[10]; "Prod. Order": Record 5405; warehouseactivityheader: Record 5766)
    var
        Itemledgerentry: Record 32;
        warehouseactivityline: Record 5767;
        lineno: Integer;
        ProdOrderLine1: Record 5406;
        Prodordercompo: Record 5407;
    begin
        ProdOrderLine1.SETRANGE(ProdOrderLine1.Status, ProdOrderLine1.Status::Released);
        ProdOrderLine1.SETRANGE(ProdOrderLine1."Prod. Order No.", "Prod. Order"."No.");
        IF ProdOrderLine1.FINDFIRST THEN;
        warehouseactivityheader.VALIDATE(warehouseactivityheader."Assigned User ID", 'CHEMILINES\MILLY.SELVARTNAM');
        warehouseactivityheader.MODIFY(TRUE);
        warehouseactivityline.RESET;
        warehouseactivityline.SETRANGE(warehouseactivityline."Activity Type", warehouseactivityline."Activity Type"::"Put-away");
        warehouseactivityline.SETRANGE(warehouseactivityline."No.", warehouseactivityheader."No.");
        IF warehouseactivityline.FINDLAST THEN
            lineno := warehouseactivityline."Line No." + 10000
        ELSE
            lineno := 10000;
        warehouseactivityline.RESET;
        warehouseactivityline.INIT;
        warehouseactivityline.VALIDATE(warehouseactivityline."Activity Type", warehouseactivityline."Activity Type"::"Put-away");
        warehouseactivityline.VALIDATE(warehouseactivityline."No.", warehouseactivityheader."No.");
        warehouseactivityline."Source Type" := 39;
        warehouseactivityline."Source Subtype" := 1;
        warehouseactivityline."Source Document" := warehouseactivityline."Source Document"::"Prod. Consumption";
        warehouseactivityline.VALIDATE(warehouseactivityline."Location Code", ProdOrderLine1."Location Code");
        warehouseactivityline.VALIDATE(warehouseactivityline."Source No.", ProdOrderLine1."Prod. Order No.");
        warehouseactivityline.VALIDATE(warehouseactivityline."Item No.", ProdOrderLine1."Item No.");
        warehouseactivityline.VALIDATE(warehouseactivityline.Quantity, ProdOrderLine1.Quantity); //
        warehouseactivityline.VALIDATE(warehouseactivityline."Due Date", "Prod. Order"."Due Date");
        warehouseactivityline.VALIDATE(warehouseactivityline."Action Type", warehouseactivityline."Action Type"::Take);
        warehouseactivityline.VALIDATE(warehouseactivityline."Bin Code", ProdOrderLine1."Bin Code");
        warehouseactivityline.VALIDATE(warehouseactivityline."Lot No.", "Prod. Order"."Lot No.");
        warehouseactivityline.VALIDATE(warehouseactivityline."Expiration Date", "Prod. Order"."Expriy Date");
        warehouseactivityline."Put away Ceated From" := warehouseactivityline."Put away Ceated From"::"From FIrm Plan";
        warehouseactivityline."Line No." := lineno;
        warehouseactivityline."Source Line No." := warehouseactivityline."Source Line No." + 10000;
        warehouseactivityline.INSERT(TRUE);
        warehouseactivityline.RESET;
        warehouseactivityline.SETRANGE(warehouseactivityline."No.", warehouseactivityheader."No.");
        IF warehouseactivityline.FINDLAST THEN
            lineno := warehouseactivityline."Line No." + 10000
        ELSE
            lineno := 10000;
        warehouseactivityline.RESET;
        warehouseactivityline.INIT;
        warehouseactivityline.VALIDATE(warehouseactivityline."Activity Type", warehouseactivityline."Activity Type"::"Put-away");
        warehouseactivityline.VALIDATE(warehouseactivityline."No.", warehouseactivityheader."No.");
        warehouseactivityline."Source Type" := 39;
        warehouseactivityline."Source Subtype" := 1;
        warehouseactivityline."Source Document" := warehouseactivityline."Source Document"::"Prod. Consumption";

        warehouseactivityline.VALIDATE(warehouseactivityline."Source No.", ProdOrderLine1."Prod. Order No.");
        warehouseactivityline.VALIDATE(warehouseactivityline."Item No.", ProdOrderLine1."Item No.");
        warehouseactivityline.VALIDATE(warehouseactivityline.Quantity, ProdOrderLine1.Quantity);//
        warehouseactivityline.VALIDATE(warehouseactivityline."Due Date", "Prod. Order"."Due Date");
        warehouseactivityline.VALIDATE(warehouseactivityline."Action Type", warehouseactivityline."Action Type"::Place);
        //IF Itemledgerentry."Variant Code"='' THEN  BEGIN
        warehouseactivityline.VALIDATE(warehouseactivityline."Location Code", 'Chemilines');
        warehouseactivityline.VALIDATE(warehouseactivityline."Bin Code", ToBin);
        //END
        /*ELSE  BEGIN
          warehouseactivityline.VALIDATE(warehouseactivityline."Location Code",'SAMPLE');
          warehouseactivityline.VALIDATE(warehouseactivityline."Bin Code",'R-SAMPLE');
        END; */
        warehouseactivityline.VALIDATE(warehouseactivityline."Lot No.", "Prod. Order"."Lot No.");
        warehouseactivityline.VALIDATE(warehouseactivityline."Expiration Date", "Prod. Order"."Expriy Date");
        warehouseactivityline."Line No." := lineno;
        warehouseactivityline."Source Line No." := warehouseactivityline."Source Line No." + 10000;
        warehouseactivityline."Put away Ceated From" := warehouseactivityline."Put away Ceated From"::"From FIrm Plan";
        warehouseactivityline.INSERT(TRUE);
        //for components
        /*
        Prodordercompo.SETRANGE("Prod. Order No.","Prod. Order"."No.");
        Prodordercompo.SETRANGE(Status,Prodordercompo.Status::Released);
        Prodordercompo.SETFILTER(
          "Flushing Method",'%1|%2|%3',
          Prodordercompo."Flushing Method"::Manual,
          Prodordercompo."Flushing Method"::"Pick + Forward",
          Prodordercompo."Flushing Method"::"Pick + Backward");
        Prodordercompo.SETRANGE("Planning Level Code",0);
        Prodordercompo.SETFILTER("Expected Quantity",'>0');
        Prodordercompo.SETFILTER(Prodordercompo."Item No.",'<>%1',"Prod. Order"."Source No.");
        IF Prodordercompo.FINDFIRST THEN
         REPEAT
          warehouseactivityline.RESET;
          warehouseactivityline.SETRANGE(warehouseactivityline."No.",warehouseactivityheader."No.");
          IF warehouseactivityline.FINDLAST THEN
            lineno:=warehouseactivityline."Line No."+10000
          ELSE
            lineno:=10000;
        
            warehouseactivityline.RESET;
            warehouseactivityline.INIT;
            warehouseactivityline.VALIDATE(warehouseactivityline."Activity Type",warehouseactivityline."Activity Type"::"Put-away");
            warehouseactivityline.VALIDATE(warehouseactivityline."No.",warehouseactivityheader."No.");
            warehouseactivityline."Source Type":=39;
            warehouseactivityline."Source Subtype":=1;
            warehouseactivityline."Source Document":=warehouseactivityline."Source Document"::"Prod. Consumption";
            warehouseactivityline.VALIDATE(warehouseactivityline."Location Code",Prodordercompo."Location Code");
            warehouseactivityline.VALIDATE(warehouseactivityline."Source No.",ProdOrderLine1."Prod. Order No.");
            warehouseactivityline.VALIDATE(warehouseactivityline."Item No.",Prodordercompo."Item No.");
            warehouseactivityline.VALIDATE(warehouseactivityline.Quantity,Prodordercompo."Expected Quantity");
            warehouseactivityline.VALIDATE(warehouseactivityline."Due Date","Prod. Order"."Due Date");
            warehouseactivityline.VALIDATE(warehouseactivityline."Action Type",warehouseactivityline."Action Type"::Take);
            warehouseactivityline.VALIDATE(warehouseactivityline."Bin Code",Prodordercompo."Bin Code");
            //warehouseactivityline.VALIDATE(warehouseactivityline."Lot No.","Production Order"."Lot No.");
            //warehouseactivityline.VALIDATE(warehouseactivityline."Expiration Date","Expriy Date");
            warehouseactivityline."Put away Ceated From":=warehouseactivityline."Put away Ceated From"::"From Firm Plan";
        
            warehouseactivityline."Line No.":=lineno;
            warehouseactivityline."Source Line No.":=warehouseactivityline."Source Line No."+10000;
            warehouseactivityline.INSERT(TRUE);
        
            warehouseactivityline.RESET;
            warehouseactivityline.SETRANGE(warehouseactivityline."No.",warehouseactivityheader."No.");
            IF warehouseactivityline.FINDLAST THEN
               lineno:=warehouseactivityline."Line No."+10000
            ELSE
               lineno:=10000;
        
            warehouseactivityline.RESET;
            warehouseactivityline.INIT;
            warehouseactivityline.VALIDATE(warehouseactivityline."Activity Type",warehouseactivityline."Activity Type"::"Put-away");
            warehouseactivityline.VALIDATE(warehouseactivityline."No.",warehouseactivityheader."No.");
            warehouseactivityline."Source Type":=39;
            warehouseactivityline."Source Subtype":=1;
            warehouseactivityline."Source Document":=warehouseactivityline."Source Document"::"Prod. Consumption";
            warehouseactivityline.VALIDATE(warehouseactivityline."Location Code",Prodordercompo."Location Code");
            warehouseactivityline.VALIDATE(warehouseactivityline."Source No.",ProdOrderLine1."Prod. Order No.");
            warehouseactivityline.VALIDATE(warehouseactivityline."Item No.",Prodordercompo."Item No.");
            warehouseactivityline.VALIDATE(warehouseactivityline.Quantity,Prodordercompo."Expected Quantity");
            warehouseactivityline.VALIDATE(warehouseactivityline."Due Date","Prod. Order"."Due Date");
            warehouseactivityline.VALIDATE(warehouseactivityline."Action Type",warehouseactivityline."Action Type"::Place);
            warehouseactivityline.VALIDATE(warehouseactivityline."Bin Code",'');
            //warehouseactivityline.VALIDATE(warehouseactivityline."Lot No.",ProdOrderHeader."Lot No.");
           // warehouseactivityline.VALIDATE(warehouseactivityline."Expiration Date","Expriy Date");
           warehouseactivityline."Put away Ceated From":=warehouseactivityline."Put away Ceated From"::"From Firm Plan";
        
            warehouseactivityline."Line No.":=lineno;
            warehouseactivityline."Source Line No.":=warehouseactivityline."Source Line No."+10000;
            warehouseactivityline.INSERT(TRUE);
        UNTIL Prodordercompo.NEXT=0;
         */

    end;

    procedure Createputaway_variant("Prod.order": Record 5405; FromBin: Code[20])
    var
        warehouseactivityheader: Record 5766;
        Itemledgerentry: Record 32;
        ProdOrderLine1: Record 5406;
        warehouseactivityline: Record 5767;
        lineno: Integer;
    begin
        warehouseactivityheader.INIT;
        warehouseactivityheader.VALIDATE(warehouseactivityheader.Type, warehouseactivityheader.Type::"Put-away");
        warehouseactivityheader.VALIDATE(warehouseactivityheader."No.", "Prod.order"."No." + 'QP>SAMP');
        warehouseactivityheader.VALIDATE(warehouseactivityheader."Location Code", "Prod.order"."Location Code");
        warehouseactivityheader."No. Series" := 'WHPE';
        warehouseactivityheader."For Sample" := TRUE;
        warehouseactivityheader.INSERT(TRUE);


        ProdOrderLine1.RESET;
        ProdOrderLine1.SETRANGE(ProdOrderLine1.Status, ProdOrderLine1.Status::Finished);
        ProdOrderLine1.SETRANGE(ProdOrderLine1."Prod. Order No.", "Prod.order"."No.");
        IF ProdOrderLine1.FINDFIRST THEN;

        Itemledgerentry.RESET;
        Itemledgerentry.SETRANGE(Itemledgerentry."Document No.", "Prod.order"."No.");
        Itemledgerentry.SETRANGE(Itemledgerentry."Entry Type", Itemledgerentry."Entry Type"::Output);
        Itemledgerentry.SETFILTER(Itemledgerentry."Variant Code", '<>%1', '');
        Itemledgerentry.SETRANGE(Itemledgerentry."Item No.", ProdOrderLine1."Item No.");
        IF Itemledgerentry.FINDFIRST THEN BEGIN
            REPEAT
                warehouseactivityline.RESET;
                warehouseactivityline.SETRANGE(warehouseactivityline."Activity Type", warehouseactivityline."Activity Type"::"Put-away");
                warehouseactivityline.SETRANGE(warehouseactivityline."No.", warehouseactivityheader."No.");
                IF warehouseactivityline.FINDLAST THEN
                    lineno := warehouseactivityline."Line No." + 10000
                ELSE
                    lineno := 10000;
                warehouseactivityline.RESET;
                warehouseactivityline.INIT;
                warehouseactivityline.VALIDATE(warehouseactivityline."Activity Type", warehouseactivityline."Activity Type"::"Put-away");
                warehouseactivityline.VALIDATE(warehouseactivityline."No.", warehouseactivityheader."No.");
                warehouseactivityline."Source Type" := 39;
                warehouseactivityline."Source Subtype" := 1;
                warehouseactivityline."Source Document" := warehouseactivityline."Source Document"::"Prod. Consumption";
                warehouseactivityline.VALIDATE(warehouseactivityline."Location Code", Itemledgerentry."Location Code");
                warehouseactivityline.VALIDATE(warehouseactivityline."Source No.", ProdOrderLine1."Prod. Order No.");
                warehouseactivityline.VALIDATE(warehouseactivityline."Item No.", ProdOrderLine1."Item No.");
                warehouseactivityline.VALIDATE(warehouseactivityline.Quantity, Itemledgerentry.Quantity); //
                warehouseactivityline.VALIDATE(warehouseactivityline."Due Date", "Prod.order"."Due Date");
                warehouseactivityline.VALIDATE(warehouseactivityline."Action Type", warehouseactivityline."Action Type"::Take);
                warehouseactivityline.VALIDATE(warehouseactivityline."Bin Code", FromBin);
                warehouseactivityline.VALIDATE(warehouseactivityline."Lot No.", Itemledgerentry."Lot No.");
                warehouseactivityline.VALIDATE(warehouseactivityline."Process Status", TRUE);
                warehouseactivityline.VALIDATE(warehouseactivityline."Expiration Date", Itemledgerentry."Expiration Date");
                warehouseactivityline.VALIDATE(warehouseactivityline."Variant Code", Itemledgerentry."Variant Code");

                warehouseactivityline."Line No." := lineno;
                warehouseactivityline."Source Line No." := warehouseactivityline."Source Line No." + 10000;
                warehouseactivityline.INSERT(TRUE);
                warehouseactivityline.RESET;
                warehouseactivityline.SETRANGE(warehouseactivityline."No.", warehouseactivityheader."No.");
                IF warehouseactivityline.FINDLAST THEN
                    lineno := warehouseactivityline."Line No." + 10000
                ELSE
                    lineno := 10000;
                warehouseactivityline.RESET;
                warehouseactivityline.INIT;
                warehouseactivityline.VALIDATE(warehouseactivityline."Activity Type", warehouseactivityline."Activity Type"::"Put-away");
                warehouseactivityline.VALIDATE(warehouseactivityline."No.", warehouseactivityheader."No.");
                warehouseactivityline."Source Type" := 39;
                warehouseactivityline."Source Subtype" := 1;
                warehouseactivityline."Source Document" := warehouseactivityline."Source Document"::"Prod. Consumption";
                warehouseactivityline.VALIDATE(warehouseactivityline."Process Status", TRUE);
                warehouseactivityline.VALIDATE(warehouseactivityline."Source No.", ProdOrderLine1."Prod. Order No.");
                warehouseactivityline.VALIDATE(warehouseactivityline."Item No.", ProdOrderLine1."Item No.");
                warehouseactivityline.VALIDATE(warehouseactivityline.Quantity, Itemledgerentry.Quantity);//
                warehouseactivityline.VALIDATE(warehouseactivityline."Due Date", "Prod.order"."Due Date");
                warehouseactivityline.VALIDATE(warehouseactivityline."Action Type", warehouseactivityline."Action Type"::Place);
                warehouseactivityline.VALIDATE(warehouseactivityline."Variant Code", Itemledgerentry."Variant Code");
                //IF Itemledgerentry."Variant Code"='' THEN  BEGIN
                warehouseactivityline.VALIDATE(warehouseactivityline."Location Code", 'SAMPLE');
                warehouseactivityline.VALIDATE(warehouseactivityline."Bin Code", ' ');
                //END ;
                //ELSE  BEGIN
                // warehouseactivityline.VALIDATE(warehouseactivityline."Location Code",'SAMPLE');
                // warehouseactivityline.VALIDATE(warehouseactivityline."Bin Code",'R-SAMPLE');
                //END;
                warehouseactivityline.VALIDATE(warehouseactivityline."Lot No.", Itemledgerentry."Lot No.");
                warehouseactivityline.VALIDATE(warehouseactivityline."Expiration Date", Itemledgerentry."Expiration Date");
                warehouseactivityline."Line No." := lineno;
                warehouseactivityline."Source Line No." := warehouseactivityline."Source Line No." + 10000;
                warehouseactivityline.INSERT(TRUE);
            UNTIL Itemledgerentry.NEXT = 0;
        END;
    end;


    procedure Createputawayline_Finish(FromBin: Code[10]; ToBin: Code[10]; "Prod. Order": Record 5405; warehouseactivityheader: Record 5766)
    var
        Itemledgerentry: Record 32;
        warehouseactivityline: Record 5767;
        lineno: Integer;
        ProdOrderLine1: Record 5406;
    begin
        ProdOrderLine1.RESET;
        ProdOrderLine1.SETRANGE(ProdOrderLine1.Status, ProdOrderLine1.Status::Finished);
        ProdOrderLine1.SETRANGE(ProdOrderLine1."Prod. Order No.", "Prod. Order"."No.");
        IF ProdOrderLine1.FINDFIRST THEN;

        Itemledgerentry.SETRANGE(Itemledgerentry."Document No.", "Prod. Order"."No.");
        Itemledgerentry.SETRANGE(Itemledgerentry."Entry Type", Itemledgerentry."Entry Type"::Output);
        Itemledgerentry.SETRANGE(Itemledgerentry."Item No.", ProdOrderLine1."Item No.");
        Itemledgerentry.SETRANGE(Itemledgerentry."Variant Code", '');
        IF Itemledgerentry.FINDFIRST THEN BEGIN
            REPEAT
                warehouseactivityline.RESET;
                warehouseactivityline.SETRANGE(warehouseactivityline."Activity Type", warehouseactivityline."Activity Type"::"Put-away");
                warehouseactivityline.SETRANGE(warehouseactivityline."No.", warehouseactivityheader."No.");
                IF warehouseactivityline.FINDLAST THEN
                    lineno := warehouseactivityline."Line No." + 10000
                ELSE
                    lineno := 10000;
                warehouseactivityline.RESET;
                warehouseactivityline.INIT;
                warehouseactivityline.VALIDATE(warehouseactivityline."Activity Type", warehouseactivityline."Activity Type"::"Put-away");
                warehouseactivityline.VALIDATE(warehouseactivityline."No.", warehouseactivityheader."No.");
                warehouseactivityline."Source Type" := 39;
                warehouseactivityline."Source Subtype" := 1;
                warehouseactivityline."Source Document" := warehouseactivityline."Source Document"::"Prod. Consumption";
                warehouseactivityline.VALIDATE(warehouseactivityline."Location Code", Itemledgerentry."Location Code");
                warehouseactivityline.VALIDATE(warehouseactivityline."Source No.", ProdOrderLine1."Prod. Order No.");
                warehouseactivityline.VALIDATE(warehouseactivityline."Item No.", ProdOrderLine1."Item No.");
                warehouseactivityline.VALIDATE(warehouseactivityline.Quantity, Itemledgerentry.Quantity); //
                warehouseactivityline.VALIDATE(warehouseactivityline."Due Date", "Prod. Order"."Due Date");
                warehouseactivityline.VALIDATE(warehouseactivityline."Action Type", warehouseactivityline."Action Type"::Take);
                warehouseactivityline.VALIDATE(warehouseactivityline."Bin Code", FromBin);
                warehouseactivityline.VALIDATE(warehouseactivityline."Lot No.", Itemledgerentry."Lot No.");
                warehouseactivityline.VALIDATE(warehouseactivityline."Expiration Date", Itemledgerentry."Expiration Date");
                warehouseactivityline."Line No." := lineno;
                warehouseactivityline."Source Line No." := warehouseactivityline."Source Line No." + 10000;
                warehouseactivityline.VALIDATE(warehouseactivityline."Variant Code", Itemledgerentry."Variant Code");
                warehouseactivityline.VALIDATE(warehouseactivityline."Put away Ceated From", warehouseactivityline."Put away Ceated From"::
                                              "From Release");
                warehouseactivityline.INSERT(TRUE);
                warehouseactivityline.RESET;
                warehouseactivityline.SETRANGE(warehouseactivityline."No.", warehouseactivityheader."No.");
                IF warehouseactivityline.FINDLAST THEN
                    lineno := warehouseactivityline."Line No." + 10000
                ELSE
                    lineno := 10000;
                warehouseactivityline.RESET;
                warehouseactivityline.INIT;
                warehouseactivityline.VALIDATE(warehouseactivityline."Activity Type", warehouseactivityline."Activity Type"::"Put-away");
                warehouseactivityline.VALIDATE(warehouseactivityline."No.", warehouseactivityheader."No.");
                warehouseactivityline."Source Type" := 39;
                warehouseactivityline."Source Subtype" := 1;
                warehouseactivityline."Source Document" := warehouseactivityline."Source Document"::"Prod. Consumption";
                warehouseactivityline.VALIDATE(warehouseactivityline."Source No.", ProdOrderLine1."Prod. Order No.");
                warehouseactivityline.VALIDATE(warehouseactivityline."Item No.", ProdOrderLine1."Item No.");
                warehouseactivityline.VALIDATE(warehouseactivityline.Quantity, Itemledgerentry.Quantity);//
                warehouseactivityline.VALIDATE(warehouseactivityline."Due Date", "Prod. Order"."Due Date");
                warehouseactivityline.VALIDATE(warehouseactivityline."Action Type", warehouseactivityline."Action Type"::Place);
                warehouseactivityline.VALIDATE(warehouseactivityline."Variant Code", Itemledgerentry."Variant Code");
                //IF Itemledgerentry."Variant Code"='' THEN  BEGIN
                warehouseactivityline.VALIDATE(warehouseactivityline."Location Code", 'free');
                warehouseactivityline.VALIDATE(warehouseactivityline."Bin Code", ' ');
                //END;
                //ELSE  BEGIN
                //warehouseactivityline.VALIDATE(warehouseactivityline."Location Code",'Chemiline');
                //warehouseactivityline.VALIDATE(warehouseactivityline."Bin Code",'QP');
                //END;
                warehouseactivityline.VALIDATE(warehouseactivityline."Lot No.", Itemledgerentry."Lot No.");
                warehouseactivityline.VALIDATE(warehouseactivityline."Expiration Date", Itemledgerentry."Expiration Date");
                warehouseactivityline."Line No." := lineno;
                warehouseactivityline.VALIDATE(warehouseactivityline."Put away Ceated From", warehouseactivityline."Put away Ceated From"::
                                              "From Release");

                warehouseactivityline."Source Line No." := warehouseactivityline."Source Line No." + 10000;
                warehouseactivityline.INSERT(TRUE);
            UNTIL Itemledgerentry.NEXT = 0;
        END;
        Createputaway_variant("Prod. Order", FromBin);
    end;

    procedure Createreclassjnl_Finishgoods(Whseactline: Record 5767)
    var
        Reclassjnl: Record 83;
        Itemledger: Record 32;
        Whseactline_rec: Record 5767;
        "Item Jnl.-Post": Codeunit 241;
        "Reservation entry": Record 337;
        "Reservation entry1": Record 337;
        Oldbtchno: Code[20];
        OldEexpiry: Date;
        Newbatchno: Code[20];
        Newexpiry: Date;
        whseactheader: Record 5766;
        Line: Integer;
        Whseactline_rec1: Record 5767;
    begin
        Reclassjnl.RESET;
        Reclassjnl.SETRANGE(Reclassjnl."Journal Template Name", 'RECLASS');
        Reclassjnl.SETRANGE(Reclassjnl."Journal Batch Name", 'FINISHGOOD');
        Reclassjnl.SETRANGE(Reclassjnl."Source Code", 'RECLASSJNL');
        IF Reclassjnl.FINDFIRST THEN
            Reclassjnl.DELETEALL;
        Line := 10000;
        Reclassjnl.RESET;
        Whseactline_rec.RESET;
        Whseactline_rec.SETRANGE(Whseactline_rec."No.", Whseactline."No.");
        Whseactline_rec.SETRANGE(Whseactline_rec."Activity Type", Whseactline_rec."Activity Type"::"Put-away");
        Whseactline_rec.SETRANGE(Whseactline_rec."Action Type", Whseactline_rec."Action Type"::Take);
        IF Whseactline_rec.FINDFIRST THEN;
        whseactheader.SETRANGE(whseactheader."No.", Whseactline_rec."No.");
        IF whseactheader.FINDFIRST THEN;
        Whseactline_rec1.RESET;
        Whseactline_rec1.SETRANGE(Whseactline_rec1."No.", Whseactline."No.");
        Whseactline_rec1.SETRANGE(Whseactline_rec1."Activity Type", Whseactline_rec1."Activity Type"::"Put-away");
        Whseactline_rec1.SETRANGE(Whseactline_rec1."Action Type", Whseactline_rec1."Action Type"::Place);
        IF Whseactline_rec1.FINDFIRST THEN
            REPEAT
                Reclassjnl.INIT;
                Reclassjnl."Journal Template Name" := 'RECLASS';
                Reclassjnl."Journal Batch Name" := 'FINISHGOOD';
                Reclassjnl."Source Code" := 'RECLASSJNL';
                Reclassjnl."Entry Type" := Reclassjnl."Entry Type"::Transfer;
                Reclassjnl."Line No." := Line;
                Reclassjnl.VALIDATE(Reclassjnl."Posting Date", TODAY);
                Reclassjnl.VALIDATE(Reclassjnl."Document No.", Whseactline_rec."No.");
                Reclassjnl.VALIDATE(Reclassjnl."Item No.", Whseactline_rec."Item No.");
                Reclassjnl.VALIDATE(Reclassjnl."Location Code", Whseactline_rec."Location Code");
                Reclassjnl.VALIDATE(Reclassjnl."Bin Code", Whseactline_rec."Bin Code");
                Reclassjnl.VALIDATE(Reclassjnl.Quantity, Whseactline_rec1.Quantity);
                Reclassjnl.VALIDATE(Reclassjnl."New Location Code", Whseactline_rec1."Location Code");
                Reclassjnl.VALIDATE(Reclassjnl."New Bin Code", Whseactline_rec1."Bin Code");
                Reclassjnl.VALIDATE(Reclassjnl."Variant Code", Whseactline_rec."Variant Code");
                Reclassjnl.INSERT(TRUE);
                IF "Reservation entry1".FINDLAST THEN;
                "Reservation entry".INIT;
                "Reservation entry"."Entry No." := "Reservation entry1"."Entry No." + 1;
                "Reservation entry".VALIDATE("Reservation entry"."Item No.", Reclassjnl."Item No.");
                "Reservation entry".VALIDATE("Reservation entry"."Location Code", Reclassjnl."Location Code");
                "Reservation entry".VALIDATE("Reservation entry"."Quantity (Base)", Reclassjnl.Quantity * -1);
                "Reservation entry"."Reservation Status" := "Reservation entry"."Reservation Status"::Prospect;
                "Reservation entry".VALIDATE("Reservation entry"."Creation Date", Reclassjnl."Posting Date");
                "Reservation entry"."Source Type" := 83;
                "Reservation entry"."Source Subtype" := 4;
                "Reservation entry"."Source ID" := Reclassjnl."Journal Template Name";
                "Reservation entry"."Source Batch Name" := Reclassjnl."Journal Batch Name";
                "Reservation entry"."Source Ref. No." := Reclassjnl."Line No.";
                "Reservation entry"."Created By" := USERID;
                "Reservation entry".Positive := FALSE;
                "Reservation entry".VALIDATE("Reservation entry"."Lot No.", Whseactline_rec."Lot No.");
                "Reservation entry".VALIDATE("Reservation entry"."New Lot No.", Whseactline_rec1."Lot No.");
                "Reservation entry".VALIDATE("Reservation entry"."Expiration Date", Whseactline_rec."Expiration Date");
                "Reservation entry".VALIDATE("Reservation entry"."New Expiration Date", Whseactline_rec1."Expiration Date");
                "Reservation entry".INSERT(TRUE);
                Line := Line + 10000;
            UNTIL Whseactline_rec1.NEXT = 0;
        Reclassjnl.RESET;
        Reclassjnl.SETRANGE(Reclassjnl."Journal Template Name", 'RECLASS');
        Reclassjnl.SETRANGE(Reclassjnl."Journal Batch Name", 'FINISHGOOD');
        Reclassjnl.SETRANGE(Reclassjnl."Source Code", 'RECLASSJNL');
        IF Reclassjnl.FINDFIRST THEN
            // CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post1", Reclassjnl);

        Whseactline_rec.RESET;
        Whseactline_rec.SETRANGE(Whseactline_rec."Activity Type", Whseactline_rec."Activity Type"::"Put-away");
        Whseactline_rec.SETRANGE(Whseactline_rec."No.", whseactheader."No.");
        IF Whseactline_rec.FINDFIRST THEN BEGIN
            Whseactline_rec.DELETEALL;
        END;

        whseactheader.DELETEALL;



        COMMIT;
    end;


    procedure Createreclassjnl_Components(Whseactline: Record 5767)
    var
        Reclassjnl: Record 83;
        Whseactline_rec: Record 5767;
        "Item Jnl.-Post": Codeunit 241;
        whseactheader: Record 5766;
        "prod.ordercomponents": Record 5407;
        "Prod.order": Record 5405;
    begin
        whseactheader.SETRANGE(whseactheader."No.", Whseactline."No.");
        IF whseactheader.FINDFIRST THEN;
        //"prod.ordercomponents".RESET;
        //"prod.ordercomponents".SETRANGE("prod.ordercomponents"."Prod. Order No.",Whseactline_rec."Source No.");
        //IF "prod.ordercomponents".FINDFIRST THEN BEGIN
        Whseactline_rec.SETRANGE(Whseactline_rec."No.", Whseactline."No.");
        IF Whseactline_rec.FINDFIRST THEN BEGIN
            Reclassjnl.RESET;
            Reclassjnl.SETRANGE(Reclassjnl."Journal Template Name", 'RECLASS');
            Reclassjnl.SETRANGE(Reclassjnl."Journal Batch Name", 'FINISHGOOD');
            Reclassjnl.SETRANGE(Reclassjnl."Source Code", 'RECLASSJNL');
            IF Reclassjnl.FINDFIRST THEN
                Reclassjnl.DELETEALL;
            REPEAT
                Reclassjnl.RESET;
                Reclassjnl.INIT;
                Reclassjnl."Journal Template Name" := 'RECLASS';
                Reclassjnl."Journal Batch Name" := 'FINISHGOOD';
                Reclassjnl."Source Code" := 'RECLASSJNL';
                Reclassjnl."Entry Type" := Reclassjnl."Entry Type"::Transfer;

                Reclassjnl."Line No." := Reclassjnl."Line No." + 10000;
                Reclassjnl.VALIDATE(Reclassjnl."Posting Date", TODAY);
                Reclassjnl.VALIDATE(Reclassjnl."Document No.", Whseactline_rec."No.");
                Reclassjnl.VALIDATE(Reclassjnl."Item No.", Whseactline_rec."Item No.");
                Reclassjnl.VALIDATE(Reclassjnl."Location Code", Whseactline_rec."Location Code");
                Reclassjnl.VALIDATE(Reclassjnl."Bin Code", Whseactline_rec."Bin Code");
                Reclassjnl.VALIDATE(Reclassjnl.Quantity, Whseactline_rec.Quantity);
                //Reclassjnl."From Location Barcode":=Whseactline_rec.Barcode;
                //Reclassjnl."From Location Scan Time":=Whseactline_rec."Scan Time";
                Whseactline_rec.NEXT;
                Reclassjnl.VALIDATE(Reclassjnl."New Location Code", Whseactline_rec."Location Code");
                Reclassjnl.VALIDATE(Reclassjnl."New Bin Code", Whseactline_rec."Bin Code");
                //Reclassjnl."To Location Barcode":=Whseactline_rec.Barcode;
                //Reclassjnl."To Location Scan Time":=Whseactline_rec."Scan Time";

                Reclassjnl.INSERT(TRUE);

            UNTIL Whseactline_rec.NEXT = 0;
        END;

        Reclassjnl.RESET;
        Reclassjnl.SETRANGE(Reclassjnl."Journal Template Name", 'RECLASS');
        Reclassjnl.SETRANGE(Reclassjnl."Journal Batch Name", 'FINISHGOOD');
        Reclassjnl.SETRANGE(Reclassjnl."Source Code", 'RECLASSJNL');


        IF Reclassjnl.FINDFIRST THEN
            CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post", Reclassjnl);
        "Prod.order".RESET;
        "Prod.order".SETRANGE("Prod.order"."No.", Whseactline_rec."Source No.");
        IF "Prod.order".FINDFIRST THEN BEGIN
            "Prod.order"."Lable Issue" := TRUE;
            "Prod.order"."Component Issue" := TRUE;
            "Prod.order".MODIFY(TRUE);
        END;

        //for Change bin on components
        "prod.ordercomponents".SETRANGE("prod.ordercomponents"."Prod. Order No.", Whseactline_rec."Source No.");
        "prod.ordercomponents".SETFILTER("prod.ordercomponents"."Item No.", '<>%1', "Prod.order"."Source No.");
        IF "prod.ordercomponents".FINDFIRST THEN
            REPEAT
                "prod.ordercomponents".VALIDATE("prod.ordercomponents"."Location Code", 'Chemilines');
                "prod.ordercomponents".VALIDATE("prod.ordercomponents"."Bin Code", 'RES');
                "prod.ordercomponents".MODIFY(TRUE);

            UNTIL "prod.ordercomponents".NEXT = 0;

        Whseactline_rec.DELETEALL;
        whseactheader.DELETEALL;
        COMMIT;
    end;

    procedure "Checkfor reclass"(Whseactline: Record 5767) Errorval: Boolean
    var
        Whseactline_rec: Record 5767;
    begin
        Whseactline_rec.SETRANGE(Whseactline_rec."No.", Whseactline."No.");
        IF Whseactline_rec.FINDFIRST THEN
            REPEAT
                IF Whseactline_rec."Process Status" = FALSE THEN
                    Errorval := TRUE;
            UNTIL Whseactline_rec.NEXT = 0;
    end;

    procedure Createreclassjnl_Sample(headerno: Code[20])
    var
        Reclassjnl: Record 83;
        Itemledger: Record 32;
        Whseactline_rec: Record 5767;
        // "Item Jnl.-Post": Codeunit 50011;
        "Reservation entry": Record 337;
        "Reservation entry1": Record 337;
        whseactheader: Record 5766;
        Whseactline_rec1: Record 5767;
        Line: Integer;
    begin
        Reclassjnl.RESET;
        Reclassjnl.SETRANGE(Reclassjnl."Journal Template Name", 'RECLASS');
        Reclassjnl.SETRANGE(Reclassjnl."Journal Batch Name", 'SAMPLE');
        Reclassjnl.SETRANGE(Reclassjnl."Source Code", 'RECLASSJNL');
        IF Reclassjnl.FINDFIRST THEN
            Reclassjnl.DELETEALL;
        Line := 10000;
        Reclassjnl.RESET;
        Whseactline_rec.RESET;
        Whseactline_rec.SETRANGE(Whseactline_rec."No.", headerno);
        Whseactline_rec.SETRANGE(Whseactline_rec."Activity Type", Whseactline_rec."Activity Type"::"Put-away");
        Whseactline_rec.SETRANGE(Whseactline_rec."Action Type", Whseactline_rec."Action Type"::Take);
        IF Whseactline_rec.FINDFIRST THEN;
        whseactheader.SETRANGE(whseactheader."No.", Whseactline_rec."No.");
        IF whseactheader.FINDFIRST THEN;
        Whseactline_rec1.RESET;
        Whseactline_rec1.SETRANGE(Whseactline_rec1."No.", headerno);
        Whseactline_rec1.SETRANGE(Whseactline_rec1."Activity Type", Whseactline_rec1."Activity Type"::"Put-away");
        Whseactline_rec1.SETRANGE(Whseactline_rec1."Action Type", Whseactline_rec1."Action Type"::Place);
        IF Whseactline_rec1.FINDFIRST THEN
            REPEAT
                Reclassjnl.INIT;
                Reclassjnl."Journal Template Name" := 'RECLASS';
                Reclassjnl."Journal Batch Name" := 'SAMPLE';
                Reclassjnl."Source Code" := 'RECLASSJNL';
                Reclassjnl."Entry Type" := Reclassjnl."Entry Type"::Transfer;
                Reclassjnl."Line No." := Line;
                Reclassjnl.VALIDATE(Reclassjnl."Posting Date", TODAY);
                Reclassjnl.VALIDATE(Reclassjnl."Document No.", Whseactline_rec."No.");
                Reclassjnl.VALIDATE(Reclassjnl."Item No.", Whseactline_rec."Item No.");
                Reclassjnl.VALIDATE(Reclassjnl."Location Code", Whseactline_rec."Location Code");
                Reclassjnl.VALIDATE(Reclassjnl."Bin Code", Whseactline_rec."Bin Code");
                Reclassjnl.VALIDATE(Reclassjnl.Quantity, Whseactline_rec1.Quantity);
                Reclassjnl.VALIDATE(Reclassjnl."New Location Code", Whseactline_rec1."Location Code");
                Reclassjnl.VALIDATE(Reclassjnl."New Bin Code", Whseactline_rec1."Bin Code");
                Reclassjnl.VALIDATE(Reclassjnl."Variant Code", Whseactline_rec."Variant Code");
                Reclassjnl.INSERT(TRUE);
                IF Reclassjnl."Bin Code" <> Whseactline_rec."Bin Code" THEN BEGIN
                    Reclassjnl."Bin Code" := Whseactline_rec."Bin Code";
                    Reclassjnl.MODIFY(FALSE);
                END;

                IF "Reservation entry1".FINDLAST THEN;
                "Reservation entry".INIT;
                "Reservation entry"."Entry No." := "Reservation entry1"."Entry No." + 1;
                "Reservation entry".VALIDATE("Reservation entry"."Item No.", Reclassjnl."Item No.");
                "Reservation entry".VALIDATE("Reservation entry"."Location Code", Reclassjnl."Location Code");
                "Reservation entry".VALIDATE("Reservation entry"."Quantity (Base)", Reclassjnl.Quantity * -1);
                "Reservation entry"."Reservation Status" := "Reservation entry"."Reservation Status"::Prospect;
                "Reservation entry".VALIDATE("Reservation entry"."Creation Date", Reclassjnl."Posting Date");
                "Reservation entry"."Source Type" := 83;
                "Reservation entry"."Source Subtype" := 4;
                "Reservation entry"."Source ID" := Reclassjnl."Journal Template Name";
                "Reservation entry"."Source Batch Name" := Reclassjnl."Journal Batch Name";
                "Reservation entry"."Source Ref. No." := Reclassjnl."Line No.";
                "Reservation entry"."Created By" := USERID;
                "Reservation entry".Positive := FALSE;
                "Reservation entry".VALIDATE("Reservation entry"."Lot No.", Whseactline_rec."Lot No.");
                "Reservation entry".VALIDATE("Reservation entry"."New Lot No.", Whseactline_rec1."Lot No.");
                "Reservation entry".VALIDATE("Reservation entry"."Expiration Date", Whseactline_rec."Expiration Date");
                "Reservation entry".VALIDATE("Reservation entry"."New Expiration Date", Whseactline_rec1."Expiration Date");
                "Reservation entry".INSERT(TRUE);
                Line := Line + 10000;
            UNTIL Whseactline_rec1.NEXT = 0;
        Reclassjnl.RESET;
        Reclassjnl.SETRANGE(Reclassjnl."Journal Template Name", 'RECLASS');
        Reclassjnl.SETRANGE(Reclassjnl."Journal Batch Name", 'SAMPLE');
        Reclassjnl.SETRANGE(Reclassjnl."Source Code", 'RECLASSJNL');
        IF Reclassjnl.FINDFIRST THEN
            // CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post1", Reclassjnl);

        Whseactline_rec.RESET;
        Whseactline_rec.SETRANGE(Whseactline_rec."Activity Type", Whseactline_rec."Activity Type"::"Put-away");
        Whseactline_rec.SETRANGE(Whseactline_rec."No.", whseactheader."No.");
        IF Whseactline_rec.FINDFIRST THEN BEGIN
            Whseactline_rec.DELETEALL;
        END;

        whseactheader.DELETEALL;



        COMMIT;
    end;

    procedure Createreclassjnl_Goodsin(Whseactline: Record 5767)
    var
        Reclassjnl: Record 83;
        Itemledger: Record 32;
        Whseactline_rec: Record 5767;
        "Item Jnl.-Post": Codeunit 241;
        "Reservation entry": Record 337;
        "Reservation entry1": Record 337;
        Oldbtchno: Code[20];
        OldEexpiry: Date;
        Newbatchno: Code[20];
        Newexpiry: Date;
        whseactheader: Record 5766;
        Line: Integer;
        Whseactline_rec1: Record 5767;
    begin
        Reclassjnl.RESET;
        Reclassjnl.SETRANGE(Reclassjnl."Journal Template Name", 'RECLASS');
        Reclassjnl.SETRANGE(Reclassjnl."Journal Batch Name", 'GOODS');
        Reclassjnl.SETRANGE(Reclassjnl."Source Code", 'RECLASSJNL');
        IF Reclassjnl.FINDFIRST THEN
            Reclassjnl.DELETEALL;
        Line := 10000;
        Reclassjnl.RESET;
        Whseactline_rec.RESET;
        Whseactline_rec.SETRANGE(Whseactline_rec."No.", Whseactline."No.");
        Whseactline_rec.SETRANGE(Whseactline_rec."Activity Type", Whseactline_rec."Activity Type"::"Put-away");
        Whseactline_rec.SETRANGE(Whseactline_rec."Action Type", Whseactline_rec."Action Type"::Take);
        IF Whseactline_rec.FINDFIRST THEN BEGIN
            whseactheader.SETRANGE(whseactheader."No.", Whseactline_rec."No.");
            IF whseactheader.FINDFIRST THEN;
            REPEAT
                Whseactline_rec1.RESET;
                Whseactline_rec1.SETRANGE(Whseactline_rec1."No.", Whseactline."No.");
                Whseactline_rec1.SETRANGE(Whseactline_rec1."Activity Type", Whseactline_rec1."Activity Type"::"Put-away");
                Whseactline_rec1.SETRANGE(Whseactline_rec1."Action Type", Whseactline_rec1."Action Type"::Place);
                Whseactline_rec1.SETRANGE(Whseactline_rec1."Lot No.", Whseactline_rec."Lot No.");
                Whseactline_rec1.SETRANGE(Whseactline_rec1."Item No.", Whseactline_rec."Item No.");
                IF Whseactline_rec1.FINDFIRST THEN;

                Reclassjnl.INIT;
                Reclassjnl."Journal Template Name" := 'RECLASS';
                Reclassjnl."Journal Batch Name" := 'GOODS';
                Reclassjnl."Source Code" := 'RECLASSJNL';
                Reclassjnl."Entry Type" := Reclassjnl."Entry Type"::Transfer;
                Reclassjnl."Line No." := Line;
                Reclassjnl.VALIDATE(Reclassjnl."Posting Date", TODAY);
                Reclassjnl.VALIDATE(Reclassjnl."Document No.", Whseactline_rec."No.");
                Reclassjnl.VALIDATE(Reclassjnl."Item No.", Whseactline_rec."Item No.");
                Reclassjnl.VALIDATE(Reclassjnl."Location Code", Whseactline_rec."Location Code");
                //Reclassjnl."Bin Code":=Whseactline_rec."Bin Code";
                Reclassjnl.VALIDATE(Reclassjnl."Bin Code", Whseactline_rec."Bin Code");
                Reclassjnl.VALIDATE(Reclassjnl.Quantity, Whseactline_rec1.Quantity);
                Reclassjnl.VALIDATE(Reclassjnl."New Location Code", Whseactline_rec1."Location Code");
                //Reclassjnl."New Bin Code":=Whseactline_rec1."Bin Code";
                Reclassjnl.VALIDATE(Reclassjnl."New Bin Code", Whseactline_rec1."Bin Code");
                Reclassjnl.VALIDATE(Reclassjnl."Variant Code", Whseactline_rec."Variant Code");
                Reclassjnl.INSERT(TRUE);

                IF "Reservation entry1".FINDLAST THEN;
                "Reservation entry".INIT;
                "Reservation entry"."Entry No." := "Reservation entry1"."Entry No." + 1;
                "Reservation entry".VALIDATE("Reservation entry"."Item No.", Reclassjnl."Item No.");
                "Reservation entry".VALIDATE("Reservation entry"."Location Code", Reclassjnl."Location Code");
                "Reservation entry".VALIDATE("Reservation entry"."Quantity (Base)", Reclassjnl.Quantity * -1);
                "Reservation entry"."Reservation Status" := "Reservation entry"."Reservation Status"::Prospect;
                "Reservation entry".VALIDATE("Reservation entry"."Creation Date", Reclassjnl."Posting Date");
                "Reservation entry"."Source Type" := 83;
                "Reservation entry"."Source Subtype" := 4;
                "Reservation entry"."Source ID" := Reclassjnl."Journal Template Name";
                "Reservation entry"."Source Batch Name" := Reclassjnl."Journal Batch Name";
                "Reservation entry"."Source Ref. No." := Reclassjnl."Line No.";
                "Reservation entry"."Created By" := USERID;
                "Reservation entry".Positive := FALSE;
                "Reservation entry".VALIDATE("Reservation entry"."Lot No.", Whseactline_rec."Lot No.");
                "Reservation entry".VALIDATE("Reservation entry"."New Lot No.", Whseactline_rec1."Lot No.");
                "Reservation entry".VALIDATE("Reservation entry"."Expiration Date", Whseactline_rec."Expiration Date");
                "Reservation entry".VALIDATE("Reservation entry"."New Expiration Date", Whseactline_rec1."Expiration Date");
                "Reservation entry".INSERT(TRUE);
                Line := Line + 10000;
            UNTIL Whseactline_rec.NEXT = 0;
        END;

        Reclassjnl.RESET;
        Reclassjnl.SETRANGE(Reclassjnl."Journal Template Name", 'RECLASS');
        Reclassjnl.SETRANGE(Reclassjnl."Journal Batch Name", 'GOODS');
        Reclassjnl.SETRANGE(Reclassjnl."Source Code", 'RECLASSJNL');
        IF Reclassjnl.FINDFIRST THEN
            // CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post1", Reclassjnl);

        Whseactline_rec.RESET;
        Whseactline_rec.SETRANGE(Whseactline_rec."Activity Type", Whseactline_rec."Activity Type"::"Put-away");
        Whseactline_rec.SETRANGE(Whseactline_rec."No.", whseactheader."No.");
        IF Whseactline_rec.FINDFIRST THEN BEGIN
            Whseactline_rec.DELETEALL;
        END;

        whseactheader.DELETEALL;



        COMMIT;
    end;


    procedure UpdateProd(var "Docno.": Code[20])
    var
        "Registered Whse. Activity Line": Record 5773;
        ProductionLine: Record 5406;
        "Registered Whse. Activity Hdr.": Record 5772;
        Productionorder: Record 5405;
    begin
        "Registered Whse. Activity Hdr.".RESET;
        "Registered Whse. Activity Hdr.".SETRANGE("Registered Whse. Activity Hdr."."Whse. Activity No.", "Docno.");
        IF "Registered Whse. Activity Hdr.".FINDFIRST THEN BEGIN
            "Registered Whse. Activity Line".RESET;
            "Registered Whse. Activity Line".SETRANGE("Registered Whse. Activity Line"."Activity Type",
            "Registered Whse. Activity Line"."Activity Type"::"Put-away");
            "Registered Whse. Activity Line".SETRANGE("Registered Whse. Activity Line"."No.", "Registered Whse. Activity Hdr."."No.");
            "Registered Whse. Activity Line".SETRANGE("Registered Whse. Activity Line"."Put away Ceated From",
            "Registered Whse. Activity Line"."Put away Ceated From"::"From FIrm Plan");
            "Registered Whse. Activity Line".SETRANGE("Registered Whse. Activity Line"."Action Type"
            , "Registered Whse. Activity Line"."Action Type"::Place);
            IF "Registered Whse. Activity Line".FINDFIRST THEN;
            ProductionLine.SETRANGE(ProductionLine."Prod. Order No.", "Registered Whse. Activity Line"."Source No.");
            IF ProductionLine.FINDFIRST THEN BEGIN
                ProductionLine.VALIDATE(ProductionLine."Bin Code", "Registered Whse. Activity Line"."Bin Code");
                ProductionLine.MODIFY(TRUE);
            END;
        END;
        Productionorder.RESET;
        Productionorder.SETRANGE(Productionorder."No.", "Registered Whse. Activity Line"."Source No.");
        IF Productionorder.FINDFIRST THEN BEGIN
            Productionorder."Checked Put away Posted" := TRUE;
            Productionorder."Room No." := '';
            Productionorder.MODIFY(TRUE);
        END;
    end;
}

