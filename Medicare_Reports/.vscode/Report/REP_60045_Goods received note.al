report 60045 "Goods Received Note Medicare"
{


    DefaultLayout = RDLC;
    RDLCLayout = './Goods Received Note Medicare.rdl';

    dataset
    {
        dataitem("Posted Whse. Receipt Line"; "Posted Whse. Receipt Line")
        {
            DataItemTableView = SORTING("Item No.", "Source No.", "Source Document")
                                ORDER(Ascending)
                                WHERE("Source Document" = FILTER('Purchase Order' | 'Sales Return Order'));
            RequestFilterFields = "No.", "Item No.";
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(VendorName; VendorName)
            {
            }
            column(VendorShipmentNo; recPostedWhseReceiptHeader."Vendor Shipment No.")
            {
            }
            column(Courier; Courier)
            {
            }
            column(No; recPostedWhseReceiptHeader."No.")
            {
            }
            column(WhseReceiptNo; recPostedWhseReceiptHeader."Whse. Receipt No.")
            {
            }
            column(AssignUserId; recPostedWhseReceiptHeader."Assigned User ID")
            {
            }
            column(PostingDate; FORMAT(recPostedWhseReceiptHeader."Posting Date"))
            {
            }
            column(AssignTime; recPostedWhseReceiptHeader."Assignment Time")
            {
            }
            column(PostedSrcNo; "Posted Whse. Receipt Line"."Posted Source No.")
            {
            }
            column(TotalReturnQty; TotalReturnQty)
            {
            }
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document No." = FIELD("Source No.");
                DataItemTableView = WHERE("Document Type" = CONST(Order),
                                          "Prod. Order No." = FILTER(<> ' '));
                dataitem("Item Ledger Entry"; "Item Ledger Entry")
                {
                    DataItemLink = "Document No." = FIELD("Prod. Order No.");
                    DataItemTableView = WHERE("Entry Type" = FILTER(<> Consumption));
                    column(ItemNo2; itemno)
                    {
                    }
                    column(Desc2; Desc)
                    {
                    }
                    column(BatchNo; BatchNo)
                    {
                    }
                    column(ExpDate; ExpDate)
                    {
                    }
                    column(ProdQty2; ProdQty)
                    {
                    }
                    column(SourceType2; "Posted Whse. Receipt Line"."Source Type")
                    {
                    }
                    column(SourceNo2; "Posted Whse. Receipt Line"."Source No.")
                    {
                    }
                    column(Flag; Flag)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        Flag := TRUE;
                        Flag2 := FALSE;
                        Flag3 := FALSE;
                        Flag4 := FALSE;

                        //Sofyan ++
                        CLEAR(itemno);
                        CLEAR(Desc);
                        CLEAR(BatchNo);
                        CLEAR(ExpDate);
                        CLEAR(ProdQty);
                        CLEAR(int1);

                        itemno := "Item Ledger Entry"."Item No.";
                        Item.RESET;
                        Item.SETRANGE("No.", itemno);
                        IF Item.FINDFIRST THEN
                            Desc := Item.Description;
                        BatchNo := "Item Ledger Entry"."Lot No.";
                        ExpDate := FORMAT("Item Ledger Entry"."Expiration Date");
                        ProdQty := "Item Ledger Entry".Quantity;
                        LotNoInfo.RESET;
                        LotNoInfo.SETRANGE("Item No.", "Item Ledger Entry"."Item No.");
                        LotNoInfo.SETRANGE("Lot No.", "Item Ledger Entry"."Lot No.");
                        IF LotNoInfo.FINDFIRST THEN
                            IF LotNoInfo.Remarks <> '' THEN
                                EVALUATE(int1, LotNoInfo.Remarks);

                        //Sofyan --
                    end;
                }
            }
            dataitem("Return Receipt Line"; "Return Receipt Line")
            {
                DataItemLink = "Return Order No." = FIELD("Source No."),
                               "No." = FIELD("Item No.");
                dataitem("Warehouse Entry"; "Warehouse Entry")
                {
                    DataItemLink = "Reference No." = FIELD("Document No."),
                                   "Registering Date" = FIELD("Posting Date"),
                                   "Source No." = FIELD("Return Order No."),
                                   "Source Line No." = FIELD("Return Order Line No.");
                    column(ItemNo4; itemno)
                    {
                    }
                    column(Desc4; Desc)
                    {
                    }
                    column(BatchNo4; BatchNo)
                    {
                    }
                    column(ExpDate4; ExpDate)
                    {
                    }
                    column(ProdQty4; ProdQty4)
                    {
                    }
                    column(SourceType4; "Posted Whse. Receipt Line"."Source Type")
                    {
                    }
                    column(SourceNo4; "Posted Whse. Receipt Line"."Source No.")
                    {
                    }
                    column(BinCode4; "Warehouse Entry"."Bin Code")
                    {
                    }
                    column(Flag2; Flag2)
                    {
                    }
                    column(int2; int2)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        Flag := FALSE;
                        Flag2 := TRUE;
                        //Sofyan ++
                        CLEAR(itemno);
                        CLEAR(Desc);
                        CLEAR(BatchNo);
                        CLEAR(ExpDate);
                        CLEAR(ProdQty4);
                        CLEAR(int2);

                        itemno := "Warehouse Entry"."Item No.";
                        Item.RESET;
                        Item.SETRANGE("No.", itemno);
                        IF Item.FINDFIRST THEN
                            Desc := Item.Description;
                        BatchNo := "Warehouse Entry"."Lot No.";
                        ExpDate := FORMAT("Warehouse Entry"."Expiration Date");
                        ProdQty4 := "Warehouse Entry".Quantity;
                        LotNoInfo.RESET;
                        LotNoInfo.SETRANGE("Item No.", "Warehouse Entry"."Item No.");
                        LotNoInfo.SETRANGE("Lot No.", "Warehouse Entry"."Lot No.");
                        IF LotNoInfo.FINDFIRST THEN
                            IF LotNoInfo.Remarks <> '' THEN
                                EVALUATE(int2, LotNoInfo.Remarks);

                        //Sofyan --
                    end;
                }

                trigger OnAfterGetRecord()
                var
                    L_ReturnReceiptLine: Record "Return Receipt Line";
                begin
                end;
            }
            dataitem("Tracking Specification"; "Tracking Specification")
            {
                DataItemLink = "Item No." = FIELD("Item No."),
                               "Source ID" = FIELD("Source No."),
                               "Source Ref. No." = FIELD("Source Line No.");
                DataItemTableView = SORTING("Source ID", "Source Type", "Source Subtype", "Source Batch Name", "Source Prod. Order Line", "Source Ref. No.");
                column(SourceType; "Posted Whse. Receipt Line"."Source Type")
                {
                }
                column(BinCode; BinCode)
                {
                }
                column(LotNo; LotNoInfo."Lot No.")
                {
                }
                column(SourceNo; "Posted Whse. Receipt Line"."Source No.")
                {
                }
                column(ProdNo; ProdNo)
                {
                }
                column(ItemNo; "Tracking Specification"."Item No.")
                {
                }
                column(Description; "Posted Whse. Receipt Line".Description)
                {
                }
                column(ForeignName; "Posted Whse. Receipt Line"."Foreign Name")
                {
                }
                column(lotno1; "Tracking Specification"."Lot No.")
                {
                }
                column(ExpirationDate; FORMAT("Tracking Specification"."Expiration Date"))
                {
                }
                column(int1; int1)
                {
                }
                column(ProdQty; ProdQty)
                {
                }
                column(PLNo; PLNo)
                {
                }
                column(ECMA; ECMA)
                {
                }
                column(Remarks1; Remarks1)
                {
                }
                column(TotalQty; total_qty)
                {
                }
                column(TotalAmt; total_amt)
                {
                }
                column(ItemNo3; itemno)
                {
                }
                column(Desc3; Desc)
                {
                }
                column(BatchNo3; BatchNo)
                {
                }
                column(ExpDate3; ExpDate)
                {
                }
                column(ProdQty3; ProdQty)
                {
                }
                column(Flag3; Flag3)
                {
                }
                column(Flag4; Flag4)
                {
                }
                column(SourceType_TrackingSpecification; "Tracking Specification"."Source Type")
                {
                }
                column(SourceID_TrackingSpecification; "Tracking Specification"."Source ID")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //Sofyan ++
                    CLEAR(itemno);
                    CLEAR(Desc);
                    CLEAR(BatchNo);
                    CLEAR(ExpDate);
                    CLEAR(ProdQty);
                    CLEAR(int1);
                    PurchaseLine.RESET;
                    PurchaseLine.SETRANGE("Document Type", PurchaseLine."Document Type"::Order);
                    PurchaseLine.SETRANGE("Document No.", "Posted Whse. Receipt Line"."Source No.");
                    PurchaseLine.SETFILTER("Prod. Order No.", '%1', '');
                    IF PurchaseLine.FINDFIRST THEN BEGIN

                        //New Code START****
                        RecProdOrder.RESET;
                        RecProdOrder.SETFILTER(RecProdOrder."Source Type", '%1', RecProdOrder."Source Type"::Item);
                        RecProdOrder.SETRANGE(RecProdOrder."Posted Receipt No.", "Posted Whse. Receipt Line"."Posted Source No.");
                        RecProdOrder.SETRANGE(RecProdOrder."Lot No.", "Tracking Specification"."Lot No.");
                        RecProdOrder.SETRANGE(RecProdOrder."Location Code", "Tracking Specification"."Location Code");
                        RecProdOrder.SETRANGE(RecProdOrder."Posted Warehouse Receipt No.", "Posted Whse. Receipt Line"."No.");
                        RecProdOrder.SETRANGE(RecProdOrder."Source No.", "Tracking Specification"."Item No.");
                        IF RecProdOrder.FINDFIRST THEN BEGIN
                            //IF RecProdOrder."No." <> '' THEN
                            //BEGIN
                            ProdNo := RecProdOrder."No.";
                            ProdQty := RecProdOrder.Quantity;  //anikEt
                            PLNo := RecProdOrder."PLPI No.";
                            ECMA := RecProdOrder."ECMA No.";
                            //END;
                        END
                        ELSE BEGIN
                            ProdQty := "Tracking Specification"."Quantity (Base)";
                            ProdNo := '';
                        END;

                        IF "Tracking Specification".Description <> "Posted Whse. Receipt Line".Description THEN
                            EVALUATE(Remarks1, "Tracking Specification".Description) //Trackingspcification.Description);
                        ELSE
                            CLEAR(Remarks1);

                        ProdQty := "Tracking Specification"."Quantity (Base)";
                        itemno := "Tracking Specification"."Item No.";
                        Desc := "Posted Whse. Receipt Line".Description;
                        BatchNo := "Tracking Specification"."Lot No.";
                        ExpDate := FORMAT("Tracking Specification"."Expiration Date");

                        LotNoInfo.RESET;
                        LotNoInfo.SETRANGE(LotNoInfo."Item No.", "Tracking Specification"."Item No.");
                        LotNoInfo.SETRANGE(LotNoInfo."Lot No.", "Tracking Specification"."Lot No.");
                        IF LotNoInfo.FINDFIRST THEN BEGIN
                            IF LotNoInfo.Remarks <> '' THEN BEGIN
                                EVALUATE(int1, LotNoInfo.Remarks);
                            END;
                        END;
                    END
                    ELSE BEGIN
                        RecProdOrder.RESET;
                        RecProdOrder.SETFILTER(RecProdOrder."Source Type", '%1', RecProdOrder."Source Type"::Item);
                        RecProdOrder.SETRANGE(RecProdOrder."Posted Receipt No.", "Posted Whse. Receipt Line"."Posted Source No.");
                        RecProdOrder.SETRANGE(RecProdOrder."Lot No.", "Tracking Specification"."Lot No.");
                        RecProdOrder.SETRANGE(RecProdOrder."Location Code", "Tracking Specification"."Location Code");
                        RecProdOrder.SETRANGE(RecProdOrder."Posted Warehouse Receipt No.", "Posted Whse. Receipt Line"."No.");
                        RecProdOrder.SETRANGE(RecProdOrder."Source No.", "Tracking Specification"."Item No.");
                        IF RecProdOrder.FINDFIRST THEN BEGIN
                            //IF RecProdOrder."No." <> '' THEN
                            //BEGIN
                            ProdNo := RecProdOrder."No.";
                            PLNo := RecProdOrder."PLPI No.";
                            ECMA := RecProdOrder."ECMA No.";
                            //END;
                        END
                        ELSE BEGIN
                            ProdQty := "Tracking Specification"."Quantity (Base)";
                            ProdNo := '';
                        END;

                        IF "Tracking Specification".Description <> "Posted Whse. Receipt Line".Description THEN
                            EVALUATE(Remarks1, "Tracking Specification".Description) //Trackingspcification.Description);
                        ELSE
                            CLEAR(Remarks1);
                    END;

                    IF ((Flag = FALSE) AND (Flag2 = FALSE) AND (Flag3 = FALSE) AND (Flag4 = FALSE)) THEN
                        Flag4 := TRUE;
                    //ELSE
                    //Flag4 := FALSE;
                end;
            }

            trigger OnAfterGetRecord()
            var
                L_PostedWhseReceiptLine: Record 7319;
            begin



                IF recPostedWhseReceiptHeader.GET("Posted Whse. Receipt Line"."No.") THEN BEGIN
                    PoGEAtt.SETRANGE(PoGEAtt."Entry Type", PoGEAtt."Entry Type"::Inward);
                    PoGEAtt.SETRANGE(PoGEAtt."Warehouse Recpt. No.", recPostedWhseReceiptHeader."Whse. Receipt No.");
                    IF PoGEAtt.FINDFIRST THEN
                        POGEH.SETRANGE(POGEH."No.", PoGEAtt."Gate Entry No.");
                    IF POGEH.FINDFIRST THEN
                        Courier := POGEH."Carrier/Courier";
                END;


                PostedReceiptNo := "Posted Whse. Receipt Line"."Posted Source No.";
                PurchHeader.SETRANGE(PurchHeader."Document Type", PurchHeader."Document Type"::Order);
                PurchHeader.SETRANGE(PurchHeader."No.", "Posted Whse. Receipt Line"."Source No.");
                IF PurchHeader.FINDFIRST THEN BEGIN
                    VendorName := PurchHeader."Buy-from Vendor Name";
                    SuppInvNo := PurchHeader."Vendor Invoice No.";
                END;

                //Prathamesh
                CLEAR(BinCode);
                L_RegisteredWhseActivityNo.RESET;
                L_RegisteredWhseActivityNo.SETRANGE(L_RegisteredWhseActivityNo."Whse. Document No.", "No.");
                L_RegisteredWhseActivityNo.SETRANGE(L_RegisteredWhseActivityNo."Source No.", "Source No.");
                L_RegisteredWhseActivityNo.SETRANGE(L_RegisteredWhseActivityNo."Item No.", "Item No.");
                L_RegisteredWhseActivityNo.SETRANGE(L_RegisteredWhseActivityNo."Action Type", L_RegisteredWhseActivityNo."Action Type"::Place);
                IF L_RegisteredWhseActivityNo.FINDFIRST THEN BEGIN
                    BinCode := L_RegisteredWhseActivityNo."Bin Code";
                END;
                //Prathamesh

                CLEAR(TotalReturnQty);
                L_PostedWhseReceiptLine.RESET;
                L_PostedWhseReceiptLine.SETRANGE("No.", "Posted Whse. Receipt Line"."No.");
                IF L_PostedWhseReceiptLine.FINDSET THEN
                    REPEAT
                        TotalReturnQty := TotalReturnQty + L_PostedWhseReceiptLine.Quantity;
                    UNTIL L_PostedWhseReceiptLine.NEXT = 0;
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.GET;

                Courier := '';
                Flag := FALSE;
                Flag2 := FALSE;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        PLNo: Code[30];
        VendorName: Text[100];
        Courier: Text[100];
        PoGEAtt: Record 50006;
        POGEH: Record 50003;
        PurchHeader: Record 38;
        SuppInvNo: Code[35];
        NoofBoxes: Integer;
        Remarks1: Text[50];
        Flag: Boolean;
        lineno: Integer;
        Forignname: Code[50];
        itemno: Code[50];
        TotalBox: Integer;
        BxQty: Decimal;
        ProdNo: Code[30];
        ProdQty: Decimal;
        ECMA: Code[85];
        PostedReceiptNo: Code[10];
        int1: Integer;
        total_qty: Integer;
        total_amt: Decimal;
        cnt: Integer;
        LotNoInfo: Record 6505;
        CompanyInfo: Record 79;
        ItemLedgerEntry: Record 32;
        recPostedWhseReceiptHeader: Record 7318;
        RecProdOrder: Record 5405;
        BinCode: Code[30];
        L_RegisteredWhseActivityNo: Record 5773;
        PurchaseLine: Record 39;
        Desc: Text[100];
        Item: Record 27;
        BatchNo: Code[50];
        ExpDate: Text;
        Flag2: Boolean;
        int2: Integer;
        ProdQty4: Decimal;
        Flag3: Boolean;
        Flag4: Boolean;
        TotalReturnQty: Integer;
}

