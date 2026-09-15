// page 50086 "Sales Order WS-Web"
// {
//     // version NAVW17.00,NAVGB7.00

//     // <changelog>
//     //   <remove id="GB0001" dev="TMARTI" date="2007-06-14" area="UKGEN"  request="UK-START-51"
//     //     baseversion="GB4.00" releaseversion="GB6.00">C/Track cleanup</remove>
//     //   <add id="GB0002" dev="TMARTI" date="2004-06-14" area="DOCLAY"  request="UK-START-51"
//     //     releaseversion="GB6.00">UK Address format</add>
//     //   <change id="GB0003" dev="KCOOLS" date="2008-11-10" area="DOCLAY" feature="NAVCORS31337"
//     //     baseversion="GB6.00" releaseversion="GB6.00.01">GB address labels not correctly transformed in RTC</change>
//     //   <add id="GB0147" dev="TMARTI" date="2004-07-25" area="UKGEN"  request="UK-START-40"
//     //     releaseversion="GB4.00">localized object</add>
//     // </changelog>

//     Caption = 'Sales Order';
//     PageType = Document;
//     RefreshOnActivate = true;
//     SourceTable = "Sales Header";
//     SourceTableView = WHERE("Document Type" = FILTER(Order));

//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'General';
//                 field("No."; REC."No.")
//                 {
//                     Importance = Promoted;

//                     trigger OnAssistEdit()
//                     begin
//                         IF AssistEdit(xRec) THEN
//                             CurrPage.UPDATE;
//                     end;
//                 }
//                 field("Sell-to Customer No."; REC."Sell-to Customer No.")
//                 {
//                     Importance = Promoted;

//                     trigger OnValidate()
//                     begin
//                         SelltoCustomerNoOnAfterValidat;
//                     end;
//                 }
//                 field("Sell-to Contact No."; REC."Sell-to Contact No.")
//                 {
//                     Importance = Additional;

//                     trigger OnValidate()
//                     begin
//                         IF GETFILTER("Sell-to Contact No.") = xRec."Sell-to Contact No." THEN
//                             IF "Sell-to Contact No." <> xRec."Sell-to Contact No." THEN
//                                 SETRANGE("Sell-to Contact No.");
//                     end;
//                 }
//                 field("Sell-to Customer Name"; REC."Sell-to Customer Name")
//                 {
//                     QuickEntry = false;
//                 }
//                 field("Sell-to Address"; REC."Sell-to Address")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Sell-to Address 2"; REC."Sell-to Address 2")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Sell-to City"; REC."Sell-to City")
//                 {
//                 }
//                 field("Sell-to County"; REC."Sell-to County")
//                 {
//                 }
//                 field("Sell-to Post Code"; REC."Sell-to Post Code")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Sell-to Contact"; REC."Sell-to Contact")
//                 {
//                     Importance = Additional;
//                 }
//                 field("No. of Archived Versions"; REC."No. of Archived Versions")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Posting Date"; REC."Posting Date")
//                 {
//                     QuickEntry = false;
//                 }
//                 field("Order Date"; REC."Order Date")
//                 {
//                     Importance = Promoted;
//                     QuickEntry = false;
//                 }
//                 field("Document Date"; REC."Document Date")
//                 {
//                     QuickEntry = false;
//                 }
//                 field("Requested Delivery Date"; REC."Requested Delivery Date")
//                 {
//                 }
//                 field("Promised Delivery Date"; REC."Promised Delivery Date")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Quote No."; REC."Quote No.")
//                 {
//                     Importance = Additional;
//                 }
//                 field("External Document No."; REC."External Document No.")
//                 {
//                     Importance = Promoted;
//                 }
//                 field("Salesperson Code"; REC."Salesperson Code")
//                 {
//                     QuickEntry = false;

//                     trigger OnValidate()
//                     begin
//                         SalespersonCodeOnAfterValidate;
//                     end;
//                 }
//                 field("Campaign No."; REC."Campaign No.")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Opportunity No."; REC."Opportunity No.")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Responsibility Center"; REC."Responsibility Center")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Assigned User ID"; REC."Assigned User ID")
//                 {
//                     Editable = false;
//                     Importance = Additional;
//                 }
//                 field("Shipment Method Code"; REC."Shipment Method Code")
//                 {
//                 }
//                 field("Job Queue Status"; REC."Job Queue Status")
//                 {
//                     Importance = Additional;
//                 }
//                 field(Status; Status)
//                 {
//                     Importance = Promoted;
//                     QuickEntry = false;
//                 }
//             }
//             part(SalesLines; 50087)
//             {
//                 SubPageLink = "Document No." = FIELD("No.");
//             }
//             group(Invoicing)
//             {
//                 Caption = 'Invoicing';
//                 field("Bill-to Customer No."; REC."Bill-to Customer No.")
//                 {
//                     Importance = Promoted;

//                     trigger OnValidate()
//                     begin
//                         BilltoCustomerNoOnAfterValidat;
//                     end;
//                 }
//                 field("Bill-to Contact No."; REC."Bill-to Contact No.")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Bill-to Name"; REC."Bill-to Name")
//                 {
//                 }
//                 field("Bill-to Address"; REC."Bill-to Address")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Bill-to Address 2"; REC."Bill-to Address 2")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Bill-to City"; REC."Bill-to City")
//                 {
//                 }
//                 field("Bill-to County"; REC."Bill-to County")
//                 {
//                 }
//                 field("Bill-to Post Code"; REC."Bill-to Post Code")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Bill-to Contact"; REC."Bill-to Contact")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Shortcut Dimension 1 Code"; REC."Shortcut Dimension 1 Code")
//                 {

//                     trigger OnValidate()
//                     begin
//                         ShortcutDimension1CodeOnAfterV;
//                     end;
//                 }
//                 field("Shortcut Dimension 2 Code"; REC."Shortcut Dimension 2 Code")
//                 {

//                     trigger OnValidate()
//                     begin
//                         ShortcutDimension2CodeOnAfterV;
//                     end;
//                 }
//                 field("Payment Terms Code"; REC."Payment Terms Code")
//                 {
//                     Importance = Promoted;
//                 }
//                 field("Due Date"; REC."Due Date")
//                 {
//                     Importance = Promoted;
//                 }
//                 field("Payment Discount %"; REC."Payment Discount %")
//                 {
//                 }
//                 field("Pmt. Discount Date"; REC."Pmt. Discount Date")
//                 {
//                 }
//                 field("Payment Method Code"; REC."Payment Method Code")
//                 {
//                 }
//                 field("Prices Including VAT"; REC."Prices Including VAT")
//                 {

//                     trigger OnValidate()
//                     begin
//                         PricesIncludingVATOnAfterValid;
//                     end;
//                 }
//                 field("VAT Bus. Posting Group"; REC."VAT Bus. Posting Group")
//                 {
//                 }
//                 field("Customer Price Group"; REC."Customer Price Group")
//                 {
//                 }
//             }
//             group(Shipping)
//             {
//                 Caption = 'Shipping';
//                 field("Ship-to Code"; REC."Ship-to Code")
//                 {
//                     Importance = Promoted;
//                 }
//                 field("Ship-to Name"; REC."Ship-to Name")
//                 {
//                 }
//                 field("Ship-to Address"; REC."Ship-to Address")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Ship-to Address 2"; REC."Ship-to Address 2")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Ship-to City"; REC."Ship-to City")
//                 {
//                 }
//                 field("Ship-to County"; REC."Ship-to County")
//                 {
//                 }
//                 field("Ship-to Post Code"; REC."Ship-to Post Code")
//                 {
//                     Importance = Promoted;
//                 }
//                 field("Ship-to Country/Region Code"; REC."Ship-to Country/Region Code")
//                 {
//                 }
//                 field("Ship-to Contact"; REC."Ship-to Contact")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Location Code"; REC."Location Code")
//                 {
//                 }
//                 field("Outbound Whse. Handling Time"; REC."Outbound Whse. Handling Time")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Shipping Agent Code"; REC."Shipping Agent Code")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Shipping Agent Service Code"; REC."Shipping Agent Service Code")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Shipping Time"; REC."Shipping Time")
//                 {
//                 }
//                 field("Late Order Shipping"; REC."Late Order Shipping")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Package Tracking No."; REC."Package Tracking No.")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Shipment Date"; REC."Shipment Date")
//                 {
//                     Importance = Promoted;
//                 }
//                 field("Shipping Advice"; REC."Shipping Advice")
//                 {
//                     Importance = Promoted;

//                     trigger OnValidate()
//                     begin
//                         IF "Shipping Advice" <> xRec."Shipping Advice" THEN
//                             IF NOT CONFIRM(Text001, FALSE, FIELDCAPTION("Shipping Advice")) THEN
//                                 ERROR(Text002);
//                     end;
//                 }
//             }
//             group("Foreign Trade")
//             {
//                 Caption = 'Foreign Trade';
//                 field("Currency Code"; REC."Currency Code")
//                 {
//                     Importance = Promoted;

//                     trigger OnAssistEdit()
//                     begin
//                         CLEAR(ChangeExchangeRate);
//                         IF "Posting Date" <> 0D THEN
//                             ChangeExchangeRate.SetParameter("Currency Code", "Currency Factor", "Posting Date")
//                         ELSE
//                             ChangeExchangeRate.SetParameter("Currency Code", "Currency Factor", WORKDATE);
//                         IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN BEGIN
//                             VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter);
//                             CurrPage.UPDATE;
//                         END;
//                         CLEAR(ChangeExchangeRate);
//                     end;

//                     trigger OnValidate()
//                     begin
//                         CurrencyCodeOnAfterValidate;
//                     end;
//                 }
//                 field("EU 3-Party Trade"; REC."EU 3-Party Trade")
//                 {
//                 }
//                 field("Transaction Type"; REC."Transaction Type")
//                 {
//                 }
//                 field("Transaction Specification"; REC."Transaction Specification")
//                 {
//                 }
//                 field("Transport Method"; REC."Transport Method")
//                 {
//                 }
//                 field("Exit Point"; REC."Exit Point")
//                 {
//                 }
//                 field(Area;Area)
//         {
//         }
//     }
//             group(Prepayment)
//             {
//                 Caption = 'Prepayment';
//                 field("Prepayment %";"Prepayment %")
//                 {
//                     Importance = Promoted;

//                     trigger OnValidate()
//                     begin
//                         Prepayment37OnAfterValidate;
//                     end;
//                 }
//                 field("Compress Prepayment";"Compress Prepayment")
//                 {
//                 }
//                 field("Prepmt. Payment Terms Code";"Prepmt. Payment Terms Code")
//                 {
//                 }
//                 field("Prepayment Due Date";"Prepayment Due Date")
//                 {
//                     Importance = Promoted;
//                 }
//                 field("Prepmt. Payment Discount %";"Prepmt. Payment Discount %")
//                 {
//                 }
//                 field("Prepmt. Pmt. Discount Date";"Prepmt. Pmt. Discount Date")
//                 {
//                 }
//             }
//         }
//         area(factboxes)
//         {
//             part(;9080)
//             {
//                 SubPageLink = "No."=FIELD("Sell-to Customer No.");
//                 Visible = true;
//             }
//             part(;9082)
//             {
//                 SubPageLink = "No."=FIELD("Bill-to Customer No.");
//                 Visible = false;
//             }
//             part(;9084)
//             {
//                 SubPageLink = No.=FIELD(Sell-to Customer No.);
//                 Visible = false;
//             }
//             part(;9087)
//             {
//                 Provider = SalesLines;
//                 SubPageLink = "Document Type"=FIELD("Document Type"),
//                               "Document No."=FIELD("Document No."),
//                               "Line No."=FIELD("Line No.");
//                 Visible = true;
//             }
//             part(;9089)
//             {
//                 Provider = SalesLines;
//                 SubPageLink = "No."=FIELD("No.");
//                 Visible = false;
//             }
//             part(;9092)
//             {
//                 SubPageLink = "Table ID"=CONST(36),
//                               "Document Type"=FIELD("Document Type"),
//                               "Document No."=FIELD("No.");
//                 Visible = false;
//             }
//             part(;9108)
//             {
//                 Provider = SalesLines;
//                 SubPageLink = "No."=FIELD("No.");
//                 Visible = false;
//             }
//             part(;9109)
//             {
//                 Provider = SalesLines;
//                 SubPageLink = "No."=FIELD("No.");
//                 Visible = false;
//             }
//             part(;9081)
//             {
//                 SubPageLink = "No."=FIELD("Bill-to Customer No.");
//                 Visible = false;
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
//             group("O&rder")
//             {
//                 Caption = 'O&rder';
//                 Image = "Order";
//                 action(Statistics)
//                 {
//                     Caption = 'Statistics';
//                     Image = Statistics;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     ShortCutKey = 'F7';

//                     trigger OnAction()
//                     begin
//                         CalcInvDiscForHeader;
//                         COMMIT;
//                         PAGE.RUNMODAL(PAGE::"Sales Order Statistics",Rec);
//                     end;
//                 }
//                 action(Card)
//                 {
//                     Caption = 'Card';
//                     Image = EditLines;
//                     RunObject = Page 21;
//                                     RunPageLink =" No."=FIELD("Sell-to Customer No.");
//                     ShortCutKey = 'Shift+F7';
//                 }
//                 action(Dimensions)
//                 {
//                     Caption = 'Dimensions';
//                     Image = Dimensions;
//                     ShortCutKey = 'Shift+Ctrl+D';

//                     trigger OnAction()
//                     begin
//                         ShowDocDim;
//                         CurrPage.SAVERECORD;
//                     end;
//                 }
//                 action("A&pprovals")
//                 {
//                     Caption = 'A&pprovals';
//                     Image = Approvals;

//                     trigger OnAction()
//                     var
//                         ApprovalEntries: Page "658";
//                     begin
//                         ApprovalEntries.Setfilters(DATABASE::"Sales Header","Document Type","No.");
//                         ApprovalEntries.RUN;
//                     end;
//                 }
//                 action("Co&mments")
//                 {
//                     Caption = 'Co&mments';
//                     Image = ViewComments;
//                     RunObject = Page 67;
//                                     RunPageLink = Document Type=FIELD(Document Type),
//                                   No.=FIELD(No.),
//                                   Document Line No.=CONST(0);
//                 }
//                 action("Credit Cards Transaction Lo&g Entries")
//                 {
//                     Caption = 'Credit Cards Transaction Lo&g Entries';
//                     Image = CreditCardLog;
//                     RunObject = Page 829;
//                                     RunPageLink = Field3=FIELD(No.),
//                                   Field4=FIELD(Bill-to Customer No.);
//                 }
//                 action("Assembly Orders")
//                 {
//                     Caption = 'Assembly Orders';
//                     Image = AssemblyOrder;

//                     trigger OnAction()
//                     var
//                         AssembleToOrderLink: Record "904";
//                     begin
//                         AssembleToOrderLink.ShowAsmOrders(Rec);
//                     end;
//                 }
//             }
//             group(Documents)
//             {
//                 Caption = 'Documents';
//                 Image = Documents;
//                 action("S&hipments")
//                 {
//                     Caption = 'S&hipments';
//                     Image = Shipment;
//                     RunObject = Page 142;
//                                     RunPageLink = Order No.=FIELD(No.);
//                     RunPageView = SORTING(Order No.);
//                 }
//                 action(Invoices)
//                 {
//                     Caption = 'Invoices';
//                     Image = Invoice;
//                     RunObject = Page 143;
//                                     RunPageLink = Order No.=FIELD(No.);
//                     RunPageView = SORTING(Order No.);
//                 }
//             }
//             group(Warehouse)
//             {
//                 Caption = 'Warehouse';
//                 Image = Warehouse;
//                 action("In&vt. Put-away/Pick Lines")
//                 {
//                     Caption = 'In&vt. Put-away/Pick Lines';
//                     Image = PickLines;
//                     RunObject = Page 5774;
//                                     RunPageLink = Source Document=CONST(Sales Order),
//                                   Source No.=FIELD(No.);
//                     RunPageView = SORTING(Source Document,Source No.,Location Code);
//                 }
//                 action("Whse. Shipment Lines")
//                 {
//                     Caption = 'Whse. Shipment Lines';
//                     Image = ShipmentLines;
//                     RunObject = Page 7341;
//                                     RunPageLink = Source Type=CONST(37),
//                                   Source Subtype=FIELD(Document Type),
//                                   Source No.=FIELD(No.);
//                     RunPageView = SORTING(Source Type,Source Subtype,Source No.,Source Line No.);
//                 }
//             }
//             group(Prepayment)
//             {
//                 Caption = 'Prepayment';
//                 Image = Prepayment;
//                 action("Prepa&yment Invoices")
//                 {
//                     Caption = 'Prepa&yment Invoices';
//                     Image = PrepaymentInvoice;
//                     RunObject = Page 143;
//                                     RunPageLink = Prepayment Order No.=FIELD(No.);
//                     RunPageView = SORTING(Prepayment Order No.);
//                 }
//                 action("Prepayment Credi&t Memos")
//                 {
//                     Caption = 'Prepayment Credi&t Memos';
//                     Image = PrepaymentCreditMemo;
//                     RunObject = Page 144;
//                                     RunPageLink = Prepayment Order No.=FIELD(No.);
//                     RunPageView = SORTING(Prepayment Order No.);
//                 }
//             }
//         }
//         area(processing)
//         {
//             group(Release)
//             {
//                 Caption = 'Release';
//                 Image = ReleaseDoc;
//                 action(Release)
//                 {
//                     Caption = 'Re&lease';
//                     Image = ReleaseDoc;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     ShortCutKey = 'Ctrl+F9';

//                     trigger OnAction()
//                     var
//                         ReleaseSalesDoc: Codeunit "414";
//                     begin
//                         //ReleaseSalesDoc.PerformManualRelease(Rec);

//                         //Code added in upgradation
//                         //alok for mandatory salesperson code
//                         IF COMPANYNAME <> 'Medicareplus International' THEN//alok for posting opening
//                         IF "Salesperson Code"='' THEN BEGIN
//                          ERROR(Text0013,"Document Type","No.");
//                         END;
//                         //alok finish
//                         IF ApprovalMgt.TestSalesPrepayment(Rec) THEN
//                           ERROR(STRSUBSTNO(Text0011,"Document Type","No."))
//                         ELSE BEGIN
//                           IF ApprovalMgt.TestSalesPayment(Rec) THEN BEGIN
//                             IF NOT CONFIRM(STRSUBSTNO(Text0012,"Document Type","No.")) THEN
//                               EXIT;
//                             Status := Status::"Pending Prepayment";
//                             MODIFY;
//                             //CurrForm.UPDATE;
//                             CurrPage.UPDATE;
//                           END ELSE
//                             ReleaseSalesDoc.PerformManualRelease(Rec);
//                         END;
//                     end;
//                 }
//                 action("Re&open")
//                 {
//                     Caption = 'Re&open';
//                     Image = ReOpen;
//                     Promoted = true;
//                     PromotedCategory = Process;

//                     trigger OnAction()
//                     var
//                         ReleaseSalesDoc: Codeunit "414";
//                     begin
//                         ReleaseSalesDoc.PerformManualReopen(Rec);
//                     end;
//                 }
//             }
//             group("F&unctions")
//             {
//                 Caption = 'F&unctions';
//                 Image = "Action";
//                 action("Calculate &Invoice Discount")
//                 {
//                     Caption = 'Calculate &Invoice Discount';
//                     Image = CalculateInvoiceDiscount;

//                     trigger OnAction()
//                     begin
//                         ApproveCalcInvDisc;
//                     end;
//                 }
//                 action("Get St&d. Cust. Sales Codes")
//                 {
//                     Caption = 'Get St&d. Cust. Sales Codes';
//                     Ellipsis = true;
//                     Image = CustomerCode;

//                     trigger OnAction()
//                     var
//                         StdCustSalesCode: Record "172";
//                     begin
//                         StdCustSalesCode.InsertSalesLines(Rec);
//                     end;
//                 }
//                 action(CopyDocument)
//                 {
//                     Caption = 'Copy Document';
//                     Ellipsis = true;
//                     Image = CopyDocument;
//                     Promoted = true;
//                     PromotedCategory = Process;

//                     trigger OnAction()
//                     begin
//                         CopySalesDoc.SetSalesHeader(Rec);
//                         CopySalesDoc.RUNMODAL;
//                         CLEAR(CopySalesDoc);
//                     end;
//                 }
//                 action("Move Negative Lines")
//                 {
//                     Caption = 'Move Negative Lines';
//                     Ellipsis = true;
//                     Image = MoveNegativeLines;

//                     trigger OnAction()
//                     begin
//                         CLEAR(MoveNegSalesLines);
//                         MoveNegSalesLines.SetSalesHeader(Rec);
//                         MoveNegSalesLines.RUNMODAL;
//                         MoveNegSalesLines.ShowDocument;
//                     end;
//                 }
//                 action("Archive Document")
//                 {
//                     Caption = 'Archi&ve Document';
//                     Image = Archive;

//                     trigger OnAction()
//                     begin
//                         ArchiveManagement.ArchiveSalesDocument(Rec);
//                         CurrPage.UPDATE(FALSE);
//                     end;
//                 }
//                 action("Send IC Sales Order Cnfmn.")
//                 {
//                     Caption = 'Send IC Sales Order Cnfmn.';
//                     Image = IntercompanyOrder;

//                     trigger OnAction()
//                     var
//                         ICInOutboxMgt: Codeunit "427";
//                         ApprovalMgt: Codeunit "439";
//                         PurchaseHeader: Record "38";
//                     begin
//                         IF ApprovalMgt.PrePostApprovalCheck(Rec,PurchaseHeader) THEN
//                           ICInOutboxMgt.SendSalesDoc(Rec,FALSE);
//                     end;
//                 }
//             }
//             group(Plan)
//             {
//                 Caption = 'Plan';
//                 Image = Planning;
//                 action("Order &Promising")
//                 {
//                     Caption = 'Order &Promising';
//                     Image = OrderPromising;

//                     trigger OnAction()
//                     var
//                         OrderPromisingLine: Record "99000880" temporary;
//                     begin
//                         OrderPromisingLine.SETRANGE("Source Type","Document Type");
//                         OrderPromisingLine.SETRANGE("Source ID","No.");
//                         PAGE.RUNMODAL(PAGE::"Order Promising Lines",OrderPromisingLine);
//                     end;
//                 }
//                 action("Demand Overview")
//                 {
//                     Caption = 'Demand Overview';
//                     Image = Forecast;

//                     trigger OnAction()
//                     var
//                         DemandOverview: Page "5830";
//                     begin
//                         DemandOverview.SetCalculationParameter(TRUE);
//                         DemandOverview.Initialize(0D,1,"No.",'','');
//                         DemandOverview.RUNMODAL;
//                     end;
//                 }
//                 action("Pla&nning")
//                 {
//                     Caption = 'Pla&nning';
//                     Image = Planning;

//                     trigger OnAction()
//                     var
//                         SalesPlanForm: Page "99000883";
//                     begin
//                         SalesPlanForm.SetSalesOrder("No.");
//                         SalesPlanForm.RUNMODAL;
//                     end;
//                 }
//             }
//             group(Request)
//             {
//                 Caption = 'Request';
//                 Image = SendApprovalRequest;
//                 action("Send A&pproval Request")
//                 {
//                     Caption = 'Send A&pproval Request';
//                     Image = SendApprovalRequest;

//                     trigger OnAction()
//                     var
//                         ApprovalMgt: Codeunit "439";
//                     begin
//                         IF ApprovalMgt.SendSalesApprovalRequest(Rec) THEN;
//                     end;
//                 }
//                 action("Cancel Approval Re&quest")
//                 {
//                     Caption = 'Cancel Approval Re&quest';
//                     Image = Cancel;

//                     trigger OnAction()
//                     var
//                         ApprovalMgt: Codeunit "439";
//                     begin
//                         IF ApprovalMgt.CancelSalesApprovalRequest(Rec,TRUE,TRUE) THEN;
//                     end;
//                 }
//             }
//             group(Warehouse)
//             {
//                 Caption = 'Warehouse';
//                 Image = Warehouse;
//                 action("Create Inventor&y Put-away / Pick")
//                 {
//                     Caption = 'Create Inventor&y Put-away / Pick';
//                     Ellipsis = true;
//                     Image = CreateInventoryPickup;
//                     Promoted = true;
//                     PromotedCategory = Process;

//                     trigger OnAction()
//                     begin
//                         CreateInvtPutAwayPick;

//                         IF NOT FIND('=><') THEN
//                           INIT;
//                     end;
//                 }
//                 action("Create &Whse. Shipment")
//                 {
//                     Caption = 'Create &Whse. Shipment';
//                     Image = NewShipment;

//                     trigger OnAction()
//                     var
//                         GetSourceDocOutbound: Codeunit "5752";
//                     begin
//                         GetSourceDocOutbound.CreateFromSalesOrder(Rec);

//                         IF NOT FIND('=><') THEN
//                           INIT;
//                     end;
//                 }
//             }
//             group("P&osting")
//             {
//                 Caption = 'P&osting';
//                 Image = Post;
//                 action(Post)
//                 {
//                     Caption = 'P&ost';
//                     Ellipsis = true;
//                     Image = PostOrder;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     PromotedIsBig = true;
//                     ShortCutKey = 'F9';

//                     trigger OnAction()
//                     begin
//                         Post(CODEUNIT::"Sales-Post (Yes/No)");
//                     end;
//                 }
//                 action("Post and &Print")
//                 {
//                     Caption = 'Post and &Print';
//                     Ellipsis = true;
//                     Image = PostPrint;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     PromotedIsBig = true;
//                     ShortCutKey = 'Shift+F9';

//                     trigger OnAction()
//                     begin
//                         Post(CODEUNIT::"Sales-Post + Print");
//                     end;
//                 }
//                 action("Test Report")
//                 {
//                     Caption = 'Test Report';
//                     Ellipsis = true;
//                     Image = TestReport;

//                     trigger OnAction()
//                     begin
//                         ReportPrint.PrintSalesHeader(Rec);
//                     end;
//                 }
//                 action("Post &Batch")
//                 {
//                     Caption = 'Post &Batch';
//                     Ellipsis = true;
//                     Image = PostBatch;

//                     trigger OnAction()
//                     begin
//                         REPORT.RUNMODAL(REPORT::"Batch Post Sales Orders",TRUE,TRUE,Rec);
//                         CurrPage.UPDATE(FALSE);
//                     end;
//                 }
//                 action("Remove From Job Queue")
//                 {
//                     Caption = 'Remove From Job Queue';
//                     Image = RemoveLine;
//                     Visible = JobQueueVisible;

//                     trigger OnAction()
//                     begin
//                         CancelBackgroundPosting;
//                     end;
//                 }
//                 group("Prepa&yment")
//                 {
//                     Caption = 'Prepa&yment';
//                     Image = Prepayment;
//                     action("Prepayment &Test Report")
//                     {
//                         Caption = 'Prepayment &Test Report';
//                         Ellipsis = true;
//                         Image = PrepaymentSimulation;

//                         trigger OnAction()
//                         begin
//                             ReportPrint.PrintSalesHeaderPrepmt(Rec);
//                         end;
//                     }
//                     action(PostPrepaymentInvoice)
//                     {
//                         Caption = 'Post Prepayment &Invoice';
//                         Ellipsis = true;
//                         Image = PrepaymentPost;

//                         trigger OnAction()
//                         var
//                             PurchaseHeader: Record "38";
//                             SalesPostYNPrepmt: Codeunit "443";
//                         begin
//                             IF ApprovalMgt.PrePostApprovalCheck(Rec,PurchaseHeader) THEN
//                               SalesPostYNPrepmt.PostPrepmtInvoiceYN(Rec,FALSE);
//                         end;
//                     }
//                     action("Post and Print Prepmt. Invoic&e")
//                     {
//                         Caption = 'Post and Print Prepmt. Invoic&e';
//                         Ellipsis = true;
//                         Image = PrepaymentPostPrint;

//                         trigger OnAction()
//                         var
//                             PurchaseHeader: Record "38";
//                             SalesPostYNPrepmt: Codeunit "443";
//                         begin
//                             IF ApprovalMgt.PrePostApprovalCheck(Rec,PurchaseHeader) THEN
//                               SalesPostYNPrepmt.PostPrepmtInvoiceYN(Rec,TRUE);
//                         end;
//                     }
//                     action(PostPrepaymentCreditMemo)
//                     {
//                         Caption = 'Post Prepayment &Credit Memo';
//                         Ellipsis = true;
//                         Image = PrepaymentPost;

//                         trigger OnAction()
//                         var
//                             PurchaseHeader: Record "38";
//                             SalesPostYNPrepmt: Codeunit "443";
//                         begin
//                             IF ApprovalMgt.PrePostApprovalCheck(Rec,PurchaseHeader) THEN
//                               SalesPostYNPrepmt.PostPrepmtCrMemoYN(Rec,FALSE);
//                         end;
//                     }
//                     action("Post and Print Prepmt. Cr. Mem&o")
//                     {
//                         Caption = 'Post and Print Prepmt. Cr. Mem&o';
//                         Ellipsis = true;
//                         Image = PrepaymentPostPrint;

//                         trigger OnAction()
//                         var
//                             PurchaseHeader: Record "38";
//                             SalesPostYNPrepmt: Codeunit "443";
//                         begin
//                             IF ApprovalMgt.PrePostApprovalCheck(Rec,PurchaseHeader) THEN
//                               SalesPostYNPrepmt.PostPrepmtCrMemoYN(Rec,TRUE);
//                         end;
//                     }
//                 }
//             }
//             group("&Print")
//             {
//                 Caption = '&Print';
//                 Image = Print;
//                 action("Order Profit")
//                 {
//                     Caption = 'Order Profit';

//                     trigger OnAction()
//                     begin
//                         SaleshdrRec.RESET;
//                         SaleshdrRec.SETRANGE(SaleshdrRec."Document Type","Document Type");
//                         SaleshdrRec.SETRANGE(SaleshdrRec."No.","No.");
//                         IF SaleshdrRec.FINDFIRST THEN
//                         BEGIN
//                           REPORT.RUNMODAL(REPORT::"Sales Order Line Wise Manish1",TRUE,FALSE,SaleshdrRec);
//                         END;
//                     end;
//                 }
//                 action("Order Confirmation")
//                 {
//                     Caption = 'Order Confirmation';
//                     Ellipsis = true;
//                     Image = Print;

//                     trigger OnAction()
//                     begin
//                         DocPrint.PrintSalesOrder(Rec,Usage::"Order Confirmation");
//                     end;
//                 }
//                 action("Work Order")
//                 {
//                     Caption = 'Work Order';
//                     Ellipsis = true;
//                     Image = Print;

//                     trigger OnAction()
//                     begin
//                         DocPrint.PrintSalesOrder(Rec,Usage::"Work Order");
//                     end;
//                 }
//                 action("Pick Instruction")
//                 {
//                     Caption = 'Pick Instruction';
//                     Image = Print;

//                     trigger OnAction()
//                     begin
//                         DocPrint.PrintSalesOrder(Rec,Usage::"Pick Instruction");
//                     end;
//                 }
//                 action("Proforma Invoice")
//                 {
//                     Caption = 'Proforma Invoice';
//                     Promoted = true;
//                     PromotedIsBig = true;

//                     trigger OnAction()
//                     begin
//                           CLEAR(ProformaInvoice);
//                           SalesHeader.SETRANGE(SalesHeader."Document Type","Document Type");
//                           SalesHeader.SETRANGE(SalesHeader."No.","No.");
//                           ProformaInvoice.SETTABLEVIEW(SalesHeader);
//                           ProformaInvoice.RUNMODAL;
//                           CurrPage.UPDATE(FALSE);
//                     end;
//                 }
//                 action("Email Proforma Invoice as Attachment")
//                 {
//                     Caption = 'Email Proforma Invoice as Attachment';
//                     Image = Email;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     PromotedIsBig = true;

//                     trigger OnAction()
//                     var
//                         Mail: Codeunit "397";
//                         Name: Text[100];
//                         FileName: Text[250];
//                         ToFile: Text[250];
//                         ReportHelper: Codeunit "50099";
//                     begin
//                         CurrPage.SETSELECTIONFILTER(Rec);
//                         Name := STRSUBSTNO('Proforma Invoice No. %1.pdf', "No.");
//                         ToFile := Name;
//                         FileName := TEMPORARYPATH + ToFile;
//                         REPORT.SAVEASPDF(REPORT::"Sales - Quot  Proforma Invoice", FileName, Rec);
//                         ToFile := ReportHelper.DownloadToClientFileName(FileName, ToFile);
//                         //Mail.NewMessage('','',Name,'',ToFile,TRUE);
//                         FILE.ERASE(FileName);
//                     end;
//                 }
//             }
//         }
//     }

//     trigger OnAfterGetRecord()
//     begin
//         JobQueueVisible := "Job Queue Status" = "Job Queue Status"::"Scheduled for Posting";
//     end;

//     trigger OnDeleteRecord(): Boolean
//     begin
//         CurrPage.SAVERECORD;
//         EXIT(ConfirmDeletion);
//     end;

//     trigger OnInsertRecord(BelowxRec: Boolean): Boolean
//     begin
//         CheckCreditMaxBeforeInsert;
//     end;

//     trigger OnNewRecord(BelowxRec: Boolean)
//     begin
//         "Responsibility Center" := UserMgt.GetSalesFilter;
//     end;

//     trigger OnOpenPage()
//     begin
//         IF UserMgt.GetSalesFilter <> '' THEN BEGIN
//           FILTERGROUP(2);
//           SETRANGE("Responsibility Center",UserMgt.GetSalesFilter);
//           FILTERGROUP(0);
//         END;

//         SETRANGE("Date Filter",0D,WORKDATE - 1);
//     end;

//     var
//         Text000: Label 'Unable to execute this function while in view only mode.';
//         CopySalesDoc: Report 292;
//                           MoveNegSalesLines: Report 6699;
//                           ApprovalMgt: Codeunit 439;
//                           ReportPrint: Codeunit 228;
//                           DocPrint: Codeunit 229;
//                           ArchiveManagement: Codeunit 5063;
//                           ChangeExchangeRate: Page 511;
//                           UserMgt: Codeunit 5700;
//                           Usage: Option "Order Confirmation","Work Order","Pick Instruction";
//     [InDataSet]

//     JobQueueVisible: Boolean;
//     Text001: Label 'Do you want to change %1 in all related records in the warehouse?';
//     Text002: Label 'The update has been interrupted to respect the warning.';
//     Text0011: Label 'There are non posted Prepayment Amounts on %1 %2.';
//     Text0012: Label 'There are unpaid Prepayment Invoices related to %1 %2.';
//     Text0013: Label 'You must specify Salesperson Code in Sales Header Document Type=''%1'',No.=''%2''';
//     SaleshdrRec: Record 36;
//     ProformaInvoice: Report "50028";
//     SalesHeader: Record 36;

// local procedure Post(PostingCodeunitID: Integer)
//     begin
//         SendToPosting(PostingCodeunitID);
//         IF "Job Queue Status" = "Job Queue Status"::"Scheduled for Posting" THEN
//           CurrPage.CLOSE;
//         CurrPage.UPDATE(FALSE);
//     end;

//     procedure UpdateAllowed(): Boolean
//     begin
//         IF CurrPage.EDITABLE = FALSE THEN
//           ERROR(Text000);
//         EXIT(TRUE);
//     end;

//     local procedure ApproveCalcInvDisc()
//     begin
//         CurrPage.SalesLines.PAGE.ApproveCalcInvDisc;
//     end;

//     local procedure SelltoCustomerNoOnAfterValidat()
//     begin
//         IF GETFILTER("Sell-to Customer No.") = xRec."Sell-to Customer No." THEN
//           IF "Sell-to Customer No." <> xRec."Sell-to Customer No." THEN
//             SETRANGE("Sell-to Customer No.");
//         CurrPage.UPDATE;
//     end;

//     local procedure SalespersonCodeOnAfterValidate()
//     begin
//         CurrPage.SalesLines.PAGE.UpdateForm(TRUE);
//     end;

//     local procedure BilltoCustomerNoOnAfterValidat()
//     begin
//         CurrPage.UPDATE;
//     end;

//     local procedure ShortcutDimension1CodeOnAfterV()
//     begin
//         CurrPage.SalesLines.PAGE.UpdateForm(TRUE);
//     end;

//     local procedure ShortcutDimension2CodeOnAfterV()
//     begin
//         CurrPage.SalesLines.PAGE.UpdateForm(TRUE);
//     end;

//     local procedure PricesIncludingVATOnAfterValid()
//     begin
//         CurrPage.UPDATE;
//     end;

//     local procedure CurrencyCodeOnAfterValidate()
//     begin
//         CurrPage.SalesLines.PAGE.UpdateForm(TRUE);
//     end;

//     local procedure Prepayment37OnAfterValidate()
//     begin
//         CurrPage.UPDATE;
//     end;
// }

