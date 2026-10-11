page 60032 "Sales Order WS-Web"
{
    // version NAVW17.00,NAVGB7.00

    // <changelog>
    //   <remove id="GB0001" dev="TMARTI" date="2007-06-14" area="UKGEN"  request="UK-START-51"
    //     baseversion="GB4.00" releaseversion="GB6.00">C/Track cleanup</remove>
    //   <add id="GB0002" dev="TMARTI" date="2004-06-14" area="DOCLAY"  request="UK-START-51"
    //     releaseversion="GB6.00">UK Address format</add>
    //   <change id="GB0003" dev="KCOOLS" date="2008-11-10" area="DOCLAY" feature="NAVCORS31337"
    //     baseversion="GB6.00" releaseversion="GB6.00.01">GB address labels not correctly transformed in RTC</change>
    //   <add id="GB0147" dev="TMARTI" date="2004-07-25" area="UKGEN"  request="UK-START-40"
    //     releaseversion="GB4.00">localized object</add>
    // </changelog>

    Caption = 'Sales Order';
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = "Sales Header";
    SourceTableView = WHERE("Document Type" = FILTER(Order));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; REC."No.")
                {
                    ApplicationArea = All;
                    Importance = Promoted;

                    trigger OnAssistEdit()
                    begin
                        IF REC.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Sell-to Customer No."; REC."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        SelltoCustomerNoOnAfterValidat;
                    end;
                }
                field("Sell-to Contact No."; REC."Sell-to Contact No.")
                {
                    ApplicationArea = All;
                    Importance = Additional;

                    trigger OnValidate()
                    begin
                        IF REC.GETFILTER("Sell-to Contact No.") = xRec."Sell-to Contact No." THEN
                            IF REC."Sell-to Contact No." <> xRec."Sell-to Contact No." THEN
                                REC.SETRANGE("Sell-to Contact No.");
                    end;
                }
                field("Sell-to Customer Name"; REC."Sell-to Customer Name")
                {
                    ApplicationArea = All;
                    QuickEntry = false;
                }
                field("Sell-to Address"; REC."Sell-to Address")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Sell-to Address 2"; REC."Sell-to Address 2")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Sell-to City"; REC."Sell-to City")
                {
                    ApplicationArea = All;
                }
                field("Sell-to County"; REC."Sell-to County")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Post Code"; REC."Sell-to Post Code")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Sell-to Contact"; REC."Sell-to Contact")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("No. of Archived Versions"; REC."No. of Archived Versions")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Posting Date"; REC."Posting Date")
                {
                    ApplicationArea = All;
                    QuickEntry = false;
                }
                field("Order Date"; REC."Order Date")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    QuickEntry = false;
                }
                field("Document Date"; REC."Document Date")
                {
                    ApplicationArea = All;
                    QuickEntry = false;
                }
                field("Requested Delivery Date"; REC."Requested Delivery Date")
                {
                    ApplicationArea = All;
                }
                field("Promised Delivery Date"; REC."Promised Delivery Date")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Quote No."; REC."Quote No.")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("External Document No."; REC."External Document No.")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Salesperson Code"; REC."Salesperson Code")
                {
                    ApplicationArea = All;
                    QuickEntry = false;

                    trigger OnValidate()
                    begin
                        SalespersonCodeOnAfterValidate;
                    end;
                }
                field("Campaign No."; REC."Campaign No.")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Opportunity No."; REC."Opportunity No.")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Responsibility Center"; REC."Responsibility Center")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Assigned User ID"; REC."Assigned User ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Importance = Additional;
                }
                field("Shipment Method Code"; REC."Shipment Method Code")
                {
                    ApplicationArea = All;
                }
                field("Job Queue Status"; REC."Job Queue Status")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field(Status; REC.Status)
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    QuickEntry = false;
                }
            }
            part(SalesLines; 60030)
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No.");
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                field("Bill-to Customer No."; REC."Bill-to Customer No.")
                {
                    ApplicationArea = All;
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        BilltoCustomerNoOnAfterValidat;
                    end;
                }
                field("Bill-to Contact No."; REC."Bill-to Contact No.")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Bill-to Name"; REC."Bill-to Name")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Address"; REC."Bill-to Address")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Bill-to Address 2"; REC."Bill-to Address 2")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Bill-to City"; REC."Bill-to City")
                {
                    ApplicationArea = All;
                }
                field("Bill-to County"; REC."Bill-to County")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Post Code"; REC."Bill-to Post Code")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Bill-to Contact"; REC."Bill-to Contact")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Shortcut Dimension 1 Code"; REC."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        ShortcutDimension1CodeOnAfterV;
                    end;
                }
                field("Shortcut Dimension 2 Code"; REC."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        ShortcutDimension2CodeOnAfterV;
                    end;
                }
                field("Payment Terms Code"; REC."Payment Terms Code")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Due Date"; REC."Due Date")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Payment Discount %"; REC."Payment Discount %")
                {
                    ApplicationArea = All;
                }
                field("Pmt. Discount Date"; REC."Pmt. Discount Date")
                {
                    ApplicationArea = All;
                }
                field("Payment Method Code"; REC."Payment Method Code")
                {
                    ApplicationArea = All;
                }
                field("Prices Including VAT"; REC."Prices Including VAT")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        PricesIncludingVATOnAfterValid;
                    end;
                }
                field("VAT Bus. Posting Group"; REC."VAT Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Customer Price Group"; REC."Customer Price Group")
                {
                    ApplicationArea = All;
                }
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                field("Ship-to Code"; REC."Ship-to Code")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Ship-to Name"; REC."Ship-to Name")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Address"; REC."Ship-to Address")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Ship-to Address 2"; REC."Ship-to Address 2")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Ship-to City"; REC."Ship-to City")
                {
                    ApplicationArea = All;
                }
                field("Ship-to County"; REC."Ship-to County")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Post Code"; REC."Ship-to Post Code")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Ship-to Country/Region Code"; REC."Ship-to Country/Region Code")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Contact"; REC."Ship-to Contact")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Location Code"; REC."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Outbound Whse. Handling Time"; REC."Outbound Whse. Handling Time")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Shipping Agent Code"; REC."Shipping Agent Code")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Shipping Agent Service Code"; REC."Shipping Agent Service Code")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Shipping Time"; REC."Shipping Time")
                {
                    ApplicationArea = All;
                }
                field("Late Order Shipping"; REC."Late Order Shipping")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Package Tracking No."; REC."Package Tracking No.")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Shipment Date"; REC."Shipment Date")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Shipping Advice"; REC."Shipping Advice")
                {
                    ApplicationArea = All;
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        IF REC."Shipping Advice" <> xRec."Shipping Advice" THEN
                            IF NOT CONFIRM(Text001, FALSE, REC.FIELDCAPTION("Shipping Advice")) THEN
                                ERROR(Text002);
                    end;
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                field("Currency Code"; REC."Currency Code")
                {
                    ApplicationArea = All;
                    Importance = Promoted;

                    trigger OnAssistEdit()
                    begin
                        CLEAR(ChangeExchangeRate);
                        IF REC."Posting Date" <> 0D THEN
                            ChangeExchangeRate.SetParameter(REC."Currency Code", REC."Currency Factor", REC."Posting Date")
                        ELSE
                            ChangeExchangeRate.SetParameter(REC."Currency Code", REC."Currency Factor", WORKDATE);
                        IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN BEGIN
                            REC.VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter);
                            CurrPage.UPDATE;
                        END;
                        CLEAR(ChangeExchangeRate);
                    end;

                    trigger OnValidate()
                    begin
                        CurrencyCodeOnAfterValidate;
                    end;
                }
                field("EU 3-Party Trade"; REC."EU 3-Party Trade")
                {
                    ApplicationArea = All;
                }
                field("Transaction Type"; REC."Transaction Type")
                {
                    ApplicationArea = All;
                }
                field("Transaction Specification"; REC."Transaction Specification")
                {
                    ApplicationArea = All;
                }
                field("Transport Method"; REC."Transport Method")
                {
                    ApplicationArea = All;
                }
                field("Exit Point"; REC."Exit Point")
                {
                    ApplicationArea = All;
                }
                field("Area";REC."Area")
        {
            ApplicationArea = All;
        }
    }
            group(Prepayment)
            {
                Caption = 'Prepayment';
                field("Prepayment %";REC."Prepayment %")
                {
                    ApplicationArea = All;
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        Prepayment37OnAfterValidate;
                    end;
                }
                field("Compress Prepayment";REC."Compress Prepayment")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. Payment Terms Code";REC."Prepmt. Payment Terms Code")
                {
                    ApplicationArea = All;
                }
                field("Prepayment Due Date";REC."Prepayment Due Date")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Prepmt. Payment Discount %";REC."Prepmt. Payment Discount %")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. Pmt. Discount Date";REC."Prepmt. Pmt. Discount Date")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            part(Control9080; "Sales Hist. Sell-to FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("Sell-to Customer No.");
                Visible = true;
            }
            part(Control9082; "Customer Statistics FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("Bill-to Customer No.");
                Visible = false;
            }
            part(Control9084; "Customer Details FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("Sell-to Customer No.");
                Visible = false;
            }
            part(Control9087; "Sales Line FactBox")
            {
                ApplicationArea = All;
                Provider = SalesLines;
                SubPageLink = "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("Document No."),
                              "Line No." = FIELD("Line No.");
                Visible = true;
            }
            part(Control9089; "Item Invoicing FactBox")
            {
                ApplicationArea = All;
                Provider = SalesLines;
                SubPageLink = "No." = FIELD("No.");
                Visible = false;
            }
            part(Control9092; "Approval FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Table ID" = CONST(36),
                              "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("No.");
                Visible = false;
            }
            part(Control9108; "Resource Details FactBox")
            {
                ApplicationArea = All;
                Provider = SalesLines;
                SubPageLink = "No." = FIELD("No.");
                Visible = false;
            }
            part(Control9109; "Item Warehouse FactBox")
            {
                ApplicationArea = All;
                Provider = SalesLines;
                SubPageLink = "No." = FIELD("No.");
                Visible = false;
            }
            part(Control9081; "Sales Hist. Bill-to FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("Bill-to Customer No.");
                Visible = false;
            }
            systempart(Control1900383207; Links)
            {
                ApplicationArea = All;
                Visible = false;
            }
            systempart(Control1905902307; Notes)
            {
                ApplicationArea = All;
                Visible = true;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("O&rder")
            {
                Caption = 'O&rder';
                Image = "Order";
                action(Statistics)
                {
                    ApplicationArea = All;
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';

                    trigger OnAction()
                    begin
                        REC.CalcInvDiscForHeader;
                        COMMIT;
                        PAGE.RUNMODAL(PAGE::"Sales Order Statistics", Rec);
                    end;
                }
                action(Card)
                {
                    ApplicationArea = All;
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = page "Customer Card";
                    RunPageLink = "No." = FIELD("Sell-to Customer No.");
                    ShortCutKey = 'Shift+F7';
                }
                action(Dimensions)
                {
                    ApplicationArea = All;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        REC.ShowDocDim;
                        CurrPage.SAVERECORD;
                    end;
                }
                action("A&pprovals")
                {
                    ApplicationArea = All;
                    Caption = 'A&pprovals';
                    Image = Approvals;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        // Setfilters was replaced by SetRecordFilters; Enum "Sales Document Type" converts to Enum "Approval Document Type" automatically since both enums declare AssignmentCompatibility with matching member names (Quote, Order, Invoice, Credit Memo, Blanket Order, Return Order).
                        ApprovalEntries.SetRecordFilters(DATABASE::"Sales Header", REC."Document Type", REC."No.");
                        ApprovalEntries.RUN;
                    end;
                }
                action("Co&mments")
                {
                    ApplicationArea = All;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Sales Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                }
                // action("Credit Cards Transaction Lo&g Entries")
                // {
                //     Caption = 'Credit Cards Transaction Lo&g Entries';
                //     Image = CreditCardLog;
                //     // TODO: verify object name for ID 829 (old "Credit Cards Transaction Log Entries" page) - no equivalent object exists in BC 27 Base Application; this NAV-era Credit Card functionality appears to have been removed. RunObject left unresolved pending confirmation of replacement/ISV source.
                //     RunObject = Page 829;
                //     RunPageLink = "Field3" = FIELD("No."),
                //                   "Field4" = FIELD("Bill-to Customer No.");
                // }
                action("Assembly Orders")
                {
                    ApplicationArea = All;
                    Caption = 'Assembly Orders';
                    Image = AssemblyOrder;

                    trigger OnAction()
                    var
                        AssembleToOrderLink: Record "Assemble-to-Order Link";
                    begin
                        AssembleToOrderLink.ShowAsmOrders(Rec);
                    end;
                }
            }
            group(Documents)
            {
                Caption = 'Documents';
                Image = Documents;
                action("S&hipments")
                {
                    ApplicationArea = All;
                    Caption = 'S&hipments';
                    Image = Shipment;
                    RunObject = Page "Posted Sales Shipments";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                }
                action(Invoices)
                {
                    ApplicationArea = All;
                    Caption = 'Invoices';
                    Image = Invoice;
                    RunObject = Page "Posted Sales Invoices";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                }
            }
            group(Group_Warehouse)
            {
                Caption = 'Warehouse';
                Image = Warehouse;
                action("In&vt. Put-away/Pick Lines")
                {
                    ApplicationArea = All;
                    Caption = 'In&vt. Put-away/Pick Lines';
                    Image = PickLines;
                    RunObject = Page "Warehouse Activity List";
                    RunPageLink = "Source Document" = CONST("Sales Order"),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Document", "Source No.", "Location Code");
                }
                action("Whse. Shipment Lines")
                {
                    ApplicationArea = All;
                    Caption = 'Whse. Shipment Lines';
                    Image = ShipmentLines;
                    RunObject = Page "Whse. Shipment Lines";
                    RunPageLink = "Source Type" = CONST(37),
                                  "Source Subtype" = FIELD("Document Type"),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                }
            }
            group(Group_Prepayment)
            {
                Caption = 'Prepayment';
                Image = Prepayment;
                action("Prepa&yment Invoices")
                {
                    ApplicationArea = All;
                    Caption = 'Prepa&yment Invoices';
                    Image = PrepaymentInvoice;
                    RunObject = Page "Posted Sales Invoices";
                    RunPageLink = "Prepayment Order No." = FIELD("No.");
                    RunPageView = SORTING("Prepayment Order No.");
                }
                action("Prepayment Credi&t Memos")
                {
                    ApplicationArea = All;
                    Caption = 'Prepayment Credi&t Memos';
                    Image = PrepaymentCreditMemo;
                    RunObject = Page "Posted Sales Credit Memos";
                    RunPageLink = "Prepayment Order No." = FIELD("No.");
                    RunPageView = SORTING("Prepayment Order No.");
                }
            }
        }
        area(processing)
        {
            group(Group_Release)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                action(Release)
                {
                    ApplicationArea = All;
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+F9';

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        //ReleaseSalesDoc.PerformManualRelease(Rec);

                        //Code added in upgradation
                        //alok for mandatory salesperson code
                        IF COMPANYNAME <> 'Medicareplus International' THEN//alok for posting opening
                            IF REC."Salesperson Code" = '' THEN BEGIN
                                ERROR(Text0013, REC."Document Type", REC."No.");
                            END;
                        //alok finish
                        IF PrepaymentMgt.TestSalesPrepayment(REC) THEN
                            ERROR(STRSUBSTNO(Text0011, REC."Document Type", REC."No."))
                        ELSE BEGIN
                            IF PrepaymentMgt.TestSalesPayment(REC) THEN BEGIN
                                IF NOT CONFIRM(STRSUBSTNO(Text0012, REC."Document Type", REC."No.")) THEN
                                    EXIT;
                                REC.Status := REC.Status::"Pending Prepayment";
                                REC.MODIFY;
                                //CurrForm.UPDATE;
                                CurrPage.UPDATE;
                            END ELSE
                                ReleaseSalesDoc.PerformManualRelease(Rec);
                        END;
                    end;
                }
                action("Re&open")
                {
                    ApplicationArea = All;
                    Caption = 'Re&open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        ReleaseSalesDoc.PerformManualReopen(Rec);
                    end;
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Calculate &Invoice Discount")
                {
                    ApplicationArea = All;
                    Caption = 'Calculate &Invoice Discount';
                    Image = CalculateInvoiceDiscount;

                    trigger OnAction()
                    begin
                        ApproveCalcInvDisc;
                    end;
                }
                action("Get St&d. Cust. Sales Codes")
                {
                    ApplicationArea = All;
                    Caption = 'Get St&d. Cust. Sales Codes';
                    Ellipsis = true;
                    Image = CustomerCode;

                    trigger OnAction()
                    var
                        StdCustSalesCode: Record "Standard Customer Sales Code";
                    begin
                        StdCustSalesCode.InsertSalesLines(Rec);
                    end;
                }
                action(CopyDocument)
                {
                    ApplicationArea = All;
                    Caption = 'Copy Document';
                    Ellipsis = true;
                    Image = CopyDocument;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        CopySalesDoc.SetSalesHeader(Rec);
                        CopySalesDoc.RUNMODAL;
                        CLEAR(CopySalesDoc);
                    end;
                }
                action("Move Negative Lines")
                {
                    ApplicationArea = All;
                    Caption = 'Move Negative Lines';
                    Ellipsis = true;
                    Image = MoveNegativeLines;

                    trigger OnAction()
                    begin
                        CLEAR(MoveNegSalesLines);
                        MoveNegSalesLines.SetSalesHeader(Rec);
                        MoveNegSalesLines.RUNMODAL;
                        MoveNegSalesLines.ShowDocument;
                    end;
                }
                action("Archive Document")
                {
                    ApplicationArea = All;
                    Caption = 'Archi&ve Document';
                    Image = Archive;

                    trigger OnAction()
                    begin
                        ArchiveManagement.ArchiveSalesDocument(Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Send IC Sales Order Cnfmn.")
                {
                    ApplicationArea = All;
                    Caption = 'Send IC Sales Order Cnfmn.';
                    Image = IntercompanyOrder;

                    trigger OnAction()
                    var
                        ICInOutboxMgt: Codeunit "ICInboxOutboxMgt";
                    begin
                        IF ApprovalMgt.PrePostApprovalCheckSales(Rec) THEN
                            ICInOutboxMgt.SendSalesDoc(Rec, FALSE);
                    end;
                }
            }
            group(Plan)
            {
                Caption = 'Plan';
                Image = Planning;
                action("Order &Promising")
                {
                    ApplicationArea = All;
                    Caption = 'Order &Promising';
                    Image = OrderPromising;

                    trigger OnAction()
                    var
                        OrderPromisingLine: Record "Order Promising Line" temporary;
                    begin
                        OrderPromisingLine.SETRANGE("Source Type", REC."Document Type");
                        OrderPromisingLine.SETRANGE("Source ID", REC."No.");
                        PAGE.RUNMODAL(PAGE::"Order Promising Lines", OrderPromisingLine);
                    end;
                }
                action("Demand Overview")
                {
                    ApplicationArea = All;
                    Caption = 'Demand Overview';
                    Image = Forecast;

                    trigger OnAction()
                    var
                        DemandOverview: Page "Demand Overview";
                    begin
                        DemandOverview.SetCalculationParameter(TRUE);
                        // Initialize was replaced by SetParameters; the old numeric demand-type literal "1" mapped to a different, now-removed option list, so the type is set explicitly to Sales Demand to match this Sales Order action.
                        DemandOverview.SetParameters(0D, "Demand Order Source Type"::"Sales Demand", REC."No.", '', '');
                        DemandOverview.RUNMODAL;
                    end;
                }
                action("Pla&nning")
                {
                    ApplicationArea = All;
                    Caption = 'Pla&nning';
                    Image = Planning;

                    trigger OnAction()
                    var
                        SalesPlanForm: Page "Sales Order Planning";
                    begin
                        SalesPlanForm.SetSalesOrder(REC."No.");
                        SalesPlanForm.RUNMODAL;
                    end;
                }
            }
            group(Request)
            {
                Caption = 'Request';
                Image = SendApprovalRequest;
                action("Send A&pproval Request")
                {
                    ApplicationArea = All;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;

                    trigger OnAction()
                    var
                        WorkflowEventHandling: Codeunit "Workflow Event Handling";
                    begin
                        // SendSalesApprovalRequest was replaced by the direct workflow-event wrapper below.
                        WorkflowEventHandling.RunWorkflowOnSendSalesDocForApproval(Rec);
                    end;
                }
                action("Cancel Approval Re&quest")
                {
                    ApplicationArea = All;
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;

                    trigger OnAction()
                    var
                        WorkflowEventHandling: Codeunit "Workflow Event Handling";
                    begin
                        // CancelSalesApprovalRequest was replaced by the direct workflow-event wrapper below; the old confirm/silent flags have no equivalent parameter on the new method.
                        WorkflowEventHandling.RunWorkflowOnCancelSalesApprovalRequest(Rec);
                    end;
                }
                group(Group_Authorize)
                {
                    Caption = 'Authorize';
                    Image = AuthorizeCreditCard;
                    action(Authorize)
                    {
                        ApplicationArea = All;
                        Caption = 'Authorize';
                        Image = AuthorizeCreditCard;

                        trigger OnAction()
                        begin
                            //Authorize;
                        end;
                    }
                    action("Void A&uthorize")
                    {
                        ApplicationArea = All;
                        Caption = 'Void A&uthorize';
                        Image = VoidCreditCard;

                        trigger OnAction()
                        begin
                            //Void;
                        end;
                    }
                }
            }
            group(Warehouse)
            {
                Caption = 'Warehouse';
                Image = Warehouse;
                action("Create Inventor&y Put-away / Pick")
                {
                    ApplicationArea = All;
                    Caption = 'Create Inventor&y Put-away / Pick';
                    Ellipsis = true;
                    Image = CreateInventoryPickup;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        REC.CreateInvtPutAwayPick;

                        IF NOT REC.FIND('=><') THEN
                            REC.INIT;
                    end;
                }
                action("Create &Whse. Shipment")
                {
                    ApplicationArea = All;
                    Caption = 'Create &Whse. Shipment';
                    Image = NewShipment;

                    trigger OnAction()
                    var
                        GetSourceDocOutbound: Codeunit "Get Source Doc. Outbound";
                    begin
                        GetSourceDocOutbound.CreateFromSalesOrder(Rec);

                        IF NOT REC.FIND('=><') THEN
                            REC.INIT;
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action(Post)
                {
                    ApplicationArea = All;
                    Caption = 'P&ost';
                    Ellipsis = true;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin
                        P_Post(CODEUNIT::"Sales-Post (Yes/No)");
                    end;
                }
                action("Post and &Print")
                {
                    ApplicationArea = All;
                    Caption = 'Post and &Print';
                    Ellipsis = true;
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';

                    trigger OnAction()
                    begin
                        P_Post(CODEUNIT::"Sales-Post + Print");
                    end;
                }
                action("Test Report")
                {
                    ApplicationArea = All;
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;

                    trigger OnAction()
                    begin
                        ReportPrint.PrintSalesHeader(Rec);
                    end;
                }
                action("Post &Batch")
                {
                    ApplicationArea = All;
                    Caption = 'Post &Batch';
                    Ellipsis = true;
                    Image = PostBatch;

                    trigger OnAction()
                    begin
                        REPORT.RUNMODAL(REPORT::"Batch Post Sales Orders", TRUE, TRUE, Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Remove From Job Queue")
                {
                    ApplicationArea = All;
                    Caption = 'Remove From Job Queue';
                    Image = RemoveLine;
                    Visible = JobQueueVisible;

                    trigger OnAction()
                    begin
                        REC.CancelBackgroundPosting;
                    end;
                }
                group("Prepa&yment")
                {
                    Caption = 'Prepa&yment';
                    Image = Prepayment;
                    action("Prepayment &Test Report")
                    {
                        ApplicationArea = All;
                        Caption = 'Prepayment &Test Report';
                        Ellipsis = true;
                        Image = PrepaymentSimulation;

                        trigger OnAction()
                        begin
                            ReportPrint.PrintSalesHeaderPrepmt(Rec);
                        end;
                    }
                    action(PostPrepaymentInvoice)
                    {
                        ApplicationArea = All;
                        Caption = 'Post Prepayment &Invoice';
                        Ellipsis = true;
                        Image = PrepaymentPost;

                        trigger OnAction()
                        var
                            SalesPostYNPrepmt: Codeunit "Sales-Post Prepayment (Yes/No)";
                        begin
                            IF ApprovalMgt.PrePostApprovalCheckSales(Rec) THEN
                                SalesPostYNPrepmt.PostPrepmtInvoiceYN(Rec, FALSE);
                        end;
                    }
                    action("Post and Print Prepmt. Invoic&e")
                    {
                        ApplicationArea = All;
                        Caption = 'Post and Print Prepmt. Invoic&e';
                        Ellipsis = true;
                        Image = PrepaymentPostPrint;

                        trigger OnAction()
                        var
                            SalesPostYNPrepmt: Codeunit "Sales-Post Prepayment (Yes/No)";
                        begin
                            IF ApprovalMgt.PrePostApprovalCheckSales(Rec) THEN
                                SalesPostYNPrepmt.PostPrepmtInvoiceYN(Rec, TRUE);
                        end;
                    }
                    action(PostPrepaymentCreditMemo)
                    {
                        ApplicationArea = All;
                        Caption = 'Post Prepayment &Credit Memo';
                        Ellipsis = true;
                        Image = PrepaymentPost;

                        trigger OnAction()
                        var
                            SalesPostYNPrepmt: Codeunit "Sales-Post Prepayment (Yes/No)";
                        begin
                            IF ApprovalMgt.PrePostApprovalCheckSales(Rec) THEN
                                SalesPostYNPrepmt.PostPrepmtCrMemoYN(Rec, FALSE);
                        end;
                    }
                    action("Post and Print Prepmt. Cr. Mem&o")
                    {
                        ApplicationArea = All;
                        Caption = 'Post and Print Prepmt. Cr. Mem&o';
                        Ellipsis = true;
                        Image = PrepaymentPostPrint;

                        trigger OnAction()
                        var
                            SalesPostYNPrepmt: Codeunit "Sales-Post Prepayment (Yes/No)";
                        begin
                            IF ApprovalMgt.PrePostApprovalCheckSales(Rec) THEN
                                SalesPostYNPrepmt.PostPrepmtCrMemoYN(Rec, TRUE);
                        end;
                    }
                }
            }
            group("&Print")
            {
                Caption = '&Print';
                Image = Print;
                action("Order Profit")
                {
                    ApplicationArea = All;
                    Caption = 'Order Profit';

                    trigger OnAction()
                    begin
                        SaleshdrRec.RESET;
                        SaleshdrRec.SETRANGE(SaleshdrRec."Document Type", REC."Document Type");
                        SaleshdrRec.SETRANGE(SaleshdrRec."No.", REC."No.");
                        IF SaleshdrRec.FINDFIRST THEN
                        BEGIN
                            REPORT.RUNMODAL(REPORT::"Sales Order Line Wise", TRUE, FALSE, SaleshdrRec);
                        END;
                    end;
                }
                action("Order Confirmation")
                {
                    ApplicationArea = All;
                    Caption = 'Order Confirmation';
                    Ellipsis = true;
                    Image = Print;

                    trigger OnAction()
                    begin
                        DocPrint.PrintSalesOrder(Rec, Usage::"Order Confirmation");
                    end;
                }
                action("Work Order")
                {
                    ApplicationArea = All;
                    Caption = 'Work Order';
                    Ellipsis = true;
                    Image = Print;

                    trigger OnAction()
                    begin
                        DocPrint.PrintSalesOrder(Rec, Usage::"Work Order");
                    end;
                }
                action("Pick Instruction")
                {
                    ApplicationArea = All;
                    Caption = 'Pick Instruction';
                    Image = Print;

                    trigger OnAction()
                    begin
                        DocPrint.PrintSalesOrder(Rec, Usage::"Pick Instruction");
                    end;
                }
                action("Proforma Invoice")
                {
                    ApplicationArea = All;
                    Caption = 'Proforma Invoice';
                    Promoted = true;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        CLEAR(ProformaInvoice);
                        SalesHeader.SETRANGE(SalesHeader."Document Type", REC."Document Type");
                        SalesHeader.SETRANGE(SalesHeader."No.", REC."No.");
                        ProformaInvoice.SETTABLEVIEW(SalesHeader);
                        ProformaInvoice.RUNMODAL;
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Email Proforma Invoice as Attachment")
                {
                    ApplicationArea = All;
                    Caption = 'Email Proforma Invoice as Attachment';
                    Image = Email;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        Mail: Codeunit "Mail";
                        TempBlob: Codeunit "Temp Blob";
                        RecRef: RecordRef;
                        InStr: InStream;
                        OutStr: OutStream;
                        Name: Text[100];
                        ToFile: Text[250];
                    begin
                        CurrPage.SETSELECTIONFILTER(REC);
                        Name := STRSUBSTNO('Proforma Invoice No. %1.pdf', REC."No.");
                        ToFile := Name;
                        // TODO: verify object name "Sales - Quot  Proforma Invoice" (note the double space) - this report is not found in the BC 27 Base Application SymbolReference.json, nor does a source file for it exist anywhere in this extension's Src folder. It may be defined in a separate dependency app not available in .alpackages, or the name/spacing may be incorrect. Left unchanged pending confirmation of the correct object reference.
                        TempBlob.CreateOutStream(OutStr);
                        RecRef.GETTABLE(REC);
                        REPORT.SAVEAS(REPORT::"Sales - Quot  Proforma Invoice", '', REPORTFORMAT::Pdf, OutStr, RecRef);
                        TempBlob.CreateInStream(InStr);
                        //Mail.NewMessage('','',Name,'',ToFile,TRUE);
                        DOWNLOADFROMSTREAM(InStr, '', '', '', ToFile);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        JobQueueVisible := REC."Job Queue Status" = REC."Job Queue Status"::"Scheduled for Posting";
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SAVERECORD;
        EXIT(REC.ConfirmDeletion);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        REC.CheckCreditMaxBeforeInsert;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        REC."Responsibility Center" := UserMgt.GetSalesFilter;
    end;

    trigger OnOpenPage()
    begin
        IF UserMgt.GetSalesFilter <> '' THEN BEGIN
            REC.FILTERGROUP(2);
            REC.SETRANGE("Responsibility Center", UserMgt.GetSalesFilter);
            REC.FILTERGROUP(0);
        END;

        REC.SETRANGE("Date Filter", 0D, WORKDATE - 1);
    end;

    var
        Text000: Label 'Unable to execute this function while in view only mode.';
        CopySalesDoc: Report "Copy Sales Document";
        MoveNegSalesLines: Report "Move Negative Sales Lines";
        ApprovalMgt: Codeunit "Approvals Mgmt.";
        PrepaymentMgt: Codeunit "Prepayment Mgt.";
        ReportPrint: Codeunit "Test Report-Print";
        DocPrint: Codeunit "Document-Print";
        ArchiveManagement: Codeunit "ArchiveManagement";
        ChangeExchangeRate: Page "Change Exchange Rate";
        UserMgt: Codeunit "User Setup Management";
        Usage: Option "Order Confirmation","Work Order","Pick Instruction";
        [InDataSet]

        JobQueueVisible: Boolean;
        Text001: Label 'Do you want to change %1 in all related records in the warehouse?';
        Text002: Label 'The update has been interrupted to respect the warning.';
        Text0011: Label 'There are non posted Prepayment Amounts on %1 %2.';
        Text0012: Label 'There are unpaid Prepayment Invoices related to %1 %2.';
        Text0013: Label 'You must specify Salesperson Code in Sales Header Document Type=''%1'',No.=''%2''';
        SaleshdrRec: Record "Sales Header";
        ProformaInvoice: Report 60044;
        SalesHeader: Record "Sales Header";

    local procedure P_Post(PostingCodeunitID: Integer)
    begin
        REC.SendToPosting(PostingCodeunitID);
        IF REC."Job Queue Status" = REC."Job Queue Status"::"Scheduled for Posting" THEN
            CurrPage.CLOSE;
        CurrPage.UPDATE(FALSE);
    end;

    procedure UpdateAllowed(): Boolean
    begin
        IF CurrPage.EDITABLE = FALSE THEN
            ERROR(Text000);
        EXIT(TRUE);
    end;

    local procedure ApproveCalcInvDisc()
    begin
        CurrPage.SalesLines.PAGE.ApproveCalcInvDisc;
    end;

    local procedure SelltoCustomerNoOnAfterValidat()
    begin
        IF REC.GETFILTER("Sell-to Customer No.") = xRec."Sell-to Customer No." THEN
            IF REC."Sell-to Customer No." <> xRec."Sell-to Customer No." THEN
                REC.SETRANGE("Sell-to Customer No.");
        CurrPage.UPDATE;
    end;

    local procedure SalespersonCodeOnAfterValidate()
    begin
        CurrPage.SalesLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure BilltoCustomerNoOnAfterValidat()
    begin
        CurrPage.UPDATE;
    end;

    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        CurrPage.SalesLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        CurrPage.SalesLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure PricesIncludingVATOnAfterValid()
    begin
        CurrPage.UPDATE;
    end;

    local procedure CurrencyCodeOnAfterValidate()
    begin
        CurrPage.SalesLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure Prepayment37OnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;
}

