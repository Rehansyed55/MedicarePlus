// table 39 "Purchase Line"
// {
//     // version NAVW113.07,NAVGB13.07

//     Caption = 'Purchase Line';
//     DrillDownPageID = 518;
//     LookupPageID = 518;

//     fields
//     {
//         field(1;"Document Type";Option)
//         {
//             Caption = 'Document Type';
//             OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
//             OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
//         }
//         field(2;"Buy-from Vendor No.";Code[20])
//         {
//             Caption = 'Buy-from Vendor No.';
//             Editable = false;
//             TableRelation = Vendor;
//         }
//         field(3;"Document No.";Code[20])
//         {
//             Caption = 'Document No.';
//             TableRelation = "Purchase Header".No. WHERE (Document Type=FIELD(Document Type));
//         }
//         field(4;"Line No.";Integer)
//         {
//             Caption = 'Line No.';
//         }
//         field(5;Type;Option)
//         {
//             Caption = 'Type';
//             OptionCaption = ' ,G/L Account,Item,,Fixed Asset,Charge (Item)';
//             OptionMembers = " ","G/L Account",Item,,"Fixed Asset","Charge (Item)";

//             trigger OnValidate()
//             var
//                 TempPurchLine: Record "39" temporary;
//             begin
//                 GetPurchHeader;
//                 TestStatusOpen;

//                 TESTFIELD("Qty. Rcd. Not Invoiced",0);
//                 TESTFIELD("Quantity Received",0);
//                 TESTFIELD("Receipt No.",'');

//                 TESTFIELD("Return Qty. Shipped Not Invd.",0);
//                 TESTFIELD("Return Qty. Shipped",0);
//                 TESTFIELD("Return Shipment No.",'');

//                 TESTFIELD("Prepmt. Amt. Inv.",0);

//                 IF "Drop Shipment" THEN
//                   ERROR(
//                     Text001,
//                     FIELDCAPTION(Type),"Sales Order No.");
//                 IF "Special Order" THEN
//                   ERROR(
//                     Text001,
//                     FIELDCAPTION(Type),"Special Order Sales No.");
//                 IF "Prod. Order No." <> '' THEN
//                   ERROR(
//                     Text044,
//                     FIELDCAPTION(Type),FIELDCAPTION("Prod. Order No."),"Prod. Order No.");

//                 IF Type <> xRec.Type THEN BEGIN
//                   IF Quantity <> 0 THEN BEGIN
//                     ReservePurchLine.VerifyChange(Rec,xRec);
//                     CALCFIELDS("Reserved Qty. (Base)");
//                     TESTFIELD("Reserved Qty. (Base)",0);
//                     WhseValidateSourceLine.PurchaseLineVerifyChange(Rec,xRec);
//                   END;
//                   IF xRec.Type IN [Type::Item,Type::"Fixed Asset"] THEN BEGIN
//                     IF Quantity <> 0 THEN
//                       PurchHeader.TESTFIELD(Status,PurchHeader.Status::Open);
//                     DeleteItemChargeAssgnt("Document Type","Document No.","Line No.");
//                   END;
//                   IF xRec.Type = Type::"Charge (Item)" THEN
//                     DeleteChargeChargeAssgnt("Document Type","Document No.","Line No.");
//                   IF xRec."Deferral Code" <> '' THEN
//                     DeferralUtilities.RemoveOrSetDeferralSchedule('',
//                       DeferralUtilities.GetPurchDeferralDocType,'','',
//                       xRec."Document Type",xRec."Document No.",xRec."Line No.",
//                       xRec.GetDeferralAmount,PurchHeader."Posting Date",'',xRec."Currency Code",TRUE);
//                 END;
//                 TempPurchLine := Rec;
//                 INIT;

//                 IF xRec."Line Amount" <> 0 THEN
//                   "Recalculate Invoice Disc." := TRUE;

//                 Type := TempPurchLine.Type;
//                 "System-Created Entry" := TempPurchLine."System-Created Entry";
//                 OnValidateTypeOnCopyFromTempPurchLine(Rec,TempPurchLine);
//                 VALIDATE("FA Posting Type");

//                 IF Type = Type::Item THEN
//                   "Allow Item Charge Assignment" := TRUE
//                 ELSE
//                   "Allow Item Charge Assignment" := FALSE;
//             end;
//         }
//         field(6;"No.";Code[20])
//         {
//             CaptionClass = GetCaptionClass(FIELDNO("No."));
//             Caption = 'No.';
//             TableRelation = IF (Type=CONST(" ")) "Standard Text"
//                             ELSE IF (Type=CONST(G/L Account),
//                                      System-Created Entry=CONST(No)) "G/L Account" WHERE (Direct Posting=CONST(Yes),
//                                                                                           Account Type=CONST(Posting),
//                                                                                           Blocked=CONST(No))
//                                                                                           ELSE IF (Type=CONST(G/L Account),
//                                                                                                    System-Created Entry=CONST(Yes)) "G/L Account"
//                                                                                                    ELSE IF (Type=CONST(Fixed Asset)) "Fixed Asset"
//                                                                                                    ELSE IF (Type=CONST("Charge (Item)")) "Item Charge"
//                                                                                                    ELSE IF (Type=CONST(Item),
//                                                                                                             Document Type=FILTER(<>Credit Memo&<>Return Order)) Item WHERE (Blocked=CONST(No),
//                                                                                                                                                                             Purchasing Blocked=CONST(No))
//                                                                                                                                                                             ELSE IF (Type=CONST(Item),
//                                                                                                                                                                                      Document Type=FILTER(Credit Memo|Return Order)) Item WHERE (Blocked=CONST(No));
//             ValidateTableRelation = false;

//             trigger OnValidate()
//             var
//                 TempPurchLine: Record "39" temporary;
//                 FindRecordMgt: Codeunit "703";
//             begin
//                 GetPurchSetup;
//                 IF PurchSetup."Create Item from Item No." THEN
//                   "No." := FindRecordMgt.FindNoFromTypedValue(Type,"No.",NOT "System-Created Entry");

//                 TestStatusOpen;
//                 TESTFIELD("Qty. Rcd. Not Invoiced",0);
//                 TESTFIELD("Quantity Received",0);
//                 TESTFIELD("Receipt No.",'');

//                 TESTFIELD("Prepmt. Amt. Inv.",0);

//                 TestReturnFieldsZero;

//                 IF "Drop Shipment" THEN
//                   ERROR(
//                     Text001,
//                     FIELDCAPTION("No."),"Sales Order No.");

//                 IF "Special Order" THEN
//                   ERROR(
//                     Text001,
//                     FIELDCAPTION("No."),"Special Order Sales No.");

//                 IF "Prod. Order No." <> '' THEN
//                   ERROR(
//                     Text044,
//                     FIELDCAPTION(Type),FIELDCAPTION("Prod. Order No."),"Prod. Order No.");

//                 OnValidateNoOnAfterChecks(Rec,xRec,CurrFieldNo);

//                 IF "No." <> xRec."No." THEN BEGIN
//                   IF (Quantity <> 0) AND ItemExists(xRec."No.") THEN BEGIN
//                     ReservePurchLine.VerifyChange(Rec,xRec);
//                     CALCFIELDS("Reserved Qty. (Base)");
//                     TESTFIELD("Reserved Qty. (Base)",0);
//                     IF Type = Type::Item THEN
//                       WhseValidateSourceLine.PurchaseLineVerifyChange(Rec,xRec);
//                     OnValidateNoOnAfterVerifyChange(Rec,xRec);
//                   END;
//                   IF Type = Type::Item THEN
//                     DeleteItemChargeAssgnt("Document Type","Document No.","Line No.");
//                   IF Type = Type::"Charge (Item)" THEN
//                     DeleteChargeChargeAssgnt("Document Type","Document No.","Line No.");
//                 END;

//                 OnValidateNoOnBeforeInitRec(Rec,xRec,CurrFieldNo);
//                 TempPurchLine := Rec;
//                 INIT;
//                 IF xRec."Line Amount" <> 0 THEN
//                   "Recalculate Invoice Disc." := TRUE;
//                 Type := TempPurchLine.Type;
//                 "No." := TempPurchLine."No.";
//                 OnValidateNoOnCopyFromTempPurchLine(Rec,TempPurchLine);
//                 IF "No." = '' THEN
//                   EXIT;

//                 IF HasTypeToFillMandatoryFields THEN BEGIN
//                   Quantity := TempPurchLine.Quantity;
//                   "Outstanding Qty. (Base)" := TempPurchLine."Outstanding Qty. (Base)";
//                 END;

//                 "System-Created Entry" := TempPurchLine."System-Created Entry";
//                 GetPurchHeader;
//                 InitHeaderDefaults(PurchHeader);
//                 UpdateLeadTimeFields;
//                 UpdateDates;
//                 "Reverse Charge Item" := FALSE;

//                 OnAfterAssignHeaderValues(Rec,PurchHeader);

//                 CASE Type OF
//                   Type::" ":
//                     CopyFromStandardText;
//                   Type::"G/L Account":
//                     CopyFromGLAccount;
//                   Type::Item:
//                     CopyFromItem;
//                   3:
//                     ERROR(Text003);
//                   Type::"Fixed Asset":
//                     CopyFromFixedAsset;
//                   Type::"Charge (Item)":
//                     CopyFromItemCharge;
//                 END;

//                 OnAfterAssignFieldsForNo(Rec,xRec,PurchHeader);

//                 IF HasTypeToFillMandatoryFields AND NOT (Type = Type::"Fixed Asset") THEN
//                   VALIDATE("VAT Prod. Posting Group");

//                 UpdatePrepmtSetupFields;

//                 IF HasTypeToFillMandatoryFields THEN BEGIN
//                   Quantity := xRec.Quantity;
//                   OnValidateNoOnAfterAssignQtyFromXRec(Rec,TempPurchLine);
//                   VALIDATE("Unit of Measure Code");
//                   IF Quantity <> 0 THEN BEGIN
//                     InitOutstanding;
//                     IF IsCreditDocType THEN
//                       InitQtyToShip
//                     ELSE
//                       InitQtyToReceive;
//                   END;
//                   UpdateWithWarehouseReceive;
//                   UpdateDirectUnitCost(FIELDNO("No."));
//                   IF xRec."Job No." <> '' THEN
//                     VALIDATE("Job No.",xRec."Job No.");
//                   "Job Line Type" := xRec."Job Line Type";
//                   IF xRec."Job Task No." <> '' THEN BEGIN
//                     VALIDATE("Job Task No.",xRec."Job Task No.");
//                     IF "No." = xRec."No." THEN
//                       VALIDATE("Job Planning Line No.",xRec."Job Planning Line No.");
//                   END;
//                 END;

//                 CreateDim(
//                   DimMgt.TypeToTableID3(Type),"No.",
//                   DATABASE::Job,"Job No.",
//                   DATABASE::"Responsibility Center","Responsibility Center",
//                   DATABASE::"Work Center","Work Center No.");

//                 PurchHeader.GET("Document Type","Document No.");
//                 UpdateItemReference;

//                 GetDefaultBin;

//                 IF JobTaskIsSet THEN BEGIN
//                   CreateTempJobJnlLine(TRUE);
//                   UpdateJobPrices;
//                   UpdateDimensionsFromJobTask;
//                 END;
//                 //after upgrade





//                  //Vendors price in blanket order

//                  IF "Document Type" = "Document Type"::"Blanket Order" THEN BEGIN
//                  PurchasePriceNew.RESET;
//                  PurchasePriceNew.SETRANGE(PurchasePriceNew."Item No.","No.");
//                  PurchasePriceNew.SETRANGE(PurchasePriceNew."Vendor No.","Buy-from Vendor No.");
//                  PurchasePriceNew.SETRANGE(PurchasePriceNew."Unit of Measure Code","Unit of Measure Code");
//                 // IF PurchasePriceNew.FINDFIRST THEN
//                  IF PurchasePriceNew.FINDLAST THEN
//                  "Direct Unit Cost":=PurchasePriceNew."Direct Unit Cost";
//                   END;

//                 //after upgrade
//                 PostingSetupMgt.CheckGenPostingSetupPurchAccount("Gen. Bus. Posting Group","Gen. Prod. Posting Group");
//                 PostingSetupMgt.CheckVATPostingSetupPurchAccount("VAT Bus. Posting Group","VAT Prod. Posting Group");
//             end;
//         }
//         field(7;"Location Code";Code[10])
//         {
//             Caption = 'Location Code';
//             TableRelation = Location WHERE (Use As In-Transit=CONST(No));

//             trigger OnValidate()
//             var
//                 Item: Record "27";
//                 ConfirmManagement: Codeunit "27";
//             begin
//                 TestStatusOpen;

//                 IF "Location Code" <> '' THEN
//                   IF IsNonInventoriableItem THEN BEGIN
//                     GetItem(Item);
//                     Item.TESTFIELD(Type,Item.Type::Inventory);
//                   END;
//                 IF xRec."Location Code" <> "Location Code" THEN BEGIN
//                   IF "Prepmt. Amt. Inv." <> 0 THEN
//                     IF NOT ConfirmManagement.ConfirmProcess(
//                          STRSUBSTNO(
//                            Text046,FIELDCAPTION("Direct Unit Cost"),FIELDCAPTION("Location Code"),PRODUCTNAME.FULL),TRUE)
//                     THEN BEGIN
//                       "Location Code" := xRec."Location Code";
//                       EXIT;
//                     END;
//                   TESTFIELD("Qty. Rcd. Not Invoiced",0);
//                   TESTFIELD("Receipt No.",'');

//                   TESTFIELD("Return Qty. Shipped Not Invd.",0);
//                   TESTFIELD("Return Shipment No.",'');
//                 END;

//                 IF "Drop Shipment" THEN
//                   ERROR(
//                     Text001,
//                     FIELDCAPTION("Location Code"),"Sales Order No.");
//                 IF "Special Order" THEN
//                   ERROR(
//                     Text001,
//                     FIELDCAPTION("Location Code"),"Special Order Sales No.");

//                 IF "Location Code" <> xRec."Location Code" THEN
//                   InitItemAppl;

//                 IF (xRec."Location Code" <> "Location Code") AND (Quantity <> 0) THEN BEGIN
//                   ReservePurchLine.VerifyChange(Rec,xRec);
//                   WhseValidateSourceLine.PurchaseLineVerifyChange(Rec,xRec);
//                   UpdateWithWarehouseReceive;
//                   PostingSetupMgt.CheckInvtPostingSetupInventoryAccount("Location Code","Posting Group");
//                 END;
//                 "Bin Code" := '';

//                 IF Type = Type::Item THEN
//                   UpdateDirectUnitCost(FIELDNO("Location Code"));

//                 IF "Location Code" = '' THEN BEGIN
//                   IF InvtSetup.GET THEN
//                     "Inbound Whse. Handling Time" := InvtSetup."Inbound Whse. Handling Time";
//                 END ELSE
//                   IF Location.GET("Location Code") THEN
//                     "Inbound Whse. Handling Time" := Location."Inbound Whse. Handling Time";

//                 UpdateLeadTimeFields;
//                 UpdateDates;

//                 GetDefaultBin;
//                 CheckWMS;

//                 IF "Document Type" = "Document Type"::"Return Order" THEN
//                   ValidateReturnReasonCode(FIELDNO("Location Code"));
//             end;
//         }
//         field(8;"Posting Group";Code[20])
//         {
//             Caption = 'Posting Group';
//             Editable = false;
//             TableRelation = IF (Type=CONST(Item)) "Inventory Posting Group"
//                             ELSE IF (Type=CONST(Fixed Asset)) "FA Posting Group";
//         }
//         field(10;"Expected Receipt Date";Date)
//         {
//             AccessByPermission = TableData 120=R;
//             Caption = 'Expected Receipt Date';

//             trigger OnValidate()
//             begin
//                 IF NOT TrackingBlocked THEN
//                   CheckDateConflict.PurchLineCheck(Rec,CurrFieldNo <> 0);

//                 IF "Expected Receipt Date" <> 0D THEN
//                   VALIDATE(
//                     "Planned Receipt Date",
//                     CalendarMgmt.CalcDateBOC2(ReversedInternalLeadTimeDays("Expected Receipt Date"),"Expected Receipt Date",
//                       CalChange."Source Type"::Location,"Location Code",'',
//                       CalChange."Source Type"::Location,"Location Code",'',FALSE))
//                 ELSE
//                   VALIDATE("Planned Receipt Date","Expected Receipt Date");


//                 //Getting the Correct  Order date  from the header to the lines
//                 PurchHeaderRec.RESET;
//                 PurchHeaderRec.SETRANGE(PurchHeaderRec."No.","Document No.");
//                 PurchHeaderRec.SETFILTER(PurchHeaderRec."Document Type",'%1|%2',PurchHeaderRec."Document Type"::Order,
//                 PurchHeaderRec."Document Type"::"Blanket Order");
//                 IF PurchHeaderRec.FINDFIRST THEN
//                 "Order Date":=PurchHeaderRec."Order Date";
//             end;
//         }
//         field(11;Description;Text[50])
//         {
//             Caption = 'Description';
//             TableRelation = IF (Type=CONST(G/L Account),
//                                 System-Created Entry=CONST(No)) "G/L Account".Name WHERE (Direct Posting=CONST(Yes),
//                                                                                           Account Type=CONST(Posting),
//                                                                                           Blocked=CONST(No))
//                                                                                           ELSE IF (Type=CONST(G/L Account),
//                                                                                                    System-Created Entry=CONST(Yes)) "G/L Account".Name
//                                                                                                    ELSE IF (Type=CONST(Item),
//                                                                                                             Document Type=FILTER(<>Credit Memo&<>Return Order)) Item.Description WHERE (Blocked=CONST(No),
//                                                                                                                                                                                         Purchasing Blocked=CONST(No))
//                                                                                                                                                                                         ELSE IF (Type=CONST(Item),
//                                                                                                                                                                                                  Document Type=FILTER(Credit Memo|Return Order)) Item.Description WHERE (Blocked=CONST(No))
//                                                                                                                                                                                                  ELSE IF (Type=CONST(Fixed Asset)) "Fixed Asset".Description
//                                                                                                                                                                                                  ELSE IF (Type=CONST("Charge (Item)")) "Item Charge".Description;
//             ValidateTableRelation = false;

//             trigger OnValidate()
//             var
//                 Item: Record "27";
//                 ApplicationAreaMgmtFacade: Codeunit "9179";
//                 FindRecordMgt: Codeunit "703";
//                 ConfirmManagement: Codeunit "27";
//                 ReturnValue: Text[50];
//                 DescriptionIsNo: Boolean;
//             begin
//                 IF Type = Type::" " THEN
//                   EXIT;
                
//                 IF ("No." <> '') AND (Type IN [Type::Item,Type::"Charge (Item)"]) THEN BEGIN
//                   CASE Type OF
//                     Type::Item:
//                       BEGIN
//                         IF (STRLEN(Description) <= MAXSTRLEN(Item."No.")) AND ("No." <> '') THEN
//                           DescriptionIsNo := Item.GET(Description)
//                         ELSE
//                           DescriptionIsNo := FALSE;
                
//                         IF NOT DescriptionIsNo THEN BEGIN
//                           Item.SETFILTER(Description,'''@' + CONVERTSTR(Description,'''','?') + '''');
//                           IF NOT Item.FINDFIRST THEN
//                             EXIT;
//                           IF Item."No." = "No." THEN
//                             EXIT;
//                           IF IsReceivedFromOcr THEN
//                             EXIT;
//                           /*IF ConfirmManagement.ConfirmProcess(
//                                STRSUBSTNO(AnotherItemWithSameDescrQst,Item."No.",Item.Description),TRUE)
//                           THEN
//                             VALIDATE("No.",Item."No.");*/
//                           EXIT;
//                         END;
                
//                         IF Item.TryGetItemNoOpenCard(ReturnValue,Description,FALSE,FALSE,FALSE) THEN
//                           CASE ReturnValue OF
//                             '',"No.":
//                               Description := xRec.Description;
//                             ELSE
//                               VALIDATE("No.",COPYSTR(ReturnValue,1,MAXSTRLEN(Item."No.")));
//                           END;
//                       END;
//                     Type::"Charge (Item)":
//                       BEGIN
//                         ItemCharge.SETFILTER(Description,'@%1',CONVERTSTR(Description,'''','?'));
//                         IF NOT ItemCharge.FINDFIRST THEN
//                           EXIT;
//                         IF ItemCharge."No." = "No." THEN
//                           EXIT;
//                         IF ConfirmManagement.ConfirmProcess(
//                              STRSUBSTNO(AnotherChargeItemWithSameDescQst,ItemCharge."No.",ItemCharge.Description),TRUE)
//                         THEN
//                           VALIDATE("No.",ItemCharge."No.");
//                       END;
//                   END;
//                 END ELSE
//                   IF "No." = '' THEN BEGIN
//                     ReturnValue := FindRecordMgt.FindNoByDescription(Type,Description,TRUE);
//                     IF ReturnValue <> '' THEN BEGIN
//                       CurrFieldNo := FIELDNO("No.");
//                       VALIDATE("No.",COPYSTR(ReturnValue,1,MAXSTRLEN("No.")));
//                     END;
//                   END;
                
//                 IF ("No." = '') AND GUIALLOWED AND ApplicationAreaMgmtFacade.IsFoundationEnabled THEN
//                   IF "Document Type" IN ["Document Type"::Order] THEN
//                     ERROR(CannotFindDescErr,Type,Description);

//             end;
//         }
//         field(12;"Description 2";Text[50])
//         {
//             Caption = 'Description 2';
//         }
//         field(13;"Unit of Measure";Text[10])
//         {
//             Caption = 'Unit of Measure';
//         }
//         field(15;Quantity;Decimal)
//         {
//             Caption = 'Quantity';
//             DecimalPlaces = 0:5;

//             trigger OnValidate()
//             var
//                 IsHandled: Boolean;
//             begin
//                 TestStatusOpen;
//                 IsHandled := FALSE;
//                 OnValidateQuantityOnBeforeDropShptCheck(Rec,xRec,CurrFieldNo,IsHandled);
//                 IF NOT IsHandled THEN
//                   IF "Drop Shipment" AND ("Document Type" <> "Document Type"::Invoice) THEN
//                     ERROR(
//                       Text001,FIELDCAPTION(Quantity),"Sales Order No.");
//                 "Quantity (Base)" := CalcBaseQty(Quantity);
//                 IF IsCreditDocType THEN BEGIN
//                   IF (Quantity * "Return Qty. Shipped" < 0) OR
//                      ((ABS(Quantity) < ABS("Return Qty. Shipped")) AND ("Return Shipment No." = ''))
//                   THEN
//                     FIELDERROR(Quantity,STRSUBSTNO(Text004,FIELDCAPTION("Return Qty. Shipped")));
//                   IF ("Quantity (Base)" * "Return Qty. Shipped (Base)" < 0) OR
//                      ((ABS("Quantity (Base)") < ABS("Return Qty. Shipped (Base)")) AND ("Return Shipment No." = ''))
//                   THEN
//                     FIELDERROR("Quantity (Base)",STRSUBSTNO(Text004,FIELDCAPTION("Return Qty. Shipped (Base)")));
//                 END ELSE BEGIN
//                   IF (Quantity * "Quantity Received" < 0) OR
//                      ((ABS(Quantity) < ABS("Quantity Received")) AND ("Receipt No." = ''))
//                   THEN
//                     FIELDERROR(Quantity,STRSUBSTNO(Text004,FIELDCAPTION("Quantity Received")));
//                   IF ("Quantity (Base)" * "Qty. Received (Base)" < 0) OR
//                      ((ABS("Quantity (Base)") < ABS("Qty. Received (Base)")) AND ("Receipt No." = ''))
//                   THEN
//                     FIELDERROR("Quantity (Base)",STRSUBSTNO(Text004,FIELDCAPTION("Qty. Received (Base)")));
//                 END;
                
//                 IF (Type = Type::"Charge (Item)") AND (CurrFieldNo <> 0) THEN BEGIN
//                   IF (Quantity = 0) AND ("Qty. to Assign" <> 0) THEN
//                     FIELDERROR("Qty. to Assign",STRSUBSTNO(Text011,FIELDCAPTION(Quantity),Quantity));
//                   IF (Quantity * "Qty. Assigned" < 0) OR (ABS(Quantity) < ABS("Qty. Assigned")) THEN
//                     FIELDERROR(Quantity,STRSUBSTNO(Text004,FIELDCAPTION("Qty. Assigned")));
//                 END;
                
//                 IF "Receipt No." <> '' THEN
//                   CheckReceiptRelation
//                 ELSE
//                   IF "Return Shipment No." <> '' THEN
//                     CheckRetShptRelation;
                
//                 IF (xRec.Quantity <> Quantity) OR (xRec."Quantity (Base)" <> "Quantity (Base)") OR
//                    ("No." = xRec."No.")
//                 THEN BEGIN
//                   InitOutstanding;
//                   IF IsCreditDocType THEN
//                     InitQtyToShip
//                   ELSE
//                     InitQtyToReceive;
//                 END;
//                 IF (Quantity * xRec.Quantity < 0) OR (Quantity = 0) THEN
//                   InitItemAppl;
                
//                 /*IF Type = Type::Item THEN
//                   UpdateDirectUnitCost(FIELDNO(Quantity))
//                 ELSE*///Sofyan
//                   VALIDATE("Line Discount %");
                
//                 IF Type = Type::"Charge (Item)" THEN
//                   "Line Discount %" := 0;
                
//                 UpdateWithWarehouseReceive;
//                 IF (xRec.Quantity <> Quantity) OR (xRec."Quantity (Base)" <> "Quantity (Base)") THEN BEGIN
//                   OnBeforeVerifyReservedQty(Rec,xRec,FIELDNO(Quantity));
//                   ReservePurchLine.VerifyQuantity(Rec,xRec);
//                   WhseValidateSourceLine.PurchaseLineVerifyChange(Rec,xRec);
//                   CheckApplToItemLedgEntry;
//                 END;
                
//                 IF (xRec.Quantity <> Quantity) AND (Quantity = 0) AND
//                    ((Amount <> 0) OR ("Amount Including VAT" <> 0) OR ("VAT Base Amount" <> 0))
//                 THEN BEGIN
//                   Amount := 0;
//                   "Amount Including VAT" := 0;
//                   "VAT Base Amount" := 0;
//                 END;
                
//                 //Alok For Qty  on Blanket
//                 IF "Document Type"="Document Type"::"Blanket Order" THEN BEGIN
//                 "Qty. on Blanket Order(Actual)":=Quantity;
                
                
//                 "Qty. on Blanket Order(Actual)":="Qty. on Blanket Order(Actual)"*"Qty. per Unit of Measure" ;
//                 END;
//                 UpdatePrePaymentAmounts;
                
//                 IF "Job Planning Line No." <> 0 THEN
//                   VALIDATE("Job Planning Line No.");
                
//                 IF JobTaskIsSet THEN BEGIN
//                   CreateTempJobJnlLine(TRUE);
//                   UpdateJobPrices;
//                 END;
                
//                 CheckWMS;

//             end;
//         }
//         field(16;"Outstanding Quantity";Decimal)
//         {
//             Caption = 'Outstanding Quantity';
//             DecimalPlaces = 0:5;
//             Editable = false;
//         }
//         field(17;"Qty. to Invoice";Decimal)
//         {
//             Caption = 'Qty. to Invoice';
//             DecimalPlaces = 0:5;

//             trigger OnValidate()
//             begin
//                 IF "Qty. to Invoice" = MaxQtyToInvoice THEN
//                   InitQtyToInvoice
//                 ELSE
//                   "Qty. to Invoice (Base)" := CalcBaseQty("Qty. to Invoice");
//                 IF ("Qty. to Invoice" * Quantity < 0) OR (ABS("Qty. to Invoice") > ABS(MaxQtyToInvoice)) THEN
//                   ERROR(
//                     Text006,
//                     MaxQtyToInvoice);
//                 IF ("Qty. to Invoice (Base)" * "Quantity (Base)" < 0) OR (ABS("Qty. to Invoice (Base)") > ABS(MaxQtyToInvoiceBase)) THEN
//                   ERROR(
//                     Text007,
//                     MaxQtyToInvoiceBase);
//                 "VAT Difference" := 0;
//                 CalcInvDiscToInvoice;
//                 CalcPrepaymentToDeduct;

//                 IF "Job Planning Line No." <> 0 THEN
//                   VALIDATE("Job Planning Line No.");
//             end;
//         }
//         field(18;"Qty. to Receive";Decimal)
//         {
//             AccessByPermission = TableData 120=R;
//             Caption = 'Qty. to Receive';
//             DecimalPlaces = 0:5;

//             trigger OnValidate()
//             begin
//                 GetLocation("Location Code");
//                 IF (CurrFieldNo <> 0) AND (Type = Type::Item) AND (NOT "Drop Shipment") THEN BEGIN
//                   IF Location."Require Receive" AND ("Qty. to Receive" <> 0) THEN
//                     CheckWarehouse;
//                   WhseValidateSourceLine.PurchaseLineVerifyChange(Rec,xRec);
//                 END;
//                 OnValidateQtyToReceiveOnAfterCheck(Rec,CurrFieldNo);

//                 IF "Qty. to Receive" = Quantity - "Quantity Received" THEN
//                   InitQtyToReceive
//                 ELSE BEGIN
//                   "Qty. to Receive (Base)" := CalcBaseQty("Qty. to Receive");
//                   InitQtyToInvoice;
//                 END;
//                 IF ((("Qty. to Receive" < 0) XOR (Quantity < 0)) AND (Quantity <> 0) AND ("Qty. to Receive" <> 0)) OR
//                    (ABS("Qty. to Receive") > ABS("Outstanding Quantity")) OR
//                    (((Quantity < 0 ) XOR ("Outstanding Quantity" < 0)) AND (Quantity <> 0) AND ("Outstanding Quantity" <> 0))
//                 THEN
//                   ERROR(
//                     Text008,
//                     "Outstanding Quantity");
//                 IF ((("Qty. to Receive (Base)" < 0) XOR ("Quantity (Base)" < 0)) AND ("Quantity (Base)" <> 0) AND ("Qty. to Receive (Base)" <> 0)) OR
//                    (ABS("Qty. to Receive (Base)") > ABS("Outstanding Qty. (Base)")) OR
//                    ((("Quantity (Base)" < 0) XOR ("Outstanding Qty. (Base)" < 0)) AND ("Quantity (Base)" <> 0) AND ("Outstanding Qty. (Base)" <> 0))
//                 THEN
//                   ERROR(
//                     Text009,
//                     "Outstanding Qty. (Base)");

//                 IF (CurrFieldNo <> 0) AND (Type = Type::Item) AND ("Qty. to Receive" < 0) THEN
//                   CheckApplToItemLedgEntry;

//                 IF "Job Planning Line No." <> 0 THEN
//                   VALIDATE("Job Planning Line No.");
//                 //alok
//                 PDN := 0;
//                 Purchaseline.SETRANGE(Purchaseline."Document Type",Purchaseline."Document Type"::Order);
//                 Purchaseline.SETRANGE(Purchaseline."Blanket Order No.","Document No.");
//                 Purchaseline.SETRANGE(Purchaseline."No.","No.");
//                 Purchaseline.SETRANGE(Purchaseline."Blanket Order Line No.","Line No.");
//                 IF Purchaseline.FINDFIRST THEN  BEGIN
//                   REPEAT
//                   PDN := PDN + Purchaseline.Quantity;
//                   UNTIL Purchaseline.NEXT = 0;
//                 END;
//                   "PDN Quantity" :=  PDN;
//                 //Alok for Qty on Blanket order
//                 IF "Document Type"="Document Type"::"Blanket Order" THEN  BEGIN
//                 "Qty. on Blanket Order(Actual)":=Quantity-"PDN Quantity";

//                   "Qty. on Blanket Order(Actual)":="Qty. on Blanket Order(Actual)"*"Qty. per Unit of Measure" ;
//                 END;
//             end;
//         }
//         field(22;"Direct Unit Cost";Decimal)
//         {
//             AutoFormatExpression = "Currency Code";
//             AutoFormatType = 2;
//             CaptionClass = GetCaptionClass(FIELDNO("Direct Unit Cost"));
//             Caption = 'Direct Unit Cost';

//             trigger OnValidate()
//             begin
//                 VALIDATE("Line Discount %");
//             end;
//         }
//         field(23;"Unit Cost (LCY)";Decimal)
//         {
//             AutoFormatType = 2;
//             Caption = 'Unit Cost (LCY)';

//             trigger OnValidate()
//             var
//                 Item: Record "27";
//                 IndirectCostPercent: Decimal;
//             begin
//                 TestStatusOpen;
//                 TESTFIELD("No.");
//                 TESTFIELD(Quantity);

//                 IF "Prod. Order No." <> '' THEN
//                   ERROR(
//                     Text99000000,
//                     FIELDCAPTION("Unit Cost (LCY)"));

//                 IF CurrFieldNo = FIELDNO("Unit Cost (LCY)") THEN
//                   IF Type = Type::Item THEN BEGIN
//                     GetItem(Item);
//                     IF Item."Costing Method" = Item."Costing Method"::Standard THEN
//                       ERROR(
//                         Text010,
//                         FIELDCAPTION("Unit Cost (LCY)"),Item.FIELDCAPTION("Costing Method"),Item."Costing Method");
//                   END;

//                 UnitCostCurrency := "Unit Cost (LCY)";
//                 GetPurchHeader;
//                 IF PurchHeader."Currency Code" <> '' THEN BEGIN
//                   PurchHeader.TESTFIELD("Currency Factor");
//                   GetGLSetup;
//                   UnitCostCurrency :=
//                     ROUND(
//                       CurrExchRate.ExchangeAmtLCYToFCY(
//                         GetDate,"Currency Code",
//                         "Unit Cost (LCY)",PurchHeader."Currency Factor"),
//                       GLSetup."Unit-Amount Rounding Precision");
//                 END;

//                 "Indirect Cost %" := 0;
//                 IF ("Direct Unit Cost" <> 0) AND
//                    ("Direct Unit Cost" <> ("Line Discount Amount" / Quantity))
//                 THEN BEGIN
//                   IndirectCostPercent :=
//                     ROUND(
//                       (UnitCostCurrency - "Direct Unit Cost" + "Line Discount Amount" / Quantity) /
//                       ("Direct Unit Cost" - "Line Discount Amount" / Quantity) * 100,0.00001);
//                   IF IndirectCostPercent >= 0 THEN
//                     "Indirect Cost %" := IndirectCostPercent;
//                 END;

//                 UpdateSalesCost;

//                 IF JobTaskIsSet THEN BEGIN
//                   CreateTempJobJnlLine(FALSE);
//                   TempJobJnlLine.VALIDATE("Unit Cost (LCY)","Unit Cost (LCY)");
//                   UpdateJobPrices;
//                 END
//             end;
//         }
//         field(25;"VAT %";Decimal)
//         {
//             Caption = 'VAT %';
//             DecimalPlaces = 0:5;
//             Editable = false;
//         }
//         field(27;"Line Discount %";Decimal)
//         {
//             Caption = 'Line Discount %';
//             DecimalPlaces = 0:5;
//             Editable = false;
//             MaxValue = 100;
//             MinValue = 0;

//             trigger OnValidate()
//             begin
//                 ValidateLineDiscountPercent(TRUE);
//             end;
//         }
//         field(28;"Line Discount Amount";Decimal)
//         {
//             AutoFormatExpression = "Currency Code";
//             AutoFormatType = 1;
//             Caption = 'Line Discount Amount';
//             Editable = false;

//             trigger OnValidate()
//             begin
//                 GetPurchHeader;
//                 "Line Discount Amount" := ROUND("Line Discount Amount",Currency."Amount Rounding Precision");
//                 TestStatusOpen;
//                 TESTFIELD(Quantity);
//                 IF xRec."Line Discount Amount" <> "Line Discount Amount" THEN
//                   UpdateLineDiscPct;
//                 "Inv. Discount Amount" := 0;
//                 "Inv. Disc. Amount to Invoice" := 0;
//                 UpdateAmounts;
//                 UpdateUnitCost;
//             end;
//         }
//         field(29;Amount;Decimal)
//         {
//             AutoFormatExpression = "Currency Code";
//             AutoFormatType = 1;
//             Caption = 'Amount';
//             Editable = false;

//             trigger OnValidate()
//             begin
//                 GetPurchHeader;
//                 Amount := ROUND(Amount,Currency."Amount Rounding Precision");
//                 CASE "VAT Calculation Type" OF
//                   "VAT Calculation Type"::"Normal VAT",
//                   "VAT Calculation Type"::"Reverse Charge VAT":
//                     BEGIN
//                       "VAT Base Amount" :=
//                         ROUND(Amount * (1 - PurchHeader."VAT Base Discount %" / 100),Currency."Amount Rounding Precision");
//                       "Amount Including VAT" :=
//                         ROUND(Amount + "VAT Base Amount" * "VAT %" / 100,Currency."Amount Rounding Precision");
//                     END;
//                   "VAT Calculation Type"::"Full VAT":
//                     IF Amount <> 0 THEN
//                       FIELDERROR(Amount,
//                         STRSUBSTNO(
//                           Text011,FIELDCAPTION("VAT Calculation Type"),
//                           "VAT Calculation Type"));
//                   "VAT Calculation Type"::"Sales Tax":
//                     BEGIN
//                       PurchHeader.TESTFIELD("VAT Base Discount %",0);
//                       "VAT Base Amount" := Amount;
//                       IF "Use Tax" THEN
//                         "Amount Including VAT" := "VAT Base Amount"
//                       ELSE BEGIN
//                         "Amount Including VAT" :=
//                           Amount +
//                           ROUND(
//                             SalesTaxCalculate.CalculateTax(
//                               "Tax Area Code","Tax Group Code","Tax Liable",PurchHeader."Posting Date",
//                               "VAT Base Amount","Quantity (Base)",PurchHeader."Currency Factor"),
//                             Currency."Amount Rounding Precision");
//                         IF "VAT Base Amount" <> 0 THEN
//                           "VAT %" :=
//                             ROUND(100 * ("Amount Including VAT" - "VAT Base Amount") / "VAT Base Amount",0.00001)
//                         ELSE
//                           "VAT %" := 0;
//                       END;
//                     END;
//                 END;

//                 InitOutstandingAmount;
//                 UpdateUnitCost;
//             end;
//         }
//         field(30;"Amount Including VAT";Decimal)
//         {
//             AutoFormatExpression = "Currency Code";
//             AutoFormatType = 1;
//             Caption = 'Amount Including VAT';
//             Editable = false;

//             trigger OnValidate()
//             begin
//                 GetPurchHeader;
//                 "Amount Including VAT" := ROUND("Amount Including VAT",Currency."Amount Rounding Precision");
//                 CASE "VAT Calculation Type" OF
//                   "VAT Calculation Type"::"Normal VAT",
//                   "VAT Calculation Type"::"Reverse Charge VAT":
//                     BEGIN
//                       Amount :=
//                         ROUND(
//                           "Amount Including VAT" /
//                           (1 + (1 - PurchHeader."VAT Base Discount %" / 100) * "VAT %" / 100),
//                           Currency."Amount Rounding Precision");
//                       "VAT Base Amount" :=
//                         ROUND(Amount * (1 - PurchHeader."VAT Base Discount %" / 100),Currency."Amount Rounding Precision");
//                     END;
//                   "VAT Calculation Type"::"Full VAT":
//                     BEGIN
//                       Amount := 0;
//                       "VAT Base Amount" := 0;
//                     END;
//                   "VAT Calculation Type"::"Sales Tax":
//                     BEGIN
//                       PurchHeader.TESTFIELD("VAT Base Discount %",0);
//                       IF "Use Tax" THEN BEGIN
//                         Amount := "Amount Including VAT";
//                         "VAT Base Amount" := Amount;
//                       END ELSE BEGIN
//                         Amount :=
//                           ROUND(
//                             SalesTaxCalculate.ReverseCalculateTax(
//                               "Tax Area Code","Tax Group Code","Tax Liable",PurchHeader."Posting Date",
//                               "Amount Including VAT","Quantity (Base)",PurchHeader."Currency Factor"),
//                             Currency."Amount Rounding Precision");
//                         "VAT Base Amount" := Amount;
//                         IF "VAT Base Amount" <> 0 THEN
//                           "VAT %" :=
//                             ROUND(100 * ("Amount Including VAT" - "VAT Base Amount") / "VAT Base Amount",0.00001)
//                         ELSE
//                           "VAT %" := 0;
//                       END;
//                     END;
//                 END;

//                 InitOutstandingAmount;
//                 UpdateUnitCost;
//             end;
//         }
//         field(31;"Unit Price (LCY)";Decimal)
//         {
//             AutoFormatType = 2;
//             Caption = 'Unit Price (LCY)';
//         }
//         field(32;"Allow Invoice Disc.";Boolean)
//         {
//             Caption = 'Allow Invoice Disc.';
//             Editable = false;
//             InitValue = true;

//             trigger OnValidate()
//             begin
//                 TestStatusOpen;
//                 IF ("Allow Invoice Disc." <> xRec."Allow Invoice Disc.") AND
//                    (NOT "Allow Invoice Disc.")
//                 THEN BEGIN
//                   "Inv. Discount Amount" := 0;
//                   "Inv. Disc. Amount to Invoice" := 0;
//                   UpdateAmounts;
//                   UpdateUnitCost;
//                 END;
//             end;
//         }
//         field(34;"Gross Weight";Decimal)
//         {
//             Caption = 'Gross Weight';
//             DecimalPlaces = 0:5;
//         }
//         field(35;"Net Weight";Decimal)
//         {
//             Caption = 'Net Weight';
//             DecimalPlaces = 0:5;
//         }
//         field(36;"Units per Parcel";Decimal)
//         {
//             Caption = 'Units per Parcel';
//             DecimalPlaces = 0:5;
//         }
//         field(37;"Unit Volume";Decimal)
//         {
//             Caption = 'Unit Volume';
//             DecimalPlaces = 0:5;
//         }
//         field(38;"Appl.-to Item Entry";Integer)
//         {
//             AccessByPermission = TableData 27=R;
//             Caption = 'Appl.-to Item Entry';

//             trigger OnLookup()
//             begin
//                 SelectItemEntry;
//             end;

//             trigger OnValidate()
//             begin
//                 IF "Appl.-to Item Entry" <> 0 THEN
//                   "Location Code" := CheckApplToItemLedgEntry;
//             end;
//         }
//         field(40;"Shortcut Dimension 1 Code";Code[20])
//         {
//             CaptionClass = '1,2,1';
//             Caption = 'Shortcut Dimension 1 Code';
//             TableRelation = "Dimension Value".Code WHERE (Global Dimension No.=CONST(1),
//                                                           Blocked=CONST(No));

//             trigger OnValidate()
//             begin
//                 ValidateShortcutDimCode(1,"Shortcut Dimension 1 Code");
//             end;
//         }
//         field(41;"Shortcut Dimension 2 Code";Code[20])
//         {
//             CaptionClass = '1,2,2';
//             Caption = 'Shortcut Dimension 2 Code';
//             TableRelation = "Dimension Value".Code WHERE (Global Dimension No.=CONST(2),
//                                                           Blocked=CONST(No));

//             trigger OnValidate()
//             begin
//                 ValidateShortcutDimCode(2,"Shortcut Dimension 2 Code");
//             end;
//         }
//         field(45;"Job No.";Code[20])
//         {
//             Caption = 'Job No.';
//             TableRelation = Job;

//             trigger OnValidate()
//             var
//                 Job: Record "167";
//             begin
//                 TESTFIELD("Drop Shipment",FALSE);
//                 TESTFIELD("Special Order",FALSE);
//                 TESTFIELD("Receipt No.",'');
//                 IF "Document Type" = "Document Type"::Order THEN
//                   TESTFIELD("Quantity Received",0);

//                 IF ReservEntryExist THEN
//                   TESTFIELD("Job No.",'');

//                 IF "Job No." <> xRec."Job No." THEN BEGIN
//                   VALIDATE("Job Task No.",'');
//                   VALIDATE("Job Planning Line No.",0);
//                 END;

//                 IF "Job No." = '' THEN BEGIN
//                   CreateDim(
//                     DATABASE::Job,"Job No.",
//                     DimMgt.TypeToTableID3(Type),"No.",
//                     DATABASE::"Responsibility Center","Responsibility Center",
//                     DATABASE::"Work Center","Work Center No.");
//                   EXIT;
//                 END;

//                 IF NOT (Type IN [Type::Item,Type::"G/L Account"]) THEN
//                   FIELDERROR("Job No.",STRSUBSTNO(Text012,FIELDCAPTION(Type),Type));
//                 Job.GET("Job No.");
//                 Job.TestBlocked;
//                 "Job Currency Code" := Job."Currency Code";

//                 CreateDim(
//                   DATABASE::Job,"Job No.",
//                   DimMgt.TypeToTableID3(Type),"No.",
//                   DATABASE::"Responsibility Center","Responsibility Center",
//                   DATABASE::"Work Center","Work Center No.");
//             end;
//         }
//         field(54;"Indirect Cost %";Decimal)
//         {
//             Caption = 'Indirect Cost %';
//             DecimalPlaces = 0:5;
//             MinValue = 0;

//             trigger OnValidate()
//             var
//                 Item: Record "27";
//             begin
//                 TESTFIELD("No.");
//                 TestStatusOpen;

//                 IF Type = Type::"Charge (Item)" THEN
//                   TESTFIELD("Indirect Cost %",0);

//                 IF (Type = Type::Item) AND ("Prod. Order No." = '') THEN BEGIN
//                   GetItem(Item);
//                   Item.TESTFIELD(Type,Item.Type::Inventory);
//                   IF Item."Costing Method" = Item."Costing Method"::Standard THEN
//                     ERROR(
//                       Text010,
//                       FIELDCAPTION("Indirect Cost %"),Item.FIELDCAPTION("Costing Method"),Item."Costing Method");
//                 END;

//                 UpdateUnitCost;
//             end;
//         }
//         field(56;"Recalculate Invoice Disc.";Boolean)
//         {
//             Caption = 'Recalculate Invoice Disc.';
//             Editable = false;
//         }
//         field(57;"Outstanding Amount";Decimal)
//         {
//             AutoFormatExpression = "Currency Code";
//             AutoFormatType = 1;
//             Caption = 'Outstanding Amount';
//             Editable = false;

//             trigger OnValidate()
//             var
//                 Currency2: Record "4";
//             begin
//                 GetPurchHeader;
//                 Currency2.InitRoundingPrecision;
//                 IF PurchHeader."Currency Code" <> '' THEN
//                   "Outstanding Amount (LCY)" :=
//                     ROUND(
//                       CurrExchRate.ExchangeAmtFCYToLCY(
//                         GetDate,"Currency Code",
//                         "Outstanding Amount",PurchHeader."Currency Factor"),
//                       Currency2."Amount Rounding Precision")
//                 ELSE
//                   "Outstanding Amount (LCY)" :=
//                     ROUND("Outstanding Amount",Currency2."Amount Rounding Precision");

//                 "Outstanding Amt. Ex. VAT (LCY)" :=
//                   ROUND("Outstanding Amount (LCY)" / (1 + "VAT %" / 100),Currency2."Amount Rounding Precision");
//             end;
//         }
//         field(58;"Qty. Rcd. Not Invoiced";Decimal)
//         {
//             Caption = 'Qty. Rcd. Not Invoiced';
//             DecimalPlaces = 0:5;
//             Editable = false;
//         }
//         field(59;"Amt. Rcd. Not Invoiced";Decimal)
//         {
//             AutoFormatExpression = "Currency Code";
//             AutoFormatType = 1;
//             Caption = 'Amt. Rcd. Not Invoiced';
//             Editable = false;

//             trigger OnValidate()
//             var
//                 Currency2: Record "4";
//             begin
//                 GetPurchHeader;
//                 Currency2.InitRoundingPrecision;
//                 IF PurchHeader."Currency Code" <> '' THEN
//                   "Amt. Rcd. Not Invoiced (LCY)" :=
//                     ROUND(
//                       CurrExchRate.ExchangeAmtFCYToLCY(
//                         GetDate,"Currency Code",
//                         "Amt. Rcd. Not Invoiced",PurchHeader."Currency Factor"),
//                       Currency2."Amount Rounding Precision")
//                 ELSE
//                   "Amt. Rcd. Not Invoiced (LCY)" :=
//                     ROUND("Amt. Rcd. Not Invoiced",Currency2."Amount Rounding Precision");

//                 "A. Rcd. Not Inv. Ex. VAT (LCY)" :=
//                   ROUND("Amt. Rcd. Not Invoiced (LCY)" / (1 + "VAT %" / 100),Currency2."Amount Rounding Precision");
//             end;
//         }
//         field(60;"Quantity Received";Decimal)
//         {
//             AccessByPermission = TableData 120=R;
//             Caption = 'Quantity Received';
//             DecimalPlaces = 0:5;
//             Editable = false;
//         }
//         field(61;"Quantity Invoiced";Decimal)
//         {
//             Caption = 'Quantity Invoiced';
//             DecimalPlaces = 0:5;
//             Editable = false;
//         }
//         field(63;"Receipt No.";Code[20])
//         {
//             Caption = 'Receipt No.';
//             Editable = false;
//         }
//         field(64;"Receipt Line No.";Integer)
//         {
//             Caption = 'Receipt Line No.';
//             Editable = false;
//         }
//         field(65;"Order No.";Code[20])
//         {
//             Caption = 'Order No.';
//         }
//         field(66;"Order Line No.";Integer)
//         {
//             Caption = 'Order Line No.';
//         }
//         field(67;"Profit %";Decimal)
//         {
//             Caption = 'Profit %';
//             DecimalPlaces = 0:5;
//             Editable = false;
//         }
//         field(68;"Pay-to Vendor No.";Code[20])
//         {
//             Caption = 'Pay-to Vendor No.';
//             Editable = false;
//             TableRelation = Vendor;
//         }
//         field(69;"Inv. Discount Amount";Decimal)
//         {
//             AutoFormatExpression = "Currency Code";
//             AutoFormatType = 1;
//             Caption = 'Inv. Discount Amount';
//             Editable = false;

//             trigger OnValidate()
//             begin
//                 UpdateAmounts;
//                 UpdateUnitCost;
//                 CalcInvDiscToInvoice;
//             end;
//         }
//         field(70;"Vendor Item No.";Text[20])
//         {
//             Caption = 'Vendor Item No.';

//             trigger OnValidate()
//             begin
//                 IF PurchHeader."Send IC Document" AND
//                    ("IC Partner Ref. Type" = "IC Partner Ref. Type"::"Vendor Item No.")
//                 THEN
//                   "IC Partner Reference" := "Vendor Item No.";
//             end;
//         }
//         field(71;"Sales Order No.";Code[20])
//         {
//             Caption = 'Sales Order No.';
//             Editable = false;
//             TableRelation = IF (Drop Shipment=CONST(Yes)) "Sales Header".No. WHERE (Document Type=CONST(Order));

//             trigger OnValidate()
//             begin
//                 IF (xRec."Sales Order No." <> "Sales Order No.") AND (Quantity <> 0) THEN BEGIN
//                   ReservePurchLine.VerifyChange(Rec,xRec);
//                   WhseValidateSourceLine.PurchaseLineVerifyChange(Rec,xRec);
//                 END;
//             end;
//         }
//         field(72;"Sales Order Line No.";Integer)
//         {
//             Caption = 'Sales Order Line No.';
//             Editable = false;
//             TableRelation = IF (Drop Shipment=CONST(Yes)) "Sales Line"."Line No." WHERE (Document Type=CONST(Order),
//                                                                                          Document No.=FIELD(Sales Order No.));

//             trigger OnValidate()
//             begin
//                 IF (xRec."Sales Order Line No." <> "Sales Order Line No.") AND (Quantity <> 0) THEN BEGIN
//                   ReservePurchLine.VerifyChange(Rec,xRec);
//                   WhseValidateSourceLine.PurchaseLineVerifyChange(Rec,xRec);
//                 END;
//             end;
//         }
//         field(73;"Drop Shipment";Boolean)
//         {
//             AccessByPermission = TableData 223=R;
//             Caption = 'Drop Shipment';
//             Editable = false;

//             trigger OnValidate()
//             begin
//                 IF (xRec."Drop Shipment" <> "Drop Shipment") AND (Quantity <> 0) THEN BEGIN
//                   ReservePurchLine.VerifyChange(Rec,xRec);
//                   WhseValidateSourceLine.PurchaseLineVerifyChange(Rec,xRec);
//                 END;
//                 IF "Drop Shipment" THEN BEGIN
//                   "Bin Code" := '';
//                   EVALUATE("Inbound Whse. Handling Time",'<0D>');
//                   VALIDATE("Inbound Whse. Handling Time");
//                   InitOutstanding;
//                   InitQtyToReceive;
//                 END;
//             end;
//         }
//         field(74;"Gen. Bus. Posting Group";Code[20])
//         {
//             Caption = 'Gen. Bus. Posting Group';
//             TableRelation = "Gen. Business Posting Group";

//             trigger OnValidate()
//             begin
//                 IF xRec."Gen. Bus. Posting Group" <> "Gen. Bus. Posting Group" THEN
//                   IF GenBusPostingGrp.ValidateVatBusPostingGroup(GenBusPostingGrp,"Gen. Bus. Posting Group") THEN
//                     VALIDATE("VAT Bus. Posting Group",GenBusPostingGrp."Def. VAT Bus. Posting Group");
//             end;
//         }
//         field(75;"Gen. Prod. Posting Group";Code[20])
//         {
//             Caption = 'Gen. Prod. Posting Group';
//             TableRelation = "Gen. Product Posting Group";

//             trigger OnValidate()
//             begin
//                 TestStatusOpen;
//                 IF xRec."Gen. Prod. Posting Group" <> "Gen. Prod. Posting Group" THEN
//                   IF GenProdPostingGrp.ValidateVatProdPostingGroup(GenProdPostingGrp,"Gen. Prod. Posting Group") THEN
//                     VALIDATE("VAT Prod. Posting Group",GenProdPostingGrp."Def. VAT Prod. Posting Group");
//             end;
//         }
//         field(77;"VAT Calculation Type";Option)
//         {
//             Caption = 'VAT Calculation Type';
//             Editable = false;
//             OptionCaption = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax';
//             OptionMembers = "Normal VAT","Reverse Charge VAT","Full VAT","Sales Tax";
//         }
//         field(78;"Transaction Type";Code[10])
//         {
//             Caption = 'Transaction Type';
//             TableRelation = "Transaction Type";
//         }
//         field(79;"Transport Method";Code[10])
//         {
//             Caption = 'Transport Method';
//             TableRelation = "Transport Method";
//         }
//         field(80;"Attached to Line No.";Integer)
//         {
//             Caption = 'Attached to Line No.';
//             Editable = false;
//             TableRelation = "Purchase Line"."Line No." WHERE (Document Type=FIELD(Document Type),
//                                                               Document No.=FIELD(Document No.));
//         }
//         field(81;"Entry Point";Code[10])
//         {
//             Caption = 'Entry Point';
//             TableRelation = "Entry/Exit Point";
//         }
//         field(82;"Area";Code[10])
//         {
//             Caption = 'Area';
//             TableRelation = Area;
//         }
//         field(83;"Transaction Specification";Code[10])
//         {
//             Caption = 'Transaction Specification';
//             TableRelation = "Transaction Specification";
//         }
//         field(85;"Tax Area Code";Code[20])
//         {
//             Caption = 'Tax Area Code';
//             TableRelation = "Tax Area";

//             trigger OnValidate()
//             begin
//                 UpdateAmounts;
//             end;
//         }
//         field(86;"Tax Liable";Boolean)
//         {
//             Caption = 'Tax Liable';

//             trigger OnValidate()
//             begin
//                 UpdateAmounts;
//             end;
//         }
//         field(87;"Tax Group Code";Code[20])
//         {
//             Caption = 'Tax Group Code';
//             TableRelation = "Tax Group";

//             trigger OnValidate()
//             begin
//                 TestStatusOpen;
//                 UpdateAmounts;
//             end;
//         }
//         field(88;"Use Tax";Boolean)
//         {
//             Caption = 'Use Tax';

//             trigger OnValidate()
//             begin
//                 UpdateAmounts;
//             end;
//         }
//         field(89;"VAT Bus. Posting Group";Code[20])
//         {
//             Caption = 'VAT Bus. Posting Group';
//             TableRelation = "VAT Business Posting Group";

//             trigger OnValidate()
//             begin
//                 VALIDATE("VAT Prod. Posting Group");
//             end;
//         }
//         field(90;"VAT Prod. Posting Group";Code[20])
//         {
//             Caption = 'VAT Prod. Posting Group';
//             TableRelation = "VAT Product Posting Group";

//             trigger OnValidate()
//             begin
//                 TestStatusOpen;
//                 VATPostingSetup.GET("VAT Bus. Posting Group","VAT Prod. Posting Group");
//                 "VAT Difference" := 0;
//                 GetPurchHeader;
//                 "VAT %" := VATPostingSetup."VAT %";
//                 "VAT Calculation Type" := VATPostingSetup."VAT Calculation Type";
//                 "VAT Identifier" := VATPostingSetup."VAT Identifier";
//                 CASE "VAT Calculation Type" OF
//                   "VAT Calculation Type"::"Reverse Charge VAT",
//                   "VAT Calculation Type"::"Sales Tax":
//                     "VAT %" := 0;
//                   "VAT Calculation Type"::"Full VAT":
//                     BEGIN
//                       TESTFIELD(Type,Type::"G/L Account");
//                       TESTFIELD("No.",VATPostingSetup.GetPurchAccount(FALSE));
//                     END;
//                 END;
//                 GetPurchSetup;
//                 IF ("VAT Bus. Posting Group" = PurchSetup."Reverse Charge VAT Posting Gr.") AND
//                    (PurchHeader."VAT Bus. Posting Group" <> PurchSetup."Domestic Vendors")
//                 THEN
//                   FIELDERROR("VAT Bus. Posting Group",STRSUBSTNO(Text1041002,"VAT Bus. Posting Group"));
//                 IF (NOT "Reverse Charge Item") AND
//                    ("VAT Bus. Posting Group" = PurchSetup."Reverse Charge VAT Posting Gr.")
//                 THEN
//                   FIELDERROR("VAT Bus. Posting Group",STRSUBSTNO(Text1041003,"VAT Bus. Posting Group"));
//                 IF PurchHeader."Prices Including VAT" AND (Type = Type::Item) THEN
//                   "Direct Unit Cost" :=
//                     ROUND(
//                       "Direct Unit Cost" * (100 + "VAT %") / (100 + xRec."VAT %"),
//                       Currency."Unit-Amount Rounding Precision");
//                 UpdateAmounts;
//             end;
//         }
//         field(91;"Currency Code";Code[10])
//         {
//             Caption = 'Currency Code';
//             Editable = false;
//             TableRelation = Currency;
//         }
//         field(92;"Outstanding Amount (LCY)";Decimal)
//         {
//             AutoFormatType = 1;
//             Caption = 'Outstanding Amount (LCY)';
//             Editable = false;
//         }
//         field(93;"Amt. Rcd. Not Invoiced (LCY)";Decimal)
//         {
//             AccessByPermission = TableData 120=R;
//             AutoFormatType = 1;
//             Caption = 'Amt. Rcd. Not Invoiced (LCY)';
//             Editable = false;
//         }
//         field(95;"Reserved Quantity";Decimal)
//         {
//             AccessByPermission = TableData 120=R;
//             CalcFormula = Sum("Reservation Entry".Quantity WHERE (Source ID=FIELD(Document No.),
//                                                                   Source Ref. No.=FIELD(Line No.),
//                                                                   Source Type=CONST(39),
//                                                                   Source Subtype=FIELD(Document Type),
//                                                                   Reservation Status=CONST(Reservation)));
//             Caption = 'Reserved Quantity';
//             DecimalPlaces = 0:5;
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(97;"Blanket Order No.";Code[20])
//         {
//             AccessByPermission = TableData 120=R;
//             Caption = 'Blanket Order No.';
//             TableRelation = "Purchase Header".No. WHERE (Document Type=CONST(Blanket Order));
//             //This property is currently not supported
//             //TestTableRelation = false;

//             trigger OnLookup()
//             begin
//                 TESTFIELD("Quantity Received",0);
//                 BlanketOrderLookup;
//             end;

//             trigger OnValidate()
//             begin
//                 TESTFIELD("Quantity Received",0);
//                 IF "Blanket Order No." = '' THEN
//                   "Blanket Order Line No." := 0
//                 ELSE
//                   VALIDATE("Blanket Order Line No.");
//             end;
//         }
//         field(98;"Blanket Order Line No.";Integer)
//         {
//             AccessByPermission = TableData 120=R;
//             Caption = 'Blanket Order Line No.';
//             TableRelation = "Purchase Line"."Line No." WHERE (Document Type=CONST(Blanket Order),
//                                                               Document No.=FIELD(Blanket Order No.));
//             //This property is currently not supported
//             //TestTableRelation = false;

//             trigger OnLookup()
//             begin
//                 BlanketOrderLookup;
//             end;

//             trigger OnValidate()
//             begin
//                 TESTFIELD("Quantity Received",0);
//                 IF "Blanket Order Line No." <> 0 THEN BEGIN
//                   PurchLine2.GET("Document Type"::"Blanket Order","Blanket Order No.","Blanket Order Line No.");
//                   PurchLine2.TESTFIELD(Type,Type);
//                   PurchLine2.TESTFIELD("No.","No.");
//                   PurchLine2.TESTFIELD("Pay-to Vendor No.","Pay-to Vendor No.");
//                   PurchLine2.TESTFIELD("Buy-from Vendor No.","Buy-from Vendor No.");
//                   IF "Drop Shipment" THEN BEGIN
//                     PurchLine2.TESTFIELD("Variant Code","Variant Code");
//                     PurchLine2.TESTFIELD("Location Code","Location Code");
//                     PurchLine2.TESTFIELD("Unit of Measure Code","Unit of Measure Code");
//                   END ELSE BEGIN
//                     VALIDATE("Variant Code",PurchLine2."Variant Code");
//                     VALIDATE("Location Code",PurchLine2."Location Code");
//                     VALIDATE("Unit of Measure Code",PurchLine2."Unit of Measure Code");
//                   END;
//                   VALIDATE("Direct Unit Cost",PurchLine2."Direct Unit Cost");
//                   VALIDATE("Line Discount %",PurchLine2."Line Discount %");
//                 END;
//             end;
//         }
//         field(99;"VAT Base Amount";Decimal)
//         {
//             AutoFormatExpression = "Currency Code";
//             AutoFormatType = 1;
//             Caption = 'VAT Base Amount';
//             Editable = false;
//         }
//         field(100;"Unit Cost";Decimal)
//         {
//             AutoFormatExpression = "Currency Code";
//             AutoFormatType = 2;
//             Caption = 'Unit Cost';
//             Editable = false;
//         }
//         field(101;"System-Created Entry";Boolean)
//         {
//             Caption = 'System-Created Entry';
//             Editable = false;
//         }
//         field(103;"Line Amount";Decimal)
//         {
//             AutoFormatExpression = "Currency Code";
//             AutoFormatType = 1;
//             CaptionClass = GetCaptionClass(FIELDNO("Line Amount"));
//             Caption = 'Line Amount';

//             trigger OnValidate()
//             begin
//                 TESTFIELD(Type);
//                 TESTFIELD(Quantity);
//                 TESTFIELD("Direct Unit Cost");

//                 GetPurchHeader;
//                 "Line Amount" := ROUND("Line Amount",Currency."Amount Rounding Precision");
//                 VALIDATE(
//                   "Line Discount Amount",ROUND(Quantity * "Direct Unit Cost",Currency."Amount Rounding Precision") - "Line Amount");
//             end;
//         }
//         field(104;"VAT Difference";Decimal)
//         {
//             AutoFormatExpression = "Currency Code";
//             AutoFormatType = 1;
//             Caption = 'VAT Difference';
//             Editable = false;
//         }
//         field(105;"Inv. Disc. Amount to Invoice";Decimal)
//         {
//             AutoFormatExpression = "Currency Code";
//             AutoFormatType = 1;
//             Caption = 'Inv. Disc. Amount to Invoice';
//             Editable = false;
//         }
//         field(106;"VAT Identifier";Code[20])
//         {
//             Caption = 'VAT Identifier';
//             Editable = false;
//         }
//         field(107;"IC Partner Ref. Type";Option)
//         {
//             AccessByPermission = TableData 410=R;
//             Caption = 'IC Partner Ref. Type';
//             OptionCaption = ' ,G/L Account,Item,,,Charge (Item),Cross Reference,Common Item No.,Vendor Item No.';
//             OptionMembers = " ","G/L Account",Item,,,"Charge (Item)","Cross Reference","Common Item No.","Vendor Item No.";

//             trigger OnValidate()
//             var
//                 Item: Record "27";
//             begin
//                 IF "IC Partner Code" <> '' THEN
//                   "IC Partner Ref. Type" := "IC Partner Ref. Type"::"G/L Account";
//                 IF "IC Partner Ref. Type" <> xRec."IC Partner Ref. Type" THEN
//                   "IC Partner Reference" := '';
//                 IF "IC Partner Ref. Type" = "IC Partner Ref. Type"::"Common Item No." THEN BEGIN
//                   GetItem(Item);
//                   Item.TESTFIELD("Common Item No.");
//                   "IC Partner Reference" := Item."Common Item No.";
//                 END;
//             end;
//         }
//         field(108;"IC Partner Reference";Code[20])
//         {
//             AccessByPermission = TableData 410=R;
//             Caption = 'IC Partner Reference';

//             trigger OnLookup()
//             var
//                 ICGLAccount: Record "410";
//                 Item: Record "27";
//                 ItemCrossReference: Record "5717";
//                 ItemVendorCatalog: Record "99";
//             begin
//                 IF "No." <> '' THEN
//                   CASE "IC Partner Ref. Type" OF
//                     "IC Partner Ref. Type"::"G/L Account":
//                       BEGIN
//                         IF ICGLAccount.GET("IC Partner Reference") THEN;
//                         IF PAGE.RUNMODAL(PAGE::"IC G/L Account List",ICGLAccount) = ACTION::LookupOK THEN
//                           VALIDATE("IC Partner Reference",ICGLAccount."No.");
//                       END;
//                     "IC Partner Ref. Type"::Item:
//                       BEGIN
//                         IF Item.GET("IC Partner Reference") THEN;
//                         IF PAGE.RUNMODAL(PAGE::"Item List",Item) = ACTION::LookupOK THEN
//                           VALIDATE("IC Partner Reference",Item."No.");
//                       END;
//                     "IC Partner Ref. Type"::"Cross Reference":
//                       BEGIN
//                         GetPurchHeader;
//                         ItemCrossReference.RESET;
//                         ItemCrossReference.SETCURRENTKEY("Cross-Reference Type","Cross-Reference Type No.");
//                         ItemCrossReference.SETFILTER(
//                           "Cross-Reference Type",'%1|%2',
//                           ItemCrossReference."Cross-Reference Type"::Vendor,
//                           ItemCrossReference."Cross-Reference Type"::" ");
//                         ItemCrossReference.SETFILTER("Cross-Reference Type No.",'%1|%2',PurchHeader."Buy-from Vendor No.",'');
//                         IF PAGE.RUNMODAL(PAGE::"Cross Reference List",ItemCrossReference) = ACTION::LookupOK THEN
//                           VALIDATE("IC Partner Reference",ItemCrossReference."Cross-Reference No.");
//                       END;
//                     "IC Partner Ref. Type"::"Vendor Item No.":
//                       BEGIN
//                         GetPurchHeader;
//                         ItemVendorCatalog.SETCURRENTKEY("Vendor No.");
//                         ItemVendorCatalog.SETRANGE("Vendor No.",PurchHeader."Buy-from Vendor No.");
//                         IF PAGE.RUNMODAL(PAGE::"Vendor Item Catalog",ItemVendorCatalog) = ACTION::LookupOK THEN
//                           VALIDATE("IC Partner Reference",ItemVendorCatalog."Vendor Item No.");
//                       END;
//                   END;
//             end;
//         }
//         field(109;"Prepayment %";Decimal)
//         {
//             Caption = 'Prepayment %';
//             DecimalPlaces = 0:5;
//             MaxValue = 100;
//             MinValue = 0;

//             trigger OnValidate()
//             begin
//                 TestStatusOpen;
//                 UpdatePrepmtSetupFields;

//                 IF HasTypeToFillMandatoryFields THEN
//                   UpdateAmounts;
//                 UpdateBaseAmounts(Amount,"Amount Including VAT","VAT Base Amount");
//             end;
//         }
//         field(110;"Prepmt. Line Amount";Decimal)
//         {
//             AutoFormatExpression = "Currency Code";
//             AutoFormatType = 1;
//             CaptionClass = GetCaptionClass(FIELDNO("Prepmt. Line Amount"));
//             Caption = 'Prepmt. Line Amount';
//             MinValue = 0;

//             trigger OnValidate()
//             begin
//                 TestStatusOpen;
//                 PrePaymentLineAmountEntered := TRUE;
//                 TESTFIELD("Line Amount");
//                 IF "Prepmt. Line Amount" < "Prepmt. Amt. Inv." THEN
//                   FIELDERROR("Prepmt. Line Amount",STRSUBSTNO(Text038,"Prepmt. Amt. Inv."));
//                 IF "Prepmt. Line Amount" > "Line Amount" THEN
//                   FIELDERROR("Prepmt. Line Amount",STRSUBSTNO(Text039,"Line Amount"));
//                 VALIDATE("Prepayment %",ROUND("Prepmt. Line Amount" * 100 / "Line Amount",0.00001));
//             end;
//         }
//         field(111;"Prepmt. Amt. Inv.";Decimal)
//         {
//             AutoFormatExpression = "Currency Code";
//             AutoFormatType = 1;
//             CaptionClass = GetCaptionClass(FIELDNO("Prepmt. Amt. Inv."));
//             Caption = 'Prepmt. Amt. Inv.';
//             Editable = false;
//         }
//         field(112;"Prepmt. Amt. Incl. VAT";Decimal)
//         {
//             AutoFormatExpression = "Currency Code";
//             AutoFormatType = 1;
//             Caption = 'Prepmt. Amt. Incl. VAT';
//             Editable = false;
//         }
//         field(113;"Prepayment Amount";Decimal)
//         {
//             AutoFormatExpression = "Currency Code";
//             AutoFormatType = 1;
//             Caption = 'Prepayment Amount';
//             Editable = false;
//         }
//         field(114;"Prepmt. VAT Base Amt.";Decimal)
//         {
//             AutoFormatExpression = "Currency Code";
//             AutoFormatType = 1;
//             Caption = 'Prepmt. VAT Base Amt.';
//             Editable = false;
//         }
//         field(115;"Prepayment VAT %";Decimal)
//         {
//             Caption = 'Prepayment VAT %';
//             DecimalPlaces = 0:5;
//             Editable = false;
//             MinValue = 0;
//         }
//         field(116;"Prepmt. VAT Calc. Type";Option)
//         {
//             Caption = 'Prepmt. VAT Calc. Type';
//             Editable = false;
//             OptionCaption = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax';
//             OptionMembers = "Normal VAT","Reverse Charge VAT","Full VAT","Sales Tax";
//         }
//         field(117;"Prepayment VAT Identifier";Code[20])
//         {
//             Caption = 'Prepayment VAT Identifier';
//             Editable = false;
//         }
//         field(118;"Prepayment Tax Area Code";Code[20])
//         {
//             Caption = 'Prepayment Tax Area Code';
//             TableRelation = "Tax Area";

//             trigger OnValidate()
//             begin
//                 UpdateAmounts;
//             end;
//         }
//         field(119;"Prepayment Tax Liable";Boolean)
//         {
//             Caption = 'Prepayment Tax Liable';

//             trigger OnValidate()
//             begin
//                 UpdateAmounts;
//             end;
//         }
//         field(120;"Prepayment Tax Group Code";Code[20])
//         {
//             Caption = 'Prepayment Tax Group Code';
//             TableRelation = "Tax Group";

//             trigger OnValidate()
//             begin
//                 TestStatusOpen;
//                 UpdateAmounts;
//             end;
//         }
//         field(121;"Prepmt Amt to Deduct";Decimal)
//         {
//             AutoFormatExpression = "Currency Code";
//             AutoFormatType = 1;
//             CaptionClass = GetCaptionClass(FIELDNO("Prepmt Amt to Deduct"));
//             Caption = 'Prepmt Amt to Deduct';
//             MinValue = 0;

//             trigger OnValidate()
//             begin
//                 IF "Prepmt Amt to Deduct" > "Prepmt. Amt. Inv." - "Prepmt Amt Deducted" THEN
//                   FIELDERROR(
//                     "Prepmt Amt to Deduct",
//                     STRSUBSTNO(Text039,"Prepmt. Amt. Inv." - "Prepmt Amt Deducted"));

//                 IF "Prepmt Amt to Deduct" > "Qty. to Invoice" * "Direct Unit Cost" THEN
//                   FIELDERROR(
//                     "Prepmt Amt to Deduct",
//                     STRSUBSTNO(Text039,"Qty. to Invoice" * "Direct Unit Cost"));
//                 IF ("Prepmt. Amt. Inv." - "Prepmt Amt to Deduct" - "Prepmt Amt Deducted") >
//                    (Quantity - "Qty. to Invoice" - "Quantity Invoiced") * "Direct Unit Cost"
//                 THEN
//                   FIELDERROR(
//                     "Prepmt Amt to Deduct",
//                     STRSUBSTNO(Text038,
//                       "Prepmt. Amt. Inv." - "Prepmt Amt Deducted" -
//                       (Quantity - "Qty. to Invoice" - "Quantity Invoiced") * "Direct Unit Cost"));
//             end;
//         }
//         field(122;"Prepmt Amt Deducted";Decimal)
//         {
//             AutoFormatExpression = "Currency Code";
//             AutoFormatType = 1;
//             CaptionClass = GetCaptionClass(FIELDNO("Prepmt Amt Deducted"));
//             Caption = 'Prepmt Amt Deducted';
//             Editable = false;
//         }
//         field(123;"Prepayment Line";Boolean)
//         {
//             Caption = 'Prepayment Line';
//             Editable = false;
//         }
//         field(124;"Prepmt. Amount Inv. Incl. VAT";Decimal)
//         {
//             AutoFormatExpression = "Currency Code";
//             AutoFormatType = 1;
//             Caption = 'Prepmt. Amount Inv. Incl. VAT';
//             Editable = false;
//         }
//         field(129;"Prepmt. Amount Inv. (LCY)";Decimal)
//         {
//             AutoFormatType = 1;
//             Caption = 'Prepmt. Amount Inv. (LCY)';
//             Editable = false;
//         }
//         field(130;"IC Partner Code";Code[20])
//         {
//             Caption = 'IC Partner Code';
//             TableRelation = "IC Partner";

//             trigger OnValidate()
//             begin
//                 IF "IC Partner Code" <> '' THEN BEGIN
//                   TESTFIELD(Type,Type::"G/L Account");
//                   GetPurchHeader;
//                   PurchHeader.TESTFIELD("Buy-from IC Partner Code",'');
//                   PurchHeader.TESTFIELD("Pay-to IC Partner Code",'');
//                   VALIDATE("IC Partner Ref. Type","IC Partner Ref. Type"::"G/L Account");
//                 END;
//             end;
//         }
//         field(132;"Prepmt. VAT Amount Inv. (LCY)";Decimal)
//         {
//             Caption = 'Prepmt. VAT Amount Inv. (LCY)';
//             Editable = false;
//         }
//         field(135;"Prepayment VAT Difference";Decimal)
//         {
//             AutoFormatExpression = "Currency Code";
//             AutoFormatType = 1;
//             Caption = 'Prepayment VAT Difference';
//             Editable = false;
//         }
//         field(136;"Prepmt VAT Diff. to Deduct";Decimal)
//         {
//             AutoFormatExpression = "Currency Code";
//             AutoFormatType = 1;
//             Caption = 'Prepmt VAT Diff. to Deduct';
//             Editable = false;
//         }
//         field(137;"Prepmt VAT Diff. Deducted";Decimal)
//         {
//             AutoFormatExpression = "Currency Code";
//             AutoFormatType = 1;
//             Caption = 'Prepmt VAT Diff. Deducted';
//             Editable = false;
//         }
//         field(140;"Outstanding Amt. Ex. VAT (LCY)";Decimal)
//         {
//             Caption = 'Outstanding Amt. Ex. VAT (LCY)';
//         }
//         field(141;"A. Rcd. Not Inv. Ex. VAT (LCY)";Decimal)
//         {
//             Caption = 'A. Rcd. Not Inv. Ex. VAT (LCY)';
//         }
//         field(145;"Pmt. Discount Amount";Decimal)
//         {
//             AutoFormatExpression = "Currency Code";
//             AutoFormatType = 1;
//             Caption = 'Pmt. Discount Amount';

//             trigger OnValidate()
//             begin
//                 TESTFIELD(Quantity);
//                 UpdateAmounts;
//             end;
//         }
//         field(480;"Dimension Set ID";Integer)
//         {
//             Caption = 'Dimension Set ID';
//             Editable = false;
//             TableRelation = "Dimension Set Entry";

//             trigger OnLookup()
//             begin
//                 ShowDimensions;
//             end;

//             trigger OnValidate()
//             begin
//                 DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID","Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");
//             end;
//         }
//         field(1001;"Job Task No.";Code[20])
//         {
//             Caption = 'Job Task No.';
//             TableRelation = "Job Task"."Job Task No." WHERE (Job No.=FIELD(Job No.));

//             trigger OnValidate()
//             begin
//                 TESTFIELD("Receipt No.",'');

//                 IF "Job Task No." <> xRec."Job Task No." THEN BEGIN
//                   VALIDATE("Job Planning Line No.",0);
//                   IF "Document Type" = "Document Type"::Order THEN
//                     TESTFIELD("Quantity Received",0);
//                 END;

//                 IF "Job Task No." = '' THEN BEGIN
//                   CLEAR(TempJobJnlLine);
//                   "Job Line Type" := "Job Line Type"::" ";
//                   UpdateJobPrices;
//                   CreateDim(
//                     DimMgt.TypeToTableID3(Type),"No.",
//                     DATABASE::Job,"Job No.",
//                     DATABASE::"Responsibility Center","Responsibility Center",
//                     DATABASE::"Work Center","Work Center No.");
//                   EXIT;
//                 END;

//                 JobSetCurrencyFactor;
//                 IF JobTaskIsSet THEN BEGIN
//                   CreateTempJobJnlLine(TRUE);
//                   UpdateJobPrices;
//                 END;
//                 UpdateDimensionsFromJobTask;
//             end;
//         }
//         field(1002;"Job Line Type";Option)
//         {
//             AccessByPermission = TableData 167=R;
//             Caption = 'Job Line Type';
//             OptionCaption = ' ,Budget,Billable,Both Budget and Billable';
//             OptionMembers = " ",Budget,Billable,"Both Budget and Billable";

//             trigger OnValidate()
//             begin
//                 TESTFIELD("Receipt No.",'');
//                 IF "Document Type" = "Document Type"::Order THEN
//                   TESTFIELD("Quantity Received",0);

//                 IF "Job Planning Line No." <> 0 THEN
//                   ERROR(Text048,FIELDCAPTION("Job Line Type"),FIELDCAPTION("Job Planning Line No."));
//             end;
//         }
//         field(1003;"Job Unit Price";Decimal)
//         {
//             AccessByPermission = TableData 167=R;
//             BlankZero = true;
//             Caption = 'Job Unit Price';

//             trigger OnValidate()
//             begin
//                 TESTFIELD("Receipt No.",'');
//                 IF "Document Type" = "Document Type"::Order THEN
//                   TESTFIELD("Quantity Received",0);

//                 IF JobTaskIsSet THEN BEGIN
//                   CreateTempJobJnlLine(FALSE);
//                   TempJobJnlLine.VALIDATE("Unit Price","Job Unit Price");
//                   UpdateJobPrices;
//                 END;
//             end;
//         }
//         field(1004;"Job Total Price";Decimal)
//         {
//             AccessByPermission = TableData 167=R;
//             BlankZero = true;
//             Caption = 'Job Total Price';
//             Editable = false;
//         }
//         field(1005;"Job Line Amount";Decimal)
//         {
//             AccessByPermission = TableData 167=R;
//             AutoFormatExpression = "Job Currency Code";
//             AutoFormatType = 1;
//             BlankZero = true;
//             Caption = 'Job Line Amount';

//             trigger OnValidate()
//             begin
//                 TESTFIELD("Receipt No.",'');
//                 IF "Document Type" = "Document Type"::Order THEN
//                   TESTFIELD("Quantity Received",0);

//                 IF JobTaskIsSet THEN BEGIN
//                   CreateTempJobJnlLine(FALSE);
//                   TempJobJnlLine.VALIDATE("Line Amount","Job Line Amount");
//                   UpdateJobPrices;
//                 END;
//             end;
//         }
//         field(1006;"Job Line Discount Amount";Decimal)
//         {
//             AccessByPermission = TableData 167=R;
//             AutoFormatExpression = "Job Currency Code";
//             AutoFormatType = 1;
//             BlankZero = true;
//             Caption = 'Job Line Discount Amount';

//             trigger OnValidate()
//             begin
//                 TESTFIELD("Receipt No.",'');
//                 IF "Document Type" = "Document Type"::Order THEN
//                   TESTFIELD("Quantity Received",0);

//                 IF JobTaskIsSet THEN BEGIN
//                   CreateTempJobJnlLine(FALSE);
//                   TempJobJnlLine.VALIDATE("Line Discount Amount","Job Line Discount Amount");
//                   UpdateJobPrices;
//                 END;
//             end;
//         }
//         field(1007;"Job Line Discount %";Decimal)
//         {
//             AccessByPermission = TableData 167=R;
//             BlankZero = true;
//             Caption = 'Job Line Discount %';
//             DecimalPlaces = 0:5;
//             MaxValue = 100;
//             MinValue = 0;

//             trigger OnValidate()
//             begin
//                 TESTFIELD("Receipt No.",'');
//                 IF "Document Type" = "Document Type"::Order THEN
//                   TESTFIELD("Quantity Received",0);

//                 IF JobTaskIsSet THEN BEGIN
//                   CreateTempJobJnlLine(FALSE);
//                   TempJobJnlLine.VALIDATE("Line Discount %","Job Line Discount %");
//                   UpdateJobPrices;
//                 END;
//             end;
//         }
//         field(1008;"Job Unit Price (LCY)";Decimal)
//         {
//             AccessByPermission = TableData 167=R;
//             BlankZero = true;
//             Caption = 'Job Unit Price (LCY)';
//             Editable = false;

//             trigger OnValidate()
//             begin
//                 TESTFIELD("Receipt No.",'');
//                 IF "Document Type" = "Document Type"::Order THEN
//                   TESTFIELD("Quantity Received",0);

//                 IF JobTaskIsSet THEN BEGIN
//                   CreateTempJobJnlLine(FALSE);
//                   TempJobJnlLine.VALIDATE("Unit Price (LCY)","Job Unit Price (LCY)");
//                   UpdateJobPrices;
//                 END;
//             end;
//         }
//         field(1009;"Job Total Price (LCY)";Decimal)
//         {
//             AccessByPermission = TableData 167=R;
//             BlankZero = true;
//             Caption = 'Job Total Price (LCY)';
//             Editable = false;
//         }
//         field(1010;"Job Line Amount (LCY)";Decimal)
//         {
//             AccessByPermission = TableData 167=R;
//             AutoFormatType = 1;
//             BlankZero = true;
//             Caption = 'Job Line Amount (LCY)';
//             Editable = false;

//             trigger OnValidate()
//             begin
//                 TESTFIELD("Receipt No.",'');
//                 IF "Document Type" = "Document Type"::Order THEN
//                   TESTFIELD("Quantity Received",0);

//                 IF JobTaskIsSet THEN BEGIN
//                   CreateTempJobJnlLine(FALSE);
//                   TempJobJnlLine.VALIDATE("Line Amount (LCY)","Job Line Amount (LCY)");
//                   UpdateJobPrices;
//                 END;
//             end;
//         }
//         field(1011;"Job Line Disc. Amount (LCY)";Decimal)
//         {
//             AccessByPermission = TableData 167=R;
//             AutoFormatType = 1;
//             BlankZero = true;
//             Caption = 'Job Line Disc. Amount (LCY)';
//             Editable = false;

//             trigger OnValidate()
//             begin
//                 TESTFIELD("Receipt No.",'');
//                 IF "Document Type" = "Document Type"::Order THEN
//                   TESTFIELD("Quantity Received",0);

//                 IF JobTaskIsSet THEN BEGIN
//                   CreateTempJobJnlLine(FALSE);
//                   TempJobJnlLine.VALIDATE("Line Discount Amount (LCY)","Job Line Disc. Amount (LCY)");
//                   UpdateJobPrices;
//                 END;
//             end;
//         }
//         field(1012;"Job Currency Factor";Decimal)
//         {
//             BlankZero = true;
//             Caption = 'Job Currency Factor';
//         }
//         field(1013;"Job Currency Code";Code[20])
//         {
//             Caption = 'Job Currency Code';
//         }
//         field(1019;"Job Planning Line No.";Integer)
//         {
//             AccessByPermission = TableData 167=R;
//             BlankZero = true;
//             Caption = 'Job Planning Line No.';

//             trigger OnLookup()
//             var
//                 JobPlanningLine: Record "1003";
//             begin
//                 JobPlanningLine.SETRANGE("Job No.","Job No.");
//                 JobPlanningLine.SETRANGE("Job Task No.","Job Task No.");
//                 CASE Type OF
//                   Type::"G/L Account":
//                     JobPlanningLine.SETRANGE(Type,JobPlanningLine.Type::"G/L Account");
//                   Type::Item:
//                     JobPlanningLine.SETRANGE(Type,JobPlanningLine.Type::Item);
//                 END;
//                 JobPlanningLine.SETRANGE("No.","No.");
//                 JobPlanningLine.SETRANGE("Usage Link",TRUE);
//                 JobPlanningLine.SETRANGE("System-Created Entry",FALSE);

//                 IF PAGE.RUNMODAL(0,JobPlanningLine) = ACTION::LookupOK THEN
//                   VALIDATE("Job Planning Line No.",JobPlanningLine."Line No.");
//             end;

//             trigger OnValidate()
//             var
//                 JobPlanningLine: Record "1003";
//             begin
//                 IF "Job Planning Line No." <> 0 THEN BEGIN
//                   JobPlanningLine.GET("Job No.","Job Task No.","Job Planning Line No.");
//                   JobPlanningLine.TESTFIELD("Job No.","Job No.");
//                   JobPlanningLine.TESTFIELD("Job Task No.","Job Task No.");
//                   CASE Type OF
//                     Type::"G/L Account":
//                       JobPlanningLine.TESTFIELD(Type,JobPlanningLine.Type::"G/L Account");
//                     Type::Item:
//                       JobPlanningLine.TESTFIELD(Type,JobPlanningLine.Type::Item);
//                   END;
//                   JobPlanningLine.TESTFIELD("No.","No.");
//                   JobPlanningLine.TESTFIELD("Usage Link",TRUE);
//                   JobPlanningLine.TESTFIELD("System-Created Entry",FALSE);
//                   "Job Line Type" := JobPlanningLine."Line Type" + 1;
//                   VALIDATE("Job Remaining Qty.",JobPlanningLine."Remaining Qty." - "Qty. to Invoice");
//                 END ELSE
//                   VALIDATE("Job Remaining Qty.",0);
//             end;
//         }
//         field(1030;"Job Remaining Qty.";Decimal)
//         {
//             AccessByPermission = TableData 167=R;
//             Caption = 'Job Remaining Qty.';
//             DecimalPlaces = 0:5;

//             trigger OnValidate()
//             var
//                 JobPlanningLine: Record "1003";
//             begin
//                 IF ("Job Remaining Qty." <> 0) AND ("Job Planning Line No." = 0) THEN
//                   ERROR(Text047,FIELDCAPTION("Job Remaining Qty."),FIELDCAPTION("Job Planning Line No."));

//                 IF "Job Planning Line No." <> 0 THEN BEGIN
//                   JobPlanningLine.GET("Job No.","Job Task No.","Job Planning Line No.");
//                   IF JobPlanningLine.Quantity >= 0 THEN BEGIN
//                     IF "Job Remaining Qty." < 0 THEN
//                       "Job Remaining Qty." := 0;
//                   END ELSE BEGIN
//                     IF "Job Remaining Qty." > 0 THEN
//                       "Job Remaining Qty." := 0;
//                   END;
//                 END;
//                 "Job Remaining Qty. (Base)" := CalcBaseQty("Job Remaining Qty.");
//             end;
//         }
//         field(1031;"Job Remaining Qty. (Base)";Decimal)
//         {
//             Caption = 'Job Remaining Qty. (Base)';
//         }
//         field(1700;"Deferral Code";Code[10])
//         {
//             Caption = 'Deferral Code';
//             TableRelation = "Deferral Template"."Deferral Code";

//             trigger OnValidate()
//             var
//                 DeferralPostDate: Date;
//             begin
//                 GetPurchHeader;
//                 DeferralPostDate := PurchHeader."Posting Date";

//                 DeferralUtilities.DeferralCodeOnValidate(
//                   "Deferral Code",DeferralUtilities.GetPurchDeferralDocType,'','',
//                   "Document Type","Document No.","Line No.",
//                   GetDeferralAmount,DeferralPostDate,
//                   Description,PurchHeader."Currency Code");

//                 IF "Document Type" = "Document Type"::"Return Order" THEN
//                   "Returns Deferral Start Date" :=
//                     DeferralUtilities.GetDeferralStartDate(DeferralUtilities.GetPurchDeferralDocType,
//                       "Document Type","Document No.","Line No.","Deferral Code",PurchHeader."Posting Date");
//             end;
//         }
//         field(1702;"Returns Deferral Start Date";Date)
//         {
//             Caption = 'Returns Deferral Start Date';

//             trigger OnValidate()
//             var
//                 DeferralHeader: Record "1701";
//                 DeferralUtilities: Codeunit "1720";
//             begin
//                 GetPurchHeader;
//                 IF DeferralHeader.GET(DeferralUtilities.GetPurchDeferralDocType,'','',"Document Type","Document No.","Line No.") THEN
//                   DeferralUtilities.CreateDeferralSchedule("Deferral Code",DeferralUtilities.GetPurchDeferralDocType,'','',
//                     "Document Type","Document No.","Line No.",GetDeferralAmount,
//                     DeferralHeader."Calc. Method","Returns Deferral Start Date",
//                     DeferralHeader."No. of Periods",TRUE,
//                     DeferralHeader."Schedule Description",FALSE,
//                     PurchHeader."Currency Code");
//             end;
//         }
//         field(5401;"Prod. Order No.";Code[20])
//         {
//             AccessByPermission = TableData 99000758=R;
//             Caption = 'Prod. Order No.';
//             Editable = false;
//             TableRelation = "Production Order".No. WHERE (Status=CONST(Released));
//             //This property is currently not supported
//             //TestTableRelation = false;
//             ValidateTableRelation = false;

//             trigger OnValidate()
//             begin
//                 IF "Drop Shipment" THEN
//                   ERROR(
//                     Text001,
//                     FIELDCAPTION("Prod. Order No."),"Sales Order No.");

//                 AddOnIntegrMgt.ValidateProdOrderOnPurchLine(Rec);
//             end;
//         }
//         field(5402;"Variant Code";Code[10])
//         {
//             Caption = 'Variant Code';
//             TableRelation = IF (Type=CONST(Item)) "Item Variant".Code WHERE (Item No.=FIELD(No.));

//             trigger OnValidate()
//             begin
//                 IF "Variant Code" <> '' THEN
//                   TESTFIELD(Type,Type::Item);
//                 TestStatusOpen;

//                 IF xRec."Variant Code" <> "Variant Code" THEN BEGIN
//                   TESTFIELD("Qty. Rcd. Not Invoiced",0);
//                   TESTFIELD("Receipt No.",'');

//                   TESTFIELD("Return Qty. Shipped Not Invd.",0);
//                   TESTFIELD("Return Shipment No.",'');
//                 END;

//                 IF "Drop Shipment" THEN
//                   ERROR(
//                     Text001,
//                     FIELDCAPTION("Variant Code"),"Sales Order No.");

//                 IF Type = Type::Item THEN
//                   UpdateDirectUnitCost(FIELDNO("Variant Code"));

//                 IF (xRec."Variant Code" <> "Variant Code") AND (Quantity <> 0) THEN BEGIN
//                   ReservePurchLine.VerifyChange(Rec,xRec);
//                   WhseValidateSourceLine.PurchaseLineVerifyChange(Rec,xRec);
//                   InitItemAppl;
//                 END;

//                 UpdateLeadTimeFields;
//                 UpdateDates;
//                 GetDefaultBin;
//                 IF Type = Type::Item THEN
//                   UpdateItemReference;

//                 IF JobTaskIsSet THEN BEGIN
//                   CreateTempJobJnlLine(TRUE);
//                   UpdateJobPrices;
//                 END;
//             end;
//         }
//         field(5403;"Bin Code";Code[20])
//         {
//             Caption = 'Bin Code';
//             TableRelation = IF (Document Type=FILTER(Order|Invoice),
//                                 Quantity=FILTER(<0)) "Bin Content"."Bin Code" WHERE (Location Code=FIELD(Location Code),
//                                                                                      Item No.=FIELD(No.),
//                                                                                      Variant Code=FIELD(Variant Code))
//                                                                                      ELSE IF (Document Type=FILTER(Return Order|Credit Memo),
//                                                                                               Quantity=FILTER(>=0)) "Bin Content"."Bin Code" WHERE (Location Code=FIELD(Location Code),
//                                                                                                                                                     Item No.=FIELD(No.),
//                                                                                                                                                     Variant Code=FIELD(Variant Code))
//                                                                                                                                                     ELSE Bin.Code WHERE (Location Code=FIELD(Location Code));

//             trigger OnLookup()
//             var
//                 WMSManagement: Codeunit "7302";
//                 BinCode: Code[20];
//             begin
//                 IF NOT IsInbound AND ("Quantity (Base)" <> 0) THEN
//                   BinCode := WMSManagement.BinContentLookUp("Location Code","No.","Variant Code",'',"Bin Code")
//                 ELSE
//                   BinCode := WMSManagement.BinLookUp("Location Code","No.","Variant Code",'');

//                 IF BinCode <> '' THEN
//                   VALIDATE("Bin Code",BinCode);
//             end;

//             trigger OnValidate()
//             var
//                 WMSManagement: Codeunit "7302";
//             begin
//                 IF "Bin Code" <> '' THEN BEGIN
//                   IF NOT IsInbound AND ("Quantity (Base)" <> 0) THEN
//                     WMSManagement.FindBinContent("Location Code","Bin Code","No.","Variant Code",'')
//                   ELSE
//                     WMSManagement.FindBin("Location Code","Bin Code",'');
//                 END;

//                 IF "Drop Shipment" THEN
//                   ERROR(
//                     Text001,
//                     FIELDCAPTION("Bin Code"),"Sales Order No.");

//                 TESTFIELD(Type,Type::Item);
//                 TESTFIELD("Location Code");

//                 IF "Bin Code" <> '' THEN BEGIN
//                   GetLocation("Location Code");
//                   Location.TESTFIELD("Bin Mandatory");
//                   CheckWarehouse;
//                 END;
//             end;
//         }
//         field(5404;"Qty. per Unit of Measure";Decimal)
//         {
//             Caption = 'Qty. per Unit of Measure';
//             DecimalPlaces = 0:5;
//             Editable = false;
//             InitValue = 1;
//         }
//         field(5407;"Unit of Measure Code";Code[10])
//         {
//             Caption = 'Unit of Measure Code';
//             TableRelation = IF (Type=CONST(Item),
//                                 No.=FILTER(<>'')) "Item Unit of Measure".Code WHERE (Item No.=FIELD(No.))
//                                 ELSE "Unit of Measure";

//             trigger OnValidate()
//             var
//                 Item: Record "27";
//                 UnitOfMeasureTranslation: Record "5402";
//             begin
//                 TestStatusOpen;
//                 TESTFIELD("Quantity Received",0);
//                 TESTFIELD("Qty. Received (Base)",0);
//                 TESTFIELD("Qty. Rcd. Not Invoiced",0);
//                 TESTFIELD("Return Qty. Shipped",0);
//                 TESTFIELD("Return Qty. Shipped (Base)",0);
//                 IF "Unit of Measure Code" <> xRec."Unit of Measure Code" THEN BEGIN
//                   TESTFIELD("Receipt No.",'');
//                   TESTFIELD("Return Shipment No.",'');
//                 END;
//                 IF "Drop Shipment" THEN
//                   ERROR(
//                     Text001,
//                     FIELDCAPTION("Unit of Measure Code"),"Sales Order No.");
//                 IF (xRec."Unit of Measure Code" <> "Unit of Measure Code") AND (Quantity <> 0) THEN
//                   WhseValidateSourceLine.PurchaseLineVerifyChange(Rec,xRec);
//                 UpdateDirectUnitCost(FIELDNO("Unit of Measure Code"));
//                 IF "Unit of Measure Code" = '' THEN
//                   "Unit of Measure" := ''
//                 ELSE BEGIN
//                   UnitOfMeasure.GET("Unit of Measure Code");
//                   "Unit of Measure" := UnitOfMeasure.Description;
//                   GetPurchHeader;
//                   IF PurchHeader."Language Code" <> '' THEN BEGIN
//                     UnitOfMeasureTranslation.SETRANGE(Code,"Unit of Measure Code");
//                     UnitOfMeasureTranslation.SETRANGE("Language Code",PurchHeader."Language Code");
//                     IF UnitOfMeasureTranslation.FINDFIRST THEN
//                       "Unit of Measure" := UnitOfMeasureTranslation.Description;
//                   END;
//                 END;
//                 IF Type = Type::Item THEN
//                   UpdateItemReference;
//                 IF "Prod. Order No." = '' THEN BEGIN
//                   IF (Type = Type::Item) AND ("No." <> '') THEN BEGIN
//                     GetItem(Item);
//                     "Qty. per Unit of Measure" := UOMMgt.GetQtyPerUnitOfMeasure(Item,"Unit of Measure Code");
//                     "Gross Weight" := Item."Gross Weight" * "Qty. per Unit of Measure";
//                     "Net Weight" := Item."Net Weight" * "Qty. per Unit of Measure";
//                     "Unit Volume" := Item."Unit Volume" * "Qty. per Unit of Measure";
//                     "Units per Parcel" := ROUND(Item."Units per Parcel" / "Qty. per Unit of Measure",0.00001);
//                     OnAfterAssignItemUOM(Rec,Item);
//                     IF "Qty. per Unit of Measure" > xRec."Qty. per Unit of Measure" THEN
//                       InitItemAppl;
//                     UpdateUOMQtyPerStockQty;
//                   END ELSE
//                     "Qty. per Unit of Measure" := 1;
//                 END ELSE
//                   "Qty. per Unit of Measure" := 0;

//                 VALIDATE(Quantity);
//             end;
//         }
//         field(5415;"Quantity (Base)";Decimal)
//         {
//             Caption = 'Quantity (Base)';
//             DecimalPlaces = 0:5;

//             trigger OnValidate()
//             begin
//                 TESTFIELD("Qty. per Unit of Measure",1);
//                 VALIDATE(Quantity,"Quantity (Base)");
//                 UpdateDirectUnitCost(FIELDNO("Quantity (Base)"));
//             end;
//         }
//         field(5416;"Outstanding Qty. (Base)";Decimal)
//         {
//             Caption = 'Outstanding Qty. (Base)';
//             DecimalPlaces = 0:5;
//             Editable = false;
//         }
//         field(5417;"Qty. to Invoice (Base)";Decimal)
//         {
//             Caption = 'Qty. to Invoice (Base)';
//             DecimalPlaces = 0:5;

//             trigger OnValidate()
//             begin
//                 TESTFIELD("Qty. per Unit of Measure",1);
//                 VALIDATE("Qty. to Invoice","Qty. to Invoice (Base)");
//             end;
//         }
//         field(5418;"Qty. to Receive (Base)";Decimal)
//         {
//             Caption = 'Qty. to Receive (Base)';
//             DecimalPlaces = 0:5;

//             trigger OnValidate()
//             begin
//                 TESTFIELD("Qty. per Unit of Measure",1);
//                 VALIDATE("Qty. to Receive","Qty. to Receive (Base)");
//             end;
//         }
//         field(5458;"Qty. Rcd. Not Invoiced (Base)";Decimal)
//         {
//             Caption = 'Qty. Rcd. Not Invoiced (Base)';
//             DecimalPlaces = 0:5;
//             Editable = false;
//         }
//         field(5460;"Qty. Received (Base)";Decimal)
//         {
//             Caption = 'Qty. Received (Base)';
//             DecimalPlaces = 0:5;
//             Editable = false;
//         }
//         field(5461;"Qty. Invoiced (Base)";Decimal)
//         {
//             Caption = 'Qty. Invoiced (Base)';
//             DecimalPlaces = 0:5;
//             Editable = false;
//         }
//         field(5495;"Reserved Qty. (Base)";Decimal)
//         {
//             CalcFormula = Sum("Reservation Entry"."Quantity (Base)" WHERE (Source Type=CONST(39),
//                                                                            Source Subtype=FIELD(Document Type),
//                                                                            Source ID=FIELD(Document No.),
//                                                                            Source Ref. No.=FIELD(Line No.),
//                                                                            Reservation Status=CONST(Reservation)));
//             Caption = 'Reserved Qty. (Base)';
//             DecimalPlaces = 0:5;
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(5600;"FA Posting Date";Date)
//         {
//             Caption = 'FA Posting Date';
//         }
//         field(5601;"FA Posting Type";Option)
//         {
//             AccessByPermission = TableData 5600=R;
//             Caption = 'FA Posting Type';
//             OptionCaption = ' ,Acquisition Cost,Maintenance,,Appreciation';
//             OptionMembers = " ","Acquisition Cost",Maintenance,,Appreciation;

//             trigger OnValidate()
//             begin
//                 IF Type = Type::"Fixed Asset" THEN BEGIN
//                   TESTFIELD("Job No.",'');
//                   IF "FA Posting Type" = "FA Posting Type"::" " THEN
//                     "FA Posting Type" := "FA Posting Type"::"Acquisition Cost";
//                   GetFAPostingGroup;
//                 END ELSE BEGIN
//                   "Depreciation Book Code" := '';
//                   "FA Posting Date" := 0D;
//                   "Salvage Value" := 0;
//                   "Depr. until FA Posting Date" := FALSE;
//                   "Depr. Acquisition Cost" := FALSE;
//                   "Maintenance Code" := '';
//                   "Insurance No." := '';
//                   "Budgeted FA No." := '';
//                   "Duplicate in Depreciation Book" := '';
//                   "Use Duplication List" := FALSE;
//                 END;
//             end;
//         }
//         field(5602;"Depreciation Book Code";Code[10])
//         {
//             Caption = 'Depreciation Book Code';
//             TableRelation = "Depreciation Book";

//             trigger OnValidate()
//             begin
//                 GetFAPostingGroup;
//             end;
//         }
//         field(5603;"Salvage Value";Decimal)
//         {
//             AutoFormatType = 1;
//             Caption = 'Salvage Value';
//         }
//         field(5605;"Depr. until FA Posting Date";Boolean)
//         {
//             AccessByPermission = TableData 5600=R;
//             Caption = 'Depr. until FA Posting Date';
//         }
//         field(5606;"Depr. Acquisition Cost";Boolean)
//         {
//             AccessByPermission = TableData 5600=R;
//             Caption = 'Depr. Acquisition Cost';
//         }
//         field(5609;"Maintenance Code";Code[10])
//         {
//             Caption = 'Maintenance Code';
//             TableRelation = Maintenance;
//         }
//         field(5610;"Insurance No.";Code[20])
//         {
//             Caption = 'Insurance No.';
//             TableRelation = Insurance;
//         }
//         field(5611;"Budgeted FA No.";Code[20])
//         {
//             Caption = 'Budgeted FA No.';
//             TableRelation = "Fixed Asset";

//             trigger OnValidate()
//             var
//                 FixedAsset: Record "5600";
//             begin
//                 IF "Budgeted FA No." <> '' THEN BEGIN
//                   FixedAsset.GET("Budgeted FA No.");
//                   FixedAsset.TESTFIELD("Budgeted Asset",TRUE);
//                 END;
//             end;
//         }
//         field(5612;"Duplicate in Depreciation Book";Code[10])
//         {
//             Caption = 'Duplicate in Depreciation Book';
//             TableRelation = "Depreciation Book";

//             trigger OnValidate()
//             begin
//                 "Use Duplication List" := FALSE;
//             end;
//         }
//         field(5613;"Use Duplication List";Boolean)
//         {
//             AccessByPermission = TableData 5600=R;
//             Caption = 'Use Duplication List';

//             trigger OnValidate()
//             begin
//                 "Duplicate in Depreciation Book" := '';
//             end;
//         }
//         field(5700;"Responsibility Center";Code[10])
//         {
//             Caption = 'Responsibility Center';
//             Editable = false;
//             TableRelation = "Responsibility Center";

//             trigger OnValidate()
//             begin
//                 CreateDim(
//                   DATABASE::"Responsibility Center","Responsibility Center",
//                   DimMgt.TypeToTableID3(Type),"No.",
//                   DATABASE::Job,"Job No.",
//                   DATABASE::"Work Center","Work Center No.");
//             end;
//         }
//         field(5705;"Cross-Reference No.";Code[20])
//         {
//             AccessByPermission = TableData 5717=R;
//             Caption = 'Cross-Reference No.';

//             trigger OnLookup()
//             begin
//                 CrossReferenceNoLookUp;
//             end;

//             trigger OnValidate()
//             var
//                 ItemCrossReference: Record "5717";
//             begin
//                 GetPurchHeader;
//                 "Buy-from Vendor No." := PurchHeader."Buy-from Vendor No.";
//                 ValidateCrossReferenceNo(ItemCrossReference,TRUE);
//             end;
//         }
//         field(5706;"Unit of Measure (Cross Ref.)";Code[10])
//         {
//             Caption = 'Unit of Measure (Cross Ref.)';
//             TableRelation = IF (Type=CONST(Item)) "Item Unit of Measure".Code WHERE (Item No.=FIELD(No.));
//         }
//         field(5707;"Cross-Reference Type";Option)
//         {
//             Caption = 'Cross-Reference Type';
//             OptionCaption = ' ,Customer,Vendor,Bar Code';
//             OptionMembers = " ",Customer,Vendor,"Bar Code";
//         }
//         field(5708;"Cross-Reference Type No.";Code[30])
//         {
//             Caption = 'Cross-Reference Type No.';
//         }
//         field(5709;"Item Category Code";Code[20])
//         {
//             Caption = 'Item Category Code';
//             TableRelation = "Item Category";
//         }
//         field(5710;Nonstock;Boolean)
//         {
//             AccessByPermission = TableData 5718=R;
//             Caption = 'Catalog';
//         }
//         field(5711;"Purchasing Code";Code[10])
//         {
//             Caption = 'Purchasing Code';
//             Editable = false;
//             TableRelation = Purchasing;

//             trigger OnValidate()
//             var
//                 PurchasingCode: Record "5721";
//             begin
//                 IF PurchasingCode.GET("Purchasing Code") THEN BEGIN
//                   "Drop Shipment" := PurchasingCode."Drop Shipment";
//                   "Special Order" := PurchasingCode."Special Order";
//                 END ELSE
//                   "Drop Shipment" := FALSE;
//                 VALIDATE("Drop Shipment","Drop Shipment");
//             end;
//         }
//         field(5712;"Product Group Code";Code[10])
//         {
//             Caption = 'Product Group Code';
//             ObsoleteReason = 'Product Groups became first level children of Item Categories.';
//             ObsoleteState = Pending;
//             TableRelation = "Product Group".Code WHERE (Item Category Code=FIELD(Item Category Code));
//             ValidateTableRelation = false;
//         }
//         field(5713;"Special Order";Boolean)
//         {
//             Caption = 'Special Order';

//             trigger OnValidate()
//             begin
//                 IF (xRec."Special Order" <> "Special Order") AND (Quantity <> 0) THEN
//                   WhseValidateSourceLine.PurchaseLineVerifyChange(Rec,xRec);
//             end;
//         }
//         field(5714;"Special Order Sales No.";Code[20])
//         {
//             AccessByPermission = TableData 223=R;
//             Caption = 'Special Order Sales No.';
//             TableRelation = IF (Special Order=CONST(Yes)) "Sales Header".No. WHERE (Document Type=CONST(Order));

//             trigger OnValidate()
//             begin
//                 IF (xRec."Special Order Sales No." <> "Special Order Sales No.") AND (Quantity <> 0) THEN
//                   WhseValidateSourceLine.PurchaseLineVerifyChange(Rec,xRec);
//             end;
//         }
//         field(5715;"Special Order Sales Line No.";Integer)
//         {
//             AccessByPermission = TableData 223=R;
//             Caption = 'Special Order Sales Line No.';
//             TableRelation = IF (Special Order=CONST(Yes)) "Sales Line"."Line No." WHERE (Document Type=CONST(Order),
//                                                                                          Document No.=FIELD(Special Order Sales No.));

//             trigger OnValidate()
//             begin
//                 IF (xRec."Special Order Sales Line No." <> "Special Order Sales Line No.") AND (Quantity <> 0) THEN
//                   WhseValidateSourceLine.PurchaseLineVerifyChange(Rec,xRec);
//             end;
//         }
//         field(5750;"Whse. Outstanding Qty. (Base)";Decimal)
//         {
//             AccessByPermission = TableData 14=R;
//             BlankZero = true;
//             CalcFormula = Sum("Warehouse Receipt Line"."Qty. Outstanding (Base)" WHERE (Source Type=CONST(39),
//                                                                                         Source Subtype=FIELD(Document Type),
//                                                                                         Source No.=FIELD(Document No.),
//                                                                                         Source Line No.=FIELD(Line No.)));
//             Caption = 'Whse. Outstanding Qty. (Base)';
//             DecimalPlaces = 0:5;
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(5752;"Completely Received";Boolean)
//         {
//             Caption = 'Completely Received';
//             Editable = false;
//         }
//         field(5790;"Requested Receipt Date";Date)
//         {
//             Caption = 'Requested Receipt Date';

//             trigger OnValidate()
//             begin
//                 TestStatusOpen;
//                 IF (CurrFieldNo <> 0) AND
//                    ("Promised Receipt Date" <> 0D)
//                 THEN
//                   ERROR(
//                     Text023,
//                     FIELDCAPTION("Requested Receipt Date"),
//                     FIELDCAPTION("Promised Receipt Date"));

//                 IF "Requested Receipt Date" <> 0D THEN
//                   VALIDATE("Order Date",
//                     CalendarMgmt.CalcDateBOC2(AdjustDateFormula("Lead Time Calculation"),"Requested Receipt Date",
//                       CalChange."Source Type"::Vendor,"Buy-from Vendor No.",'',
//                       CalChange."Source Type"::Location,"Location Code",'',TRUE))
//                 ELSE
//                   IF "Requested Receipt Date" <> xRec."Requested Receipt Date" THEN
//                     GetUpdateBasicDates;
//             end;
//         }
//         field(5791;"Promised Receipt Date";Date)
//         {
//             AccessByPermission = TableData 99000880=R;
//             Caption = 'Promised Receipt Date';

//             trigger OnValidate()
//             begin
//                 IF CurrFieldNo <> 0 THEN
//                   IF "Promised Receipt Date" <> 0D THEN
//                     VALIDATE("Planned Receipt Date","Promised Receipt Date")
//                   ELSE
//                     VALIDATE("Requested Receipt Date")
//                 ELSE
//                   VALIDATE("Planned Receipt Date","Promised Receipt Date");
//             end;
//         }
//         field(5792;"Lead Time Calculation";DateFormula)
//         {
//             AccessByPermission = TableData 120=R;
//             Caption = 'Lead Time Calculation';

//             trigger OnValidate()
//             begin
//                 TestStatusOpen;
//                 LeadTimeMgt.CheckLeadTimeIsNotNegative("Lead Time Calculation");

//                 IF "Requested Receipt Date" <> 0D THEN
//                   VALIDATE("Planned Receipt Date")
//                 ELSE
//                   GetUpdateBasicDates;
//             end;
//         }
//         field(5793;"Inbound Whse. Handling Time";DateFormula)
//         {
//             AccessByPermission = TableData 14=R;
//             Caption = 'Inbound Whse. Handling Time';

//             trigger OnValidate()
//             begin
//                 TestStatusOpen;
//                 IF ("Promised Receipt Date" <> 0D) OR
//                    ("Requested Receipt Date" <> 0D)
//                 THEN
//                   VALIDATE("Planned Receipt Date")
//                 ELSE
//                   VALIDATE("Expected Receipt Date");
//             end;
//         }
//         field(5794;"Planned Receipt Date";Date)
//         {
//             AccessByPermission = TableData 99000880=R;
//             Caption = 'Planned Receipt Date';

//             trigger OnValidate()
//             begin
//                 TestStatusOpen;
//                 IF "Promised Receipt Date" <> 0D THEN BEGIN
//                   IF "Planned Receipt Date" <> 0D THEN
//                     "Expected Receipt Date" :=
//                       CalendarMgmt.CalcDateBOC(InternalLeadTimeDays("Planned Receipt Date"),"Planned Receipt Date",
//                         CalChange."Source Type"::Location,"Location Code",'',
//                         CalChange."Source Type"::Location,"Location Code",'',FALSE)
//                   ELSE
//                     "Expected Receipt Date" := "Planned Receipt Date";
//                 END ELSE
//                   IF "Planned Receipt Date" <> 0D THEN BEGIN
//                     "Order Date" :=
//                       CalendarMgmt.CalcDateBOC2(AdjustDateFormula("Lead Time Calculation"),"Planned Receipt Date",
//                         CalChange."Source Type"::Vendor,"Buy-from Vendor No.",'',
//                         CalChange."Source Type"::Location,"Location Code",'',TRUE);
//                     "Expected Receipt Date" :=
//                       CalendarMgmt.CalcDateBOC(InternalLeadTimeDays("Planned Receipt Date"),"Planned Receipt Date",
//                         CalChange."Source Type"::Location,"Location Code",'',
//                         CalChange."Source Type"::Location,"Location Code",'',FALSE)
//                   END ELSE
//                     GetUpdateBasicDates;

//                 IF NOT TrackingBlocked THEN
//                   CheckDateConflict.PurchLineCheck(Rec,CurrFieldNo <> 0);
//             end;
//         }
//         field(5795;"Order Date";Date)
//         {
//             AccessByPermission = TableData 120=R;
//             Caption = 'Order Date';

//             trigger OnValidate()
//             begin
//                 TestStatusOpen;
//                 IF (CurrFieldNo <> 0) AND
//                    ("Document Type" = "Document Type"::Order) AND
//                    ("Order Date" < WORKDATE) AND
//                    ("Order Date" <> 0D)
//                 THEN
//                   MESSAGE(
//                     Text018,
//                     FIELDCAPTION("Order Date"),"Order Date",WORKDATE);

//                 IF "Order Date" <> 0D THEN
//                   "Planned Receipt Date" :=
//                     CalendarMgmt.CalcDateBOC(AdjustDateFormula("Lead Time Calculation"),"Order Date",
//                       CalChange."Source Type"::Vendor,"Buy-from Vendor No.",'',
//                       CalChange."Source Type"::Location,"Location Code",'',TRUE);

//                 IF "Planned Receipt Date" <> 0D THEN
//                   "Expected Receipt Date" :=
//                     CalendarMgmt.CalcDateBOC(InternalLeadTimeDays("Planned Receipt Date"),"Planned Receipt Date",
//                       CalChange."Source Type"::Location,"Location Code",'',
//                       CalChange."Source Type"::Location,"Location Code",'',FALSE)
//                 ELSE
//                   "Expected Receipt Date" := "Planned Receipt Date";

//                 IF NOT TrackingBlocked THEN
//                   CheckDateConflict.PurchLineCheck(Rec,CurrFieldNo <> 0);
//             end;
//         }
//         field(5800;"Allow Item Charge Assignment";Boolean)
//         {
//             AccessByPermission = TableData 5800=R;
//             Caption = 'Allow Item Charge Assignment';
//             InitValue = true;

//             trigger OnValidate()
//             begin
//                 CheckItemChargeAssgnt;
//             end;
//         }
//         field(5801;"Qty. to Assign";Decimal)
//         {
//             CalcFormula = Sum("Item Charge Assignment (Purch)"."Qty. to Assign" WHERE (Document Type=FIELD(Document Type),
//                                                                                        Document No.=FIELD(Document No.),
//                                                                                        Document Line No.=FIELD(Line No.)));
//             Caption = 'Qty. to Assign';
//             DecimalPlaces = 0:5;
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(5802;"Qty. Assigned";Decimal)
//         {
//             CalcFormula = Sum("Item Charge Assignment (Purch)"."Qty. Assigned" WHERE (Document Type=FIELD(Document Type),
//                                                                                       Document No.=FIELD(Document No.),
//                                                                                       Document Line No.=FIELD(Line No.)));
//             Caption = 'Qty. Assigned';
//             DecimalPlaces = 0:5;
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(5803;"Return Qty. to Ship";Decimal)
//         {
//             AccessByPermission = TableData 6650=R;
//             Caption = 'Return Qty. to Ship';
//             DecimalPlaces = 0:5;

//             trigger OnValidate()
//             begin
//                 IF (CurrFieldNo <> 0) AND
//                    (Type = Type::Item) AND
//                    ("Return Qty. to Ship" <> 0) AND
//                    (NOT "Drop Shipment")
//                 THEN
//                   CheckWarehouse;

//                 IF "Return Qty. to Ship" = Quantity - "Return Qty. Shipped" THEN
//                   InitQtyToShip
//                 ELSE BEGIN
//                   "Return Qty. to Ship (Base)" := CalcBaseQty("Return Qty. to Ship");
//                   InitQtyToInvoice;
//                 END;
//                 IF ("Return Qty. to Ship" * Quantity < 0) OR
//                    (ABS("Return Qty. to Ship") > ABS("Outstanding Quantity")) OR
//                    (Quantity * "Outstanding Quantity" < 0)
//                 THEN
//                   ERROR(
//                     Text020,
//                     "Outstanding Quantity");
//                 IF ("Return Qty. to Ship (Base)" * "Quantity (Base)" < 0) OR
//                    (ABS("Return Qty. to Ship (Base)") > ABS("Outstanding Qty. (Base)")) OR
//                    ("Quantity (Base)" * "Outstanding Qty. (Base)" < 0)
//                 THEN
//                   ERROR(
//                     Text021,
//                     "Outstanding Qty. (Base)");

//                 IF (CurrFieldNo <> 0) AND (Type = Type::Item) AND ("Return Qty. to Ship" > 0) THEN
//                   CheckApplToItemLedgEntry;
//             end;
//         }
//         field(5804;"Return Qty. to Ship (Base)";Decimal)
//         {
//             Caption = 'Return Qty. to Ship (Base)';
//             DecimalPlaces = 0:5;

//             trigger OnValidate()
//             begin
//                 TESTFIELD("Qty. per Unit of Measure",1);
//                 VALIDATE("Return Qty. to Ship","Return Qty. to Ship (Base)");
//             end;
//         }
//         field(5805;"Return Qty. Shipped Not Invd.";Decimal)
//         {
//             Caption = 'Return Qty. Shipped Not Invd.';
//             DecimalPlaces = 0:5;
//             Editable = false;
//         }
//         field(5806;"Ret. Qty. Shpd Not Invd.(Base)";Decimal)
//         {
//             Caption = 'Ret. Qty. Shpd Not Invd.(Base)';
//             DecimalPlaces = 0:5;
//             Editable = false;
//         }
//         field(5807;"Return Shpd. Not Invd.";Decimal)
//         {
//             AutoFormatExpression = "Currency Code";
//             AutoFormatType = 1;
//             Caption = 'Return Shpd. Not Invd.';
//             Editable = false;

//             trigger OnValidate()
//             var
//                 Currency2: Record "4";
//             begin
//                 GetPurchHeader;
//                 Currency2.InitRoundingPrecision;
//                 IF PurchHeader."Currency Code" <> '' THEN
//                   "Return Shpd. Not Invd. (LCY)" :=
//                     ROUND(
//                       CurrExchRate.ExchangeAmtFCYToLCY(
//                         GetDate,"Currency Code",
//                         "Return Shpd. Not Invd.",PurchHeader."Currency Factor"),
//                       Currency2."Amount Rounding Precision")
//                 ELSE
//                   "Return Shpd. Not Invd. (LCY)" :=
//                     ROUND("Return Shpd. Not Invd.",Currency2."Amount Rounding Precision");
//             end;
//         }
//         field(5808;"Return Shpd. Not Invd. (LCY)";Decimal)
//         {
//             AutoFormatType = 1;
//             Caption = 'Return Shpd. Not Invd. (LCY)';
//             Editable = false;
//         }
//         field(5809;"Return Qty. Shipped";Decimal)
//         {
//             AccessByPermission = TableData 6650=R;
//             Caption = 'Return Qty. Shipped';
//             DecimalPlaces = 0:5;
//             Editable = false;
//         }
//         field(5810;"Return Qty. Shipped (Base)";Decimal)
//         {
//             Caption = 'Return Qty. Shipped (Base)';
//             DecimalPlaces = 0:5;
//             Editable = false;
//         }
//         field(6600;"Return Shipment No.";Code[20])
//         {
//             Caption = 'Return Shipment No.';
//             Editable = false;
//         }
//         field(6601;"Return Shipment Line No.";Integer)
//         {
//             Caption = 'Return Shipment Line No.';
//             Editable = false;
//         }
//         field(6608;"Return Reason Code";Code[10])
//         {
//             Caption = 'Return Reason Code';
//             TableRelation = "Return Reason";

//             trigger OnValidate()
//             begin
//                 ValidateReturnReasonCode(FIELDNO("Return Reason Code"));
//             end;
//         }
//         field(6609;Subtype;Option)
//         {
//             Caption = 'Subtype';
//             OptionCaption = ' ,Item - Inventory,Item - Service,Comment';
//             OptionMembers = " ","Item - Inventory","Item - Service",Comment;
//         }
//         field(6610;"Copied From Posted Doc.";Boolean)
//         {
//             Caption = 'Copied From Posted Doc.';
//         }
//         field(7010;"Attached Doc Count";Integer)
//         {
//             BlankNumbers = DontBlank;
//             CalcFormula = Count("Document Attachment" WHERE (Table ID=CONST(39),
//                                                              No.=FIELD(Document No.),
//                                                              Document Type=FIELD(Document Type),
//                                                              Line No.=FIELD(Line No.)));
//             Caption = 'Attached Doc Count';
//             FieldClass = FlowField;
//             InitValue = 0;
//         }
//         field(10500;"Reverse Charge Item";Boolean)
//         {
//             Caption = 'Reverse Charge Item';
//             Editable = false;
//         }
//         field(50000;"PL No.";Code[20])
//         {
//             Description = 'Upgrade frm Nav5';
//             TableRelation = "Product License"."PL No." WHERE (Stock Code=FIELD(No.),
//                                                               Blocked=CONST(No));

//             trigger OnValidate()
//             begin
//                 //alok for validate Forign name and ECMA no on change on PL no. - krupesh uncommented

//                 ProdVarLic_REc.SETRANGE(ProdVarLic_REc."PL No.","PL No.");
//                 //ProdVarLic_REc.ASCENDING(TRUE);
//                 ProdVarLic_REc.SETRANGE(ProdVarLic_REc."Stock Code","No.");
//                 //kd ProdVarLic_REc.SETRANGE(ProdVarLic_REc.Status,ProdVarLic_REc.Status::Certified);
//                 ProdVarLic_REc.SETFILTER(ProdVarLic_REc.Status,'%1|%2',ProdVarLic_REc.Status::Certified,ProdVarLic_REc.Status::New);
//                 IF ProdVarLic_REc.FINDLAST THEN BEGIN
//                    "ECMA No.":=ProdVarLic_REc."ECMA No.";
//                 END;


//                 IF  Prodlicens.GET(ProdVarLic_REc."PL No.","No.") THEN BEGIN
//                   "Foreign Name":=Prodlicens."Foreign Name";
//                   "Foreign Pack Size" := Prodlicens."Foreign Pack size";
//                 END;

//                 //alok finish - krupesh uncommented
//             end;
//         }
//         field(50001;"ECMA No.";Code[100])
//         {
//             Description = 'Upgrade frm Nav5';
//             TableRelation = "Variant Product license line"."ECMA No." WHERE (PL No.=FIELD(PL No.),
//                                                                              Stock Code=FIELD(No.),
//                                                                              Status=FILTER(Certified|New),
//                                                                              Blocked=CONST(No));
//         }
//         field(50002;"Rebox/Overlabel";Option)
//         {
//             Description = 'Upgrade frm Nav5';
//             OptionCaption = ' ,Rebox,Overlabel';
//             OptionMembers = " ",Rebox,Overlabel;
//         }
//         field(50003;"Foreign Name";Code[50])
//         {
//             Description = 'Upgrade frm Nav5';
//         }
//         field(50004;"PDN Quantity";Decimal)
//         {
//             Caption = 'PDN Qty.';
//             DecimalPlaces = 0:0;
//             Description = 'Upgrade frm Nav5';
//             Editable = false;
//         }
//         field(50005;Status;Option)
//         {
//             Description = 'Upgrade frm Nav5';
//             OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment,Closed';
//             OptionMembers = Open,Released,"Pending Approval","Pending Prepayment",Closed;
//         }
//         field(50006;"Foreign Pack Size";Code[20])
//         {
//             Description = 'Upgrade frm Nav5';
//         }
//         field(50007;"Qty. on Blanket Order(Actual)";Decimal)
//         {
//             Description = 'Upgrade frm Nav5';
//         }
//         field(50008;"Buy From Country Code";Code[20])
//         {
//             CalcFormula = Lookup("Purchase Header"."Buy-from Country/Region Code" WHERE (Document Type=FIELD(Document Type),
//                                                                                          No.=FIELD(Document No.),
//                                                                                          Buy-from Vendor No.=FIELD(Buy-from Vendor No.)));
//             Description = 'chem-222';
//             FieldClass = FlowField;
//         }
//         field(50009;"Your Reference";Text[35])
//         {
//             CalcFormula = Lookup("Purchase Header"."Your Reference" WHERE (Document Type=FIELD(Document Type),
//                                                                            No.=FIELD(Document No.)));
//             Caption = 'Your Reference';
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(50012;"Original Ordered Quantity";Decimal)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(99000750;"Routing No.";Code[20])
//         {
//             Caption = 'Routing No.';
//             TableRelation = "Routing Header";
//         }
//         field(99000751;"Operation No.";Code[10])
//         {
//             Caption = 'Operation No.';
//             Editable = false;
//             TableRelation = "Prod. Order Routing Line"."Operation No." WHERE (Status=CONST(Released),
//                                                                               Prod. Order No.=FIELD(Prod. Order No.),
//                                                                               Routing No.=FIELD(Routing No.));

//             trigger OnValidate()
//             var
//                 ProdOrderRtngLine: Record "5409";
//             begin
//                 IF "Operation No." = '' THEN
//                   EXIT;

//                 TESTFIELD(Type,Type::Item);
//                 TESTFIELD("Prod. Order No.");
//                 TESTFIELD("Routing No.");

//                 ProdOrderRtngLine.GET(
//                   ProdOrderRtngLine.Status::Released,
//                   "Prod. Order No.",
//                   "Routing Reference No.",
//                   "Routing No.",
//                   "Operation No.");

//                 ProdOrderRtngLine.TESTFIELD(
//                   Type,
//                   ProdOrderRtngLine.Type::"Work Center");

//                 "Expected Receipt Date" := ProdOrderRtngLine."Ending Date";
//                 VALIDATE("Work Center No.",ProdOrderRtngLine."No.");
//                 VALIDATE("Direct Unit Cost",ProdOrderRtngLine."Direct Unit Cost");
//             end;
//         }
//         field(99000752;"Work Center No.";Code[20])
//         {
//             Caption = 'Work Center No.';
//             Editable = false;
//             TableRelation = "Work Center";

//             trigger OnValidate()
//             begin
//                 IF Type = Type::"Charge (Item)" THEN
//                   TESTFIELD("Work Center No.",'');
//                 IF "Work Center No." = '' THEN
//                   EXIT;

//                 WorkCenter.GET("Work Center No.");
//                 "Gen. Prod. Posting Group" := WorkCenter."Gen. Prod. Posting Group";
//                 "VAT Prod. Posting Group" := '';
//                 IF GenProdPostingGrp.ValidateVatProdPostingGroup(GenProdPostingGrp,"Gen. Prod. Posting Group") THEN
//                   "VAT Prod. Posting Group" := GenProdPostingGrp."Def. VAT Prod. Posting Group";
//                 VALIDATE("VAT Prod. Posting Group");

//                 "Overhead Rate" := WorkCenter."Overhead Rate";
//                 VALIDATE("Indirect Cost %",WorkCenter."Indirect Cost %");

//                 CreateDim(
//                   DATABASE::"Work Center","Work Center No.",
//                   DimMgt.TypeToTableID3(Type),"No.",
//                   DATABASE::Job,"Job No.",
//                   DATABASE::"Responsibility Center","Responsibility Center");
//             end;
//         }
//         field(99000753;Finished;Boolean)
//         {
//             Caption = 'Finished';
//         }
//         field(99000754;"Prod. Order Line No.";Integer)
//         {
//             Caption = 'Prod. Order Line No.';
//             Editable = false;
//             TableRelation = "Prod. Order Line"."Line No." WHERE (Status=FILTER(Released..),
//                                                                  Prod. Order No.=FIELD(Prod. Order No.));
//         }
//         field(99000755;"Overhead Rate";Decimal)
//         {
//             Caption = 'Overhead Rate';
//             DecimalPlaces = 0:5;

//             trigger OnValidate()
//             begin
//                 VALIDATE("Indirect Cost %");
//             end;
//         }
//         field(99000756;"MPS Order";Boolean)
//         {
//             Caption = 'MPS Order';
//         }
//         field(99000757;"Planning Flexibility";Option)
//         {
//             Caption = 'Planning Flexibility';
//             OptionCaption = 'Unlimited,None';
//             OptionMembers = Unlimited,"None";

//             trigger OnValidate()
//             begin
//                 IF "Planning Flexibility" <> xRec."Planning Flexibility" THEN
//                   ReservePurchLine.UpdatePlanningFlexibility(Rec);
//             end;
//         }
//         field(99000758;"Safety Lead Time";DateFormula)
//         {
//             Caption = 'Safety Lead Time';

//             trigger OnValidate()
//             begin
//                 VALIDATE("Inbound Whse. Handling Time");
//             end;
//         }
//         field(99000759;"Routing Reference No.";Integer)
//         {
//             Caption = 'Routing Reference No.';
//         }
//     }

//     keys
//     {
//         key(Key1;"Document Type","Document No.","Line No.")
//         {
//         }
//         key(Key2;"Document Type",Type,"No.","Variant Code","Drop Shipment","Location Code","Expected Receipt Date")
//         {
//             SumIndexFields = "Outstanding Qty. (Base)";
//         }
//         key(Key3;"Document Type","Pay-to Vendor No.","Currency Code","Document No.")
//         {
//             MaintainSIFTIndex = false;
//             SumIndexFields = "Outstanding Amount","Amt. Rcd. Not Invoiced","Outstanding Amount (LCY)","Amt. Rcd. Not Invoiced (LCY)";
//         }
//         key(Key4;"Document Type","Blanket Order No.","Blanket Order Line No.")
//         {
//         }
//         key(Key5;"Document Type",Type,"Prod. Order No.","Prod. Order Line No.","Routing No.","Operation No.")
//         {
//         }
//         key(Key6;"Document Type","Document No.","Location Code")
//         {
//             MaintainSQLIndex = false;
//             SumIndexFields = Amount,"Amount Including VAT";
//         }
//         key(Key7;"Document Type","Receipt No.","Receipt Line No.")
//         {
//         }
//         key(Key8;Type,"No.","Variant Code","Drop Shipment","Location Code","Document Type","Expected Receipt Date")
//         {
//             MaintainSQLIndex = false;
//         }
//         key(Key9;"Document Type","Buy-from Vendor No.")
//         {
//         }
//         key(Key10;"Document Type","Job No.","Job Task No.","Document No.")
//         {
//             SumIndexFields = "Outstanding Amt. Ex. VAT (LCY)","A. Rcd. Not Inv. Ex. VAT (LCY)";
//         }
//         key(Key11;"Document Type","Document No.",Type,"No.")
//         {
//         }
//         key(Key12;"Expected Receipt Date","Document No.")
//         {
//         }
//         key(Key13;Type,"No.")
//         {
//             SumIndexFields = "Outstanding Quantity",Quantity;
//         }
//         key(Key14;Type,"No.","Location Code")
//         {
//             SumIndexFields = "Outstanding Quantity";
//         }
//         key(Key15;"No.",Type,"Document Type",Status)
//         {
//             SumIndexFields = "Outstanding Qty. (Base)","Qty. on Blanket Order(Actual)";
//         }
//         key(Key16;"Document Type","No.",Type,Status,"Expected Receipt Date")
//         {
//             SumIndexFields = "Qty. on Blanket Order(Actual)","Outstanding Qty. (Base)";
//         }
//         key(Key17;"Document Type","Location Code","No.",Type,Status)
//         {
//             SumIndexFields = "Qty. on Blanket Order(Actual)";
//         }
//         key(Key18;"Recalculate Invoice Disc.")
//         {
//         }
//         key(Key19;"Outstanding Quantity")
//         {
//         }
//         key(Key20;"Location Code","Quantity Invoiced")
//         {
//         }
//     }

//     fieldgroups
//     {
//     }

//     trigger OnDelete()
//     var
//         PurchCommentLine: Record "43";
//         SalesOrderLine: Record "37";
//     begin
//         TestStatusOpen;
//         IF (Quantity <> 0) AND ItemExists("No.") THEN BEGIN
//           ReservePurchLine.DeleteLine(Rec);
//           IF "Receipt No." = '' THEN
//             TESTFIELD("Qty. Rcd. Not Invoiced",0);
//           IF "Return Shipment No." = '' THEN
//             TESTFIELD("Return Qty. Shipped Not Invd.",0);

//           CALCFIELDS("Reserved Qty. (Base)");
//           TESTFIELD("Reserved Qty. (Base)",0);
//           WhseValidateSourceLine.PurchaseLineDelete(Rec);
//         END;

//         IF ("Document Type" = "Document Type"::Order) AND (Quantity <> "Quantity Invoiced") THEN
//           TESTFIELD("Prepmt. Amt. Inv.","Prepmt Amt Deducted");

//         IF "Sales Order Line No." <> 0 THEN BEGIN
//           LOCKTABLE;
//           SalesOrderLine.LOCKTABLE;
//           SalesOrderLine.GET(SalesOrderLine."Document Type"::Order,"Sales Order No.","Sales Order Line No.");
//           SalesOrderLine."Purchase Order No." := '';
//           SalesOrderLine."Purch. Order Line No." := 0;
//           SalesOrderLine.MODIFY;
//         END;

//         IF ("Special Order Sales Line No." <> 0) AND ("Quantity Invoiced" = 0) THEN BEGIN
//           LOCKTABLE;
//           SalesOrderLine.LOCKTABLE;
//           IF SalesOrderLine.GET(
//                SalesOrderLine."Document Type"::Order,"Special Order Sales No.","Special Order Sales Line No.")
//           THEN BEGIN
//             SalesOrderLine."Special Order Purchase No." := '';
//             SalesOrderLine."Special Order Purch. Line No." := 0;
//             SalesOrderLine.MODIFY;
//           END;
//         END;

//         CatalogItemMgt.DelNonStockPurch(Rec);

//         IF "Document Type" = "Document Type"::"Blanket Order" THEN BEGIN
//           PurchLine2.RESET;
//           PurchLine2.SETCURRENTKEY("Document Type","Blanket Order No.","Blanket Order Line No.");
//           PurchLine2.SETRANGE("Blanket Order No.","Document No.");
//           PurchLine2.SETRANGE("Blanket Order Line No.","Line No.");
//           IF PurchLine2.FINDFIRST THEN
//             PurchLine2.TESTFIELD("Blanket Order Line No.",0);
//         END;

//         IF Type = Type::Item THEN
//           DeleteItemChargeAssgnt("Document Type","Document No.","Line No.");

//         IF Type = Type::"Charge (Item)" THEN
//           DeleteChargeChargeAssgnt("Document Type","Document No.","Line No.");

//         IF "Line No." <> 0 THEN BEGIN
//           PurchLine2.RESET;
//           PurchLine2.SETRANGE("Document Type","Document Type");
//           PurchLine2.SETRANGE("Document No.","Document No.");
//           PurchLine2.SETRANGE("Attached to Line No.","Line No.");
//           PurchLine2.SETFILTER("Line No.",'<>%1',"Line No.");
//           PurchLine2.DELETEALL(TRUE);
//         END;

//         PurchCommentLine.SETRANGE("Document Type","Document Type");
//         PurchCommentLine.SETRANGE("No.","Document No.");
//         PurchCommentLine.SETRANGE("Document Line No.","Line No.");
//         IF NOT PurchCommentLine.ISEMPTY THEN
//           PurchCommentLine.DELETEALL;

//         // In case we have roundings on VAT or Sales Tax, we should update some other line
//         IF (Type <> Type::" ") AND ("Line No." <> 0) AND ("Attached to Line No." = 0) AND
//            (Quantity <> 0) AND (Amount <> 0) AND (Amount <> "Amount Including VAT") AND NOT StatusCheckSuspended
//         THEN BEGIN
//           Quantity := 0;
//           "Quantity (Base)" := 0;
//           "Line Discount Amount" := 0;
//           "Inv. Discount Amount" := 0;
//           "Inv. Disc. Amount to Invoice" := 0;
//           UpdateAmounts;
//         END;

//         IF "Deferral Code" <> '' THEN
//           DeferralUtilities.DeferralCodeOnDelete(
//             DeferralUtilities.GetPurchDeferralDocType,'','',
//             "Document Type","Document No.","Line No.");
//     end;

//     trigger OnInsert()
//     begin
//         TestStatusOpen;
//         IF Quantity <> 0 THEN BEGIN
//           OnBeforeVerifyReservedQty(Rec,xRec,0);
//           ReservePurchLine.VerifyQuantity(Rec,xRec);
//         END;
//         LOCKTABLE;
//         PurchHeader."No." := '';
//         IF ("Deferral Code" <> '') AND (GetDeferralAmount <> 0) THEN
//           UpdateDeferralAmounts;

//         DomesticVendorWarning;
//     end;

//     trigger OnModify()
//     begin
//         IF ("Document Type" = "Document Type"::"Blanket Order") AND
//            ((Type <> xRec.Type) OR ("No." <> xRec."No."))
//         THEN BEGIN
//           PurchLine2.RESET;
//           PurchLine2.SETCURRENTKEY("Document Type","Blanket Order No.","Blanket Order Line No.");
//           PurchLine2.SETRANGE("Blanket Order No.","Document No.");
//           PurchLine2.SETRANGE("Blanket Order Line No.","Line No.");
//           IF PurchLine2.FINDSET THEN
//             REPEAT
//               PurchLine2.TESTFIELD(Type,Type);
//               PurchLine2.TESTFIELD("No.","No.");
//             UNTIL PurchLine2.NEXT = 0;
//         END;

//         IF ((Quantity <> 0) OR (xRec.Quantity <> 0)) AND ItemExists(xRec."No.") THEN
//           ReservePurchLine.VerifyChange(Rec,xRec);

//         DomesticVendorWarning;
//     end;

//     trigger OnRename()
//     begin
//         ERROR(Text000,TABLECAPTION);
//     end;

//     var
//         Text000: Label 'You cannot rename a %1.';
//         Text001: Label 'You cannot change %1 because the order line is associated with sales order %2.';
//         Text002: Label 'Prices including VAT cannot be calculated when %1 is %2.';
//         Text003: Label 'You cannot purchase resources.';
//         Text004: Label 'must not be less than %1';
//         Text006: Label 'You cannot invoice more than %1 units.';
//         Text007: Label 'You cannot invoice more than %1 base units.';
//         Text008: Label 'You cannot receive more than %1 units.';
//         Text009: Label 'You cannot receive more than %1 base units.';
//         Text010: Label 'You cannot change %1 when %2 is %3.';
//         Text011: Label ' must be 0 when %1 is %2';
//         Text012: Label 'must not be specified when %1 = %2';
//         Text016: Label '%1 is required for %2 = %3.';
//         WhseRequirementMsg: Label '%1 is required for this line. The entered information may be disregarded by warehouse activities.', Comment='%1=Document';
//         Text018: Label '%1 %2 is earlier than the work date %3.';
//         Text020: Label 'You cannot return more than %1 units.';
//         Text021: Label 'You cannot return more than %1 base units.';
//         Text022: Label 'You cannot change %1, if item charge is already posted.';
//         Text023: Label 'You cannot change the %1 when the %2 has been filled in.';
//         Text029: Label 'must be positive.';
//         Text030: Label 'must be negative.';
//         Text031: Label 'You cannot define item tracking on this line because it is linked to production order %1.';
//         Text032: Label '%1 must not be greater than the sum of %2 and %3.';
//         Text033: Label 'Warehouse ';
//         Text034: Label 'Inventory ';
//         Text035: Label '%1 units for %2 %3 have already been returned or transferred. Therefore, only %4 units can be returned.';
//         Text037: Label 'cannot be %1.';
//         Text038: Label 'cannot be less than %1.';
//         Text039: Label 'cannot be more than %1.';
//         Text040: Label 'You must use form %1 to enter %2, if item tracking is used.';
//         ItemChargeAssignmentErr: Label 'You can only assign Item Charges for Line Types of Charge (Item).';
//         Text99000000: Label 'You cannot change %1 when the purchase order is associated to a production order.';
//         PurchHeader: Record "38";
//         PurchLine2: Record "39";
//         GLAcc: Record "15";
//         Currency: Record "4";
//         CurrExchRate: Record "330";
//         VATPostingSetup: Record "325";
//         GenBusPostingGrp: Record "250";
//         GenProdPostingGrp: Record "251";
//         UnitOfMeasure: Record "204";
//         ItemCharge: Record "5800";
//         SKU: Record "5700";
//         WorkCenter: Record "99000754";
//         InvtSetup: Record "313";
//         Location: Record "14";
//         GLSetup: Record "98";
//         CalChange: Record "7602";
//         TempJobJnlLine: Record "210" temporary;
//         PurchSetup: Record "312";
//         SalesTaxCalculate: Codeunit "398";
//         ReservEngineMgt: Codeunit "99000831";
//         ReservePurchLine: Codeunit "99000834";
//         UOMMgt: Codeunit "5402";
//         AddOnIntegrMgt: Codeunit "5403";
//         DimMgt: Codeunit "408";
//         DistIntegration: Codeunit "5702";
//         CatalogItemMgt: Codeunit "5703";
//         WhseValidateSourceLine: Codeunit "5777";
//         LeadTimeMgt: Codeunit "5404";
//         PurchPriceCalcMgt: Codeunit "7010";
//         CalendarMgmt: Codeunit "7600";
//         CheckDateConflict: Codeunit "99000815";
//         DeferralUtilities: Codeunit "1720";
//         PostingSetupMgt: Codeunit "48";
//         TrackingBlocked: Boolean;
//         StatusCheckSuspended: Boolean;
//         GLSetupRead: Boolean;
//         UnitCostCurrency: Decimal;
//         UpdateFromVAT: Boolean;
//         Text042: Label 'You cannot return more than the %1 units that you have received for %2 %3.';
//         Text043: Label 'must be positive when %1 is not 0.';
//         Text044: Label 'You cannot change %1 because this purchase order is associated with %2 %3.';
//         Text046: Label '%3 will not update %1 when changing %2 because a prepayment invoice has been posted. Do you want to continue?', Comment='%1 - product name';
//         Text047: Label '%1 can only be set when %2 is set.';
//         Text048: Label '%1 cannot be changed when %2 is set.';
//         PrePaymentLineAmountEntered: Boolean;
//         Text049: Label 'You have changed one or more dimensions on the %1, which is already shipped. When you post the line with the changed dimension to General Ledger, amounts on the Inventory Interim account will be out of balance when reported per dimension.\\Do you want to keep the changed dimension?';
//         Text050: Label 'Cancelled.';
//         Text051: Label 'must have the same sign as the receipt';
//         Text052: Label 'The quantity that you are trying to invoice is greater than the quantity in receipt %1.';
//         Text053: Label 'must have the same sign as the return shipment';
//         Text054: Label 'The quantity that you are trying to invoice is greater than the quantity in return shipment %1.';
//         Text1041000: Label 'Warning: You have selected an item that is subject to Reverse Charge VAT. Please check that the VAT Code %1 in the %2 field is correct. If necessary, update this field before posting. ';
//         Text1041002: Label 'cannot be %1. %1 can only be used for domestic customers and vendors. ';
//         Text1041003: Label 'cannot be %1. %1 can only be used for reverse charge items. ';
//         AnotherItemWithSameDescrQst: Label 'Item No. %1 also has the description "%2".\Do you want to change the current item no. to %1?', Comment='%1=Item no., %2=item description';
//         AnotherChargeItemWithSameDescQst: Label 'Item charge No. %1 also has the description "%2".\Do you want to change the current item charge no. to %1?', Comment='%1=Item charge no., %2=item charge description';
//         PurchSetupRead: Boolean;
//         CannotFindDescErr: Label 'Cannot find %1 with Description %2.\\Make sure to use the correct type.', Comment='%1 = Type caption %2 = Description';
//         CommentLbl: Label 'Comment';
//         LineDiscountPctErr: Label 'The value in the Line Discount % field must be between 0 and 100.';
//         PurchasingBlockedErr: Label 'You cannot purchase this item because the Purchasing Blocked check box is selected on the item card.';
//         CannotChangePrepaidServiceChargeErr: Label 'You cannot change the line because it will affect service charges that are already invoiced as part of a prepayment.';
//         ProdVarLic_REc: Record "50010";
//         Prodlicens: Record "50008";
//         PurchLine: Record "39";
//         PDN: Decimal;
//         Liences: Record "50008";
//         Vendor: Record "23";
//         Purchaseline: Record "39";
//         PurchasePriceNew: Record "7012";
//         PurchHeaderRec: Record "38";

//     [Scope('Personalization')]
//     procedure InitOutstanding()
//     begin
//         IF IsCreditDocType THEN BEGIN
//           "Outstanding Quantity" := Quantity - "Return Qty. Shipped";
//           "Outstanding Qty. (Base)" := "Quantity (Base)" - "Return Qty. Shipped (Base)";
//           "Return Qty. Shipped Not Invd." := "Return Qty. Shipped" - "Quantity Invoiced";
//           "Ret. Qty. Shpd Not Invd.(Base)" := "Return Qty. Shipped (Base)" - "Qty. Invoiced (Base)";
//         END ELSE BEGIN
//           "Outstanding Quantity" := Quantity - "Quantity Received";
//           "Outstanding Qty. (Base)" := "Quantity (Base)" - "Qty. Received (Base)";
//           "Qty. Rcd. Not Invoiced" := "Quantity Received" - "Quantity Invoiced";
//           "Qty. Rcd. Not Invoiced (Base)" := "Qty. Received (Base)" - "Qty. Invoiced (Base)";
//         END;

//         OnAfterInitOutstandingQty(Rec);
//         "Completely Received" := (Quantity <> 0) AND ("Outstanding Quantity" = 0);
//         InitOutstandingAmount;
//     end;

//     [Scope('Personalization')]
//     procedure InitOutstandingAmount()
//     var
//         AmountInclVAT: Decimal;
//     begin
//         IF Quantity = 0 THEN BEGIN
//           "Outstanding Amount" := 0;
//           "Outstanding Amount (LCY)" := 0;
//           "Outstanding Amt. Ex. VAT (LCY)" := 0;
//           "Amt. Rcd. Not Invoiced" := 0;
//           "Amt. Rcd. Not Invoiced (LCY)" := 0;
//           "Return Shpd. Not Invd." := 0;
//           "Return Shpd. Not Invd. (LCY)" := 0;
//         END ELSE BEGIN
//           GetPurchHeader;
//           AmountInclVAT := "Amount Including VAT";
//           VALIDATE(
//             "Outstanding Amount",
//             ROUND(
//               AmountInclVAT * "Outstanding Quantity" / Quantity,
//               Currency."Amount Rounding Precision"));
//           IF IsCreditDocType THEN
//             VALIDATE(
//               "Return Shpd. Not Invd.",
//               ROUND(
//                 AmountInclVAT * "Return Qty. Shipped Not Invd." / Quantity,
//                 Currency."Amount Rounding Precision"))
//           ELSE
//             VALIDATE(
//               "Amt. Rcd. Not Invoiced",
//               ROUND(
//                 AmountInclVAT * "Qty. Rcd. Not Invoiced" / Quantity,
//                 Currency."Amount Rounding Precision"));
//         END;

//         OnAfterInitOutstandingAmount(Rec,xRec,PurchHeader,Currency);
//     end;

//     [Scope('Personalization')]
//     procedure InitQtyToReceive()
//     begin
//         GetPurchSetup;
//         IF (PurchSetup."Default Qty. to Receive" = PurchSetup."Default Qty. to Receive"::Remainder) OR
//            ("Document Type" = "Document Type"::Invoice)
//         THEN BEGIN
//           "Qty. to Receive" := "Outstanding Quantity";
//           "Qty. to Receive (Base)" := "Outstanding Qty. (Base)";
//         END ELSE
//           IF "Qty. to Receive" <> 0 THEN
//             "Qty. to Receive (Base)" := CalcBaseQty("Qty. to Receive");

//         OnAfterInitQtyToReceive(Rec,CurrFieldNo);

//         InitQtyToInvoice;
//     end;

//     [Scope('Personalization')]
//     procedure InitQtyToShip()
//     begin
//         GetPurchSetup;
//         IF (PurchSetup."Default Qty. to Receive" = PurchSetup."Default Qty. to Receive"::Remainder) OR
//            ("Document Type" = "Document Type"::"Credit Memo")
//         THEN BEGIN
//           "Return Qty. to Ship" := "Outstanding Quantity";
//           "Return Qty. to Ship (Base)" := "Outstanding Qty. (Base)";
//         END ELSE
//           IF "Return Qty. to Ship" <> 0 THEN
//             "Return Qty. to Ship (Base)" := CalcBaseQty("Return Qty. to Ship");

//         OnAfterInitQtyToShip(Rec,CurrFieldNo);

//         InitQtyToInvoice;
//     end;

//     [Scope('Personalization')]
//     procedure InitQtyToInvoice()
//     begin
//         "Qty. to Invoice" := MaxQtyToInvoice;
//         "Qty. to Invoice (Base)" := MaxQtyToInvoiceBase;
//         "VAT Difference" := 0;
//         CalcInvDiscToInvoice;
//         IF PurchHeader."Document Type" <> PurchHeader."Document Type"::Invoice THEN
//           CalcPrepaymentToDeduct;

//         OnAfterInitQtyToInvoice(Rec,CurrFieldNo);
//     end;

//     local procedure InitItemAppl()
//     begin
//         "Appl.-to Item Entry" := 0;
//     end;

//     local procedure InitHeaderDefaults(PurchHeader: Record "38")
//     begin
//         PurchHeader.TESTFIELD("Buy-from Vendor No.");

//         "Buy-from Vendor No." := PurchHeader."Buy-from Vendor No.";
//         "Currency Code" := PurchHeader."Currency Code";
//         "Expected Receipt Date" := PurchHeader."Expected Receipt Date";
//         "Shortcut Dimension 1 Code" := PurchHeader."Shortcut Dimension 1 Code";
//         "Shortcut Dimension 2 Code" := PurchHeader."Shortcut Dimension 2 Code";
//         IF NOT IsNonInventoriableItem THEN
//           "Location Code" := PurchHeader."Location Code";
//         "Transaction Type" := PurchHeader."Transaction Type";
//         "Transport Method" := PurchHeader."Transport Method";
//         "Pay-to Vendor No." := PurchHeader."Pay-to Vendor No.";
//         "Gen. Bus. Posting Group" := PurchHeader."Gen. Bus. Posting Group";
//         "VAT Bus. Posting Group" := PurchHeader."VAT Bus. Posting Group";
//         "Entry Point" := PurchHeader."Entry Point";
//         Area := PurchHeader.Area;
//         "Transaction Specification" := PurchHeader."Transaction Specification";
//         "Tax Area Code" := PurchHeader."Tax Area Code";
//         "Tax Liable" := PurchHeader."Tax Liable";
//         IF NOT "System-Created Entry" AND ("Document Type" = "Document Type"::Order) AND HasTypeToFillMandatoryFields OR
//            IsServiceCharge
//         THEN
//           "Prepayment %" := PurchHeader."Prepayment %";
//         "Prepayment Tax Area Code" := PurchHeader."Tax Area Code";
//         "Prepayment Tax Liable" := PurchHeader."Tax Liable";
//         "Responsibility Center" := PurchHeader."Responsibility Center";
//         "Requested Receipt Date" := PurchHeader."Requested Receipt Date";
//         "Promised Receipt Date" := PurchHeader."Promised Receipt Date";
//         "Inbound Whse. Handling Time" := PurchHeader."Inbound Whse. Handling Time";
//         "Order Date" := PurchHeader."Order Date";

//         OnAfterInitHeaderDefaults(Rec,PurchHeader);
//     end;

//     [Scope('Personalization')]
//     procedure MaxQtyToInvoice(): Decimal
//     begin
//         IF "Prepayment Line" THEN
//           EXIT(1);
//         IF IsCreditDocType THEN
//           EXIT("Return Qty. Shipped" + "Return Qty. to Ship" - "Quantity Invoiced");

//         EXIT("Quantity Received" + "Qty. to Receive" - "Quantity Invoiced");
//     end;

//     [Scope('Personalization')]
//     procedure MaxQtyToInvoiceBase(): Decimal
//     begin
//         IF IsCreditDocType THEN
//           EXIT("Return Qty. Shipped (Base)" + "Return Qty. to Ship (Base)" - "Qty. Invoiced (Base)");

//         EXIT("Qty. Received (Base)" + "Qty. to Receive (Base)" - "Qty. Invoiced (Base)");
//     end;

//     [Scope('Personalization')]
//     procedure CalcInvDiscToInvoice()
//     var
//         OldInvDiscAmtToInv: Decimal;
//     begin
//         GetPurchHeader;
//         OldInvDiscAmtToInv := "Inv. Disc. Amount to Invoice";
//         IF Quantity = 0 THEN
//           VALIDATE("Inv. Disc. Amount to Invoice",0)
//         ELSE
//           VALIDATE(
//             "Inv. Disc. Amount to Invoice",
//             ROUND(
//               "Inv. Discount Amount" * "Qty. to Invoice" / Quantity,
//               Currency."Amount Rounding Precision"));

//         IF OldInvDiscAmtToInv <> "Inv. Disc. Amount to Invoice" THEN BEGIN
//           "Amount Including VAT" := "Amount Including VAT" - "VAT Difference";
//           "VAT Difference" := 0;
//         END;
//     end;

//     local procedure CalcBaseQty(Qty: Decimal): Decimal
//     begin
//         IF "Prod. Order No." = '' THEN
//           TESTFIELD("Qty. per Unit of Measure");
//         EXIT(ROUND(Qty * "Qty. per Unit of Measure",0.00001));
//     end;

//     [Scope('Personalization')]
//     procedure CalcLineAmount(): Decimal
//     begin
//         EXIT("Line Amount" - "Inv. Discount Amount");
//     end;

//     local procedure CopyFromStandardText()
//     var
//         StandardText: Record "7";
//     begin
//         StandardText.GET("No.");
//         Description := StandardText.Description;
//         "Allow Item Charge Assignment" := FALSE;
//         OnAfterAssignStdTxtValues(Rec,StandardText);
//     end;

//     local procedure CopyFromGLAccount()
//     begin
//         GLAcc.GET("No.");
//         GLAcc.CheckGLAcc;
//         IF NOT "System-Created Entry" THEN
//           GLAcc.TESTFIELD("Direct Posting",TRUE);
//         Description := GLAcc.Name;
//         "Gen. Prod. Posting Group" := GLAcc."Gen. Prod. Posting Group";
//         "VAT Prod. Posting Group" := GLAcc."VAT Prod. Posting Group";
//         "Tax Group Code" := GLAcc."Tax Group Code";
//         "Allow Invoice Disc." := FALSE;
//         "Allow Item Charge Assignment" := FALSE;
//         InitDeferralCode;
//         OnAfterAssignGLAccountValues(Rec,GLAcc);
//     end;

//     local procedure CopyFromItem()
//     var
//         Item: Record "27";
//         PrepaymentMgt: Codeunit "441";
//     begin
//         GetItem(Item);
//         GetGLSetup;
//         OnBeforeCopyFromItem(Rec,Item);
//         Item.TESTFIELD(Blocked,FALSE);
//         Item.TESTFIELD("Gen. Prod. Posting Group");
//         IF Item."Purchasing Blocked" AND NOT IsCreditDocType THEN
//           ERROR(PurchasingBlockedErr);
//         IF Item.Type = Item.Type::Inventory THEN BEGIN
//           Item.TESTFIELD("Inventory Posting Group");
//           "Posting Group" := Item."Inventory Posting Group";
//         END;
//         Description := Item.Description;
//         "Description 2" := Item."Description 2";
//         "Unit Price (LCY)" := Item."Unit Price";
//         "Units per Parcel" := Item."Units per Parcel";
//         "Indirect Cost %" := Item."Indirect Cost %";
//         "Overhead Rate" := Item."Overhead Rate";
//         "Allow Invoice Disc." := Item."Allow Invoice Disc.";
//         "Gen. Prod. Posting Group" := Item."Gen. Prod. Posting Group";
//         "VAT Prod. Posting Group" := Item."VAT Prod. Posting Group";
//         "Tax Group Code" := Item."Tax Group Code";
//         Nonstock := Item."Created From Nonstock Item";
//         "Item Category Code" := Item."Item Category Code";
//         "Allow Item Charge Assignment" := TRUE;
//         PrepaymentMgt.SetPurchPrepaymentPct(Rec,PurchHeader."Posting Date");
//         "Reverse Charge Item" := Item."Reverse Charge Applies";
//         IF Item.Type = Item.Type::Inventory THEN
//           PostingSetupMgt.CheckInvtPostingSetupInventoryAccount("Location Code","Posting Group");

//         IF Item."Price Includes VAT" THEN BEGIN
//           IF NOT VATPostingSetup.GET(Item."VAT Bus. Posting Gr. (Price)",Item."VAT Prod. Posting Group") THEN
//             VATPostingSetup.INIT;
//           CASE VATPostingSetup."VAT Calculation Type" OF
//             VATPostingSetup."VAT Calculation Type"::"Reverse Charge VAT":
//               VATPostingSetup."VAT %" := 0;
//             VATPostingSetup."VAT Calculation Type"::"Sales Tax":
//               ERROR(
//                 Text002,
//                 VATPostingSetup.FIELDCAPTION("VAT Calculation Type"),
//                 VATPostingSetup."VAT Calculation Type");
//           END;
//           "Unit Price (LCY)" :=
//             ROUND("Unit Price (LCY)" / (1 + VATPostingSetup."VAT %" / 100),
//               GLSetup."Unit-Amount Rounding Precision");
//         END;

//         IF PurchHeader."Language Code" <> '' THEN
//           GetItemTranslation;

//         "Unit of Measure Code" := Item."Purch. Unit of Measure";
//         InitDeferralCode;
//         OnAfterAssignItemValues(Rec,Item);
//     end;

//     local procedure CopyFromFixedAsset()
//     var
//         FixedAsset: Record "5600";
//     begin
//         FixedAsset.GET("No.");
//         FixedAsset.TESTFIELD(Inactive,FALSE);
//         FixedAsset.TESTFIELD(Blocked,FALSE);
//         GetFAPostingGroup;
//         Description := FixedAsset.Description;
//         "Description 2" := FixedAsset."Description 2";
//         "Allow Invoice Disc." := FALSE;
//         "Allow Item Charge Assignment" := FALSE;
//         OnAfterAssignFixedAssetValues(Rec,FixedAsset);
//     end;

//     local procedure CopyFromItemCharge()
//     begin
//         ItemCharge.GET("No.");
//         Description := ItemCharge.Description;
//         "Gen. Prod. Posting Group" := ItemCharge."Gen. Prod. Posting Group";
//         "VAT Prod. Posting Group" := ItemCharge."VAT Prod. Posting Group";
//         "Tax Group Code" := ItemCharge."Tax Group Code";
//         "Allow Invoice Disc." := FALSE;
//         "Allow Item Charge Assignment" := FALSE;
//         "Indirect Cost %" := 0;
//         "Overhead Rate" := 0;
//         OnAfterAssignItemChargeValues(Rec,ItemCharge);
//     end;

//     local procedure SelectItemEntry()
//     var
//         ItemLedgEntry: Record "32";
//     begin
//         TESTFIELD("Prod. Order No.",'');
//         ItemLedgEntry.SETCURRENTKEY("Item No.",Open);
//         ItemLedgEntry.SETRANGE("Item No.","No.");
//         ItemLedgEntry.SETRANGE(Open,TRUE);
//         ItemLedgEntry.SETRANGE(Positive,TRUE);
//         IF "Location Code" <> '' THEN
//           ItemLedgEntry.SETRANGE("Location Code","Location Code");
//         ItemLedgEntry.SETRANGE("Variant Code","Variant Code");

//         IF PAGE.RUNMODAL(PAGE::"Item Ledger Entries",ItemLedgEntry) = ACTION::LookupOK THEN
//           VALIDATE("Appl.-to Item Entry",ItemLedgEntry."Entry No.");
//     end;

//     [Scope('Personalization')]
//     procedure SetPurchHeader(NewPurchHeader: Record "38")
//     begin
//         PurchHeader := NewPurchHeader;

//         IF PurchHeader."Currency Code" = '' THEN
//           Currency.InitRoundingPrecision
//         ELSE BEGIN
//           PurchHeader.TESTFIELD("Currency Factor");
//           Currency.GET(PurchHeader."Currency Code");
//           Currency.TESTFIELD("Amount Rounding Precision");
//         END;
//     end;

//     local procedure GetPurchHeader()
//     begin
//         TESTFIELD("Document No.");
//         IF ("Document Type" <> PurchHeader."Document Type") OR ("Document No." <> PurchHeader."No.") THEN BEGIN
//           PurchHeader.GET("Document Type","Document No.");
//           IF PurchHeader."Currency Code" = '' THEN
//             Currency.InitRoundingPrecision
//           ELSE BEGIN
//             PurchHeader.TESTFIELD("Currency Factor");
//             Currency.GET(PurchHeader."Currency Code");
//             Currency.TESTFIELD("Amount Rounding Precision");
//           END;
//         END;

//         OnAfterGetPurchHeader(Rec,PurchHeader);
//     end;

//     local procedure GetItem(var Item: Record "27")
//     begin
//         TESTFIELD("No.");
//         Item.GET("No.");

//         OnAfterGetItem(Item,Rec);
//     end;

//     [Scope('Personalization')]
//     procedure UpdateDirectUnitCost(CalledByFieldNo: Integer)
//     var
//         IsHandled: Boolean;
//     begin
//         /*IsHandled := FALSE;
//         OnBeforeUpdateDirectUnitCost(Rec,xRec,CalledByFieldNo,CurrFieldNo,IsHandled);
//         IF IsHandled THEN
//           EXIT;
        
//         IF (CurrFieldNo <> 0) AND ("Prod. Order No." <> '') THEN
//           UpdateAmounts;
        
//         IF ((CalledByFieldNo <> CurrFieldNo) AND (CurrFieldNo <> 0)) OR
//            ("Prod. Order No." <> '')
//         THEN
//           EXIT;
        
//         IF Type = Type::Item THEN BEGIN
//           GetPurchHeader;
//           IsHandled := FALSE;
//           OnUpdateDirectUnitCostOnBeforeFindPrice(PurchHeader,Rec,CalledByFieldNo,CurrFieldNo,IsHandled);
//           IF NOT IsHandled THEN
//             PurchPriceCalcMgt.FindPurchLinePrice(PurchHeader,Rec,CalledByFieldNo);
//           IF NOT ("Copied From Posted Doc." AND IsCreditDocType) THEN
//             PurchPriceCalcMgt.FindPurchLineLineDisc(PurchHeader,Rec);
//           VALIDATE("Direct Unit Cost");
        
//           IF CalledByFieldNo IN [FIELDNO("No."),FIELDNO("Variant Code"),FIELDNO("Location Code")] THEN
//             UpdateItemReference;
//         END;
        
//         OnAfterUpdateDirectUnitCost(Rec,xRec,CalledByFieldNo,CurrFieldNo);
//         */
//         IsHandled := FALSE;
//         OnBeforeUpdateDirectUnitCost(Rec,xRec,CalledByFieldNo,CurrFieldNo,IsHandled);
//         IF IsHandled THEN
//           EXIT;
        
//         IF (CurrFieldNo <> 0) AND ("Prod. Order No." <> '') THEN
//           UpdateAmounts;
        
//         IF ((CalledByFieldNo <> CurrFieldNo) AND (CurrFieldNo <> 0)) OR
//            ("Prod. Order No." <> '')
//         THEN
//           EXIT;
        
//         //alok for UOM
//         IF (CalledByFieldNo<>5407) THEN BEGIN
//         //(xRec."Unit of Measure Code"='') AND  THEN BEGIN
//         IF Type = Type::Item THEN BEGIN
//           GetPurchHeader;
//           PurchPriceCalcMgt.FindPurchLinePrice(PurchHeader,Rec,CalledByFieldNo);
//           PurchPriceCalcMgt.FindPurchLineLineDisc(PurchHeader,Rec);
//           VALIDATE("Direct Unit Cost");
//         END;
//         //alok finish
//           IF (CalledByFieldNo IN [FIELDNO("No."),FIELDNO("Variant Code"),FIELDNO("Location Code")])
//           AND (Rec.Type = Type::Item) THEN  //robo-upgrade
//             SetVendorItemNo;
//         END;
        
//         IF CalledByFieldNo IN [FIELDNO("No."),FIELDNO("Variant Code"),FIELDNO("Location Code")] THEN
//             UpdateItemReference;

//     end;

//     [Scope('Personalization')]
//     procedure UpdateUnitCost()
//     var
//         Item: Record "27";
//         DiscountAmountPerQty: Decimal;
//     begin
//         GetPurchHeader;
//         GetGLSetup;
//         IF Quantity = 0 THEN
//           DiscountAmountPerQty := 0
//         ELSE
//           DiscountAmountPerQty :=
//             ROUND(("Line Discount Amount" + "Inv. Discount Amount") / Quantity,
//               GLSetup."Unit-Amount Rounding Precision");

//         IF "VAT Calculation Type" = "VAT Calculation Type"::"Full VAT" THEN
//           "Unit Cost" := 0
//         ELSE
//           IF PurchHeader."Prices Including VAT" THEN
//             "Unit Cost" :=
//               ("Direct Unit Cost" - DiscountAmountPerQty) * (1 + "Indirect Cost %" / 100) / (1 + "VAT %" / 100) +
//               GetOverheadRateFCY - "VAT Difference"
//           ELSE
//             "Unit Cost" :=
//               ("Direct Unit Cost" - DiscountAmountPerQty) * (1 + "Indirect Cost %" / 100) +
//               GetOverheadRateFCY;

//         IF PurchHeader."Currency Code" <> '' THEN BEGIN
//           PurchHeader.TESTFIELD("Currency Factor");
//           "Unit Cost (LCY)" :=
//             CurrExchRate.ExchangeAmtFCYToLCY(
//               GetDate,"Currency Code",
//               "Unit Cost",PurchHeader."Currency Factor");
//         END ELSE
//           "Unit Cost (LCY)" := "Unit Cost";

//         IF (Type = Type::Item) AND ("Prod. Order No." = '') THEN BEGIN
//           GetItem(Item);
//           IF Item."Costing Method" = Item."Costing Method"::Standard THEN BEGIN
//             IF GetSKU THEN
//               "Unit Cost (LCY)" := SKU."Unit Cost" * "Qty. per Unit of Measure"
//             ELSE
//               "Unit Cost (LCY)" := Item."Unit Cost" * "Qty. per Unit of Measure";
//           END;
//         END;

//         "Unit Cost (LCY)" := ROUND("Unit Cost (LCY)",GLSetup."Unit-Amount Rounding Precision");
//         IF PurchHeader."Currency Code" <> '' THEN
//           Currency.TESTFIELD("Unit-Amount Rounding Precision");
//         "Unit Cost" := ROUND("Unit Cost",Currency."Unit-Amount Rounding Precision");

//         OnAfterUpdateUnitCost(Rec,xRec,PurchHeader,Item,SKU,Currency,GLSetup);

//         UpdateSalesCost;

//         IF JobTaskIsSet AND NOT UpdateFromVAT AND NOT "Prepayment Line" THEN BEGIN
//           CreateTempJobJnlLine(FALSE);
//           TempJobJnlLine.VALIDATE("Unit Cost (LCY)","Unit Cost (LCY)");
//           UpdateJobPrices;
//         END;
//     end;

//     [Scope('Personalization')]
//     procedure UpdateAmounts()
//     var
//         RemLineAmountToInvoice: Decimal;
//         VATBaseAmount: Decimal;
//         LineAmountChanged: Boolean;
//     begin
//         IF Type = Type::" " THEN
//           EXIT;
//         GetPurchHeader;

//         VATBaseAmount := "VAT Base Amount";
//         "Recalculate Invoice Disc." := TRUE;

//         IF "Line Amount" <> xRec."Line Amount" THEN BEGIN
//           "VAT Difference" := 0;
//           LineAmountChanged := TRUE;
//         END;
//         IF "Line Amount" <> ROUND(Quantity * "Direct Unit Cost",Currency."Amount Rounding Precision") - "Line Discount Amount" THEN BEGIN
//           "Line Amount" :=
//             ROUND(Quantity * "Direct Unit Cost",Currency."Amount Rounding Precision") - "Line Discount Amount";
//           "VAT Difference" := 0;
//           LineAmountChanged := TRUE;
//         END;

//         IF NOT "Prepayment Line" THEN BEGIN
//           IF "Prepayment %" <> 0 THEN BEGIN
//             IF Quantity < 0 THEN
//               FIELDERROR(Quantity,STRSUBSTNO(Text043,FIELDCAPTION("Prepayment %")));
//             IF "Direct Unit Cost" < 0 THEN
//               FIELDERROR("Direct Unit Cost",STRSUBSTNO(Text043,FIELDCAPTION("Prepayment %")));
//           END;
//           IF PurchHeader."Document Type" <> PurchHeader."Document Type"::Invoice THEN BEGIN
//             "Prepayment VAT Difference" := 0;
//             IF NOT PrePaymentLineAmountEntered THEN
//               "Prepmt. Line Amount" := ROUND("Line Amount" * "Prepayment %" / 100,Currency."Amount Rounding Precision");
//             IF "Prepmt. Line Amount" < "Prepmt. Amt. Inv." THEN BEGIN
//               IF IsServiceCharge THEN
//                 ERROR(CannotChangePrepaidServiceChargeErr);
//               FIELDERROR("Prepmt. Line Amount",STRSUBSTNO(Text037,"Prepmt. Amt. Inv."));
//             END;
//             PrePaymentLineAmountEntered := FALSE;
//             IF "Prepmt. Line Amount" <> 0 THEN BEGIN
//               RemLineAmountToInvoice :=
//                 ROUND("Line Amount" * (Quantity - "Quantity Invoiced") / Quantity,Currency."Amount Rounding Precision");
//               IF RemLineAmountToInvoice < ("Prepmt. Line Amount" - "Prepmt Amt Deducted") THEN
//                 FIELDERROR("Prepmt. Line Amount",STRSUBSTNO(Text039,RemLineAmountToInvoice + "Prepmt Amt Deducted"));
//             END;
//           END ELSE
//             IF (CurrFieldNo <> 0) AND ("Line Amount" <> xRec."Line Amount") AND
//                ("Prepmt. Amt. Inv." <> 0) AND ("Prepayment %" = 100)
//             THEN BEGIN
//               IF "Line Amount" < xRec."Line Amount" THEN
//                 FIELDERROR("Line Amount",STRSUBSTNO(Text038,xRec."Line Amount"));
//               FIELDERROR("Line Amount",STRSUBSTNO(Text039,xRec."Line Amount"));
//             END;
//         END;

//         OnAfterUpdateAmounts(Rec,xRec,CurrFieldNo);

//         UpdateVATAmounts;
//         IF VATBaseAmount <> "VAT Base Amount" THEN
//           LineAmountChanged := TRUE;

//         IF LineAmountChanged THEN BEGIN
//           UpdateDeferralAmounts;
//           LineAmountChanged := FALSE;
//         END;

//         InitOutstandingAmount;

//         IF Type = Type::"Charge (Item)" THEN
//           UpdateItemChargeAssgnt;

//         CalcPrepaymentToDeduct;

//         OnAfterUpdateAmountsDone(Rec,xRec,CurrFieldNo);
//     end;

//     [Scope('Personalization')]
//     procedure UpdateVATAmounts()
//     var
//         PurchLine2: Record "39";
//         TotalLineAmount: Decimal;
//         TotalInvDiscAmount: Decimal;
//         TotalAmount: Decimal;
//         TotalAmountInclVAT: Decimal;
//         TotalQuantityBase: Decimal;
//     begin
//         OnBeforeUpdateVATAmounts(Rec);

//         GetPurchHeader;
//         PurchLine2.SETRANGE("Document Type","Document Type");
//         PurchLine2.SETRANGE("Document No.","Document No.");
//         PurchLine2.SETFILTER("Line No.",'<>%1',"Line No.");
//         PurchLine2.SETRANGE("VAT Identifier","VAT Identifier");
//         PurchLine2.SETRANGE("Tax Group Code","Tax Group Code");

//         IF "Line Amount" = "Inv. Discount Amount" THEN BEGIN
//           Amount := 0;
//           "VAT Base Amount" := 0;
//           "Amount Including VAT" := 0;
//           IF (Quantity = 0) AND (xRec.Quantity <> 0) AND (xRec.Amount <> 0) THEN BEGIN
//             IF "Line No." <> 0 THEN
//               MODIFY;
//             PurchLine2.SETFILTER(Amount,'<>0');
//             IF PurchLine2.FIND('<>') THEN BEGIN
//               PurchLine2.ValidateLineDiscountPercent(FALSE);
//               PurchLine2.MODIFY;
//             END;
//           END;
//         END ELSE BEGIN
//           TotalLineAmount := 0;
//           TotalInvDiscAmount := 0;
//           TotalAmount := 0;
//           TotalAmountInclVAT := 0;
//           TotalQuantityBase := 0;
//           IF ("VAT Calculation Type" = "VAT Calculation Type"::"Sales Tax") OR
//              (("VAT Calculation Type" IN
//                ["VAT Calculation Type"::"Normal VAT","VAT Calculation Type"::"Reverse Charge VAT"]) AND ("VAT %" <> 0))
//           THEN
//             IF NOT PurchLine2.ISEMPTY THEN BEGIN
//               PurchLine2.CALCSUMS("Line Amount","Inv. Discount Amount",Amount,"Amount Including VAT","Quantity (Base)");
//               TotalLineAmount := PurchLine2."Line Amount";
//               TotalInvDiscAmount := PurchLine2."Inv. Discount Amount";
//               TotalAmount := PurchLine2.Amount;
//               TotalAmountInclVAT := PurchLine2."Amount Including VAT";
//               TotalQuantityBase := PurchLine2."Quantity (Base)";
//               OnAfterUpdateTotalAmounts(Rec,PurchLine2,TotalAmount,TotalAmountInclVAT,TotalLineAmount,TotalInvDiscAmount);
//             END;

//           IF PurchHeader."Prices Including VAT" THEN
//             CASE "VAT Calculation Type" OF
//               "VAT Calculation Type"::"Normal VAT",
//               "VAT Calculation Type"::"Reverse Charge VAT":
//                 BEGIN
//                   Amount :=
//                     ROUND(
//                       (TotalLineAmount - TotalInvDiscAmount + CalcLineAmount) / (1 + "VAT %" / 100),
//                       Currency."Amount Rounding Precision") -
//                     TotalAmount;
//                   "VAT Base Amount" :=
//                     ROUND(
//                       Amount * (1 - PurchHeader."VAT Base Discount %" / 100),
//                       Currency."Amount Rounding Precision");
//                   "Amount Including VAT" :=
//                     TotalLineAmount + "Line Amount" -
//                     ROUND(
//                       (TotalAmount + Amount) * (PurchHeader."VAT Base Discount %" / 100) * "VAT %" / 100,
//                       Currency."Amount Rounding Precision",Currency.VATRoundingDirection) -
//                     TotalAmountInclVAT - TotalInvDiscAmount - "Inv. Discount Amount";
//                 END;
//               "VAT Calculation Type"::"Full VAT":
//                 BEGIN
//                   Amount := 0;
//                   "VAT Base Amount" := 0;
//                 END;
//               "VAT Calculation Type"::"Sales Tax":
//                 BEGIN
//                   PurchHeader.TESTFIELD("VAT Base Discount %",0);
//                   "Amount Including VAT" :=
//                     ROUND(CalcLineAmount,Currency."Amount Rounding Precision");
//                   IF "Use Tax" THEN
//                     Amount := "Amount Including VAT"
//                   ELSE
//                     Amount :=
//                       ROUND(
//                         SalesTaxCalculate.ReverseCalculateTax(
//                           "Tax Area Code","Tax Group Code","Tax Liable",PurchHeader."Posting Date",
//                           TotalAmountInclVAT + "Amount Including VAT",TotalQuantityBase + "Quantity (Base)",
//                           PurchHeader."Currency Factor"),
//                         Currency."Amount Rounding Precision") -
//                       TotalAmount;
//                   "VAT Base Amount" := Amount;
//                   IF "VAT Base Amount" <> 0 THEN
//                     "VAT %" :=
//                       ROUND(100 * ("Amount Including VAT" - "VAT Base Amount") / "VAT Base Amount",0.00001)
//                   ELSE
//                     "VAT %" := 0;
//                 END;
//             END
//           ELSE
//             CASE "VAT Calculation Type" OF
//               "VAT Calculation Type"::"Normal VAT",
//               "VAT Calculation Type"::"Reverse Charge VAT":
//                 BEGIN
//                   Amount := ROUND(CalcLineAmount,Currency."Amount Rounding Precision");
//                   "VAT Base Amount" :=
//                     ROUND(Amount * (1 - PurchHeader."VAT Base Discount %" / 100),Currency."Amount Rounding Precision");
//                   "Amount Including VAT" :=
//                     TotalAmount + Amount +
//                     ROUND(
//                       (TotalAmount + Amount) * (1 - PurchHeader."VAT Base Discount %" / 100) * "VAT %" / 100,
//                       Currency."Amount Rounding Precision",Currency.VATRoundingDirection) -
//                     TotalAmountInclVAT;
//                 END;
//               "VAT Calculation Type"::"Full VAT":
//                 BEGIN
//                   Amount := 0;
//                   "VAT Base Amount" := 0;
//                   "Amount Including VAT" := CalcLineAmount;
//                 END;
//               "VAT Calculation Type"::"Sales Tax":
//                 BEGIN
//                   Amount := ROUND(CalcLineAmount,Currency."Amount Rounding Precision");
//                   "VAT Base Amount" := Amount;
//                   IF "Use Tax" THEN
//                     "Amount Including VAT" := Amount
//                   ELSE
//                     "Amount Including VAT" :=
//                       TotalAmount + Amount +
//                       ROUND(
//                         SalesTaxCalculate.CalculateTax(
//                           "Tax Area Code","Tax Group Code","Tax Liable",PurchHeader."Posting Date",
//                           TotalAmount + Amount,TotalQuantityBase + "Quantity (Base)",
//                           PurchHeader."Currency Factor"),
//                         Currency."Amount Rounding Precision") -
//                       TotalAmountInclVAT;
//                   IF "VAT Base Amount" <> 0 THEN
//                     "VAT %" :=
//                       ROUND(100 * ("Amount Including VAT" - "VAT Base Amount") / "VAT Base Amount",0.00001)
//                   ELSE
//                     "VAT %" := 0;
//                 END;
//             END;
//         END;

//         OnAfterUpdateVATAmounts(Rec);
//     end;

//     [Scope('Personalization')]
//     procedure UpdatePrepmtSetupFields()
//     var
//         GenPostingSetup: Record "252";
//         GLAcc: Record "15";
//     begin
//         IF ("Prepayment %" <> 0) AND HasTypeToFillMandatoryFields THEN BEGIN
//           TESTFIELD("Document Type","Document Type"::Order);
//           TESTFIELD("No.");
//           GenPostingSetup.GET("Gen. Bus. Posting Group","Gen. Prod. Posting Group");
//           IF GenPostingSetup."Purch. Prepayments Account" <> '' THEN BEGIN
//             GLAcc.GET(GenPostingSetup."Purch. Prepayments Account");
//             VATPostingSetup.GET("VAT Bus. Posting Group",GLAcc."VAT Prod. Posting Group");
//             VATPostingSetup.TESTFIELD("VAT Calculation Type","VAT Calculation Type");
//           END ELSE
//             CLEAR(VATPostingSetup);
//           "Prepayment VAT %" := VATPostingSetup."VAT %";
//           "Prepmt. VAT Calc. Type" := VATPostingSetup."VAT Calculation Type";
//           "Prepayment VAT Identifier" := VATPostingSetup."VAT Identifier";
//           IF "Prepmt. VAT Calc. Type" IN
//              ["Prepmt. VAT Calc. Type"::"Reverse Charge VAT","Prepmt. VAT Calc. Type"::"Sales Tax"]
//           THEN
//             "Prepayment VAT %" := 0;
//           "Prepayment Tax Group Code" := GLAcc."Tax Group Code";
//         END;
//     end;

//     local procedure UpdateSalesCost()
//     var
//         SalesOrderLine: Record "37";
//     begin
//         CASE TRUE OF
//           "Sales Order Line No." <> 0:
//             // Drop Shipment
//             SalesOrderLine.GET(SalesOrderLine."Document Type"::Order,"Sales Order No.","Sales Order Line No.");
//           "Special Order Sales Line No." <> 0:
//             // Special Order
//             BEGIN
//               IF NOT
//                  SalesOrderLine.GET(SalesOrderLine."Document Type"::Order,"Special Order Sales No.","Special Order Sales Line No.")
//               THEN
//                 EXIT;
//             END;
//           ELSE
//             EXIT;
//         END;
//         SalesOrderLine."Unit Cost (LCY)" := "Unit Cost (LCY)" * SalesOrderLine."Qty. per Unit of Measure" / "Qty. per Unit of Measure";
//         SalesOrderLine."Unit Cost" := "Unit Cost" * SalesOrderLine."Qty. per Unit of Measure" / "Qty. per Unit of Measure";
//         SalesOrderLine.VALIDATE("Unit Cost (LCY)");
//         SalesOrderLine.MODIFY;
//     end;

//     local procedure GetFAPostingGroup()
//     var
//         LocalGLAcc: Record "15";
//         FAPostingGr: Record "5606";
//         FADeprBook: Record "5612";
//         FASetup: Record "5603";
//     begin
//         IF (Type <> Type::"Fixed Asset") OR ("No." = '') THEN
//           EXIT;
//         IF "Depreciation Book Code" = '' THEN BEGIN
//           FASetup.GET;
//           "Depreciation Book Code" := FASetup."Default Depr. Book";
//           IF NOT FADeprBook.GET("No.","Depreciation Book Code") THEN
//             "Depreciation Book Code" := '';
//           IF "Depreciation Book Code" = '' THEN
//             EXIT;
//         END;
//         IF "FA Posting Type" = "FA Posting Type"::" " THEN
//           "FA Posting Type" := "FA Posting Type"::"Acquisition Cost";
//         FADeprBook.GET("No.","Depreciation Book Code");
//         FADeprBook.TESTFIELD("FA Posting Group");
//         FAPostingGr.GET(FADeprBook."FA Posting Group");
//         CASE "FA Posting Type" OF
//           "FA Posting Type"::"Acquisition Cost":
//             LocalGLAcc.GET(FAPostingGr.GetAcquisitionCostAccount);
//           "FA Posting Type"::Appreciation:
//             LocalGLAcc.GET(FAPostingGr.GetAppreciationAccount);
//           "FA Posting Type"::Maintenance:
//             LocalGLAcc.GET(FAPostingGr.GetMaintenanceExpenseAccount);
//         END;
//         LocalGLAcc.CheckGLAcc;
//         LocalGLAcc.TESTFIELD("Gen. Prod. Posting Group");
//         "Posting Group" := FADeprBook."FA Posting Group";
//         "Gen. Prod. Posting Group" := LocalGLAcc."Gen. Prod. Posting Group";
//         "Tax Group Code" := LocalGLAcc."Tax Group Code";
//         VALIDATE("VAT Prod. Posting Group",LocalGLAcc."VAT Prod. Posting Group");
//     end;

//     [Scope('Personalization')]
//     procedure UpdateUOMQtyPerStockQty()
//     var
//         Item: Record "27";
//     begin
//         GetItem(Item);
//         //alok for uom
//         IF xRec."Unit of Measure Code"='' THEN BEGIN
//         "Unit Cost (LCY)" := Item."Unit Cost" * "Qty. per Unit of Measure";
//         "Unit Price (LCY)" := Item."Unit Price" * "Qty. per Unit of Measure";
//         END;
//         //alok finish
//         GetPurchHeader;
//         IF PurchHeader."Currency Code" <> '' THEN
//           "Unit Cost" :=
//             CurrExchRate.ExchangeAmtLCYToFCY(
//               GetDate,PurchHeader."Currency Code",
//               "Unit Cost (LCY)",PurchHeader."Currency Factor")
//         ELSE
//           "Unit Cost" := "Unit Cost (LCY)";
//         UpdateDirectUnitCost(FIELDNO("Unit of Measure Code"));
//     end;

//     [Scope('Personalization')]
//     procedure SelectMultipleItems()
//     var
//         ItemListPage: Page "31";
//         SelectionFilter: Text;
//     begin
//         IF IsCreditDocType THEN
//           SelectionFilter := ItemListPage.SelectActiveItems
//         ELSE
//           SelectionFilter := ItemListPage.SelectActiveItemsForPurchase;
//         IF SelectionFilter <> '' THEN
//           AddItems(SelectionFilter);
//     end;

//     local procedure AddItems(SelectionFilter: Text)
//     var
//         Item: Record "27";
//         DummyPurchLine: Record "39";
//         PurchLine: Record "39";
//         LastPurchLine: Record "39";
//         TransferExtendedText: Codeunit "378";
//     begin
//         InitNewLine(PurchLine);
//         Item.SETFILTER("No.",SelectionFilter);
//         IF Item.FINDSET THEN
//           REPEAT
//             PurchLine.INIT;
//             PurchLine."Line No." += 10000;
//             PurchLine.VALIDATE(Type,Type::Item);
//             PurchLine.VALIDATE("No.",Item."No.");
//             PurchLine.INSERT(TRUE);
//             IF TransferExtendedText.PurchCheckIfAnyExtText(PurchLine,FALSE) THEN BEGIN
//               TransferExtendedText.InsertPurchExtTextRetLast(PurchLine,DummyPurchLine);
//               PurchLine."Line No." := LastPurchLine."Line No."
//             END;
//           UNTIL Item.NEXT = 0;
//     end;

//     local procedure InitNewLine(var NewPurchLine: Record "39")
//     var
//         PurchLine: Record "39";
//     begin
//         NewPurchLine.COPY(Rec);
//         PurchLine.SETRANGE("Document Type",NewPurchLine."Document Type");
//         PurchLine.SETRANGE("Document No.",NewPurchLine."Document No.");
//         IF PurchLine.FINDLAST THEN
//           NewPurchLine."Line No." := PurchLine."Line No."
//         ELSE
//           NewPurchLine."Line No." := 0;
//     end;

//     [Scope('Personalization')]
//     procedure ShowReservation()
//     var
//         Reservation: Page "498";
//     begin
//         TESTFIELD(Type,Type::Item);
//         TESTFIELD("Prod. Order No.",'');
//         TESTFIELD("No.");
//         CLEAR(Reservation);
//         Reservation.SetPurchLine(Rec);
//         Reservation.RUNMODAL;
//     end;

//     [Scope('Personalization')]
//     procedure ShowReservationEntries(Modal: Boolean)
//     var
//         ReservEntry: Record "337";
//     begin
//         TESTFIELD(Type,Type::Item);
//         TESTFIELD("No.");
//         ReservEngineMgt.InitFilterAndSortingLookupFor(ReservEntry,TRUE);
//         ReservePurchLine.FilterReservFor(ReservEntry,Rec);
//         IF Modal THEN
//           PAGE.RUNMODAL(PAGE::"Reservation Entries",ReservEntry)
//         ELSE
//           PAGE.RUN(PAGE::"Reservation Entries",ReservEntry);
//     end;

//     [Scope('Personalization')]
//     procedure GetDate(): Date
//     begin
//         IF PurchHeader."Posting Date" <> 0D THEN
//           EXIT(PurchHeader."Posting Date");
//         EXIT(WORKDATE);
//     end;

//     [Scope('Personalization')]
//     procedure Signed(Value: Decimal): Decimal
//     begin
//         CASE "Document Type" OF
//           "Document Type"::Quote,
//           "Document Type"::Order,
//           "Document Type"::Invoice,
//           "Document Type"::"Blanket Order":
//             EXIT(Value);
//           "Document Type"::"Return Order",
//           "Document Type"::"Credit Memo":
//             EXIT(-Value);
//         END;
//     end;

//     [Scope('Personalization')]
//     procedure BlanketOrderLookup()
//     var
//         IsHandled: Boolean;
//     begin
//         IsHandled := FALSE;
//         OnBeforeBlanketOrderLookup(Rec,CurrFieldNo,IsHandled);
//         IF IsHandled THEN
//           EXIT;

//         PurchLine2.RESET;
//         PurchLine2.SETCURRENTKEY("Document Type",Type,"No.");
//         PurchLine2.SETRANGE("Document Type","Document Type"::"Blanket Order");
//         PurchLine2.SETRANGE(Type,Type);
//         PurchLine2.SETRANGE("No.","No.");
//         PurchLine2.SETRANGE("Pay-to Vendor No.","Pay-to Vendor No.");
//         PurchLine2.SETRANGE("Buy-from Vendor No.","Buy-from Vendor No.");
//         IF PAGE.RUNMODAL(PAGE::"Purchase Lines",PurchLine2) = ACTION::LookupOK THEN BEGIN
//           PurchLine2.TESTFIELD("Document Type","Document Type"::"Blanket Order");
//           "Blanket Order No." := PurchLine2."Document No.";
//           VALIDATE("Blanket Order Line No.",PurchLine2."Line No.");
//         END;
//     end;

//     [Scope('Personalization')]
//     procedure BlockDynamicTracking(SetBlock: Boolean)
//     begin
//         TrackingBlocked := SetBlock;
//         ReservePurchLine.Block(SetBlock);
//     end;

//     [Scope('Personalization')]
//     procedure ShowDimensions()
//     begin
//         "Dimension Set ID" :=
//           DimMgt.EditDimensionSet("Dimension Set ID",STRSUBSTNO('%1 %2 %3',"Document Type","Document No.","Line No."));
//         VerifyItemLineDim;
//         DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID","Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");
//     end;

//     [Scope('Personalization')]
//     procedure OpenItemTrackingLines()
//     var
//         IsHandled: Boolean;
//     begin
//         IsHandled := FALSE;
//         OnBeforeOpenItemTrackingLines(Rec,IsHandled);
//         IF IsHandled THEN
//           EXIT;

//         TESTFIELD(Type,Type::Item);
//         TESTFIELD("No.");
//         IF "Prod. Order No." <> '' THEN
//           ERROR(Text031,"Prod. Order No.");

//         TESTFIELD("Quantity (Base)");

//         ReservePurchLine.CallItemTracking(Rec);
//     end;

//     [Scope('Personalization')]
//     procedure CreateDim(Type1: Integer;No1: Code[20];Type2: Integer;No2: Code[20];Type3: Integer;No3: Code[20];Type4: Integer;No4: Code[20])
//     var
//         SourceCodeSetup: Record "242";
//         TableID: array [10] of Integer;
//         No: array [10] of Code[20];
//     begin
//         SourceCodeSetup.GET;
//         TableID[1] := Type1;
//         No[1] := No1;
//         TableID[2] := Type2;
//         No[2] := No2;
//         TableID[3] := Type3;
//         No[3] := No3;
//         TableID[4] := Type4;
//         No[4] := No4;
//         OnAfterCreateDimTableIDs(Rec,CurrFieldNo,TableID,No);

//         "Shortcut Dimension 1 Code" := '';
//         "Shortcut Dimension 2 Code" := '';
//         GetPurchHeader;
//         "Dimension Set ID" :=
//           DimMgt.GetRecDefaultDimID(
//             Rec,CurrFieldNo,TableID,No,SourceCodeSetup.Purchases,
//             "Shortcut Dimension 1 Code","Shortcut Dimension 2 Code",PurchHeader."Dimension Set ID",DATABASE::Vendor);
//         DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID","Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");
//     end;

//     [Scope('Personalization')]
//     procedure ValidateShortcutDimCode(FieldNumber: Integer;var ShortcutDimCode: Code[20])
//     begin
//         DimMgt.ValidateShortcutDimValues(FieldNumber,ShortcutDimCode,"Dimension Set ID");
//         VerifyItemLineDim;
//     end;

//     [Scope('Personalization')]
//     procedure LookupShortcutDimCode(FieldNumber: Integer;var ShortcutDimCode: Code[20])
//     begin
//         DimMgt.LookupDimValueCode(FieldNumber,ShortcutDimCode);
//         ValidateShortcutDimCode(FieldNumber,ShortcutDimCode);
//     end;

//     [Scope('Personalization')]
//     procedure ShowShortcutDimCode(var ShortcutDimCode: array [8] of Code[20])
//     begin
//         DimMgt.GetShortcutDimensions("Dimension Set ID",ShortcutDimCode);
//     end;

//     local procedure GetSKU(): Boolean
//     begin
//         TESTFIELD("No.");
//         IF (SKU."Location Code" = "Location Code") AND
//            (SKU."Item No." = "No.") AND
//            (SKU."Variant Code" = "Variant Code")
//         THEN
//           EXIT(TRUE);
//         IF SKU.GET("Location Code","No.","Variant Code") THEN
//           EXIT(TRUE);

//         EXIT(FALSE);
//     end;

//     [Scope('Personalization')]
//     procedure ShowItemChargeAssgnt()
//     var
//         ItemChargeAssgntPurch: Record "5805";
//         AssignItemChargePurch: Codeunit "5805";
//         ItemChargeAssgnts: Page "5805";
//         ItemChargeAssgntLineAmt: Decimal;
//     begin
//         GET("Document Type","Document No.","Line No.");
//         TESTFIELD("No.");
//         TESTFIELD(Quantity);

//         IF Type <> Type::"Charge (Item)" THEN
//           ERROR(ItemChargeAssignmentErr);

//         GetPurchHeader;
//         IF PurchHeader."Currency Code" = '' THEN
//           Currency.InitRoundingPrecision
//         ELSE
//           Currency.GET(PurchHeader."Currency Code");
//         IF ("Inv. Discount Amount" = 0) AND
//            ("Line Discount Amount" = 0) AND
//            (NOT PurchHeader."Prices Including VAT")
//         THEN
//           ItemChargeAssgntLineAmt := "Line Amount"
//         ELSE
//           IF PurchHeader."Prices Including VAT" THEN
//             ItemChargeAssgntLineAmt :=
//               ROUND(CalcLineAmount / (1 + "VAT %" / 100),Currency."Amount Rounding Precision")
//           ELSE
//             ItemChargeAssgntLineAmt := CalcLineAmount;

//         ItemChargeAssgntPurch.RESET;
//         ItemChargeAssgntPurch.SETRANGE("Document Type","Document Type");
//         ItemChargeAssgntPurch.SETRANGE("Document No.","Document No.");
//         ItemChargeAssgntPurch.SETRANGE("Document Line No.","Line No.");
//         ItemChargeAssgntPurch.SETRANGE("Item Charge No.","No.");
//         IF NOT ItemChargeAssgntPurch.FINDLAST THEN BEGIN
//           ItemChargeAssgntPurch."Document Type" := "Document Type";
//           ItemChargeAssgntPurch."Document No." := "Document No.";
//           ItemChargeAssgntPurch."Document Line No." := "Line No.";
//           ItemChargeAssgntPurch."Item Charge No." := "No.";
//           ItemChargeAssgntPurch."Unit Cost" :=
//             ROUND(ItemChargeAssgntLineAmt / Quantity,
//               Currency."Unit-Amount Rounding Precision");
//         END;

//         ItemChargeAssgntLineAmt :=
//           ROUND(
//             ItemChargeAssgntLineAmt * ("Qty. to Invoice" / Quantity),
//             Currency."Amount Rounding Precision");

//         IF IsCreditDocType THEN
//           AssignItemChargePurch.CreateDocChargeAssgnt(ItemChargeAssgntPurch,"Return Shipment No.")
//         ELSE
//           AssignItemChargePurch.CreateDocChargeAssgnt(ItemChargeAssgntPurch,"Receipt No.");
//         CLEAR(AssignItemChargePurch);
//         COMMIT;

//         ItemChargeAssgnts.Initialize(Rec,ItemChargeAssgntLineAmt);
//         ItemChargeAssgnts.RUNMODAL;

//         CALCFIELDS("Qty. to Assign");
//     end;

//     [Scope('Personalization')]
//     procedure UpdateItemChargeAssgnt()
//     var
//         ItemChargeAssgntPurch: Record "5805";
//         ShareOfVAT: Decimal;
//         TotalQtyToAssign: Decimal;
//         TotalAmtToAssign: Decimal;
//     begin
//         IF "Document Type" = "Document Type"::"Blanket Order" THEN
//           EXIT;

//         CALCFIELDS("Qty. Assigned","Qty. to Assign");
//         IF ABS("Quantity Invoiced") > ABS(("Qty. Assigned" + "Qty. to Assign")) THEN
//           ERROR(Text032,FIELDCAPTION("Quantity Invoiced"),FIELDCAPTION("Qty. Assigned"),FIELDCAPTION("Qty. to Assign"));

//         ItemChargeAssgntPurch.SETRANGE("Document Type","Document Type");
//         ItemChargeAssgntPurch.SETRANGE("Document No.","Document No.");
//         ItemChargeAssgntPurch.SETRANGE("Document Line No.","Line No.");
//         ItemChargeAssgntPurch.CALCSUMS("Qty. to Assign");
//         TotalQtyToAssign := ItemChargeAssgntPurch."Qty. to Assign";
//         IF (CurrFieldNo <> 0) AND ("Unit Cost" <> xRec."Unit Cost") THEN BEGIN
//           ItemChargeAssgntPurch.SETFILTER("Qty. Assigned",'<>0');
//           IF NOT ItemChargeAssgntPurch.ISEMPTY THEN
//             ERROR(Text022,
//               FIELDCAPTION("Unit Cost"));
//           ItemChargeAssgntPurch.SETRANGE("Qty. Assigned");
//         END;

//         IF (CurrFieldNo <> 0) AND (Quantity <> xRec.Quantity) THEN BEGIN
//           ItemChargeAssgntPurch.SETFILTER("Qty. Assigned",'<>0');
//           IF NOT ItemChargeAssgntPurch.ISEMPTY THEN
//             ERROR(Text022,
//               FIELDCAPTION(Quantity));
//           ItemChargeAssgntPurch.SETRANGE("Qty. Assigned");
//         END;

//         IF ItemChargeAssgntPurch.FINDSET(TRUE) AND (Quantity <> 0) THEN BEGIN
//           GetPurchHeader;
//           TotalAmtToAssign := CalcTotalAmtToAssign(TotalQtyToAssign);
//           REPEAT
//             ShareOfVAT := 1;
//             IF PurchHeader."Prices Including VAT" THEN
//               ShareOfVAT := 1 + "VAT %" / 100;
//             IF ItemChargeAssgntPurch."Unit Cost" <>
//                ROUND(CalcLineAmount / Quantity / ShareOfVAT,Currency."Unit-Amount Rounding Precision")
//             THEN
//               ItemChargeAssgntPurch."Unit Cost" :=
//                 ROUND(CalcLineAmount / Quantity / ShareOfVAT,Currency."Unit-Amount Rounding Precision");
//             IF TotalQtyToAssign <> 0 THEN BEGIN
//               ItemChargeAssgntPurch."Amount to Assign" :=
//                 ROUND(ItemChargeAssgntPurch."Qty. to Assign" / TotalQtyToAssign * TotalAmtToAssign,
//                   Currency."Amount Rounding Precision");
//               TotalQtyToAssign -= ItemChargeAssgntPurch."Qty. to Assign";
//               TotalAmtToAssign -= ItemChargeAssgntPurch."Amount to Assign";
//             END;
//             ItemChargeAssgntPurch.MODIFY;
//           UNTIL ItemChargeAssgntPurch.NEXT = 0;
//           CALCFIELDS("Qty. to Assign");
//         END;
//     end;

//     local procedure DeleteItemChargeAssgnt(DocType: Option;DocNo: Code[20];DocLineNo: Integer)
//     var
//         ItemChargeAssgntPurch: Record "5805";
//     begin
//         ItemChargeAssgntPurch.SETRANGE("Applies-to Doc. Type",DocType);
//         ItemChargeAssgntPurch.SETRANGE("Applies-to Doc. No.",DocNo);
//         ItemChargeAssgntPurch.SETRANGE("Applies-to Doc. Line No.",DocLineNo);
//         IF NOT ItemChargeAssgntPurch.ISEMPTY THEN
//           ItemChargeAssgntPurch.DELETEALL(TRUE);
//     end;

//     local procedure DeleteChargeChargeAssgnt(DocType: Option;DocNo: Code[20];DocLineNo: Integer)
//     var
//         ItemChargeAssgntPurch: Record "5805";
//     begin
//         IF DocType <> "Document Type"::"Blanket Order" THEN
//           IF "Quantity Invoiced" <> 0 THEN BEGIN
//             CALCFIELDS("Qty. Assigned");
//             TESTFIELD("Qty. Assigned","Quantity Invoiced");
//           END;

//         ItemChargeAssgntPurch.RESET;
//         ItemChargeAssgntPurch.SETRANGE("Document Type",DocType);
//         ItemChargeAssgntPurch.SETRANGE("Document No.",DocNo);
//         ItemChargeAssgntPurch.SETRANGE("Document Line No.",DocLineNo);
//         IF NOT ItemChargeAssgntPurch.ISEMPTY THEN
//           ItemChargeAssgntPurch.DELETEALL;
//     end;

//     [Scope('Personalization')]
//     procedure CheckItemChargeAssgnt()
//     var
//         ItemChargeAssgntPurch: Record "5805";
//     begin
//         ItemChargeAssgntPurch.SETRANGE("Applies-to Doc. Type","Document Type");
//         ItemChargeAssgntPurch.SETRANGE("Applies-to Doc. No.","Document No.");
//         ItemChargeAssgntPurch.SETRANGE("Applies-to Doc. Line No.","Line No.");
//         ItemChargeAssgntPurch.SETRANGE("Document Type","Document Type");
//         ItemChargeAssgntPurch.SETRANGE("Document No.","Document No.");
//         IF ItemChargeAssgntPurch.FINDSET THEN BEGIN
//           TESTFIELD("Allow Item Charge Assignment");
//           REPEAT
//             ItemChargeAssgntPurch.TESTFIELD("Qty. to Assign",0);
//           UNTIL ItemChargeAssgntPurch.NEXT = 0;
//         END;
//     end;

//     [Scope('Personalization')]
//     procedure GetCaptionClass(FieldNumber: Integer): Text[80]
//     var
//         CaptionManagement: Codeunit "42";
//     begin
//         EXIT(CaptionManagement.GetPurchaseLineCaptionClass(Rec,FieldNumber));
//     end;

//     [Scope('Personalization')]
//     procedure TestStatusOpen()
//     begin
//         OnBeforeTestStatusOpen(Rec,PurchHeader);

//         IF StatusCheckSuspended THEN
//           EXIT;
//         GetPurchHeader;
//         IF NOT "System-Created Entry" THEN
//           IF HasTypeToFillMandatoryFields THEN
//             PurchHeader.TESTFIELD(Status,PurchHeader.Status::Open);

//         OnAfterTestStatusOpen(Rec,PurchHeader);
//     end;

//     [Scope('Personalization')]
//     procedure SuspendStatusCheck(Suspend: Boolean)
//     begin
//         StatusCheckSuspended := Suspend;
//     end;

//     [Scope('Personalization')]
//     procedure UpdateLeadTimeFields()
//     begin
//         IF Type = Type::Item THEN BEGIN
//           GetPurchHeader;

//           EVALUATE("Lead Time Calculation",
//             LeadTimeMgt.PurchaseLeadTime(
//               "No.","Location Code","Variant Code",
//               "Buy-from Vendor No."));
//           IF FORMAT("Lead Time Calculation") = '' THEN
//             "Lead Time Calculation" := PurchHeader."Lead Time Calculation";
//           EVALUATE("Safety Lead Time",LeadTimeMgt.SafetyLeadTime("No.","Location Code","Variant Code"));
//         END;
//     end;

//     [Scope('Personalization')]
//     procedure GetUpdateBasicDates()
//     begin
//         GetPurchHeader;
//         IF PurchHeader."Expected Receipt Date" <> 0D THEN
//           VALIDATE("Expected Receipt Date",PurchHeader."Expected Receipt Date")
//         ELSE
//           VALIDATE("Order Date",PurchHeader."Order Date");
//     end;

//     [Scope('Personalization')]
//     procedure UpdateDates()
//     begin
//         IF "Promised Receipt Date" <> 0D THEN
//           VALIDATE("Promised Receipt Date")
//         ELSE
//           IF "Requested Receipt Date" <> 0D THEN
//             VALIDATE("Requested Receipt Date")
//           ELSE
//             GetUpdateBasicDates;
//     end;

//     [Scope('Personalization')]
//     procedure InternalLeadTimeDays(PurchDate: Date): Text[30]
//     var
//         TotalDays: DateFormula;
//     begin
//         EVALUATE(
//           TotalDays,'<' + FORMAT(CALCDATE("Safety Lead Time",CALCDATE("Inbound Whse. Handling Time",PurchDate)) - PurchDate) + 'D>');
//         EXIT(FORMAT(TotalDays));
//     end;

//     local procedure ReversedInternalLeadTimeDays(PurchDate: Date): Text[30]
//     var
//         TotalDays: DateFormula;
//         ReversedSafetyLeadTime: DateFormula;
//         ReversedWhseHandlingTime: DateFormula;
//     begin
//         CalendarMgmt.ReverseDateFormula(ReversedSafetyLeadTime,"Safety Lead Time");
//         CalendarMgmt.ReverseDateFormula(ReversedWhseHandlingTime,"Inbound Whse. Handling Time");
//         EVALUATE(
//           TotalDays,'<' + FORMAT(PurchDate - CALCDATE(ReversedWhseHandlingTime,CALCDATE(ReversedSafetyLeadTime,PurchDate))) + 'D>');
//         EXIT(FORMAT(TotalDays));
//     end;

//     [Scope('Personalization')]
//     procedure UpdateVATOnLines(QtyType: Option General,Invoicing,Shipping;var PurchHeader: Record "38";var PurchLine: Record "39";var VATAmountLine: Record "290") LineWasModified: Boolean
//     var
//         TempVATAmountLineRemainder: Record "290" temporary;
//         Currency: Record "4";
//         NewAmount: Decimal;
//         NewAmountIncludingVAT: Decimal;
//         NewVATBaseAmount: Decimal;
//         VATAmount: Decimal;
//         VATDifference: Decimal;
//         InvDiscAmount: Decimal;
//         LineAmountToInvoice: Decimal;
//         LineAmountToInvoiceDiscounted: Decimal;
//         DeferralAmount: Decimal;
//     begin
//         LineWasModified := FALSE;
//         IF QtyType = QtyType::Shipping THEN
//           EXIT;
//         IF PurchHeader."Currency Code" = '' THEN
//           Currency.InitRoundingPrecision
//         ELSE
//           Currency.GET(PurchHeader."Currency Code");

//         TempVATAmountLineRemainder.DELETEALL;

//         WITH PurchLine DO BEGIN
//           SETRANGE("Document Type",PurchHeader."Document Type");
//           SETRANGE("Document No.",PurchHeader."No.");
//           LOCKTABLE;
//           IF FINDSET THEN
//             REPEAT
//               IF NOT ZeroAmountLine(QtyType) THEN BEGIN
//                 DeferralAmount := GetDeferralAmount;
//                 VATAmountLine.GET("VAT Identifier","VAT Calculation Type","Tax Group Code","Use Tax","Line Amount" >= 0);
//                 IF VATAmountLine.Modified THEN BEGIN
//                   IF NOT TempVATAmountLineRemainder.GET(
//                        "VAT Identifier","VAT Calculation Type","Tax Group Code","Use Tax","Line Amount" >= 0)
//                   THEN BEGIN
//                     TempVATAmountLineRemainder := VATAmountLine;
//                     TempVATAmountLineRemainder.INIT;
//                     TempVATAmountLineRemainder.INSERT;
//                   END;

//                   IF QtyType = QtyType::General THEN
//                     LineAmountToInvoice := "Line Amount"
//                   ELSE
//                     LineAmountToInvoice :=
//                       ROUND("Line Amount" * "Qty. to Invoice" / Quantity,Currency."Amount Rounding Precision");

//                   IF "Allow Invoice Disc." THEN BEGIN
//                     IF (VATAmountLine."Inv. Disc. Base Amount" = 0) OR (LineAmountToInvoice = 0) THEN
//                       InvDiscAmount := 0
//                     ELSE BEGIN
//                       IF QtyType = QtyType::General THEN
//                         LineAmountToInvoice := "Line Amount"
//                       ELSE
//                         LineAmountToInvoice :=
//                           ROUND("Line Amount" * "Qty. to Invoice" / Quantity,Currency."Amount Rounding Precision");
//                       LineAmountToInvoiceDiscounted :=
//                         VATAmountLine."Invoice Discount Amount" * LineAmountToInvoice /
//                         VATAmountLine."Inv. Disc. Base Amount";
//                       TempVATAmountLineRemainder."Invoice Discount Amount" :=
//                         TempVATAmountLineRemainder."Invoice Discount Amount" + LineAmountToInvoiceDiscounted;
//                       InvDiscAmount :=
//                         ROUND(
//                           TempVATAmountLineRemainder."Invoice Discount Amount",Currency."Amount Rounding Precision");
//                       TempVATAmountLineRemainder."Invoice Discount Amount" :=
//                         TempVATAmountLineRemainder."Invoice Discount Amount" - InvDiscAmount;
//                     END;
//                     IF QtyType = QtyType::General THEN BEGIN
//                       "Inv. Discount Amount" := InvDiscAmount;
//                       CalcInvDiscToInvoice;
//                     END ELSE
//                       "Inv. Disc. Amount to Invoice" := InvDiscAmount;
//                   END ELSE
//                     InvDiscAmount := 0;
//                   IF QtyType = QtyType::General THEN
//                     IF PurchHeader."Prices Including VAT" THEN BEGIN
//                       IF (VATAmountLine.CalcLineAmount = 0) OR ("Line Amount" = 0) THEN BEGIN
//                         VATAmount := 0;
//                         NewAmountIncludingVAT := 0;
//                       END ELSE BEGIN
//                         VATAmount :=
//                           TempVATAmountLineRemainder."VAT Amount" +
//                           VATAmountLine."VAT Amount" * CalcLineAmount / VATAmountLine.CalcLineAmount;
//                         NewAmountIncludingVAT :=
//                           TempVATAmountLineRemainder."Amount Including VAT" +
//                           VATAmountLine."Amount Including VAT" * CalcLineAmount / VATAmountLine.CalcLineAmount;
//                       END;
//                       NewAmount :=
//                         ROUND(NewAmountIncludingVAT,Currency."Amount Rounding Precision") -
//                         ROUND(VATAmount,Currency."Amount Rounding Precision");
//                       NewVATBaseAmount :=
//                         ROUND(
//                           NewAmount * (1 - PurchHeader."VAT Base Discount %" / 100),
//                           Currency."Amount Rounding Precision");
//                     END ELSE BEGIN
//                       IF "VAT Calculation Type" = "VAT Calculation Type"::"Full VAT" THEN BEGIN
//                         VATAmount := CalcLineAmount;
//                         NewAmount := 0;
//                         NewVATBaseAmount := 0;
//                       END ELSE BEGIN
//                         NewAmount := CalcLineAmount;
//                         NewVATBaseAmount :=
//                           ROUND(
//                             NewAmount * (1 - PurchHeader."VAT Base Discount %" / 100),
//                             Currency."Amount Rounding Precision");
//                         IF VATAmountLine."VAT Base" = 0 THEN
//                           VATAmount := 0
//                         ELSE
//                           VATAmount :=
//                             TempVATAmountLineRemainder."VAT Amount" +
//                             VATAmountLine."VAT Amount" * NewAmount / VATAmountLine."VAT Base";
//                       END;
//                       NewAmountIncludingVAT := NewAmount + ROUND(VATAmount,Currency."Amount Rounding Precision");
//                     END
//                   ELSE BEGIN
//                     IF VATAmountLine.CalcLineAmount = 0 THEN
//                       VATDifference := 0
//                     ELSE
//                       VATDifference :=
//                         TempVATAmountLineRemainder."VAT Difference" +
//                         VATAmountLine."VAT Difference" * (LineAmountToInvoice - InvDiscAmount) / VATAmountLine.CalcLineAmount;
//                     IF LineAmountToInvoice = 0 THEN
//                       "VAT Difference" := 0
//                     ELSE
//                       "VAT Difference" := ROUND(VATDifference,Currency."Amount Rounding Precision");
//                   END;

//                   IF QtyType = QtyType::General THEN
//                     UpdateBaseAmounts(NewAmount,ROUND(NewAmountIncludingVAT,Currency."Amount Rounding Precision"),NewVATBaseAmount);
//                   InitOutstanding;
//                   IF NOT ((Type = Type::"Charge (Item)") AND ("Quantity Invoiced" <> "Qty. Assigned")) THEN BEGIN
//                     SetUpdateFromVAT(TRUE);
//                     UpdateUnitCost;
//                   END;
//                   IF Type = Type::"Charge (Item)" THEN
//                     UpdateItemChargeAssgnt;
//                   MODIFY;
//                   LineWasModified := TRUE;

//                   IF ("Deferral Code" <> '') AND (DeferralAmount <> GetDeferralAmount) THEN
//                     UpdateDeferralAmounts;

//                   TempVATAmountLineRemainder."Amount Including VAT" :=
//                     NewAmountIncludingVAT - ROUND(NewAmountIncludingVAT,Currency."Amount Rounding Precision");
//                   TempVATAmountLineRemainder."VAT Amount" := VATAmount - NewAmountIncludingVAT + NewAmount;
//                   TempVATAmountLineRemainder."VAT Difference" := VATDifference - "VAT Difference";
//                   TempVATAmountLineRemainder.MODIFY;
//                 END;
//               END;
//             UNTIL NEXT = 0;
//         END;

//         OnAfterUpdateVATOnLines(PurchHeader,PurchLine,VATAmountLine,QtyType);
//     end;

//     [Scope('Personalization')]
//     procedure CalcVATAmountLines(QtyType: Option General,Invoicing,Shipping;var PurchHeader: Record "38";var PurchLine: Record "39";var VATAmountLine: Record "290")
//     var
//         TotalVATAmount: Decimal;
//         QtyToHandle: Decimal;
//         AmtToHandle: Decimal;
//         RoundingLineInserted: Boolean;
//     begin
//         IF IsCalcVATAmountLinesHandled(PurchHeader,PurchLine,VATAmountLine) THEN
//           EXIT;

//         Currency.Initialize(PurchHeader."Currency Code");

//         VATAmountLine.DELETEALL;

//         WITH PurchLine DO BEGIN
//           SETRANGE("Document Type",PurchHeader."Document Type");
//           SETRANGE("Document No.",PurchHeader."No.");
//           IF FINDSET THEN
//             REPEAT
//               IF NOT ZeroAmountLine(QtyType) THEN BEGIN
//                 IF (Type = Type::"G/L Account") AND NOT "Prepayment Line" THEN
//                   RoundingLineInserted := ("No." = GetVPGInvRoundAcc(PurchHeader)) OR RoundingLineInserted;
//                 IF "VAT Calculation Type" IN
//                    ["VAT Calculation Type"::"Reverse Charge VAT","VAT Calculation Type"::"Sales Tax"]
//                 THEN
//                   "VAT %" := 0;
//                 IF NOT VATAmountLine.GET(
//                      "VAT Identifier","VAT Calculation Type","Tax Group Code","Use Tax","Line Amount" >= 0)
//                 THEN
//                   VATAmountLine.InsertNewLine(
//                     "VAT Identifier","VAT Calculation Type","Tax Group Code","Use Tax","VAT %","Line Amount" >= 0,FALSE);

//                 CASE QtyType OF
//                   QtyType::General:
//                     BEGIN
//                       VATAmountLine.Quantity += "Quantity (Base)";
//                       VATAmountLine.SumLine(
//                         "Line Amount","Inv. Discount Amount","VAT Difference","Allow Invoice Disc.","Prepayment Line");
//                     END;
//                   QtyType::Invoicing:
//                     BEGIN
//                       CASE TRUE OF
//                         ("Document Type" IN ["Document Type"::Order,"Document Type"::Invoice]) AND
//                         (NOT PurchHeader.Receive) AND PurchHeader.Invoice AND (NOT "Prepayment Line"):
//                           IF "Receipt No." = '' THEN BEGIN
//                             QtyToHandle := GetAbsMin("Qty. to Invoice","Qty. Rcd. Not Invoiced");
//                             VATAmountLine.Quantity += GetAbsMin("Qty. to Invoice (Base)","Qty. Rcd. Not Invoiced (Base)");
//                           END ELSE BEGIN
//                             QtyToHandle := "Qty. to Invoice";
//                             VATAmountLine.Quantity += "Qty. to Invoice (Base)";
//                           END;
//                         IsCreditDocType AND (NOT PurchHeader.Ship) AND PurchHeader.Invoice:
//                           IF "Return Shipment No." = '' THEN BEGIN
//                             QtyToHandle := GetAbsMin("Qty. to Invoice","Return Qty. Shipped Not Invd.");
//                             VATAmountLine.Quantity += GetAbsMin("Qty. to Invoice (Base)","Ret. Qty. Shpd Not Invd.(Base)");
//                           END ELSE BEGIN
//                             QtyToHandle := "Qty. to Invoice";
//                             VATAmountLine.Quantity += "Qty. to Invoice (Base)";
//                           END;
//                         ELSE BEGIN
//                           QtyToHandle := "Qty. to Invoice";
//                           VATAmountLine.Quantity += "Qty. to Invoice (Base)";
//                         END;
//                       END;
//                       AmtToHandle := GetLineAmountToHandle(QtyToHandle);
//                       IF PurchHeader."Invoice Discount Calculation" <> PurchHeader."Invoice Discount Calculation"::Amount THEN
//                         VATAmountLine.SumLine(
//                           AmtToHandle,ROUND("Inv. Discount Amount" * QtyToHandle / Quantity,Currency."Amount Rounding Precision"),
//                           "VAT Difference","Allow Invoice Disc.","Prepayment Line")
//                       ELSE
//                         VATAmountLine.SumLine(
//                           AmtToHandle,"Inv. Disc. Amount to Invoice","VAT Difference","Allow Invoice Disc.","Prepayment Line");
//                     END;
//                   QtyType::Shipping:
//                     BEGIN
//                       IF "Document Type" IN
//                          ["Document Type"::"Return Order","Document Type"::"Credit Memo"]
//                       THEN BEGIN
//                         QtyToHandle := "Return Qty. to Ship";
//                         VATAmountLine.Quantity += "Return Qty. to Ship (Base)";
//                       END ELSE BEGIN
//                         QtyToHandle := "Qty. to Receive";
//                         VATAmountLine.Quantity += "Qty. to Receive (Base)";
//                       END;
//                       AmtToHandle := GetLineAmountToHandle(QtyToHandle);
//                       VATAmountLine.SumLine(
//                         AmtToHandle,ROUND("Inv. Discount Amount" * QtyToHandle / Quantity,Currency."Amount Rounding Precision"),
//                         "VAT Difference","Allow Invoice Disc.","Prepayment Line");
//                     END;
//                 END;
//                 TotalVATAmount += "Amount Including VAT" - Amount;
//               END;
//             UNTIL NEXT = 0;
//         END;

//         VATAmountLine.UpdateLines(
//           TotalVATAmount,Currency,PurchHeader."Currency Factor",PurchHeader."Prices Including VAT",
//           PurchHeader."VAT Base Discount %",PurchHeader."Tax Area Code",PurchHeader."Tax Liable",PurchHeader."Posting Date");

//         IF RoundingLineInserted AND (TotalVATAmount <> 0) THEN
//           IF GetVATAmountLineOfMaxAmt(VATAmountLine,PurchLine) THEN BEGIN
//             VATAmountLine."VAT Amount" += TotalVATAmount;
//             VATAmountLine."Amount Including VAT" += TotalVATAmount;
//             VATAmountLine."Calculated VAT Amount" += TotalVATAmount;
//             VATAmountLine.MODIFY;
//           END;

//         OnAfterCalcVATAmountLines(PurchHeader,PurchLine,VATAmountLine,QtyType);
//     end;

//     local procedure GetVATAmountLineOfMaxAmt(var VATAmountLine: Record "290";PurchaseLine: Record "39"): Boolean
//     var
//         VATAmount1: Decimal;
//         VATAmount2: Decimal;
//         IsPositive1: Boolean;
//         IsPositive2: Boolean;
//     begin
//         IF VATAmountLine.GET(
//              PurchaseLine."VAT Identifier",PurchaseLine."VAT Calculation Type",PurchaseLine."Tax Group Code",FALSE,FALSE)
//         THEN BEGIN
//           VATAmount1 := VATAmountLine."VAT Amount";
//           IsPositive1 := VATAmountLine.Positive;
//         END;
//         IF VATAmountLine.GET(
//              PurchaseLine."VAT Identifier",PurchaseLine."VAT Calculation Type",PurchaseLine."Tax Group Code",FALSE,TRUE)
//         THEN BEGIN
//           VATAmount2 := VATAmountLine."VAT Amount";
//           IsPositive2 := VATAmountLine.Positive;
//         END;
//         IF ABS(VATAmount1) >= ABS(VATAmount2) THEN
//           EXIT(
//             VATAmountLine.GET(
//               PurchaseLine."VAT Identifier",PurchaseLine."VAT Calculation Type",PurchaseLine."Tax Group Code",FALSE,IsPositive1));
//         EXIT(
//           VATAmountLine.GET(
//             PurchaseLine."VAT Identifier",PurchaseLine."VAT Calculation Type",PurchaseLine."Tax Group Code",FALSE,IsPositive2));
//     end;

//     [Scope('Personalization')]
//     procedure UpdateWithWarehouseReceive()
//     begin
//         IF Type = Type::Item THEN
//           CASE TRUE OF
//             ("Document Type" IN ["Document Type"::Quote,"Document Type"::Order]) AND (Quantity >= 0):
//               IF Location.RequireReceive("Location Code") THEN
//                 VALIDATE("Qty. to Receive",0)
//               ELSE
//                 VALIDATE("Qty. to Receive","Outstanding Quantity");
//             ("Document Type" IN ["Document Type"::Quote,"Document Type"::Order]) AND (Quantity < 0):
//               IF Location.RequireShipment("Location Code") THEN
//                 VALIDATE("Qty. to Receive",0)
//               ELSE
//                 VALIDATE("Qty. to Receive","Outstanding Quantity");
//             ("Document Type" = "Document Type"::"Return Order") AND (Quantity >= 0):
//               IF Location.RequireShipment("Location Code") THEN
//                 VALIDATE("Return Qty. to Ship",0)
//               ELSE
//                 VALIDATE("Return Qty. to Ship","Outstanding Quantity");
//             ("Document Type" = "Document Type"::"Return Order") AND (Quantity < 0):
//               IF Location.RequireReceive("Location Code") THEN
//                 VALIDATE("Return Qty. to Ship",0)
//               ELSE
//                 VALIDATE("Return Qty. to Ship","Outstanding Quantity");
//           END;

//         GetPurchHeader;
//         OnAfterUpdateWithWarehouseReceive(PurchHeader,Rec);

//         SetDefaultQuantity;
//     end;

//     local procedure CheckWarehouse()
//     var
//         Location2: Record "14";
//         WhseSetup: Record "5769";
//         ShowDialog: Option " ",Message,Error;
//         DialogText: Text[50];
//     begin
//         IF "Prod. Order No." <> '' THEN
//           EXIT;
//         GetLocation("Location Code");
//         IF "Location Code" = '' THEN BEGIN
//           WhseSetup.GET;
//           Location2."Require Shipment" := WhseSetup."Require Shipment";
//           Location2."Require Pick" := WhseSetup."Require Pick";
//           Location2."Require Receive" := WhseSetup."Require Receive";
//           Location2."Require Put-away" := WhseSetup."Require Put-away";
//         END ELSE
//           Location2 := Location;

//         DialogText := Text033;
//         IF ("Document Type" IN ["Document Type"::Order,"Document Type"::"Return Order"]) AND
//            Location2."Directed Put-away and Pick"
//         THEN BEGIN
//           ShowDialog := ShowDialog::Error;
//           IF (("Document Type" = "Document Type"::Order) AND (Quantity >= 0)) OR
//              (("Document Type" = "Document Type"::"Return Order") AND (Quantity < 0))
//           THEN
//             DialogText :=
//               DialogText + Location2.GetRequirementText(Location2.FIELDNO("Require Receive"))
//           ELSE
//             DialogText :=
//               DialogText + Location2.GetRequirementText(Location2.FIELDNO("Require Shipment"));
//         END ELSE BEGIN
//           IF (("Document Type" = "Document Type"::Order) AND (Quantity >= 0) AND
//               (Location2."Require Receive" OR Location2."Require Put-away")) OR
//              (("Document Type" = "Document Type"::"Return Order") AND (Quantity < 0) AND
//               (Location2."Require Receive" OR Location2."Require Put-away"))
//           THEN BEGIN
//             IF WhseValidateSourceLine.WhseLinesExist(
//                  DATABASE::"Purchase Line",
//                  "Document Type",
//                  "Document No.",
//                  "Line No.",
//                  0,
//                  Quantity)
//             THEN
//               ShowDialog := ShowDialog::Error
//             ELSE
//               IF Location2."Require Receive" THEN
//                 ShowDialog := ShowDialog::Message;
//             IF Location2."Require Receive" THEN
//               DialogText :=
//                 DialogText + Location2.GetRequirementText(Location2.FIELDNO("Require Receive"))
//             ELSE BEGIN
//               DialogText := Text034;
//               DialogText :=
//                 DialogText + Location2.GetRequirementText(Location2.FIELDNO("Require Put-away"));
//             END;
//           END;

//           IF (("Document Type" = "Document Type"::Order) AND (Quantity < 0) AND
//               (Location2."Require Shipment" OR Location2."Require Pick")) OR
//              (("Document Type" = "Document Type"::"Return Order") AND (Quantity >= 0) AND
//               (Location2."Require Shipment" OR Location2."Require Pick"))
//           THEN BEGIN
//             IF WhseValidateSourceLine.WhseLinesExist(
//                  DATABASE::"Purchase Line",
//                  "Document Type",
//                  "Document No.",
//                  "Line No.",
//                  0,
//                  Quantity)
//             THEN
//               ShowDialog := ShowDialog::Error
//             ELSE
//               IF Location2."Require Shipment" THEN
//                 ShowDialog := ShowDialog::Message;
//             IF Location2."Require Shipment" THEN
//               DialogText :=
//                 DialogText + Location2.GetRequirementText(Location2.FIELDNO("Require Shipment"))
//             ELSE BEGIN
//               DialogText := Text034;
//               DialogText :=
//                 DialogText + Location2.GetRequirementText(Location2.FIELDNO("Require Pick"));
//             END;
//           END;
//         END;

//         CASE ShowDialog OF
//           ShowDialog::Message:
//             MESSAGE(WhseRequirementMsg,DialogText);
//           ShowDialog::Error:
//             ERROR(Text016,DialogText,FIELDCAPTION("Line No."),"Line No.")
//         END;

//         HandleDedicatedBin(TRUE);
//     end;

//     local procedure GetOverheadRateFCY(): Decimal
//     var
//         Item: Record "27";
//         QtyPerUOM: Decimal;
//     begin
//         IF "Prod. Order No." = '' THEN
//           QtyPerUOM := "Qty. per Unit of Measure"
//         ELSE BEGIN
//           GetItem(Item);
//           QtyPerUOM := UOMMgt.GetQtyPerUnitOfMeasure(Item,"Unit of Measure Code");
//         END;

//         EXIT(
//           CurrExchRate.ExchangeAmtLCYToFCY(
//             GetDate,"Currency Code","Overhead Rate" * QtyPerUOM,PurchHeader."Currency Factor"));
//     end;

//     [Scope('Personalization')]
//     procedure GetItemTranslation()
//     var
//         ItemTranslation: Record "30";
//     begin
//         GetPurchHeader;
//         IF ItemTranslation.GET("No.","Variant Code",PurchHeader."Language Code") THEN BEGIN
//           Description := ItemTranslation.Description;
//           "Description 2" := ItemTranslation."Description 2";
//         END;
//     end;

//     local procedure GetGLSetup()
//     begin
//         IF NOT GLSetupRead THEN
//           GLSetup.GET;
//         GLSetupRead := TRUE;
//     end;

//     local procedure GetPurchSetup()
//     begin
//         IF NOT PurchSetupRead THEN
//           PurchSetup.GET;
//         PurchSetupRead := TRUE;
//     end;

//     [Scope('Personalization')]
//     procedure AdjustDateFormula(DateFormulatoAdjust: DateFormula): Text[30]
//     begin
//         IF FORMAT(DateFormulatoAdjust) <> '' THEN
//           EXIT(FORMAT(DateFormulatoAdjust));
//         EVALUATE(DateFormulatoAdjust,'<0D>');
//         EXIT(FORMAT(DateFormulatoAdjust));
//     end;

//     local procedure GetLocation(LocationCode: Code[10])
//     begin
//         IF LocationCode = '' THEN
//           CLEAR(Location)
//         ELSE
//           IF Location.Code <> LocationCode THEN
//             Location.GET(LocationCode);
//     end;

//     [Scope('Personalization')]
//     procedure RowID1(): Text[250]
//     var
//         ItemTrackingMgt: Codeunit "6500";
//     begin
//         EXIT(ItemTrackingMgt.ComposeRowID(DATABASE::"Purchase Line","Document Type",
//             "Document No.",'',0,"Line No."));
//     end;

//     local procedure GetDefaultBin()
//     var
//         WMSManagement: Codeunit "7302";
//     begin
//         IF Type <> Type::Item THEN
//           EXIT;

//         "Bin Code" := '';
//         IF "Drop Shipment" THEN
//           EXIT;

//         IF ("Location Code" <> '') AND ("No." <> '') THEN BEGIN
//           GetLocation("Location Code");
//           IF Location."Bin Mandatory" AND NOT Location."Directed Put-away and Pick" THEN BEGIN
//             WMSManagement.GetDefaultBin("No.","Variant Code","Location Code","Bin Code");
//             HandleDedicatedBin(FALSE);
//           END;
//         END;
//     end;

//     [Scope('Personalization')]
//     procedure IsInbound(): Boolean
//     begin
//         CASE "Document Type" OF
//           "Document Type"::Order,"Document Type"::Invoice,"Document Type"::Quote,"Document Type"::"Blanket Order":
//             EXIT("Quantity (Base)" > 0);
//           "Document Type"::"Return Order","Document Type"::"Credit Memo":
//             EXIT("Quantity (Base)" < 0);
//         END;

//         EXIT(FALSE);
//     end;

//     local procedure HandleDedicatedBin(IssueWarning: Boolean)
//     var
//         WhseIntegrationMgt: Codeunit "7317";
//     begin
//         IF NOT IsInbound AND ("Quantity (Base)" <> 0) THEN
//           WhseIntegrationMgt.CheckIfBinDedicatedOnSrcDoc("Location Code","Bin Code",IssueWarning);
//     end;

//     [Scope('Personalization')]
//     procedure CrossReferenceNoLookUp()
//     var
//         ItemCrossReference: Record "5717";
//     begin
//         IF Type = Type::Item THEN BEGIN
//           GetPurchHeader;
//           ItemCrossReference.RESET;
//           ItemCrossReference.SETCURRENTKEY("Cross-Reference Type","Cross-Reference Type No.");
//           ItemCrossReference.SETFILTER(
//             "Cross-Reference Type",'%1|%2',
//             ItemCrossReference."Cross-Reference Type"::Vendor,
//             ItemCrossReference."Cross-Reference Type"::" ");
//           ItemCrossReference.SETFILTER("Cross-Reference Type No.",'%1|%2',PurchHeader."Buy-from Vendor No.",'');
//           IF PAGE.RUNMODAL(PAGE::"Cross Reference List",ItemCrossReference) = ACTION::LookupOK THEN BEGIN
//             "Cross-Reference No." := ItemCrossReference."Cross-Reference No.";
//             ValidateCrossReferenceNo(ItemCrossReference,FALSE);
//             VALIDATE("Cross-Reference No.",ItemCrossReference."Cross-Reference No.");
//             PurchPriceCalcMgt.FindPurchLinePrice(PurchHeader,Rec,FIELDNO("Cross-Reference No."));
//             PurchPriceCalcMgt.FindPurchLineLineDisc(PurchHeader,Rec);
//             VALIDATE("Direct Unit Cost");
//           END;
//         END;
//     end;

//     local procedure ValidateCrossReferenceNo(ItemCrossReference: Record "5717";SearchItem: Boolean)
//     var
//         ReturnedItemCrossReference: Record "5717";
//     begin
//         ReturnedItemCrossReference.INIT;
//         IF "Cross-Reference No." <> '' THEN BEGIN
//           IF SearchItem THEN
//             DistIntegration.ICRLookupPurchaseItem(Rec,ReturnedItemCrossReference,CurrFieldNo <> 0)
//           ELSE
//             ReturnedItemCrossReference := ItemCrossReference;

//           OnValidateCrossReferenceNoOnBeforeAssignNo(Rec,ReturnedItemCrossReference);

//           VALIDATE("No.",ReturnedItemCrossReference."Item No.");
//           SetVendorItemNo;
//           IF ReturnedItemCrossReference."Variant Code" <> '' THEN
//             VALIDATE("Variant Code",ReturnedItemCrossReference."Variant Code");
//           IF ReturnedItemCrossReference."Unit of Measure" <> '' THEN
//             VALIDATE("Unit of Measure Code",ReturnedItemCrossReference."Unit of Measure");
//           UpdateDirectUnitCost(FIELDNO("Cross-Reference No."));
//         END;

//         "Unit of Measure (Cross Ref.)" := ReturnedItemCrossReference."Unit of Measure";
//         "Cross-Reference Type" := ReturnedItemCrossReference."Cross-Reference Type";
//         "Cross-Reference Type No." := ReturnedItemCrossReference."Cross-Reference Type No.";
//         "Cross-Reference No." := ReturnedItemCrossReference."Cross-Reference No.";

//         IF (ReturnedItemCrossReference.Description <> '') OR (ReturnedItemCrossReference."Description 2" <> '') THEN BEGIN
//           Description := ReturnedItemCrossReference.Description;
//           "Description 2" := ReturnedItemCrossReference."Description 2";
//         END;

//         UpdateICPartner;
//     end;

//     [Scope('Personalization')]
//     procedure ItemExists(ItemNo: Code[20]): Boolean
//     var
//         Item2: Record "27";
//     begin
//         IF Type = Type::Item THEN
//           IF NOT Item2.GET(ItemNo) THEN
//             EXIT(FALSE);
//         EXIT(TRUE);
//     end;

//     local procedure GetAbsMin(QtyToHandle: Decimal;QtyHandled: Decimal): Decimal
//     begin
//         IF ABS(QtyHandled) < ABS(QtyToHandle) THEN
//           EXIT(QtyHandled);

//         EXIT(QtyToHandle);
//     end;

//     local procedure CheckApplToItemLedgEntry(): Code[10]
//     var
//         ItemLedgEntry: Record "32";
//         ApplyRec: Record "339";
//         ItemTrackingLines: Page "6510";
//         ReturnedQty: Decimal;
//         RemainingtobeReturnedQty: Decimal;
//     begin
//         IF "Appl.-to Item Entry" = 0 THEN
//           EXIT;

//         IF "Receipt No." <> '' THEN
//           EXIT;

//         TESTFIELD(Type,Type::Item);
//         TESTFIELD(Quantity);
//         IF Signed(Quantity) > 0 THEN
//           TESTFIELD("Prod. Order No.",'');
//         IF IsCreditDocType THEN BEGIN
//           IF Quantity < 0 THEN
//             FIELDERROR(Quantity,Text029);
//         END ELSE BEGIN
//           IF Quantity > 0 THEN
//             FIELDERROR(Quantity,Text030);
//         END;
//         ItemLedgEntry.GET("Appl.-to Item Entry");
//         ItemLedgEntry.TESTFIELD(Positive,TRUE);
//         IF ItemLedgEntry.TrackingExists THEN
//           ERROR(Text040,ItemTrackingLines.CAPTION,FIELDCAPTION("Appl.-to Item Entry"));

//         ItemLedgEntry.TESTFIELD("Item No.","No.");
//         ItemLedgEntry.TESTFIELD("Variant Code","Variant Code");

//         // Track qty in both alternative and base UOM for better error checking and reporting
//         IF ABS("Quantity (Base)") > ItemLedgEntry.Quantity THEN
//           ERROR(
//             Text042,
//             ItemLedgEntry.Quantity,ItemLedgEntry.FIELDCAPTION("Document No."),
//             ItemLedgEntry."Document No.");

//         IF IsCreditDocType THEN
//           IF ABS("Outstanding Qty. (Base)") > ItemLedgEntry."Remaining Quantity" THEN BEGIN
//             ReturnedQty := ApplyRec.Returned(ItemLedgEntry."Entry No.");
//             RemainingtobeReturnedQty := ItemLedgEntry.Quantity - ReturnedQty;
//             IF NOT ("Qty. per Unit of Measure" = 0) THEN BEGIN
//               ReturnedQty := ROUND(ReturnedQty / "Qty. per Unit of Measure",0.00001);
//               RemainingtobeReturnedQty := ROUND(RemainingtobeReturnedQty / "Qty. per Unit of Measure",0.00001);
//             END;

//             IF ((("Qty. per Unit of Measure" = 0) AND (RemainingtobeReturnedQty < ABS("Outstanding Qty. (Base)"))) OR
//                 (("Qty. per Unit of Measure" <> 0) AND (RemainingtobeReturnedQty < ABS("Outstanding Quantity"))))
//             THEN
//               ERROR(
//                 Text035,
//                 ReturnedQty,ItemLedgEntry.FIELDCAPTION("Document No."),
//                 ItemLedgEntry."Document No.",RemainingtobeReturnedQty);
//           END;

//         EXIT(ItemLedgEntry."Location Code");
//     end;

//     [Scope('Personalization')]
//     procedure CalcPrepaymentToDeduct()
//     begin
//         IF ("Qty. to Invoice" <> 0) AND ("Prepmt. Amt. Inv." <> 0) THEN BEGIN
//           GetPurchHeader;
//           IF ("Prepayment %" = 100) AND NOT IsFinalInvoice THEN
//             "Prepmt Amt to Deduct" := GetLineAmountToHandle("Qty. to Invoice")
//           ELSE
//             "Prepmt Amt to Deduct" :=
//               ROUND(
//                 ("Prepmt. Amt. Inv." - "Prepmt Amt Deducted") *
//                 "Qty. to Invoice" / (Quantity - "Quantity Invoiced"),Currency."Amount Rounding Precision")
//         END ELSE
//           "Prepmt Amt to Deduct" := 0
//     end;

//     [Scope('Personalization')]
//     procedure IsFinalInvoice(): Boolean
//     begin
//         EXIT("Qty. to Invoice" = Quantity - "Quantity Invoiced");
//     end;

//     [Scope('Personalization')]
//     procedure GetLineAmountToHandle(QtyToHandle: Decimal): Decimal
//     var
//         LineAmount: Decimal;
//         LineDiscAmount: Decimal;
//     begin
//         IF "Line Discount %" = 100 THEN
//           EXIT(0);

//         GetPurchHeader;

//         IF "Prepmt Amt to Deduct" = 0 THEN
//           LineAmount := ROUND(QtyToHandle * "Direct Unit Cost",Currency."Amount Rounding Precision")
//         ELSE BEGIN
//           LineAmount := ROUND(Quantity * "Direct Unit Cost",Currency."Amount Rounding Precision");
//           LineAmount := ROUND(QtyToHandle * LineAmount / Quantity,Currency."Amount Rounding Precision");
//         END;

//         IF QtyToHandle <> Quantity THEN
//           LineDiscAmount := ROUND(LineAmount * "Line Discount %" / 100,Currency."Amount Rounding Precision")
//         ELSE
//           LineDiscAmount := "Line Discount Amount";

//         OnAfterGetLineAmountToHandle(Rec,QtyToHandle,LineAmount,LineDiscAmount);
//         EXIT(LineAmount - LineDiscAmount);
//     end;

//     [Scope('Personalization')]
//     procedure JobTaskIsSet(): Boolean
//     var
//         JobTaskSet: Boolean;
//     begin
//         JobTaskSet := FALSE;
//         OnBeforeJobTaskIsSet(Rec,JobTaskSet);

//         EXIT(
//           (("Job No." <> '') AND ("Job Task No." <> '') AND (Type IN [Type::"G/L Account",Type::Item])) OR
//           JobTaskSet);
//     end;

//     [Scope('Personalization')]
//     procedure CreateTempJobJnlLine(GetPrices: Boolean)
//     begin
//         OnBeforeCreateTempJobJnlLine(TempJobJnlLine,Rec,xRec,GetPrices,CurrFieldNo);

//         GetPurchHeader;
//         CLEAR(TempJobJnlLine);
//         TempJobJnlLine.DontCheckStdCost;
//         TempJobJnlLine.VALIDATE("Job No.","Job No.");
//         TempJobJnlLine.VALIDATE("Job Task No.","Job Task No.");
//         TempJobJnlLine.VALIDATE("Posting Date",PurchHeader."Posting Date");
//         TempJobJnlLine.SetCurrencyFactor("Job Currency Factor");
//         IF Type = Type::"G/L Account" THEN
//           TempJobJnlLine.VALIDATE(Type,TempJobJnlLine.Type::"G/L Account")
//         ELSE
//           TempJobJnlLine.VALIDATE(Type,TempJobJnlLine.Type::Item);
//         TempJobJnlLine.VALIDATE("No.","No.");
//         TempJobJnlLine.VALIDATE(Quantity,Quantity);
//         TempJobJnlLine.VALIDATE("Variant Code","Variant Code");
//         TempJobJnlLine.VALIDATE("Unit of Measure Code","Unit of Measure Code");

//         IF NOT GetPrices THEN BEGIN
//           IF xRec."Line No." <> 0 THEN BEGIN
//             TempJobJnlLine."Unit Cost" := xRec."Unit Cost";
//             TempJobJnlLine."Unit Cost (LCY)" := xRec."Unit Cost (LCY)";
//             TempJobJnlLine."Unit Price" := xRec."Job Unit Price";
//             TempJobJnlLine."Line Amount" := xRec."Job Line Amount";
//             TempJobJnlLine."Line Discount %" := xRec."Job Line Discount %";
//             TempJobJnlLine."Line Discount Amount" := xRec."Job Line Discount Amount";
//           END ELSE BEGIN
//             TempJobJnlLine."Unit Cost" := "Unit Cost";
//             TempJobJnlLine."Unit Cost (LCY)" := "Unit Cost (LCY)";
//             TempJobJnlLine."Unit Price" := "Job Unit Price";
//             TempJobJnlLine."Line Amount" := "Job Line Amount";
//             TempJobJnlLine."Line Discount %" := "Job Line Discount %";
//             TempJobJnlLine."Line Discount Amount" := "Job Line Discount Amount";
//           END;
//           TempJobJnlLine.VALIDATE("Unit Price");
//         END ELSE
//           TempJobJnlLine.VALIDATE("Unit Cost (LCY)","Unit Cost (LCY)");

//         OnAfterCreateTempJobJnlLine(TempJobJnlLine,Rec,xRec,GetPrices,CurrFieldNo);
//     end;

//     [Scope('Personalization')]
//     procedure UpdateJobPrices()
//     var
//         PurchRcptLine: Record "121";
//     begin
//         IF "Receipt No." = '' THEN BEGIN
//           "Job Unit Price" := TempJobJnlLine."Unit Price";
//           "Job Total Price" := TempJobJnlLine."Total Price";
//           "Job Unit Price (LCY)" := TempJobJnlLine."Unit Price (LCY)";
//           "Job Total Price (LCY)" := TempJobJnlLine."Total Price (LCY)";
//           "Job Line Amount (LCY)" := TempJobJnlLine."Line Amount (LCY)";
//           "Job Line Disc. Amount (LCY)" := TempJobJnlLine."Line Discount Amount (LCY)";
//           "Job Line Amount" := TempJobJnlLine."Line Amount";
//           "Job Line Discount %" := TempJobJnlLine."Line Discount %";
//           "Job Line Discount Amount" := TempJobJnlLine."Line Discount Amount";
//         END ELSE BEGIN
//           PurchRcptLine.GET("Receipt No.","Receipt Line No.");
//           "Job Unit Price" := PurchRcptLine."Job Unit Price";
//           "Job Total Price" := PurchRcptLine."Job Total Price";
//           "Job Unit Price (LCY)" := PurchRcptLine."Job Unit Price (LCY)";
//           "Job Total Price (LCY)" := PurchRcptLine."Job Total Price (LCY)";
//           "Job Line Amount (LCY)" := PurchRcptLine."Job Line Amount (LCY)";
//           "Job Line Disc. Amount (LCY)" := PurchRcptLine."Job Line Disc. Amount (LCY)";
//           "Job Line Amount" := PurchRcptLine."Job Line Amount";
//           "Job Line Discount %" := PurchRcptLine."Job Line Discount %";
//           "Job Line Discount Amount" := PurchRcptLine."Job Line Discount Amount";
//         END;

//         OnAfterUpdateJobPrices(Rec,TempJobJnlLine,PurchRcptLine);
//     end;

//     [Scope('Personalization')]
//     procedure JobSetCurrencyFactor()
//     begin
//         GetPurchHeader;
//         CLEAR(TempJobJnlLine);
//         TempJobJnlLine.VALIDATE("Job No.","Job No.");
//         TempJobJnlLine.VALIDATE("Job Task No.","Job Task No.");
//         TempJobJnlLine.VALIDATE("Posting Date",PurchHeader."Posting Date");
//         "Job Currency Factor" := TempJobJnlLine."Currency Factor";
//     end;

//     [Scope('Personalization')]
//     procedure SetUpdateFromVAT(UpdateFromVAT2: Boolean)
//     begin
//         UpdateFromVAT := UpdateFromVAT2;
//     end;

//     [Scope('Personalization')]
//     procedure InitQtyToReceive2()
//     begin
//         "Qty. to Receive" := "Outstanding Quantity";
//         "Qty. to Receive (Base)" := "Outstanding Qty. (Base)";

//         "Qty. to Invoice" := MaxQtyToInvoice;
//         "Qty. to Invoice (Base)" := MaxQtyToInvoiceBase;
//         "VAT Difference" := 0;

//         CalcInvDiscToInvoice;

//         CalcPrepaymentToDeduct;

//         IF "Job Planning Line No." <> 0 THEN
//           VALIDATE("Job Planning Line No.");
//     end;

//     [Scope('Personalization')]
//     procedure ClearQtyIfBlank()
//     begin
//         IF "Document Type" = "Document Type"::Order THEN BEGIN
//           GetPurchSetup;
//           IF PurchSetup."Default Qty. to Receive" = PurchSetup."Default Qty. to Receive"::Blank THEN BEGIN
//             "Qty. to Receive" := 0;
//             "Qty. to Receive (Base)" := 0;
//           END;
//         END;
//     end;

//     [Scope('Personalization')]
//     procedure ShowLineComments()
//     var
//         PurchCommentLine: Record "43";
//     begin
//         TESTFIELD("Document No.");
//         TESTFIELD("Line No.");
//         PurchCommentLine.ShowComments("Document Type","Document No.","Line No.");
//     end;

//     [Scope('Personalization')]
//     procedure SetDefaultQuantity()
//     begin
//         GetPurchSetup;
//         IF PurchSetup."Default Qty. to Receive" = PurchSetup."Default Qty. to Receive"::Blank THEN BEGIN
//           IF ("Document Type" = "Document Type"::Order) OR ("Document Type" = "Document Type"::Quote) THEN BEGIN
//             "Qty. to Receive" := 0;
//             "Qty. to Receive (Base)" := 0;
//             "Qty. to Invoice" := 0;
//             "Qty. to Invoice (Base)" := 0;
//           END;
//           IF "Document Type" = "Document Type"::"Return Order" THEN BEGIN
//             "Return Qty. to Ship" := 0;
//             "Return Qty. to Ship (Base)" := 0;
//             "Qty. to Invoice" := 0;
//             "Qty. to Invoice (Base)" := 0;
//           END;
//         END;

//         OnAfterSetDefaultQuantity(Rec,xRec);
//     end;

//     [Scope('Personalization')]
//     procedure UpdatePrePaymentAmounts()
//     var
//         ReceiptLine: Record "121";
//         PurchOrderLine: Record "39";
//         PurchOrderHeader: Record "38";
//     begin
//         IF ("Document Type" <> "Document Type"::Invoice) OR ("Prepayment %" = 0) THEN
//           EXIT;

//         IF NOT ReceiptLine.GET("Receipt No.","Receipt Line No.") THEN BEGIN
//           "Prepmt Amt to Deduct" := 0;
//           "Prepmt VAT Diff. to Deduct" := 0;
//         END ELSE
//           IF PurchOrderLine.GET(PurchOrderLine."Document Type"::Order,ReceiptLine."Order No.",ReceiptLine."Order Line No.") THEN BEGIN
//             IF ("Prepayment %" = 100) AND (Quantity <> PurchOrderLine.Quantity - PurchOrderLine."Quantity Invoiced") THEN
//               "Prepmt Amt to Deduct" := "Line Amount"
//             ELSE
//               "Prepmt Amt to Deduct" :=
//                 ROUND((PurchOrderLine."Prepmt. Amt. Inv." - PurchOrderLine."Prepmt Amt Deducted") *
//                   Quantity / (PurchOrderLine.Quantity - PurchOrderLine."Quantity Invoiced"),Currency."Amount Rounding Precision");
//             "Prepmt VAT Diff. to Deduct" := "Prepayment VAT Difference" - "Prepmt VAT Diff. Deducted";
//             PurchOrderHeader.GET(PurchOrderHeader."Document Type"::Order,PurchOrderLine."Document No.");
//           END ELSE BEGIN
//             "Prepmt Amt to Deduct" := 0;
//             "Prepmt VAT Diff. to Deduct" := 0;
//           END;

//         GetPurchHeader;
//         PurchHeader.TESTFIELD("Prices Including VAT",PurchOrderHeader."Prices Including VAT");
//         IF PurchHeader."Prices Including VAT" THEN BEGIN
//           "Prepmt. Amt. Incl. VAT" := "Prepmt Amt to Deduct";
//           "Prepayment Amount" :=
//             ROUND(
//               "Prepmt Amt to Deduct" / (1 + ("Prepayment VAT %" / 100)),
//               Currency."Amount Rounding Precision");
//         END ELSE BEGIN
//           "Prepmt. Amt. Incl. VAT" :=
//             ROUND(
//               "Prepmt Amt to Deduct" * (1 + ("Prepayment VAT %" / 100)),
//               Currency."Amount Rounding Precision");
//           "Prepayment Amount" := "Prepmt Amt to Deduct";
//         END;
//         "Prepmt. Line Amount" := "Prepmt Amt to Deduct";
//         "Prepmt. Amt. Inv." := "Prepmt. Line Amount";
//         "Prepmt. VAT Base Amt." := "Prepayment Amount";
//         "Prepmt. Amount Inv. Incl. VAT" := "Prepmt. Amt. Incl. VAT";
//         "Prepmt Amt Deducted" := 0;
//     end;

//     [Scope('Personalization')]
//     procedure SetVendorItemNo()
//     var
//         Item: Record "27";
//         ItemVend: Record "99";
//     begin
//         GetItem(Item);
//         ItemVend.INIT;
//         ItemVend."Vendor No." := "Buy-from Vendor No.";
//         ItemVend."Variant Code" := "Variant Code";
//         Item.FindItemVend(ItemVend,"Location Code");
//         VALIDATE("Vendor Item No.",ItemVend."Vendor Item No.");
//     end;

//     [Scope('Personalization')]
//     procedure ZeroAmountLine(QtyType: Option General,Invoicing,Shipping): Boolean
//     begin
//         IF Type = Type::" " THEN
//           EXIT(TRUE);
//         IF Quantity = 0 THEN
//           EXIT(TRUE);
//         IF "Direct Unit Cost" = 0 THEN
//           EXIT(TRUE);
//         IF QtyType = QtyType::Invoicing THEN
//           IF "Qty. to Invoice" = 0 THEN
//             EXIT(TRUE);
//         EXIT(FALSE);
//     end;

//     [Scope('Personalization')]
//     procedure FilterLinesWithItemToPlan(var Item: Record "27";DocumentType: Option)
//     begin
//         RESET;
//         SETCURRENTKEY("Document Type",Type,"No.","Variant Code","Drop Shipment","Location Code","Expected Receipt Date");
//         SETRANGE("Document Type",DocumentType);
//         SETRANGE(Type,Type::Item);
//         SETRANGE("No.",Item."No.");
//         SETFILTER("Variant Code",Item.GETFILTER("Variant Filter"));
//         SETFILTER("Location Code",Item.GETFILTER("Location Filter"));
//         SETFILTER("Drop Shipment",Item.GETFILTER("Drop Shipment Filter"));
//         SETFILTER("Expected Receipt Date",Item.GETFILTER("Date Filter"));
//         SETFILTER("Shortcut Dimension 1 Code",Item.GETFILTER("Global Dimension 1 Filter"));
//         SETFILTER("Shortcut Dimension 2 Code",Item.GETFILTER("Global Dimension 2 Filter"));
//         SETFILTER("Outstanding Qty. (Base)",'<>0');

//         OnAfterFilterLinesWithItemToPlan(Rec,Item);
//     end;

//     [Scope('Personalization')]
//     procedure FindLinesWithItemToPlan(var Item: Record "27";DocumentType: Option): Boolean
//     begin
//         FilterLinesWithItemToPlan(Item,DocumentType);
//         EXIT(FIND('-'));
//     end;

//     [Scope('Personalization')]
//     procedure LinesWithItemToPlanExist(var Item: Record "27";DocumentType: Option): Boolean
//     begin
//         FilterLinesWithItemToPlan(Item,DocumentType);
//         EXIT(NOT ISEMPTY);
//     end;

//     [Scope('Personalization')]
//     procedure GetVPGInvRoundAcc(var PurchHeader: Record "38"): Code[20]
//     var
//         Vendor: Record "23";
//         VendorPostingGroup: Record "93";
//     begin
//         GetPurchSetup;
//         IF PurchSetup."Invoice Rounding" THEN
//           IF Vendor.GET(PurchHeader."Pay-to Vendor No.") THEN
//             VendorPostingGroup.GET(Vendor."Vendor Posting Group");

//         EXIT(VendorPostingGroup."Invoice Rounding Account");
//     end;

//     local procedure CheckReceiptRelation()
//     var
//         PurchRcptLine: Record "121";
//     begin
//         PurchRcptLine.GET("Receipt No.","Receipt Line No.");
//         IF (Quantity * PurchRcptLine."Qty. Rcd. Not Invoiced") < 0 THEN
//           FIELDERROR("Qty. to Invoice",Text051);
//         IF ABS(Quantity) > ABS(PurchRcptLine."Qty. Rcd. Not Invoiced") THEN
//           ERROR(Text052,PurchRcptLine."Document No.");
//     end;

//     local procedure CheckRetShptRelation()
//     var
//         ReturnShptLine: Record "6651";
//     begin
//         ReturnShptLine.GET("Return Shipment No.","Return Shipment Line No.");
//         IF (Quantity * (ReturnShptLine.Quantity - ReturnShptLine."Quantity Invoiced")) < 0 THEN
//           FIELDERROR("Qty. to Invoice",Text053);
//         IF ABS(Quantity) > ABS(ReturnShptLine.Quantity - ReturnShptLine."Quantity Invoiced") THEN
//           ERROR(Text054,ReturnShptLine."Document No.");
//     end;

//     local procedure VerifyItemLineDim()
//     begin
//         IF IsReceivedShippedItemDimChanged THEN
//           ConfirmReceivedShippedItemDimChange;
//     end;

//     [Scope('Personalization')]
//     procedure IsReceivedShippedItemDimChanged(): Boolean
//     begin
//         EXIT(("Dimension Set ID" <> xRec."Dimension Set ID") AND (Type = Type::Item) AND
//           (("Qty. Rcd. Not Invoiced" <> 0) OR ("Return Qty. Shipped Not Invd." <> 0)));
//     end;

//     local procedure IsServiceCharge(): Boolean
//     var
//         VendorPostingGroup: Record "93";
//     begin
//         IF Type <> Type::"G/L Account" THEN
//           EXIT(FALSE);

//         GetPurchHeader;
//         VendorPostingGroup.GET(PurchHeader."Vendor Posting Group");
//         EXIT(VendorPostingGroup."Service Charge Acc." = "No.");
//     end;

//     [Scope('Personalization')]
//     procedure ConfirmReceivedShippedItemDimChange(): Boolean
//     var
//         ConfirmManagement: Codeunit "27";
//     begin
//         IF NOT ConfirmManagement.ConfirmProcess(STRSUBSTNO(Text049,TABLECAPTION),TRUE) THEN
//           ERROR(Text050);

//         EXIT(TRUE);
//     end;

//     [Scope('Personalization')]
//     procedure InitType()
//     begin
//         IF "Document No." <> '' THEN BEGIN
//           IF NOT PurchHeader.GET("Document Type","Document No.") THEN
//             EXIT;
//           IF (PurchHeader.Status = PurchHeader.Status::Released) AND
//              (xRec.Type IN [xRec.Type::Item,xRec.Type::"Fixed Asset"])
//           THEN
//             Type := Type::" "
//           ELSE
//             Type := xRec.Type;
//         END;
//     end;

//     local procedure CheckWMS()
//     begin
//         IF CurrFieldNo <> 0 THEN
//           CheckLocationOnWMS;
//     end;

//     [Scope('Personalization')]
//     procedure CheckLocationOnWMS()
//     var
//         DialogText: Text;
//     begin
//         IF Type = Type::Item THEN BEGIN
//           DialogText := Text033;
//           IF "Quantity (Base)" <> 0 THEN
//             CASE "Document Type" OF
//               "Document Type"::Invoice:
//                 IF "Receipt No." = '' THEN
//                   IF Location.GET("Location Code") AND Location."Directed Put-away and Pick" THEN BEGIN
//                     DialogText += Location.GetRequirementText(Location.FIELDNO("Require Receive"));
//                     ERROR(Text016,DialogText,FIELDCAPTION("Line No."),"Line No.");
//                   END;
//               "Document Type"::"Credit Memo":
//                 IF "Return Shipment No." = '' THEN
//                   IF Location.GET("Location Code") AND Location."Directed Put-away and Pick" THEN BEGIN
//                     DialogText += Location.GetRequirementText(Location.FIELDNO("Require Shipment"));
//                     ERROR(Text016,DialogText,FIELDCAPTION("Line No."),"Line No.");
//                   END;
//             END;
//         END;
//     end;

//     [Scope('Personalization')]
//     procedure IsNonInventoriableItem(): Boolean
//     var
//         Item: Record "27";
//     begin
//         IF Type <> Type::Item THEN
//           EXIT(FALSE);
//         IF "No." = '' THEN
//           EXIT(FALSE);
//         GetItem(Item);
//         EXIT(Item.IsNonInventoriableType);
//     end;

//     [Scope('Personalization')]
//     procedure IsInventoriableItem(): Boolean
//     var
//         Item: Record "27";
//     begin
//         IF Type <> Type::Item THEN
//           EXIT(FALSE);
//         IF "No." = '' THEN
//           EXIT(FALSE);
//         GetItem(Item);
//         EXIT(Item.IsInventoriableType);
//     end;

//     local procedure ReservEntryExist(): Boolean
//     var
//         NewReservEntry: Record "337";
//     begin
//         ReservePurchLine.FilterReservFor(NewReservEntry,Rec);
//         NewReservEntry.SETRANGE("Reservation Status",NewReservEntry."Reservation Status"::Reservation,
//           NewReservEntry."Reservation Status"::Tracking);

//         EXIT(NOT NewReservEntry.ISEMPTY);
//     end;

//     local procedure ValidateReturnReasonCode(CallingFieldNo: Integer)
//     var
//         ReturnReason: Record "6635";
//     begin
//         IF CallingFieldNo = 0 THEN
//           EXIT;
//         IF "Return Reason Code" = '' THEN
//           UpdateDirectUnitCost(CallingFieldNo);

//         IF ReturnReason.GET("Return Reason Code") THEN BEGIN
//           IF (CallingFieldNo <> FIELDNO("Location Code")) AND (ReturnReason."Default Location Code" <> '') THEN
//             VALIDATE("Location Code",ReturnReason."Default Location Code");
//           IF ReturnReason."Inventory Value Zero" THEN
//             VALIDATE("Direct Unit Cost",0)
//           ELSE
//             UpdateDirectUnitCost(CallingFieldNo);
//         END;
//     end;

//     [Scope('Internal')]
//     procedure ValidateLineDiscountPercent(DropInvoiceDiscountAmount: Boolean)
//     begin
//         TestStatusOpen;
//         GetPurchHeader;
//         "Line Discount Amount" :=
//           ROUND(
//             ROUND(Quantity * "Direct Unit Cost",Currency."Amount Rounding Precision") *
//             "Line Discount %" / 100,
//             Currency."Amount Rounding Precision");
//         IF DropInvoiceDiscountAmount THEN BEGIN
//           "Inv. Discount Amount" := 0;
//           "Inv. Disc. Amount to Invoice" := 0;
//         END;
//         UpdateAmounts;
//         UpdateUnitCost;
//     end;

//     local procedure UpdateDimensionsFromJobTask()
//     var
//         SourceCodeSetup: Record "242";
//         DimSetArrID: array [10] of Integer;
//         DimValue1: Code[20];
//         DimValue2: Code[20];
//     begin
//         SourceCodeSetup.GET;
//         DimSetArrID[1] := "Dimension Set ID";
//         DimSetArrID[2] :=
//           DimMgt.CreateDimSetFromJobTaskDim("Job No.",
//             "Job Task No.",DimValue1,DimValue2);
//         DimMgt.CreateDimForPurchLineWithHigherPriorities(
//           Rec,CurrFieldNo,DimSetArrID[3],DimValue1,DimValue2,SourceCodeSetup.Purchases,DATABASE::Job);

//         "Dimension Set ID" :=
//           DimMgt.GetCombinedDimensionSetID(
//             DimSetArrID,DimValue1,DimValue2);

//         "Shortcut Dimension 1 Code" := DimValue1;
//         "Shortcut Dimension 2 Code" := DimValue2;
//     end;

//     local procedure DomesticVendorWarning()
//     begin
//         GetGLSetup;
//         GetPurchSetup;
//         GetPurchHeader;
//         IF (CurrFieldNo = 0) AND GLSetup."Threshold applies" AND
//            (PurchHeader."VAT Registration No." <> '') AND
//            (Type = Type::Item) AND "Reverse Charge Item" AND
//            ("VAT Bus. Posting Group" = PurchSetup."Domestic Vendors")
//         THEN
//           MESSAGE(Text1041000,"VAT Bus. Posting Group",FIELDCAPTION("VAT Bus. Posting Group"));
//     end;

//     local procedure UpdateItemCrossRef()
//     begin
//         DistIntegration.EnterPurchaseItemCrossRef(Rec);
//         UpdateICPartner;
//     end;

//     local procedure UpdateItemReference()
//     begin
//         UpdateItemCrossRef;
//         IF Type <> Type::Item THEN
//           EXIT;

//         IF "Cross-Reference No." = '' THEN
//           SetVendorItemNo
//         ELSE
//           VALIDATE("Vendor Item No.","Cross-Reference No.");
//     end;

//     local procedure UpdateICPartner()
//     var
//         ICPartner: Record "413";
//         ItemCrossReference: Record "5717";
//     begin
//         IF PurchHeader."Send IC Document" AND
//            (PurchHeader."IC Direction" = PurchHeader."IC Direction"::Outgoing)
//         THEN
//           CASE Type OF
//             Type::" ",Type::"Charge (Item)":
//               BEGIN
//                 "IC Partner Ref. Type" := Type;
//                 "IC Partner Reference" := "No.";
//               END;
//             Type::"G/L Account":
//               BEGIN
//                 "IC Partner Ref. Type" := Type;
//                 "IC Partner Reference" := GLAcc."Default IC Partner G/L Acc. No";
//               END;
//             Type::Item:
//               BEGIN
//                 ICPartner.GET(PurchHeader."Buy-from IC Partner Code");
//                 CASE ICPartner."Outbound Purch. Item No. Type" OF
//                   ICPartner."Outbound Purch. Item No. Type"::"Common Item No.":
//                     VALIDATE("IC Partner Ref. Type","IC Partner Ref. Type"::"Common Item No.");
//                   ICPartner."Outbound Purch. Item No. Type"::"Internal No.",
//                   ICPartner."Outbound Purch. Item No. Type"::"Cross Reference":
//                     BEGIN
//                       IF ICPartner."Outbound Purch. Item No. Type" = ICPartner."Outbound Purch. Item No. Type"::"Internal No." THEN
//                         VALIDATE("IC Partner Ref. Type","IC Partner Ref. Type"::Item)
//                       ELSE
//                         VALIDATE("IC Partner Ref. Type","IC Partner Ref. Type"::"Cross Reference");
//                       ItemCrossReference.SETRANGE("Cross-Reference Type",ItemCrossReference."Cross-Reference Type"::Vendor);
//                       ItemCrossReference.SETRANGE("Cross-Reference Type No.","Buy-from Vendor No.");
//                       ItemCrossReference.SETRANGE("Item No.","No.");
//                       ItemCrossReference.SETRANGE("Variant Code","Variant Code");
//                       ItemCrossReference.SETRANGE("Unit of Measure","Unit of Measure Code");
//                       IF ItemCrossReference.FINDFIRST THEN
//                         "IC Partner Reference" := ItemCrossReference."Cross-Reference No."
//                       ELSE
//                         "IC Partner Reference" := "No.";
//                     END;
//                   ICPartner."Outbound Purch. Item No. Type"::"Vendor Item No.":
//                     BEGIN
//                       "IC Partner Ref. Type" := "IC Partner Ref. Type"::"Vendor Item No.";
//                       "IC Partner Reference" := "Vendor Item No.";
//                     END;
//                 END;
//               END;
//             Type::"Fixed Asset":
//               BEGIN
//                 "IC Partner Ref. Type" := "IC Partner Ref. Type"::" ";
//                 "IC Partner Reference" := '';
//               END;
//           END;
//     end;

//     local procedure CalcTotalAmtToAssign(TotalQtyToAssign: Decimal) TotalAmtToAssign: Decimal
//     begin
//         TotalAmtToAssign := CalcLineAmount * TotalQtyToAssign / Quantity;

//         IF PurchHeader."Prices Including VAT" THEN
//           TotalAmtToAssign := TotalAmtToAssign / (1 + "VAT %" / 100) - "VAT Difference";

//         TotalAmtToAssign := ROUND(TotalAmtToAssign,Currency."Amount Rounding Precision");
//     end;

//     [Scope('Personalization')]
//     procedure HasTypeToFillMandatoryFields(): Boolean
//     begin
//         EXIT(Type <> Type::" ");
//     end;

//     [Scope('Personalization')]
//     procedure GetDeferralAmount() DeferralAmount: Decimal
//     begin
//         IF "VAT Base Amount" <> 0 THEN
//           DeferralAmount := "VAT Base Amount"
//         ELSE
//           DeferralAmount := CalcLineAmount;
//     end;

//     local procedure UpdateDeferralAmounts()
//     var
//         DeferralPostDate: Date;
//         AdjustStartDate: Boolean;
//     begin
//         GetPurchHeader;
//         DeferralPostDate := PurchHeader."Posting Date";
//         AdjustStartDate := TRUE;
//         IF "Document Type" = "Document Type"::"Return Order" THEN BEGIN
//           IF "Returns Deferral Start Date" = 0D THEN
//             "Returns Deferral Start Date" := PurchHeader."Posting Date";
//           DeferralPostDate := "Returns Deferral Start Date";
//           AdjustStartDate := FALSE;
//         END;

//         DeferralUtilities.RemoveOrSetDeferralSchedule(
//           "Deferral Code",DeferralUtilities.GetPurchDeferralDocType,'','',
//           "Document Type","Document No.","Line No.",
//           GetDeferralAmount,DeferralPostDate,Description,PurchHeader."Currency Code",AdjustStartDate);
//     end;

//     procedure ShowDeferrals(PostingDate: Date;CurrencyCode: Code[10]): Boolean
//     begin
//         EXIT(DeferralUtilities.OpenLineScheduleEdit(
//             "Deferral Code",DeferralUtilities.GetPurchDeferralDocType,'','',
//             "Document Type","Document No.","Line No.",
//             GetDeferralAmount,PostingDate,Description,CurrencyCode));
//     end;

//     local procedure InitDeferralCode()
//     var
//         Item: Record "27";
//     begin
//         IF "Document Type" IN
//            ["Document Type"::Order,"Document Type"::Invoice,"Document Type"::"Credit Memo","Document Type"::"Return Order"]
//         THEN
//           CASE Type OF
//             Type::"G/L Account":
//               VALIDATE("Deferral Code",GLAcc."Default Deferral Template Code");
//             Type::Item:
//               BEGIN
//                 GetItem(Item);
//                 VALIDATE("Deferral Code",Item."Default Deferral Template Code");
//               END;
//           END;
//     end;

//     [Scope('Personalization')]
//     procedure DefaultDeferralCode()
//     var
//         Item: Record "27";
//     begin
//         CASE Type OF
//           Type::"G/L Account":
//             BEGIN
//               GLAcc.GET("No.");
//               InitDeferralCode;
//             END;
//           Type::Item:
//             BEGIN
//               GetItem(Item);
//               InitDeferralCode;
//             END;
//         END;
//     end;

//     [Scope('Personalization')]
//     procedure IsCreditDocType(): Boolean
//     begin
//         EXIT("Document Type" IN ["Document Type"::"Return Order","Document Type"::"Credit Memo"]);
//     end;

//     [Scope('Personalization')]
//     procedure IsInvoiceDocType(): Boolean
//     begin
//         EXIT("Document Type" IN ["Document Type"::Order,"Document Type"::Invoice]);
//     end;

//     local procedure IsReceivedFromOcr(): Boolean
//     var
//         IncomingDocument: Record "130";
//     begin
//         GetPurchHeader;
//         IF NOT IncomingDocument.GET(PurchHeader."Incoming Document Entry No.") THEN
//           EXIT(FALSE);
//         EXIT(IncomingDocument."OCR Status" = IncomingDocument."OCR Status"::Success);
//     end;

//     local procedure TestReturnFieldsZero()
//     begin
//         TESTFIELD("Return Qty. Shipped Not Invd.",0);
//         TESTFIELD("Return Qty. Shipped",0);
//         TESTFIELD("Return Shipment No.",'');
//     end;

//     [Scope('Personalization')]
//     procedure CanEditUnitOfMeasureCode(): Boolean
//     var
//         ItemUnitOfMeasure: Record "5404";
//     begin
//         IF (Type = Type::Item) AND ("No." <> '') THEN BEGIN
//           ItemUnitOfMeasure.SETRANGE("Item No.","No.");
//           EXIT(ItemUnitOfMeasure.COUNT > 1);
//         END;
//         EXIT(TRUE);
//     end;

//     [Scope('Personalization')]
//     procedure TestItemFields(ItemNo: Code[20];VariantCode: Code[10];LocationCode: Code[10])
//     begin
//         TESTFIELD(Type,Type::Item);
//         TESTFIELD("No.",ItemNo);
//         TESTFIELD("Variant Code",VariantCode);
//         TESTFIELD("Location Code",LocationCode);
//     end;

//     [Scope('Personalization')]
//     procedure ClearPurchaseHeader()
//     begin
//         CLEAR(PurchHeader);
//     end;

//     [Scope('Personalization')]
//     procedure FormatType(): Text[20]
//     begin
//         IF Type = Type::" " THEN
//           EXIT(CommentLbl);

//         EXIT(FORMAT(Type));
//     end;

//     [Scope('Personalization')]
//     procedure RenameNo(LineType: Option;OldNo: Code[20];NewNo: Code[20])
//     begin
//         RESET;
//         SETRANGE(Type,LineType);
//         SETRANGE("No.",OldNo);
//         MODIFYALL("No.",NewNo,TRUE);
//     end;

//     local procedure UpdateLineDiscPct()
//     var
//         LineDiscountPct: Decimal;
//     begin
//         IF ROUND(Quantity * "Direct Unit Cost",Currency."Amount Rounding Precision") <> 0 THEN BEGIN
//           LineDiscountPct := ROUND(
//               "Line Discount Amount" / ROUND(Quantity * "Direct Unit Cost",Currency."Amount Rounding Precision") * 100,
//               0.00001);
//           IF NOT (LineDiscountPct IN [0..100]) THEN
//             ERROR(LineDiscountPctErr);
//           "Line Discount %" := LineDiscountPct;
//         END ELSE
//           "Line Discount %" := 0;
//     end;

//     local procedure UpdateBaseAmounts(NewAmount: Decimal;NewAmountIncludingVAT: Decimal;NewVATBaseAmount: Decimal)
//     begin
//         Amount := NewAmount;
//         "Amount Including VAT" := NewAmountIncludingVAT;
//         "VAT Base Amount" := NewVATBaseAmount;
//         IF NOT PurchHeader."Prices Including VAT" AND (Amount > 0) AND (Amount < "Prepmt. Line Amount") THEN
//           "Prepmt. Line Amount" := Amount;
//         IF PurchHeader."Prices Including VAT" AND ("Amount Including VAT" > 0) AND ("Amount Including VAT" < "Prepmt. Line Amount") THEN
//           "Prepmt. Line Amount" := "Amount Including VAT";
//     end;

//     local procedure IsCalcVATAmountLinesHandled(PurchHeader: Record "38";var PurchLine: Record "39";var VATAmountLine: Record "290") IsHandled: Boolean
//     begin
//         IsHandled := FALSE;
//         OnBeforeCalcVATAmountLines(PurchHeader,PurchLine,VATAmountLine,IsHandled);
//         EXIT(IsHandled);
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnAfterAssignFieldsForNo(var PurchLine: Record "39";var xPurchLine: Record "39";PurchHeader: Record "38")
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnAfterAssignHeaderValues(var PurchLine: Record "39";PurchHeader: Record "38")
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnAfterAssignStdTxtValues(var PurchLine: Record "39";StandardText: Record "7")
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnAfterAssignGLAccountValues(var PurchLine: Record "39";GLAccount: Record "15")
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnAfterAssignItemValues(var PurchLine: Record "39";Item: Record "27")
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnAfterAssignItemChargeValues(var PurchLine: Record "39";ItemCharge: Record "5800")
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnAfterAssignFixedAssetValues(var PurchLine: Record "39";FixedAsset: Record "5600")
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnAfterAssignItemUOM(var PurchLine: Record "39";Item: Record "27")
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnAfterGetItem(var Item: Record "27";var PurchaseLine: Record "39")
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnAfterGetPurchHeader(var PurchaseLine: Record "39";var PurchaseHeader: Record "38")
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnAfterFilterLinesWithItemToPlan(var PurchaseLine: Record "39";var Item: Record "27")
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnAfterUpdateDirectUnitCost(var PurchLine: Record "39";xPurchLine: Record "39";CalledByFieldNo: Integer;CurrFieldNo: Integer)
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnBeforeUpdateDirectUnitCost(var PurchLine: Record "39";xPurchLine: Record "39";CalledByFieldNo: Integer;CurrFieldNo: Integer;var Handled: Boolean)
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnBeforeVerifyReservedQty(var PurchLine: Record "39";xPurchLine: Record "39";CalledByFieldNo: Integer)
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnAfterInitHeaderDefaults(var PurchLine: Record "39";PurchHeader: Record "38")
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnAfterInitOutstandingQty(var PurchaseLine: Record "39")
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnAfterInitOutstandingAmount(var PurchLine: Record "39";xPurchLine: Record "39";PurchHeader: Record "38";Currency: Record "4")
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnAfterInitQtyToInvoice(var PurchLine: Record "39";CurrFieldNo: Integer)
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnAfterInitQtyToShip(var PurchLine: Record "39";CurrFieldNo: Integer)
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnAfterInitQtyToReceive(var PurchLine: Record "39";CurrFieldNo: Integer)
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnAfterSetDefaultQuantity(var PurchLine: Record "39";var xPurchLine: Record "39")
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnAfterCalcVATAmountLines(var PurchHeader: Record "38";var PurchLine: Record "39";var VATAmountLine: Record "290";QtyType: Option General,Invoicing,Shipping)
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnAfterCreateDimTableIDs(var PurchLine: Record "39";FieldNo: Integer;var TableID: array [10] of Integer;var No: array [10] of Code[20])
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnAfterGetLineAmountToHandle(PurchLine: Record "39";QtyToHandle: Decimal;var LineAmount: Decimal;var LineDiscAmount: Decimal)
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnAfterTestStatusOpen(var PurchaseLine: Record "39";PurchaseHeader: Record "38")
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnAfterUpdateAmounts(var PurchLine: Record "39";var xPurchLine: Record "39";CurrFieldNo: Integer)
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnAfterUpdateAmountsDone(var PurchLine: Record "39";var xPurchLine: Record "39";CurrFieldNo: Integer)
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnAfterUpdateUnitCost(var PurchLine: Record "39";xPurchLine: Record "39";PurchHeader: Record "38";Item: Record "27";StockkeepingUnit: Record "5700";Currency: Record "4";GLSetup: Record "98")
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnAfterUpdateJobPrices(var PurchLine: Record "39";JobJnlLine: Record "210";PurchRcptLine: Record "121")
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnAfterUpdateWithWarehouseReceive(PurchaseHeader: Record "38";var PurchaseLine: Record "39")
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnAfterUpdateVATAmounts(var PurchaseLine: Record "39")
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnAfterUpdateVATOnLines(var PurchHeader: Record "38";var PurchLine: Record "39";var VATAmountLine: Record "290";QtyType: Option General,Invoicing,Shipping)
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnAfterUpdateTotalAmounts(var PurchaseLine: Record "39";PurchaseLine2: Record "39";var TotalAmount: Decimal;var TotalAmountInclVAT: Decimal;var TotalLineAmount: Decimal;var TotalInvDiscAmount: Decimal)
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnBeforeCopyFromItem(var PurchaseLine: Record "39";var Item: Record "27")
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnBeforeBlanketOrderLookup(var PurchaseLine: Record "39";FieldNo: Integer;var IsHandled: Boolean)
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnBeforeCalcVATAmountLines(PurchHeader: Record "38";var PurchLine: Record "39";var VATAmountLine: Record "290";var IsHandled: Boolean)
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnBeforeCreateTempJobJnlLine(var TempJobJournalLine: Record "210" temporary;PurchaseLine: Record "39";xPurchaseLine: Record "39";GetPrices: Boolean;CallingFieldNo: Integer)
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnBeforeJobTaskIsSet(PurchLine: Record "39";var IsJobLine: Boolean)
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnBeforeOpenItemTrackingLines(PurchaseLine: Record "39";var IsHandled: Boolean)
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnBeforeTestStatusOpen(var PurchaseLine: Record "39";PurchaseHeader: Record "38")
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnBeforeUpdateVATAmounts(var PurchaseLine: Record "39")
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnAfterCreateTempJobJnlLine(var JobJournalLine: Record "210";PurchLine: Record "39";xPurchLine: Record "39";GetPrices: Boolean;CurrFieldNo: Integer)
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnUpdateDirectUnitCostOnBeforeFindPrice(PurchaseHeader: Record "38";var PurchaseLine: Record "39";CalledByFieldNo: Integer;FieldNo: Integer;var IsHandled: Boolean)
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnValidateCrossReferenceNoOnBeforeAssignNo(var PurchaseLine: Record "39";var ItemCrossReference: Record "5717")
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnValidateTypeOnCopyFromTempPurchLine(var PurchLine: Record "39";TempPurchaseLine: Record "39" temporary)
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnValidateNoOnCopyFromTempPurchLine(var PurchLine: Record "39";TempPurchaseLine: Record "39" temporary)
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnValidateNoOnAfterAssignQtyFromXRec(var PurchaseLine: Record "39";TempPurchaseLine: Record "39" temporary)
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnValidateNoOnAfterChecks(var PurchaseLine: Record "39";xPurchaseLine: Record "39";FieldNo: Integer)
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnValidateNoOnAfterVerifyChange(var PurchaseLine: Record "39";xPurchaseLine: Record "39")
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnValidateNoOnBeforeInitRec(var PurchaseLine: Record "39";xPurchaseLine: Record "39";FieldNo: Integer)
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnValidateQtyToReceiveOnAfterCheck(var PurchaseLine: Record "39";FieldNo: Integer)
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnValidateQuantityOnBeforeDropShptCheck(var PurchaseLine: Record "39";xPurchaseLine: Record "39";FieldNo: Integer;var IsHandled: Boolean)
//     begin
//     end;

//     [Scope('Personalization')]
//     procedure AssignedItemCharge(): Boolean
//     begin
//         EXIT((Type = Type::"Charge (Item)") AND ("No." <> '') AND ("Qty. to Assign" < Quantity));
//     end;

//     procedure ShowDeferralSchedule()
//     var
//         PurchaseHeader: Record "38";
//     begin
//         PurchaseHeader.GET("Document Type","Document No.");
//         ShowDeferrals(PurchaseHeader."Posting Date",PurchaseHeader."Currency Code");
//     end;
// }

