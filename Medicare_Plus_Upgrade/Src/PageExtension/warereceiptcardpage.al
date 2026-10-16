// page 5768 "Warehouse Receipt"
// {
//     // version NAVW113.00

//     Caption = 'Warehouse Receipt';
//     PageType = Document;
//     PopulateAllFields = true;
//     RefreshOnActivate = true;
//     SourceTable = Table7316;

//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'General';
//                 field("No.";"No.")
//                 {
//                     ApplicationArea = Warehouse;
//                     ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';

//                     trigger OnAssistEdit()
//                     begin
//                         IF AssistEdit(xRec) THEN
//                           CurrPage.UPDATE;
//                     end;
//                 }
//                 field("Location Code";"Location Code")
//                 {
//                     ApplicationArea = Location;
//                     ToolTip = 'Specifies the code of the location in which the items are being received.';

//                     trigger OnLookup(var Text: Text): Boolean
//                     begin
//                         CurrPage.SAVERECORD;
//                         LookupLocation(Rec);
//                         CurrPage.UPDATE(TRUE);
//                     end;
//                 }
//                 field("Zone Code";"Zone Code")
//                 {
//                     ApplicationArea = Warehouse;
//                     ToolTip = 'Specifies the zone in which the items are being received if you are using directed put-away and pick.';
//                 }
//                 field("Bin Code";"Bin Code")
//                 {
//                     ApplicationArea = Warehouse;
//                     ToolTip = 'Specifies the bin where the items are picked or put away.';
//                 }
//                 field("Document Status";"Document Status")
//                 {
//                     ApplicationArea = Warehouse;
//                     ToolTip = 'Specifies the status of the warehouse receipt.';
//                 }
//                 field("Posting Date";"Posting Date")
//                 {
//                     ApplicationArea = Warehouse;
//                     ToolTip = 'Specifies the posting date of the warehouse receipt.';
//                 }
//                 field("Vendor Shipment No.";"Vendor Shipment No.")
//                 {
//                     ApplicationArea = Warehouse;
//                     ToolTip = 'Specifies the vendor''s shipment number. It is inserted in the corresponding field on the source document during posting.';
//                 }
//                 field("Assigned User ID";"Assigned User ID")
//                 {
//                     ApplicationArea = Warehouse;
//                     ToolTip = 'Specifies the ID of the user who is responsible for the document.';
//                 }
//                 field("Assignment Date";"Assignment Date")
//                 {
//                     ApplicationArea = Warehouse;
//                     Editable = false;
//                     ToolTip = 'Specifies the date when the user was assigned the activity.';
//                 }
//                 field("Assignment Time";"Assignment Time")
//                 {
//                     ApplicationArea = Warehouse;
//                     Editable = false;
//                     ToolTip = 'Specifies the time when the user was assigned the activity.';
//                 }
//                 field("Gate Entry No.";"Gate Entry No.")
//                 {

//                     trigger OnValidate()
//                     var
//                         "Posted Gate Entry Line": Record "50004";
//                         WhseRqst: Record "5765";
//                         GetSourceDocuments: Report "5753";
//                         "Warehouse Receipt Line": Record "7317";
//                     begin
//                         //kd - while testing
//                         Compname:=COMPANYNAME;
//                         Defaultsetup.GET();
//                          IF Defaultsetup."Company name"=Compname THEN BEGIN
//                         "Posted Gate Entry Line".RESET;
//                         "Posted Gate Entry Line".SETRANGE("Posted Gate Entry Line"."Gate Entry No.","Gate Entry No.");
//                         IF "Posted Gate Entry Line".FINDFIRST THEN BEGIN
//                          REPEAT
//                           WhseRqst.FILTERGROUP(2);
//                           WhseRqst.SETRANGE(Type,WhseRqst.Type::Inbound);
//                           WhseRqst.SETRANGE("Location Code","Location Code");
//                           WhseRqst.FILTERGROUP(0);
//                           WhseRqst.SETRANGE("Document Status",WhseRqst."Document Status"::Released);
//                           WhseRqst.SETRANGE("Completely Handled",FALSE);
//                           WhseRqst.SETRANGE(WhseRqst."Source No.","Posted Gate Entry Line"."Doc. Source No.");
//                           IF WhseRqst.FINDFIRST THEN;
//                           GetSourceDocuments.SetOneCreatedReceiptHeader(Rec);
//                           WhseRqst.MARKEDONLY(TRUE);
//                           IF NOT WhseRqst.FIND('-') THEN BEGIN
//                             WhseRqst.MARKEDONLY(FALSE);
//                             WhseRqst.SETRECFILTER;
//                           END;
//                           GetSourceDocuments.USEREQUESTPAGE(FALSE);
//                           GetSourceDocuments.SETTABLEVIEW(WhseRqst);
//                           GetSourceDocuments.RUNMODAL;
//                           CLEAR(GetSourceDocuments);
//                          UNTIL "Posted Gate Entry Line".NEXT=0;
//                         END;
//                         Rec."Document Status" :=GetHeaderStatus(0);
//                         MODIFY;
//                         "Warehouse Receipt Line".RESET;
//                         "Warehouse Receipt Line".SETRANGE("Warehouse Receipt Line"."No.","No.");
//                         IF "Warehouse Receipt Line".FINDFIRST THEN BEGIN
//                          REPEAT
//                           "Warehouse Receipt Line".VALIDATE("Warehouse Receipt Line"."Qty. to Receive",0);
//                           "Warehouse Receipt Line".MODIFY(TRUE);
//                          UNTIL "Warehouse Receipt Line".NEXT=0;
//                         END;
//                         END;
//                         //kd - while testing
//                     end;
//                 }
//                 field("Select All";"Select All")
//                 {

//                     trigger OnValidate()
//                     begin


//                         //"lineno." := 10000; //chem-493
//                         warehousereceiptline.RESET;  //chem-493
//                         warehousereceiptline.SETRANGE(warehousereceiptline."No.","No.");//chem-493
//                         IF warehousereceiptline.FIND('-') THEN //chem-493
//                         REPEAT
//                         //IF warehousereceiptline.GET("No.","lineno.") THEN  //chem-493
//                         //BEGIN      //chem-493
//                               IF ("Select All" = TRUE) AND (warehousereceiptline."Create Production Order"=FALSE) THEN BEGIN
//                                 warehousereceiptline."Create Production Order" := TRUE;
//                                 warehousereceiptline.MODIFY;
//                                 END
//                               ELSE IF ("Select All" = TRUE) AND (warehousereceiptline."Create Production Order"=TRUE) THEN BEGIN
//                                 warehousereceiptline."Create Production Order" := TRUE;
//                                 warehousereceiptline.MODIFY;
//                                 END
//                               ELSE IF ("Select All" = FALSE) AND (warehousereceiptline."Create Production Order"=TRUE) THEN BEGIN
//                                 warehousereceiptline."Create Production Order" := FALSE;//TRUE
//                                 warehousereceiptline.MODIFY;
//                                 END
//                               ELSE IF ("Select All" = FALSE) AND (warehousereceiptline."Create Production Order"=FALSE) THEN BEGIN
//                                 warehousereceiptline."Create Production Order" := FALSE;
//                                 warehousereceiptline.MODIFY;
//                                 END;
//                         //END;//chem-493
//                           //"lineno." := "lineno."+10000; //chem-493
//                         UNTIL warehousereceiptline.NEXT = 0;
//                     end;
//                 }
//                 field("Sorting Method";"Sorting Method")
//                 {
//                     ApplicationArea = Warehouse;
//                     OptionCaption = ' ,Item,Document,Shelf or Bin,Due Date ';
//                     ToolTip = 'Specifies the method by which the receipts are sorted.';

//                     trigger OnValidate()
//                     begin
//                         SortingMethodOnAfterValidate;
//                     end;
//                 }
//             }
//             part(WhseReceiptLines;5769)
//             {
//                 ApplicationArea = Warehouse;
//                 SubPageLink = No.=FIELD(No.);
//                 SubPageView = SORTING(No.,Sorting Sequence No.);
//             }
//         }
//         area(factboxes)
//         {
//             part(;9109)
//             {
//                 ApplicationArea = Warehouse;
//                 Provider = WhseReceiptLines;
//                 SubPageLink = No.=FIELD(Item No.);
//                 Visible = true;
//             }
//             systempart(;Links)
//             {
//                 Visible = false;
//             }
//             systempart(;Notes)
//             {
//                 Visible = true;
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group("&Receipt")
//             {
//                 Caption = '&Receipt';
//                 Image = Receipt;
//                 action(List)
//                 {
//                     ApplicationArea = Location;
//                     Caption = 'List';
//                     Image = OpportunitiesList;
//                     ShortCutKey = 'Shift+Ctrl+L';
//                     ToolTip = 'View all warehouse documents of this type that exist.';

//                     trigger OnAction()
//                     begin
//                         LookupWhseRcptHeader(Rec);
//                     end;
//                 }
//                 action("Co&mments")
//                 {
//                     ApplicationArea = Comments;
//                     Caption = 'Co&mments';
//                     Image = ViewComments;
//                     RunObject = Page 5776;
//                     RunPageLink = Table Name=CONST(Whse. Receipt),
//                                   Type=CONST(" "),
//                                   No.=FIELD(No.);
//                     ToolTip = 'View or add comments for the record.';
//                 }
//                 action("Posted &Whse. Receipts")
//                 {
//                     ApplicationArea = Warehouse;
//                     Caption = 'Posted &Whse. Receipts';
//                     Image = PostedReceipts;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     RunObject = Page 7333;
//                     RunPageLink = Whse. Receipt No.=FIELD(No.);
//                     RunPageView = SORTING(Whse. Receipt No.);
//                     ToolTip = 'View the quantity that has been posted as received.';
//                 }
//             }
//         }
//         area(processing)
//         {
//             group("F&unctions")
//             {
//                 Caption = 'F&unctions';
//                 Image = "Action";
//                 action("Use Filters to Get Src. Docs.")
//                 {
//                     ApplicationArea = Warehouse;
//                     Caption = 'Use Filters to Get Src. Docs.';
//                     Ellipsis = true;
//                     Image = UseFilters;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     ToolTip = 'Retrieve the released source document lines that define which items to receive or ship.';

//                     trigger OnAction()
//                     var
//                         GetSourceDocInbound: Codeunit "5751";
//                     begin
//                         GetSourceDocInbound.GetInboundDocs(Rec);
//                         "Document Status" := GetHeaderStatus(0);
//                         MODIFY;
//                     end;
//                 }
//                 action("Get Source Documents")
//                 {
//                     ApplicationArea = Warehouse;
//                     Caption = 'Get Source Documents';
//                     Ellipsis = true;
//                     Image = GetSourceDoc;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     ShortCutKey = 'Shift+F11';
//                     ToolTip = 'Open the list of released source documents, such as purchase orders, to select the document to receive items for. ';

//                     trigger OnAction()
//                     var
//                         GetSourceDocInbound: Codeunit "5751";
//                     begin
//                         GetSourceDocInbound.GetSingleInboundDoc(Rec);
//                         "Document Status" := GetHeaderStatus(0);
//                         MODIFY;
//                     end;
//                 }
//                 separator()
//                 {
//                     Caption = '';
//                 }
//                 action("Autofill Qty. to Receive")
//                 {
//                     ApplicationArea = Warehouse;
//                     Caption = 'Autofill Qty. to Receive';
//                     Image = AutofillQtyToHandle;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     PromotedIsBig = true;
//                     ToolTip = 'Have the system enter the outstanding quantity in the Qty. to Receive field.';

//                     trigger OnAction()
//                     begin
//                         AutofillQtyToReceive;
//                     end;
//                 }
//                 action("Delete Qty. to Receive")
//                 {
//                     ApplicationArea = Warehouse;
//                     Caption = 'Delete Qty. to Receive';
//                     Image = DeleteQtyToHandle;
//                     ToolTip = 'Have the system clear the value in the Qty. To Receive field. ';

//                     trigger OnAction()
//                     begin
//                         DeleteQtyToReceive;
//                     end;
//                 }
//                 separator()
//                 {
//                 }
//                 action(CalculateCrossDock)
//                 {
//                     ApplicationArea = Warehouse;
//                     Caption = 'Calculate Cross-Dock';
//                     Image = CalculateCrossDock;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     ToolTip = 'Open the Cross-Dock Opportunities window to see details about the lines requesting the item, such as type of document, quantity requested, and due date. This information might help you to decide how much to cross-dock, where to place the items in the cross-dock area, or how to group them.';

//                     trigger OnAction()
//                     var
//                         CrossDockOpp: Record "5768";
//                         CrossDockMgt: Codeunit "5780";
//                     begin
//                         CrossDockMgt.CalculateCrossDockLines(CrossDockOpp,'',"No.","Location Code");
//                     end;
//                 }
//             }
//             group("P&osting")
//             {
//                 Caption = 'P&osting';
//                 Image = Post;
//                 action("Post Receipt")
//                 {
//                     ApplicationArea = Warehouse;
//                     Caption = 'P&ost Receipt';
//                     Image = PostOrder;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     PromotedIsBig = true;
//                     ShortCutKey = 'F9';
//                     ToolTip = 'Post the items as received. A put-away document is created automatically.';

//                     trigger OnAction()
//                     begin
//                         //WhsePostRcptYesNo;

//                         //Sofayn ++
//                         WarehouseReceiptLine_Rec.RESET;
//                         WarehouseReceiptLine_Rec.SETCURRENTKEY("No.","Line No.");
//                         WarehouseReceiptLine_Rec.SETRANGE("No.","No.");
//                         IF WarehouseReceiptLine_Rec.FINDFIRST THEN
//                           BEGIN
//                             PostedGateEntryLine1_Rec.RESET;
//                             PostedGateEntryLine1_Rec.SETRANGE(PostedGateEntryLine1_Rec."Doc. Source No.",WarehouseReceiptLine_Rec."Source No.");
//                             IF PostedGateEntryLine1_Rec.FINDFIRST THEN
//                               CurrPage.WhseReceiptLines.PAGE.WhsePostRcptYesNo
//                             ELSE
//                               ERROR('Gate entries not present for the Receipt, You can not post receipt !');
//                            END;
//                         //Sofyan --
//                     end;
//                 }
//                 action("Post and &Print")
//                 {
//                     ApplicationArea = Warehouse;
//                     Caption = 'Post and &Print';
//                     Image = PostPrint;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     PromotedIsBig = true;
//                     ShortCutKey = 'Shift+F9';
//                     ToolTip = 'Finalize and prepare to print the document or journal. The values and quantities are posted to the related accounts. A report request window where you can specify what to include on the print-out.';

//                     trigger OnAction()
//                     begin
//                         WhsePostRcptPrintPostedRcpt;
//                     end;
//                 }
//                 action("Post and Print P&ut-away")
//                 {
//                     ApplicationArea = Warehouse;
//                     Caption = 'Post and Print P&ut-away';
//                     Image = PostPrint;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     PromotedIsBig = true;
//                     ShortCutKey = 'Shift+Ctrl+F9';
//                     ToolTip = 'Post the items as received and print the put-away document.';

//                     trigger OnAction()
//                     begin
//                         //WhsePostRcptPrint;
//                         //Sofyan ++

//                         WarehouseReceiptLine_Rec.RESET;
//                         WarehouseReceiptLine_Rec.SETCURRENTKEY("No.","Line No.");
//                         WarehouseReceiptLine_Rec.SETRANGE("No.","No.");
//                         IF WarehouseReceiptLine_Rec.FINDFIRST THEN
//                           BEGIN
//                             PostedGateEntryLine1_Rec.RESET;
//                             PostedGateEntryLine1_Rec.SETRANGE(PostedGateEntryLine1_Rec."Doc. Source No.",WarehouseReceiptLine_Rec."Source No.");
//                             IF PostedGateEntryLine1_Rec.FINDFIRST THEN
//                               CurrPage.WhseReceiptLines.PAGE.WhsePostRcptPrint
//                             ELSE
//                               ERROR('Gate entries not present for the Receipt, You can not post receipt !');
//                            END;

//                         //Sofyan --
//                     end;
//                 }
//             }
//             action("&Print")
//             {
//                 ApplicationArea = Warehouse;
//                 Caption = '&Print';
//                 Ellipsis = true;
//                 Image = Print;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 ToolTip = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.';

//                 trigger OnAction()
//                 begin
//                     WhseDocPrint.PrintRcptHeader(Rec);
//                 end;
//             }
//         }
//     }

//     trigger OnFindRecord(Which: Text): Boolean
//     begin
//         EXIT(FindFirstAllowedRec(Which));
//     end;

//     trigger OnNextRecord(Steps: Integer): Integer
//     begin
//         EXIT(FindNextAllowedRec(Steps));
//     end;

//     trigger OnOpenPage()
//     begin
//         ErrorIfUserIsNotWhseEmployee;
//     end;

//     var
//         WhseDocPrint: Codeunit "5776";
//         TEstrec: Record "336";
//         warehousereceiptline: Record "7317";
//         "lineno.": Integer;
//         uncheck1: Boolean;
//         PostedGateEntryLine1_Rec: Record "50004";
//         WarehouseReceiptLine_Rec: Record "7317";
//         Compname: Text[250];
//         Defaultsetup: Record "50012";

//     local procedure AutofillQtyToReceive()
//     begin
//         CurrPage.WhseReceiptLines.PAGE.AutofillQtyToReceive;
//     end;

//     local procedure DeleteQtyToReceive()
//     begin
//         CurrPage.WhseReceiptLines.PAGE.DeleteQtyToReceive;
//     end;

//     local procedure WhsePostRcptYesNo()
//     begin
//         CurrPage.WhseReceiptLines.PAGE.WhsePostRcptYesNo;
//     end;

//     local procedure WhsePostRcptPrint()
//     begin
//         CurrPage.WhseReceiptLines.PAGE.WhsePostRcptPrint;
//     end;

//     local procedure WhsePostRcptPrintPostedRcpt()
//     begin
//         CurrPage.WhseReceiptLines.PAGE.WhsePostRcptPrintPostedRcpt;
//     end;

//     local procedure SortingMethodOnAfterValidate()
//     begin
//         CurrPage.UPDATE;
//     end;

//     procedure MakeProdOrder(WMSReceiptNo: Code[20])
//     var
//         WMSReceiptLine: Record "7317";
//         Prodorder: Record "5405";
//         "Tracking Specification": Record "336";
//     begin
//         /*hIREN
//         WMSReceiptLine.RESET;
//         WMSReceiptLine.SETRANGE(WMSReceiptLine."No.",WMSReceiptNo);
//         IF WMSReceiptLine.FINDFIRST THEN
//         BEGIN
//         REPEAT
//                 Prodorder.RESET;
//                 Prodorder.SETRANGE(Prodorder.WMSReceiptNo,WMSReceiptNo);
//                 Prodorder.SETRANGE(Prodorder."Source Type",Prodorder."Source Type"::Item);
//                 Prodorder.SETRANGE(Prodorder."Source No.",WMSReceiptLine."Item No.");
//                 IF NOT Prodorder.FINDFIRST THEN
//                 BEGIN
//                     Prodorder.INIT;
//                     Prodorder.VALIDATE(Prodorder.Status,2);
//                     Prodorder.VALIDATE(Prodorder."No.",'');
//                     Prodorder.VALIDATE(Prodorder."Source Type",Prodorder."Source Type"::Item);
//                     Prodorder.VALIDATE(Prodorder."Source No.",WMSReceiptLine."Item No.");
//                     Prodorder.VALIDATE(Prodorder.Quantity,WMSReceiptLine."Qty. to Receive");
//                     Prodorder.VALIDATE(Prodorder."ECMA No.",WMSReceiptLine."ECMA No.");
//                     Prodorder.VALIDATE(Prodorder.WMSReceiptNo,WMSReceiptNo);
//                     Prodorder.INSERT(TRUE);
//                END;
//         UNTIL WMSReceiptLine.NEXT=0;
//         MESSAGE('Firmed Planned Production Order Created Successfully !');
//         END
//         ELSE
//         BEGIN
//          ERROR('Please insert Warehouse receipt line details');
//         END;
//         */

//     end;
// }

