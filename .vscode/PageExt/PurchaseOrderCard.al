// page 50 "Purchase Order"
// {
//     // version NAVW113.07,NAVGB13.07

//     Caption = 'Purchase Order';
//     PageType = Document;
//     PromotedActionCategories = 'New,Process,Report,Approve,Release,Posting,Prepare,Order,Request Approval,Print/Send';
//     RefreshOnActivate = true;
//     SourceTable = Table38;
//     SourceTableView = WHERE(Document Type=FILTER(Order));

//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'General';
//                 Editable = Flag;
//                 field("No.";"No.")
//                 {
//                     ApplicationArea = Suite;
//                     Importance = Promoted;
//                     ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
//                     Visible = DocNoVisible;

//                     trigger OnAssistEdit()
//                     begin
//                         IF AssistEdit(xRec) THEN
//                           CurrPage.UPDATE;
//                     end;
//                 }
//                 field("Buy-from Vendor No.";"Buy-from Vendor No.")
//                 {
//                     ApplicationArea = Suite;
//                     Caption = 'Vendor No.';
//                     Importance = Additional;
//                     NotBlank = true;
//                     ToolTip = 'Specifies the number of the vendor who delivers the products.';

//                     trigger OnValidate()
//                     begin
//                         OnAfterValidateBuyFromVendorNo(Rec,xRec);
//                         CurrPage.UPDATE;
//                     end;
//                 }
//                 field("Buy-from Vendor Name";"Buy-from Vendor Name")
//                 {
//                     ApplicationArea = Suite;
//                     Caption = 'Vendor Name';
//                     Importance = Promoted;
//                     ShowMandatory = true;
//                     ToolTip = 'Specifies the name of the vendor who delivers the products.';

//                     trigger OnValidate()
//                     begin
//                         OnAfterValidateBuyFromVendorNo(Rec,xRec);
//                         CurrPage.UPDATE;
//                     end;
//                 }
//                 field("Posting Description";"Posting Description")
//                 {
//                     ApplicationArea = Suite;
//                     ToolTip = 'Specifies additional posting information for the document. After you post the document, the description can add detail to vendor and customer ledger entries.';
//                     Visible = false;
//                 }
//                 group("Buy-from")
//                 {
//                     Caption = 'Buy-from';
//                     Editable = Flag;
//                     field("Buy-from Address";"Buy-from Address")
//                     {
//                         ApplicationArea = Suite;
//                         Caption = 'Address';
//                         Importance = Additional;
//                         QuickEntry = false;
//                         ToolTip = 'Specifies the vendor''s buy-from address.';
//                     }
//                     field("Buy-from Address 2";"Buy-from Address 2")
//                     {
//                         ApplicationArea = Suite;
//                         Caption = 'Address 2';
//                         Importance = Additional;
//                         QuickEntry = false;
//                         ToolTip = 'Specifies an additional part of the vendor''s buy-from address.';
//                     }
//                     field("Buy-from City";"Buy-from City")
//                     {
//                         ApplicationArea = Suite;
//                         Caption = 'City';
//                         Importance = Additional;
//                         QuickEntry = false;
//                         ToolTip = 'Specifies the city of the vendor on the purchase document.';
//                     }
//                     group()
//                     {
//                         Editable = Flag;
//                         Visible = IsBuyFromCountyVisible;
//                         field("Buy-from County";"Buy-from County")
//                         {
//                             ApplicationArea = Suite;
//                             Caption = 'County';
//                             Importance = Additional;
//                             QuickEntry = false;
//                             ToolTip = 'Specifies the state, province or county of the address.';
//                         }
//                     }
//                     field("Buy-from Post Code";"Buy-from Post Code")
//                     {
//                         ApplicationArea = Suite;
//                         Caption = 'Post Code';
//                         Importance = Additional;
//                         QuickEntry = false;
//                         ToolTip = 'Specifies the postal code.';
//                     }
//                     field("Buy-from Country/Region Code";"Buy-from Country/Region Code")
//                     {
//                         ApplicationArea = Suite;
//                         Caption = 'Country/Region';
//                         Importance = Additional;
//                         QuickEntry = false;
//                         ToolTip = 'Specifies the country or region of the address.';

//                         trigger OnValidate()
//                         begin
//                             IsBuyFromCountyVisible := FormatAddress.UseCounty("Buy-from Country/Region Code");
//                         end;
//                     }
//                     field("Buy-from Contact No.";"Buy-from Contact No.")
//                     {
//                         ApplicationArea = Suite;
//                         Caption = 'Contact No.';
//                         Importance = Additional;
//                         ToolTip = 'Specifies the number of contact person of the vendor''s buy-from.';
//                     }
//                 }
//                 field("Your Reference";"Your Reference")
//                 {
//                     Importance = Promoted;
//                 }
//                 field("Buy-from Contact";"Buy-from Contact")
//                 {
//                     ApplicationArea = Suite;
//                     Caption = 'Contact';
//                     Editable = "Buy-from Vendor No." <> '';
//                     ToolTip = 'Specifies the name of the person to contact about an order from this vendor.';
//                 }
//                 field("Document Date";"Document Date")
//                 {
//                     ApplicationArea = Suite;
//                     ToolTip = 'Specifies the date when the related document was created.';
//                 }
//                 field("Invoice Receipt Date";"Invoice Receipt Date")
//                 {
//                     ApplicationArea = Suite;
//                     ToolTip = 'Specifies the date when the document was received.';
//                 }
//                 field("Expected Receipt Date";"Expected Receipt Date")
//                 {
//                 }
//                 field("Posting Date";"Posting Date")
//                 {
//                     ApplicationArea = Suite;
//                     Importance = Additional;
//                     ToolTip = 'Specifies the posting date of the record.';

//                     trigger OnValidate()
//                     begin
//                         SaveInvoiceDiscountAmount;
//                     end;
//                 }
//                 field("Forwarder Name";"Forwarder Name")
//                 {
//                 }
//                 field("Due Date";"Due Date")
//                 {
//                     ApplicationArea = Suite;
//                     Importance = Additional;
//                     ToolTip = 'Specifies when the related purchase invoice must be paid.';
//                 }
//                 field("Vendor Invoice No.";"Vendor Invoice No.")
//                 {
//                     ApplicationArea = Suite;
//                     ShowMandatory = VendorInvoiceNoMandatory;
//                     ToolTip = 'Specifies the document number of the original document you received from the vendor. You can require the document number for posting, or let it be optional. By default, it''s required, so that this document references the original. Making document numbers optional removes a step from the posting process. For example, if you attach the original invoice as a PDF, you might not need to enter the document number. To specify whether document numbers are required, in the Purchases & Payables Setup window, select or clear the Ext. Doc. No. Mandatory field.';
//                 }
//                 field("Purchaser Code";"Purchaser Code")
//                 {
//                     ApplicationArea = Suite;
//                     Importance = Additional;
//                     ToolTip = 'Specifies which purchaser is assigned to the vendor.';

//                     trigger OnValidate()
//                     begin
//                         PurchaserCodeOnAfterValidate;
//                     end;
//                 }
//                 field("No. of Archived Versions";"No. of Archived Versions")
//                 {
//                     ApplicationArea = Suite;
//                     Importance = Additional;
//                     ToolTip = 'Specifies the number of archived versions for this document.';
//                 }
//                 field("Order Date";"Order Date")
//                 {
//                     ApplicationArea = Suite;
//                     Importance = Additional;
//                     ToolTip = 'Specifies the date when the order was created.';
//                 }
//                 field("Quote No.";"Quote No.")
//                 {
//                     ApplicationArea = Suite;
//                     Importance = Additional;
//                     ToolTip = 'Specifies the quote number for the purchase order.';
//                 }
//                 field("Vendor Order No.";"Vendor Order No.")
//                 {
//                     ApplicationArea = Suite;
//                     Importance = Additional;
//                     ToolTip = 'Specifies the vendor''s order number.';
//                 }
//                 field("Vendor Shipment No.";"Vendor Shipment No.")
//                 {
//                     ApplicationArea = Suite;
//                     ToolTip = 'Specifies the vendor''s shipment number.';
//                 }
//                 field("Order Address Code";"Order Address Code")
//                 {
//                     ApplicationArea = Suite;
//                     Caption = 'Alternate Vendor Address Code';
//                     Importance = Additional;
//                     ToolTip = 'Specifies the order address of the related vendor.';
//                 }
//                 field("Responsibility Center";"Responsibility Center")
//                 {
//                     ApplicationArea = Suite;
//                     Importance = Additional;
//                     ToolTip = 'Specifies the code of the responsibility center, such as a distribution hub, that is associated with the involved user, company, customer, or vendor.';
//                 }
//                 field("Assigned User ID";"Assigned User ID")
//                 {
//                     ApplicationArea = Suite;
//                     Importance = Additional;
//                     ToolTip = 'Specifies the ID of the user who is responsible for the document.';
//                 }
//                 field(Status;Status)
//                 {
//                     ApplicationArea = Suite;
//                     Importance = Additional;
//                     ToolTip = 'Specifies whether the record is open, waiting to be approved, invoiced for prepayment, or released to the next stage of processing.';
//                 }
//                 field("Job Queue Status";"Job Queue Status")
//                 {
//                     ApplicationArea = All;
//                     Importance = Additional;
//                     ToolTip = 'Specifies the status of a job queue entry that handles the posting of purchase orders.';
//                     Visible = JobQueueUsed;
//                 }
//             }
//             part(PurchLines;54)
//             {
//                 ApplicationArea = Suite;
//                 Editable = "Buy-from Vendor No." <> '';
//                 Enabled = "Buy-from Vendor No." <> '';
//                 SubPageLink = Document No.=FIELD(No.);
//                 UpdatePropagation = Both;
//             }
//             group("Invoice Details")
//             {
//                 Caption = 'Invoice Details';
//                 Editable = Flag;
//                 field("Freight Company";"Freight Company")
//                 {
//                 }
//                 field("Campaign No.";"Campaign No.")
//                 {
//                 }
//                 field("Currency Code";"Currency Code")
//                 {
//                     ApplicationArea = Suite;
//                     Importance = Promoted;
//                     ToolTip = 'Specifies the currency of amounts on the purchase document.';

//                     trigger OnAssistEdit()
//                     begin
//                         CLEAR(ChangeExchangeRate);
//                         IF "Posting Date" <> 0D THEN
//                           ChangeExchangeRate.SetParameter("Currency Code","Currency Factor","Posting Date")
//                         ELSE
//                           ChangeExchangeRate.SetParameter("Currency Code","Currency Factor",WORKDATE);
//                         IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN BEGIN
//                           VALIDATE("Currency Factor",ChangeExchangeRate.GetParameter);
//                           SaveInvoiceDiscountAmount;
//                         END;
//                         CLEAR(ChangeExchangeRate);
//                     end;

//                     trigger OnValidate()
//                     begin
//                         CurrPage.SAVERECORD;
//                         PurchCalcDiscByType.ApplyDefaultInvoiceDiscount(0,Rec);
//                     end;
//                 }
//                 field("Prices Including VAT";"Prices Including VAT")
//                 {
//                     ApplicationArea = Suite;
//                     ToolTip = 'Specifies if the Unit Price and Line Amount fields on document lines should be shown with or without VAT.';

//                     trigger OnValidate()
//                     begin
//                         PricesIncludingVATOnAfterValid;
//                     end;
//                 }
//                 field("VAT Bus. Posting Group";"VAT Bus. Posting Group")
//                 {
//                     ApplicationArea = Suite;
//                     ToolTip = 'Specifies the VAT specification of the involved customer or vendor to link transactions made for this record with the appropriate general ledger account according to the VAT posting setup.';
//                 }
//                 field("Payment Terms Code";"Payment Terms Code")
//                 {
//                     ApplicationArea = Suite;
//                     Importance = Promoted;
//                     ToolTip = 'Specifies a formula that calculates the payment due date, payment discount date, and payment discount amount.';
//                 }
//                 field("Payment Method Code";"Payment Method Code")
//                 {
//                     ApplicationArea = Suite;
//                     Importance = Additional;
//                     ToolTip = 'Specifies how to make payment, such as with bank transfer, cash, or check.';
//                 }
//                 field("Shortcut Dimension 1 Code";"Shortcut Dimension 1 Code")
//                 {
//                     ApplicationArea = Dimensions;
//                     ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';

//                     trigger OnValidate()
//                     begin
//                         ShortcutDimension1CodeOnAfterV;
//                     end;
//                 }
//                 field("Shortcut Dimension 2 Code";"Shortcut Dimension 2 Code")
//                 {
//                     ApplicationArea = Dimensions;
//                     ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';

//                     trigger OnValidate()
//                     begin
//                         ShortcutDimension2CodeOnAfterV;
//                     end;
//                 }
//                 field("Payment Discount %";"Payment Discount %")
//                 {
//                     ApplicationArea = Suite;
//                     ToolTip = 'Specifies the payment discount percent granted if payment is made on or before the date in the Pmt. Discount Date field.';
//                 }
//                 field("Pmt. Discount Date";"Pmt. Discount Date")
//                 {
//                     ApplicationArea = Suite;
//                     Importance = Additional;
//                     ToolTip = 'Specifies the date on which the amount in the entry must be paid for a payment discount to be granted.';
//                 }
//                 field("Shipment Method Code";"Shipment Method Code")
//                 {
//                     ApplicationArea = Basic,Suite;
//                     ToolTip = 'Specifies the delivery conditions of the related shipment, such as free on board (FOB).';
//                 }
//                 field("Payment Reference";"Payment Reference")
//                 {
//                     ApplicationArea = Suite;
//                     ToolTip = 'Specifies the payment of the purchase invoice.';
//                 }
//                 field("Creditor No.";"Creditor No.")
//                 {
//                     ApplicationArea = Suite;
//                     ToolTip = 'Specifies the number of the vendor.';
//                 }
//                 field("On Hold";"On Hold")
//                 {
//                     ApplicationArea = Suite;
//                     ToolTip = 'Specifies that the related entry represents an unpaid invoice for which either a payment suggestion, a reminder, or a finance charge memo exists.';
//                 }
//                 field("Inbound Whse. Handling Time";"Inbound Whse. Handling Time")
//                 {
//                     ApplicationArea = Warehouse;
//                     Importance = Additional;
//                     ToolTip = 'Specifies the time it takes to make items part of available inventory, after the items have been posted as received.';
//                 }
//                 field("Lead Time Calculation";"Lead Time Calculation")
//                 {
//                     ApplicationArea = Suite;
//                     Importance = Additional;
//                     ToolTip = 'Specifies a date formula for the amount of time it takes to replenish the item.';
//                 }
//                 field("Requested Receipt Date";"Requested Receipt Date")
//                 {
//                     ApplicationArea = Suite;
//                     ToolTip = 'Specifies the date that you want the vendor to deliver to the ship-to address.';
//                 }
//                 field("Promised Receipt Date";"Promised Receipt Date")
//                 {
//                     ApplicationArea = OrderPromising;
//                     ToolTip = 'Specifies the date that the vendor has promised to deliver the order.';
//                 }
//             }
//             group("Shipping and Payment")
//             {
//                 Caption = 'Shipping and Payment';
//                 Editable = Flag;
//                 group()
//                 {
//                     group()
//                     {
//                         field(ShippingOptionWithLocation;ShipToOptions)
//                         {
//                             ApplicationArea = Basic,Suite;
//                             Caption = 'Ship-to';
//                             HideValue = NOT ShowShippingOptionsWithLocation AND (ShipToOptions = ShipToOptions::Location);
//                             OptionCaption = 'Default (Company Address),Location,Customer Address,Custom Address';
//                             ToolTip = 'Specifies the address that the products on the purchase document are shipped to. Default (Company Address): The same as the company address specified in the Company Information window. Location: One of the company''s location addresses. Customer Address: Used in connection with drop shipment. Custom Address: Any ship-to address that you specify in the fields below.';

//                             trigger OnValidate()
//                             begin
//                                 ValidateShippingOption;
//                             end;
//                         }
//                         group()
//                         {
//                             group()
//                             {
//                                 Visible = ShipToOptions = ShipToOptions::Location;
//                                 field("Location Code";"Location Code")
//                                 {
//                                     ApplicationArea = Location;
//                                     Importance = Promoted;
//                                     ToolTip = 'Specifies a code for the location where you want the items to be placed when they are received.';
//                                 }
//                             }
//                             group()
//                             {
//                                 Visible = ShipToOptions = ShipToOptions::"Customer Address";
//                                 field("Sell-to Customer No.";"Sell-to Customer No.")
//                                 {
//                                     ApplicationArea = Suite;
//                                     Caption = 'Customer';
//                                     ToolTip = 'Specifies the number of the customer that the items are shipped to directly from your vendor, as a drop shipment.';
//                                 }
//                                 field("Ship-to Code";"Ship-to Code")
//                                 {
//                                     ApplicationArea = Suite;
//                                     Editable = "Sell-to Customer No." <> '';
//                                     ToolTip = 'Specifies the code for another delivery address than the vendor''s own address, which is entered by default.';
//                                 }
//                             }
//                             field("Ship-to Name";"Ship-to Name")
//                             {
//                                 ApplicationArea = Basic,Suite;
//                                 Caption = 'Name';
//                                 Editable = ShipToOptions = ShipToOptions::"Custom Address";
//                                 Importance = Additional;
//                                 ToolTip = 'Specifies the name of the company at the address that you want the items on the purchase document to be shipped to.';
//                             }
//                             field("Ship-to Address";"Ship-to Address")
//                             {
//                                 ApplicationArea = Basic,Suite;
//                                 Caption = 'Address';
//                                 Editable = ShipToOptions = ShipToOptions::"Custom Address";
//                                 Importance = Additional;
//                                 QuickEntry = false;
//                                 ToolTip = 'Specifies the address that you want the items on the purchase document to be shipped to.';
//                             }
//                             field("Ship-to Address 2";"Ship-to Address 2")
//                             {
//                                 ApplicationArea = Basic,Suite;
//                                 Caption = 'Address 2';
//                                 Editable = ShipToOptions = ShipToOptions::"Custom Address";
//                                 Importance = Additional;
//                                 QuickEntry = false;
//                                 ToolTip = 'Specifies additional address information.';
//                             }
//                             field("Ship-to City";"Ship-to City")
//                             {
//                                 ApplicationArea = Basic,Suite;
//                                 Caption = 'City';
//                                 Editable = ShipToOptions = ShipToOptions::"Custom Address";
//                                 Importance = Additional;
//                                 QuickEntry = false;
//                                 ToolTip = 'Specifies the city of the vendor on the purchase document.';
//                             }
//                             group()
//                             {
//                                 Visible = IsShipToCountyVisible;
//                                 field("Ship-to County";"Ship-to County")
//                                 {
//                                     ApplicationArea = Basic,Suite;
//                                     Caption = 'County';
//                                     Editable = ShipToOptions = ShipToOptions::"Custom Address";
//                                     Importance = Additional;
//                                     QuickEntry = false;
//                                     ToolTip = 'Specifies the state, province or county of the address.';
//                                 }
//                             }
//                             field("Ship-to Post Code";"Ship-to Post Code")
//                             {
//                                 ApplicationArea = Basic,Suite;
//                                 Caption = 'Post Code';
//                                 Editable = ShipToOptions = ShipToOptions::"Custom Address";
//                                 Importance = Additional;
//                                 QuickEntry = false;
//                                 ToolTip = 'Specifies the postal code of the address that you want the items on the purchase document to be shipped to.';
//                             }
//                             field("Ship-to Country/Region Code";"Ship-to Country/Region Code")
//                             {
//                                 ApplicationArea = Basic,Suite;
//                                 Caption = 'Country/Region';
//                                 Editable = ShipToOptions = ShipToOptions::"Custom Address";
//                                 Importance = Additional;
//                                 QuickEntry = false;
//                                 ToolTip = 'Specifies the country/region code of the address that you want the items on the purchase document to be shipped to.';

//                                 trigger OnValidate()
//                                 begin
//                                     IsShipToCountyVisible := FormatAddress.UseCounty("Ship-to Country/Region Code");
//                                 end;
//                             }
//                             field("Ship-to Contact";"Ship-to Contact")
//                             {
//                                 ApplicationArea = Basic,Suite;
//                                 Caption = 'Contact';
//                                 Editable = ShipToOptions = ShipToOptions::"Custom Address";
//                                 Importance = Additional;
//                                 ToolTip = 'Specifies the name of a contact person for the address of the address that you want the items on the purchase document to be shipped to.';
//                             }
//                         }
//                     }
//                 }
//                 group()
//                 {
//                     Editable = Flag;
//                     field(PayToOptions;PayToOptions)
//                     {
//                         ApplicationArea = Basic,Suite;
//                         Caption = 'Pay-to';
//                         OptionCaption = 'Default (Vendor),Another Vendor,Custom Address';
//                         ToolTip = 'Specifies the vendor that the purchase document will be paid to. Default (Vendor): The same as the vendor on the purchase document. Another Vendor: Any vendor that you specify in the fields below.';

//                         trigger OnValidate()
//                         begin
//                             IF PayToOptions = PayToOptions::"Default (Vendor)" THEN
//                               VALIDATE("Pay-to Vendor No.","Buy-from Vendor No.");
//                         end;
//                     }
//                     group()
//                     {
//                         Editable = Flag;
//                         Visible = NOT (PayToOptions = PayToOptions::"Default (Vendor)");
//                         field("Pay-to Name";"Pay-to Name")
//                         {
//                             ApplicationArea = Basic,Suite;
//                             Caption = 'Name';
//                             Editable = PayToOptions = PayToOptions::"Another Vendor";
//                             Enabled = PayToOptions = PayToOptions::"Another Vendor";
//                             Importance = Promoted;
//                             ToolTip = 'Specifies the name of the vendor sending the invoice.';
//                         }
//                         field("Pay-to Address";"Pay-to Address")
//                         {
//                             ApplicationArea = Basic,Suite;
//                             Caption = 'Address';
//                             Editable = (PayToOptions = PayToOptions::"Custom Address") OR ("Buy-from Vendor No." <> "Pay-to Vendor No.");
//                             Enabled = (PayToOptions = PayToOptions::"Custom Address") OR ("Buy-from Vendor No." <> "Pay-to Vendor No.");
//                             Importance = Additional;
//                             QuickEntry = false;
//                             ToolTip = 'Specifies the address of the vendor sending the invoice.';
//                         }
//                         field("Pay-to Address 2";"Pay-to Address 2")
//                         {
//                             ApplicationArea = Basic,Suite;
//                             Caption = 'Address 2';
//                             Editable = (PayToOptions = PayToOptions::"Custom Address") OR ("Buy-from Vendor No." <> "Pay-to Vendor No.");
//                             Enabled = (PayToOptions = PayToOptions::"Custom Address") OR ("Buy-from Vendor No." <> "Pay-to Vendor No.");
//                             Importance = Additional;
//                             QuickEntry = false;
//                             ToolTip = 'Specifies additional address information.';
//                         }
//                         field("Pay-to City";"Pay-to City")
//                         {
//                             ApplicationArea = Basic,Suite;
//                             Caption = 'City';
//                             Editable = (PayToOptions = PayToOptions::"Custom Address") OR ("Buy-from Vendor No." <> "Pay-to Vendor No.");
//                             Enabled = (PayToOptions = PayToOptions::"Custom Address") OR ("Buy-from Vendor No." <> "Pay-to Vendor No.");
//                             Importance = Additional;
//                             QuickEntry = false;
//                             ToolTip = 'Specifies the city of the vendor on the purchase document.';
//                         }
//                         group()
//                         {
//                             Visible = IsPayToCountyVisible;
//                             field("Pay-to County";"Pay-to County")
//                             {
//                                 ApplicationArea = Basic,Suite;
//                                 Caption = 'County';
//                                 Editable = (PayToOptions = PayToOptions::"Custom Address") OR ("Buy-from Vendor No." <> "Pay-to Vendor No.");
//                                 Enabled = (PayToOptions = PayToOptions::"Custom Address") OR ("Buy-from Vendor No." <> "Pay-to Vendor No.");
//                                 Importance = Additional;
//                                 QuickEntry = false;
//                                 ToolTip = 'Specifies the state, province or county of the address.';
//                             }
//                         }
//                         field("Pay-to Post Code";"Pay-to Post Code")
//                         {
//                             ApplicationArea = Basic,Suite;
//                             Caption = 'Post Code';
//                             Editable = (PayToOptions = PayToOptions::"Custom Address") OR ("Buy-from Vendor No." <> "Pay-to Vendor No.");
//                             Enabled = (PayToOptions = PayToOptions::"Custom Address") OR ("Buy-from Vendor No." <> "Pay-to Vendor No.");
//                             Importance = Additional;
//                             QuickEntry = false;
//                             ToolTip = 'Specifies the postal code.';
//                         }
//                         field("Pay-to Country/Region Code";"Pay-to Country/Region Code")
//                         {
//                             ApplicationArea = Basic,Suite;
//                             Caption = 'Country/Region';
//                             Editable = (PayToOptions = PayToOptions::"Custom Address") OR ("Buy-from Vendor No." <> "Pay-to Vendor No.");
//                             Enabled = (PayToOptions = PayToOptions::"Custom Address") OR ("Buy-from Vendor No." <> "Pay-to Vendor No.");
//                             Importance = Additional;
//                             QuickEntry = false;
//                             ToolTip = 'Specifies the country/region code of the vendor on the purchase document.';

//                             trigger OnValidate()
//                             begin
//                                 IsPayToCountyVisible := FormatAddress.UseCounty("Pay-to Country/Region Code");
//                             end;
//                         }
//                         field("Pay-to Contact No.";"Pay-to Contact No.")
//                         {
//                             ApplicationArea = Suite;
//                             Caption = 'Contact No.';
//                             Editable = (PayToOptions = PayToOptions::"Custom Address") OR ("Buy-from Vendor No." <> "Pay-to Vendor No.");
//                             Enabled = (PayToOptions = PayToOptions::"Custom Address") OR ("Buy-from Vendor No." <> "Pay-to Vendor No.");
//                             Importance = Additional;
//                             ToolTip = 'Specifies the number of contact person of the vendor''s buy-from.';
//                         }
//                         field("Pay-to Contact";"Pay-to Contact")
//                         {
//                             ApplicationArea = Basic,Suite;
//                             Caption = 'Contact';
//                             Editable = (PayToOptions = PayToOptions::"Custom Address") OR ("Buy-from Vendor No." <> "Pay-to Vendor No.");
//                             Enabled = (PayToOptions = PayToOptions::"Custom Address") OR ("Buy-from Vendor No." <> "Pay-to Vendor No.");
//                             ToolTip = 'Specifies the name of the person to contact about an order from this vendor.';
//                         }
//                     }
//                 }
//             }
//             group("Foreign Trade")
//             {
//                 Caption = 'Foreign Trade';
//                 Editable = Flag;
//                 field("Transaction Specification";"Transaction Specification")
//                 {
//                     ApplicationArea = Suite;
//                     ToolTip = 'Specifies a specification of the document''s transaction, for the purpose of reporting to INTRASTAT.';
//                 }
//                 field("Transaction Type";"Transaction Type")
//                 {
//                     ApplicationArea = Basic,Suite;
//                     ToolTip = 'Specifies the type of transaction that the document represents, for the purpose of reporting to INTRASTAT.';
//                 }
//                 field("Transport Method";"Transport Method")
//                 {
//                     ApplicationArea = Suite;
//                     ToolTip = 'Specifies the transport method, for the purpose of reporting to INTRASTAT.';
//                 }
//                 field("Entry Point";"Entry Point")
//                 {
//                     ApplicationArea = Suite;
//                     ToolTip = 'Specifies the code of the port of entry where the items pass into your country/region, for reporting to Intrastat.';
//                 }
//                 field(Area;Area)
//                 {
//                     ApplicationArea = Suite;
//                     ToolTip = 'Specifies the area of the customer or vendor, for the purpose of reporting to INTRASTAT.';
//                 }
//             }
//             group(Prepayment)
//             {
//                 Caption = 'Prepayment';
//                 Editable = Flag;
//                 field("Prepayment %";"Prepayment %")
//                 {
//                     ApplicationArea = Prepayments;
//                     Importance = Promoted;
//                     ToolTip = 'Specifies the prepayment percentage to use to calculate the prepayment for sales.';

//                     trigger OnValidate()
//                     begin
//                         Prepayment37OnAfterValidate;
//                     end;
//                 }
//                 field("Compress Prepayment";"Compress Prepayment")
//                 {
//                     ApplicationArea = Prepayments;
//                     ToolTip = 'Specifies that prepayments on the purchase order are combined if they have the same general ledger account for prepayments or the same dimensions.';
//                 }
//                 field("Prepmt. Payment Terms Code";"Prepmt. Payment Terms Code")
//                 {
//                     ApplicationArea = Prepayments;
//                     ToolTip = 'Specifies the code that represents the payment terms for prepayment invoices related to the purchase document.';
//                 }
//                 field("Prepayment Due Date";"Prepayment Due Date")
//                 {
//                     ApplicationArea = Prepayments;
//                     Importance = Promoted;
//                     ToolTip = 'Specifies when the prepayment invoice for this purchase order is due.';
//                 }
//                 field("Prepmt. Payment Discount %";"Prepmt. Payment Discount %")
//                 {
//                     ApplicationArea = Prepayments;
//                     ToolTip = 'Specifies the payment discount percent granted on the prepayment if the vendor pays on or before the date entered in the Prepmt. Pmt. Discount Date field.';
//                 }
//                 field("Prepmt. Pmt. Discount Date";"Prepmt. Pmt. Discount Date")
//                 {
//                     ApplicationArea = Prepayments;
//                     ToolTip = 'Specifies the last date the vendor can pay the prepayment invoice and still receive a payment discount on the prepayment amount.';
//                 }
//                 field("Vendor Cr. Memo No.";"Vendor Cr. Memo No.")
//                 {
//                     ApplicationArea = Suite;
//                     ToolTip = 'Specifies the number that the vendor uses for the purchase order.';
//                 }
//             }
//         }
//         area(factboxes)
//         {
//             part("Attached Documents";1174)
//             {
//                 ApplicationArea = All;
//                 Caption = 'Attachments';
//                 SubPageLink = Table ID=CONST(38),
//                               No.=FIELD(No.),
//                               Document Type=FIELD(Document Type);
//             }
//             part(;9103)
//             {
//                 ApplicationArea = Suite;
//                 SubPageLink = Table ID=CONST(38),
//                               Document Type=FIELD(Document Type),
//                               Document No.=FIELD(No.);
//                 Visible = OpenApprovalEntriesExistForCurrUser;
//             }
//             part(;9090)
//             {
//                 ApplicationArea = Suite;
//                 Provider = PurchLines;
//                 SubPageLink = No.=FIELD(No.);
//                 Visible = false;
//             }
//             part(ApprovalFactBox;9092)
//             {
//                 ApplicationArea = Suite;
//                 Visible = false;
//             }
//             part(;9093)
//             {
//                 ApplicationArea = Suite;
//                 SubPageLink = No.=FIELD(Buy-from Vendor No.);
//                 Visible = false;
//             }
//             part(;9094)
//             {
//                 ApplicationArea = Suite;
//                 SubPageLink = No.=FIELD(Pay-to Vendor No.);
//             }
//             part(IncomingDocAttachFactBox;193)
//             {
//                 ApplicationArea = Suite;
//                 ShowFilter = false;
//                 Visible = false;
//             }
//             part(;9095)
//             {
//                 ApplicationArea = Suite;
//                 SubPageLink = No.=FIELD(Buy-from Vendor No.);
//             }
//             part(;9096)
//             {
//                 ApplicationArea = Suite;
//                 SubPageLink = No.=FIELD(Pay-to Vendor No.);
//                 Visible = false;
//             }
//             part(;9100)
//             {
//                 ApplicationArea = Suite;
//                 Provider = PurchLines;
//                 SubPageLink = Document Type=FIELD(Document Type),
//                               Document No.=FIELD(Document No.),
//                               Line No.=FIELD(Line No.);
//             }
//             part(WorkflowStatus;1528)
//             {
//                 ApplicationArea = Suite;
//                 Editable = false;
//                 Enabled = false;
//                 ShowFilter = false;
//                 Visible = ShowWorkflowStatus;
//             }
//             systempart(;Links)
//             {
//                 Visible = false;
//             }
//             systempart(;Notes)
//             {
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
//                 action(Dimensions)
//                 {
//                     AccessByPermission = TableData 348=R;
//                     ApplicationArea = Dimensions;
//                     Caption = 'Dimensions';
//                     Enabled = "No." <> '';
//                     Image = Dimensions;
//                     Promoted = true;
//                     PromotedCategory = Category8;
//                     ShortCutKey = 'Shift+Ctrl+D';
//                     ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

//                     trigger OnAction()
//                     begin
//                         ShowDocDim;
//                         CurrPage.SAVERECORD;
//                     end;
//                 }
//                 action(Statistics)
//                 {
//                     ApplicationArea = Suite;
//                     Caption = 'Statistics';
//                     Image = Statistics;
//                     Promoted = true;
//                     PromotedCategory = Category8;
//                     PromotedIsBig = true;
//                     ShortCutKey = 'F7';
//                     ToolTip = 'View statistical information, such as the value of posted entries, for the record.';

//                     trigger OnAction()
//                     begin
//                         OpenPurchaseOrderStatistics;
//                         PurchCalcDiscByType.ResetRecalculateInvoiceDisc(Rec);
//                     end;
//                 }
//                 action(Vendor)
//                 {
//                     ApplicationArea = Suite;
//                     Caption = 'Vendor';
//                     Enabled = "Buy-from Vendor No." <> '';
//                     Image = Vendor;
//                     Promoted = true;
//                     PromotedCategory = Category8;
//                     RunObject = Page 26;
//                     RunPageLink = No.=FIELD(Buy-from Vendor No.);
//                     ShortCutKey = 'Shift+F7';
//                     ToolTip = 'View or edit detailed information about the vendor on the purchase document.';
//                 }
//                 action(Approvals)
//                 {
//                     AccessByPermission = TableData 454=R;
//                     ApplicationArea = Suite;
//                     Caption = 'Approvals';
//                     Image = Approvals;
//                     Promoted = true;
//                     PromotedCategory = Category9;
//                     ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

//                     trigger OnAction()
//                     var
//                         WorkflowsEntriesBuffer: Record "832";
//                     begin
//                         WorkflowsEntriesBuffer.RunWorkflowEntriesPage(RECORDID,DATABASE::"Purchase Header","Document Type","No.");
//                     end;
//                 }
//                 action("Co&mments")
//                 {
//                     ApplicationArea = Comments;
//                     Caption = 'Co&mments';
//                     Image = ViewComments;
//                     Promoted = true;
//                     PromotedCategory = Category8;
//                     RunObject = Page 66;
//                     RunPageLink = Document Type=FIELD(Document Type),
//                                   No.=FIELD(No.),
//                                   Document Line No.=CONST(0);
//                     ToolTip = 'View or add comments for the record.';
//                 }
//                 action(DocAttach)
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Attachments';
//                     Image = Attach;
//                     Promoted = true;
//                     PromotedCategory = Category8;
//                     PromotedIsBig = true;
//                     ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

//                     trigger OnAction()
//                     var
//                         DocumentAttachmentDetails: Page "1173";
//                         RecRef: RecordRef;
//                     begin
//                         RecRef.GETTABLE(Rec);
//                         DocumentAttachmentDetails.OpenForRecRef(RecRef);
//                         DocumentAttachmentDetails.RUNMODAL;
//                     end;
//                 }
//             }
//             group(Documents)
//             {
//                 Caption = 'Documents';
//                 Image = Documents;
//                 action(Receipts)
//                 {
//                     ApplicationArea = Suite;
//                     Caption = 'Receipts';
//                     Image = PostedReceipts;
//                     RunObject = Page 145;
//                     RunPageLink = Order No.=FIELD(No.);
//                     RunPageView = SORTING(Order No.);
//                     ToolTip = 'View a list of posted purchase receipts for the order.';
//                 }
//                 action(Invoices)
//                 {
//                     ApplicationArea = Suite;
//                     Caption = 'Invoices';
//                     Image = Invoice;
//                     Promoted = false;
//                     //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
//                     //PromotedIsBig = false;
//                     RunObject = Page 146;
//                     RunPageLink = Order No.=FIELD(No.);
//                     RunPageView = SORTING(Order No.);
//                     ToolTip = 'View a list of ongoing purchase invoices for the order.';
//                 }
//                 action(PostedPrepaymentInvoices)
//                 {
//                     ApplicationArea = Prepayments;
//                     Caption = 'Prepa&yment Invoices';
//                     Image = PrepaymentInvoice;
//                     RunObject = Page 146;
//                     RunPageLink = Prepayment Order No.=FIELD(No.);
//                     RunPageView = SORTING(Prepayment Order No.);
//                     ToolTip = 'View related posted sales invoices that involve a prepayment. ';
//                 }
//                 action(PostedPrepaymentCrMemos)
//                 {
//                     ApplicationArea = Prepayments;
//                     Caption = 'Prepayment Credi&t Memos';
//                     Image = PrepaymentCreditMemo;
//                     RunObject = Page 147;
//                     RunPageLink = Prepayment Order No.=FIELD(No.);
//                     RunPageView = SORTING(Prepayment Order No.);
//                     ToolTip = 'View related posted sales credit memos that involve a prepayment. ';
//                 }
//             }
//             group(Warehouse)
//             {
//                 Caption = 'Warehouse';
//                 Image = Warehouse;
//                 separator()
//                 {
//                 }
//                 action("In&vt. Put-away/Pick Lines")
//                 {
//                     ApplicationArea = Warehouse;
//                     Caption = 'In&vt. Put-away/Pick Lines';
//                     Image = PickLines;
//                     RunObject = Page 5774;
//                     RunPageLink = Source Document=CONST(Purchase Order),
//                                   Source No.=FIELD(No.);
//                     RunPageView = SORTING(Source Document,Source No.,Location Code);
//                     ToolTip = 'View items that are inbound or outbound on inventory put-away or inventory pick documents for the transfer order.';
//                 }
//                 action("Whse. Receipt Lines")
//                 {
//                     ApplicationArea = Warehouse;
//                     Caption = 'Whse. Receipt Lines';
//                     Image = ReceiptLines;
//                     RunObject = Page 7342;
//                     RunPageLink = Source Type=CONST(39),
//                                   Source Subtype=FIELD(Document Type),
//                                   Source No.=FIELD(No.);
//                     RunPageView = SORTING(Source Type,Source Subtype,Source No.,Source Line No.);
//                     ToolTip = 'View ongoing warehouse receipts for the document, in advanced warehouse configurations.';
//                 }
//                 separator()
//                 {
//                 }
//                 group("Dr&op Shipment")
//                 {
//                     Caption = 'Dr&op Shipment';
//                     Image = Delivery;
//                     action(Warehouse_GetSalesOrder)
//                     {
//                         ApplicationArea = Suite;
//                         Caption = 'Get &Sales Order';
//                         Image = "Order";
//                         RunObject = Codeunit 76;
//                         ToolTip = 'Select the sales order that must be linked to the purchase order, for drop shipment or special order. ';
//                     }
//                 }
//                 group("Speci&al Order")
//                 {
//                     Caption = 'Speci&al Order';
//                     Image = SpecialOrder;
//                     action("Get &Sales Order")
//                     {
//                         AccessByPermission = TableData 110=R;
//                         ApplicationArea = Suite;
//                         Caption = 'Get &Sales Order';
//                         Image = "Order";
//                         ToolTip = 'Select the sales order that must be linked to the purchase order, for drop shipment or special order. ';

//                         trigger OnAction()
//                         var
//                             PurchHeader: Record "38";
//                             DistIntegration: Codeunit "5702";
//                         begin
//                             PurchHeader.COPY(Rec);
//                             DistIntegration.GetSpecialOrders(PurchHeader);
//                             Rec := PurchHeader;
//                         end;
//                     }
//                     action("Attached Gate Entry")
//                     {
//                         Caption = 'Attached Gate Entry';
//                         Promoted = false;
//                         RunObject = Page 50004;
//                         RunPageLink = Source No.=FIELD(No.),
//                                       Source Type=CONST(Purchase Order),
//                                       Entry Type=CONST(Inward);
//                     }
//                 }
//             }
//         }
//         area(processing)
//         {
//             group(Approval)
//             {
//                 Caption = 'Approval';
//                 action(Approve)
//                 {
//                     ApplicationArea = Suite;
//                     Caption = 'Approve';
//                     Image = Approve;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     PromotedIsBig = true;
//                     PromotedOnly = true;
//                     ToolTip = 'Approve the requested changes.';
//                     Visible = OpenApprovalEntriesExistForCurrUser;

//                     trigger OnAction()
//                     var
//                         ApprovalsMgmt: Codeunit "1535";
//                     begin
//                         ApprovalsMgmt.ApproveRecordApprovalRequest(RECORDID);
//                     end;
//                 }
//                 action(Reject)
//                 {
//                     ApplicationArea = Suite;
//                     Caption = 'Reject';
//                     Image = Reject;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     PromotedIsBig = true;
//                     PromotedOnly = true;
//                     ToolTip = 'Reject the requested changes.';
//                     Visible = OpenApprovalEntriesExistForCurrUser;

//                     trigger OnAction()
//                     var
//                         ApprovalsMgmt: Codeunit "1535";
//                     begin
//                         ApprovalsMgmt.RejectRecordApprovalRequest(RECORDID);
//                     end;
//                 }
//                 action(Delegate)
//                 {
//                     ApplicationArea = Suite;
//                     Caption = 'Delegate';
//                     Image = Delegate;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     PromotedOnly = true;
//                     ToolTip = 'Delegate the requested changes to the substitute approver.';
//                     Visible = OpenApprovalEntriesExistForCurrUser;

//                     trigger OnAction()
//                     var
//                         ApprovalsMgmt: Codeunit "1535";
//                     begin
//                         ApprovalsMgmt.DelegateRecordApprovalRequest(RECORDID);
//                     end;
//                 }
//                 action(Comment)
//                 {
//                     ApplicationArea = Suite;
//                     Caption = 'Comments';
//                     Image = ViewComments;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     PromotedOnly = true;
//                     ToolTip = 'View or add comments for the record.';
//                     Visible = OpenApprovalEntriesExistForCurrUser;

//                     trigger OnAction()
//                     var
//                         ApprovalsMgmt: Codeunit "1535";
//                     begin
//                         ApprovalsMgmt.GetApprovalComment(Rec);
//                     end;
//                 }
//             }
//             group(Release)
//             {
//                 Caption = 'Release';
//                 Image = ReleaseDoc;
//                 separator()
//                 {
//                 }
//                 action(Release)
//                 {
//                     ApplicationArea = Suite;
//                     Caption = 'Re&lease';
//                     Image = ReleaseDoc;
//                     Promoted = true;
//                     PromotedCategory = Category5;
//                     PromotedOnly = true;
//                     ShortCutKey = 'Ctrl+F9';
//                     ToolTip = 'Release the document to the next stage of processing. When a document is released, it will be included in all availability calculations from the expected receipt date of the items. You must reopen the document before you can make changes to it.';

//                     trigger OnAction()
//                     var
//                         ReleasePurchDoc: Codeunit "415";
//                     begin
//                         ReleasePurchDoc.PerformManualRelease(Rec);
//                         //Sofyan++
//                         PurchaseLine.RESET;
//                         PurchaseLine.SETRANGE("Document Type",Rec."Document Type");
//                         PurchaseLine.SETRANGE("Document No.",Rec."No.");
//                         PurchaseLine.SETRANGE(Type,PurchaseLine.Type::Item);
//                         IF PurchaseLine.FINDSET THEN BEGIN
//                           REPEAT
//                             PurchaseLine.Status := Rec.Status;
//                             PurchaseLine.MODIFY;
//                             UNTIL PurchaseLine.NEXT = 0;
//                           END;
//                         //Sofyan--
//                     end;
//                 }
//                 action(Reopen)
//                 {
//                     ApplicationArea = Suite;
//                     Caption = 'Re&open';
//                     Enabled = Status <> Status::Open;
//                     Image = ReOpen;
//                     Promoted = true;
//                     PromotedCategory = Category5;
//                     PromotedOnly = true;
//                     ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed';

//                     trigger OnAction()
//                     var
//                         ReleasePurchDoc: Codeunit "415";
//                     begin

//                         //kd

//                         ArchiveManagement.StorePurchDocument(Rec,FALSE);
//                         CurrPage.UPDATE(FALSE);

//                         //kd
//                         ReleasePurchDoc.PerformManualReopen(Rec);

//                         //Sofyan++
//                         PurchaseLine.RESET;
//                         PurchaseLine.SETRANGE("Document Type",Rec."Document Type");
//                         PurchaseLine.SETRANGE("Document No.",Rec."No.");
//                         PurchaseLine.SETRANGE(Type,PurchaseLine.Type::Item);
//                         IF PurchaseLine.FINDSET THEN BEGIN
//                           REPEAT
//                             PurchaseLine.Status := Rec.Status;
//                             IF PurchaseLine."Original Ordered Quantity" <> 0 THEN
//                               //PurchaseLine.VALIDATE(Quantity,PurchaseLine."Original Ordered Quantity");
//                               PurchaseLine.Quantity:=PurchaseLine."Original Ordered Quantity";
//                              PurchaseLine.MODIFY;
//                             UNTIL PurchaseLine.NEXT = 0;
//                           END;
//                         //Sofyan--
//                     end;
//                 }
//                 action("Close Order")
//                 {
//                     ApplicationArea = Suite;
//                     Caption = 'Cl&ose Order';
//                     Image = Close;
//                     ToolTip = 'This will close the Blanket Purchase Order and will be removed from the Quantity on Blanket Order';

//                     trigger OnAction()
//                     var
//                         ReleasePurchDoc: Codeunit "415";
//                     begin
//                         IF Status <> Status::Released THEN
//                           ERROR(TEXT50000);
//                         /*
//                         Status := Status::Closed;
//                         CurrPage.UPDATE(TRUE);
//                         */
//                         //Sofyan++
//                         Status := Status::Closed;
//                         CurrPage.UPDATE(TRUE);
                        
//                         PurchaseLine.RESET;
//                         PurchaseLine.SETRANGE("Document Type",Rec."Document Type");
//                         PurchaseLine.SETRANGE("Document No.",Rec."No.");
//                         //PurchaseLine.SETRANGE(Type,PurchaseLine.Type::Item);
//                         IF PurchaseLine.FINDSET THEN BEGIN
//                           REPEAT
//                             PurchaseLine."Original Ordered Quantity":=PurchaseLine.Quantity;
//                             PurchaseLine.Quantity:=PurchaseLine."Quantity Received";
//                             PurchaseLine."Outstanding Qty. (Base)" := 0;
//                             PurchaseLine."Outstanding Quantity" := 0;
//                             PurchaseLine.Status := Status;
//                             /*//kd
//                             PurchaseLine.VALIDATE("Original Ordered Quantity",PurchaseLine.Quantity);
//                             PurchaseLine.VALIDATE(Quantity,PurchaseLine."Quantity Received");
//                             //kd*/
//                             PurchaseLine.MODIFY;
//                             UNTIL PurchaseLine.NEXT = 0;
//                           END;
//                         //Sofyan--

//                     end;
//                 }
//                 separator()
//                 {
//                 }
//             }
//             group("F&unctions")
//             {
//                 Caption = 'F&unctions';
//                 Image = "Action";
//                 action(CalculateInvoiceDiscount)
//                 {
//                     AccessByPermission = TableData 24=R;
//                     ApplicationArea = Suite;
//                     Caption = 'Calculate &Invoice Discount';
//                     Image = CalculateInvoiceDiscount;
//                     ToolTip = 'Calculate the discount that can be granted based on all lines in the purchase document.';

//                     trigger OnAction()
//                     begin
//                         ApproveCalcInvDisc;
//                         PurchCalcDiscByType.ResetRecalculateInvoiceDisc(Rec);
//                     end;
//                 }
//                 separator()
//                 {
//                 }
//                 action(GetRecurringPurchaseLines)
//                 {
//                     ApplicationArea = Suite;
//                     Caption = 'Get Recurring Purchase Lines';
//                     Ellipsis = true;
//                     Image = VendorCode;
//                     ToolTip = 'Insert purchase document lines that you have set up for the vendor as recurring. Recurring purchase lines could be for a monthly replenishment order or a fixed freight expense.';

//                     trigger OnAction()
//                     var
//                         StdVendPurchCode: Record "175";
//                     begin
//                         StdVendPurchCode.InsertPurchLines(Rec);
//                     end;
//                 }
//                 separator()
//                 {
//                 }
//                 action(CopyDocument)
//                 {
//                     ApplicationArea = Suite;
//                     Caption = 'Copy Document';
//                     Ellipsis = true;
//                     Enabled = "No." <> '';
//                     Image = CopyDocument;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     ToolTip = 'Copy document lines and header information from another purchase document to this document. You can copy a posted purchase invoice into a new purchase invoice to quickly create a similar document.';

//                     trigger OnAction()
//                     begin
//                         CopyPurchDoc.SetPurchHeader(Rec);
//                         CopyPurchDoc.RUNMODAL;
//                         CLEAR(CopyPurchDoc);
//                         IF GET("Document Type","No.") THEN;
//                     end;
//                 }
//                 action(MoveNegativeLines)
//                 {
//                     ApplicationArea = Suite;
//                     Caption = 'Move Negative Lines';
//                     Ellipsis = true;
//                     Image = MoveNegativeLines;
//                     ToolTip = 'Prepare to create a replacement sales order in a sales return process.';

//                     trigger OnAction()
//                     begin
//                         CLEAR(MoveNegPurchLines);
//                         MoveNegPurchLines.SetPurchHeader(Rec);
//                         MoveNegPurchLines.RUNMODAL;
//                         MoveNegPurchLines.ShowDocument;
//                     end;
//                 }
//                 group("Dr&op Shipment")
//                 {
//                     Caption = 'Dr&op Shipment';
//                     Image = Delivery;
//                     action(Functions_GetSalesOrder)
//                     {
//                         ApplicationArea = Suite;
//                         Caption = 'Get &Sales Order';
//                         Image = "Order";
//                         RunObject = Codeunit 76;
//                         ToolTip = 'Select the sales order that must be linked to the purchase order, for drop shipment or special order. ';
//                     }
//                 }
//                 group("Speci&al Order")
//                 {
//                     Caption = 'Speci&al Order';
//                     Image = SpecialOrder;
//                     action("Get &Sales Order")
//                     {
//                         AccessByPermission = TableData 110=R;
//                         ApplicationArea = Suite;
//                         Caption = 'Get &Sales Order';
//                         Image = "Order";
//                         ToolTip = 'Select the sales order that must be linked to the purchase order, for drop shipment or special order. ';

//                         trigger OnAction()
//                         var
//                             PurchHeader: Record "38";
//                             DistIntegration: Codeunit "5702";
//                         begin
//                             PurchHeader.COPY(Rec);
//                             DistIntegration.GetSpecialOrders(PurchHeader);
//                             Rec := PurchHeader;
//                         end;
//                     }
//                     action("Sales &Order")
//                     {
//                         Caption = 'Sales &Order';

//                         trigger OnAction()
//                         begin
//                             CurrPage.PurchLines.PAGE.OpenSpecOrderSalesOrderForm;
//                         end;
//                     }
//                 }
//                 action("Archive Document")
//                 {
//                     ApplicationArea = Suite;
//                     Caption = 'Archi&ve Document';
//                     Image = Archive;
//                     ToolTip = 'Send the document to the archive, for example because it is too soon to delete it. Later, you delete or reprocess the archived document.';

//                     trigger OnAction()
//                     begin
//                         ArchiveManagement.ArchivePurchDocument(Rec);
//                         CurrPage.UPDATE(FALSE);
//                     end;
//                 }
//                 action("Send Intercompany Purchase Order")
//                 {
//                     AccessByPermission = TableData 410=R;
//                     ApplicationArea = Intercompany;
//                     Caption = 'Send Intercompany Purchase Order';
//                     Image = IntercompanyOrder;
//                     ToolTip = 'Send the purchase order to the intercompany outbox or directly to the intercompany partner if automatic transaction sending is enabled.';

//                     trigger OnAction()
//                     var
//                         ICInOutboxMgt: Codeunit "427";
//                         ApprovalsMgmt: Codeunit "1535";
//                     begin
//                         IF ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) THEN
//                           ICInOutboxMgt.SendPurchDoc(Rec,FALSE);
//                     end;
//                 }
//                 separator()
//                 {
//                 }
//                 group(IncomingDocument)
//                 {
//                     Caption = 'Incoming Document';
//                     Image = Documents;
//                     action(IncomingDocCard)
//                     {
//                         ApplicationArea = Suite;
//                         Caption = 'View Incoming Document';
//                         Enabled = HasIncomingDocument;
//                         Image = ViewOrder;
//                         ToolTip = 'View any incoming document records and file attachments that exist for the entry or document, for example for auditing purposes';

//                         trigger OnAction()
//                         var
//                             IncomingDocument: Record "130";
//                         begin
//                             IncomingDocument.ShowCardFromEntryNo("Incoming Document Entry No.");
//                         end;
//                     }
//                     action(SelectIncomingDoc)
//                     {
//                         AccessByPermission = TableData 130=R;
//                         ApplicationArea = Suite;
//                         Caption = 'Select Incoming Document';
//                         Image = SelectLineToApply;
//                         ToolTip = 'Select an incoming document record and file attachment that you want to link to the entry or document.';

//                         trigger OnAction()
//                         var
//                             IncomingDocument: Record "130";
//                         begin
//                             VALIDATE("Incoming Document Entry No.",IncomingDocument.SelectIncomingDocument("Incoming Document Entry No.",RECORDID));
//                         end;
//                     }
//                     action(IncomingDocAttachFile)
//                     {
//                         ApplicationArea = Suite;
//                         Caption = 'Create Incoming Document from File';
//                         Ellipsis = true;
//                         Enabled = ("Incoming Document Entry No." = 0) AND ("No." <> '');
//                         Image = Attach;
//                         ToolTip = 'Create an incoming document from a file that you select from the disk. The file will be attached to the incoming document record.';

//                         trigger OnAction()
//                         var
//                             IncomingDocumentAttachment: Record "133";
//                         begin
//                             IncomingDocumentAttachment.NewAttachmentFromPurchaseDocument(Rec);
//                         end;
//                     }
//                     action(RemoveIncomingDoc)
//                     {
//                         ApplicationArea = Suite;
//                         Caption = 'Remove Incoming Document';
//                         Enabled = HasIncomingDocument;
//                         Image = RemoveLine;
//                         ToolTip = 'Remove any incoming document records and file attachments.';

//                         trigger OnAction()
//                         var
//                             IncomingDocument: Record "130";
//                         begin
//                             IF IncomingDocument.GET("Incoming Document Entry No.") THEN
//                               IncomingDocument.RemoveLinkToRelatedRecord;
//                             "Incoming Document Entry No." := 0;
//                             MODIFY(TRUE);
//                         end;
//                     }
//                 }
//             }
//             group("Request Approval")
//             {
//                 Caption = 'Request Approval';
//                 action(SendApprovalRequest)
//                 {
//                     ApplicationArea = Basic,Suite;
//                     Caption = 'Send A&pproval Request';
//                     Enabled = NOT OpenApprovalEntriesExist AND CanRequestApprovalForFlow;
//                     Image = SendApprovalRequest;
//                     Promoted = true;
//                     PromotedCategory = Category9;
//                     PromotedIsBig = true;
//                     PromotedOnly = true;
//                     ToolTip = 'Request approval of the document.';

//                     trigger OnAction()
//                     var
//                         ApprovalsMgmt: Codeunit "1535";
//                     begin
//                         IF ApprovalsMgmt.CheckPurchaseApprovalPossible(Rec) THEN
//                           ApprovalsMgmt.OnSendPurchaseDocForApproval(Rec);
//                     end;
//                 }
//                 action(CancelApprovalRequest)
//                 {
//                     ApplicationArea = Basic,Suite;
//                     Caption = 'Cancel Approval Re&quest';
//                     Enabled = CanCancelApprovalForRecord OR CanCancelApprovalForFlow;
//                     Image = CancelApprovalRequest;
//                     Promoted = true;
//                     PromotedCategory = Category9;
//                     PromotedIsBig = true;
//                     PromotedOnly = true;
//                     ToolTip = 'Cancel the approval request.';

//                     trigger OnAction()
//                     var
//                         ApprovalsMgmt: Codeunit "1535";
//                         WorkflowWebhookMgt: Codeunit "1543";
//                     begin
//                         ApprovalsMgmt.OnCancelPurchaseApprovalRequest(Rec);
//                         WorkflowWebhookMgt.FindAndCancel(RECORDID);
//                     end;
//                 }
//                 group(Flow)
//                 {
//                     Caption = 'Flow';
//                     Image = Flow;
//                     action(CreateFlow)
//                     {
//                         ApplicationArea = Basic,Suite;
//                         Caption = 'Create a Flow';
//                         Image = Flow;
//                         Promoted = true;
//                         PromotedCategory = Category9;
//                         PromotedOnly = true;
//                         ToolTip = 'Create a new Flow from a list of relevant Flow templates.';
//                         Visible = IsSaaS;

//                         trigger OnAction()
//                         var
//                             FlowServiceManagement: Codeunit "6400";
//                             FlowTemplateSelector: Page "6400";
//                         begin
//                             // Opens page 6400 where the user can use filtered templates to create new flows.
//                             FlowTemplateSelector.SetSearchText(FlowServiceManagement.GetPurchasingTemplateFilter);
//                             FlowTemplateSelector.RUN;
//                         end;
//                     }
//                     action(SeeFlows)
//                     {
//                         ApplicationArea = Basic,Suite;
//                         Caption = 'See my Flows';
//                         Image = Flow;
//                         Promoted = true;
//                         PromotedCategory = Category9;
//                         PromotedOnly = true;
//                         RunObject = Page 6401;
//                         ToolTip = 'View and configure Flows that you created.';
//                     }
//                 }
//             }
//             group(Warehouse)
//             {
//                 Caption = 'Warehouse';
//                 Image = Warehouse;
//                 action("Create &Whse. Receipt")
//                 {
//                     AccessByPermission = TableData 7316=R;
//                     ApplicationArea = Warehouse;
//                     Caption = 'Create &Whse. Receipt';
//                     Image = NewReceipt;
//                     ToolTip = 'Create a warehouse receipt to start a receive and put-away process according to an advanced warehouse configuration.';

//                     trigger OnAction()
//                     var
//                         GetSourceDocInbound: Codeunit "5751";
//                     begin
//                         GetSourceDocInbound.CreateFromPurchOrder(Rec);

//                         IF NOT FIND('=><') THEN
//                           INIT;
//                     end;
//                 }
//                 action("Create Inventor&y Put-away/Pick")
//                 {
//                     AccessByPermission = TableData 7340=R;
//                     ApplicationArea = Warehouse;
//                     Caption = 'Create Inventor&y Put-away/Pick';
//                     Ellipsis = true;
//                     Image = CreateInventoryPickup;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     ToolTip = 'Create an inventory put-away or inventory pick to handle items on the document according to a basic warehouse configuration that does not require warehouse receipt or shipment documents.';

//                     trigger OnAction()
//                     begin
//                         CreateInvtPutAwayPick;

//                         IF NOT FIND('=><') THEN
//                           INIT;
//                     end;
//                 }
//                 action("Get Gate Entry Lines")
//                 {
//                     Caption = 'Get Gate Entry Lines';

//                     trigger OnAction()
//                     begin
//                         //GetGateEntryLines;
//                     end;
//                 }
//                 separator()
//                 {
//                 }
//             }
//             group("P&osting")
//             {
//                 Caption = 'P&osting';
//                 Image = Post;
//                 action(Post)
//                 {
//                     ApplicationArea = Suite;
//                     Caption = 'P&ost';
//                     Ellipsis = true;
//                     Image = PostOrder;
//                     Promoted = true;
//                     PromotedCategory = Category6;
//                     PromotedIsBig = true;
//                     ShortCutKey = 'F9';
//                     ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';

//                     trigger OnAction()
//                     begin
//                         Post(CODEUNIT::"Purch.-Post (Yes/No)");
//                     end;
//                 }
//                 action(Preview)
//                 {
//                     ApplicationArea = Suite;
//                     Caption = 'Preview Posting';
//                     Image = ViewPostedOrder;
//                     Promoted = true;
//                     PromotedCategory = Category6;
//                     ToolTip = 'Review the different types of entries that will be created when you post the document or journal.';

//                     trigger OnAction()
//                     var
//                         PurchPostYesNo: Codeunit "91";
//                     begin
//                         PurchPostYesNo.Preview(Rec);
//                     end;
//                 }
//                 action("Post and &Print")
//                 {
//                     ApplicationArea = Suite;
//                     Caption = 'Post and &Print';
//                     Ellipsis = true;
//                     Image = PostPrint;
//                     Promoted = true;
//                     PromotedCategory = Category6;
//                     PromotedIsBig = true;
//                     ShortCutKey = 'Shift+F9';
//                     ToolTip = 'Finalize and prepare to print the document or journal. The values and quantities are posted to the related accounts. A report request window where you can specify what to include on the print-out.';

//                     trigger OnAction()
//                     begin
//                         Post(CODEUNIT::"Purch.-Post + Print");
//                     end;
//                 }
//                 action("Test Report")
//                 {
//                     ApplicationArea = Suite;
//                     Caption = 'Test Report';
//                     Ellipsis = true;
//                     Image = TestReport;
//                     ToolTip = 'View a test report so that you can find and correct any errors before you perform the actual posting of the journal or document.';

//                     trigger OnAction()
//                     begin
//                         ReportPrint.PrintPurchHeader(Rec);
//                     end;
//                 }
//                 action("Post &Batch")
//                 {
//                     ApplicationArea = Suite;
//                     Caption = 'Post &Batch';
//                     Ellipsis = true;
//                     Image = PostBatch;
//                     ToolTip = 'Post several documents at once. A report request window opens where you can specify which documents to post.';

//                     trigger OnAction()
//                     begin
//                         REPORT.RUNMODAL(REPORT::"Batch Post Purchase Orders",TRUE,TRUE,Rec);
//                         CurrPage.UPDATE(FALSE);
//                     end;
//                 }
//                 action("Remove From Job Queue")
//                 {
//                     ApplicationArea = Suite;
//                     Caption = 'Remove From Job Queue';
//                     Image = RemoveLine;
//                     ToolTip = 'Remove the scheduled processing of this record from the job queue.';
//                     Visible = JobQueueVisible;

//                     trigger OnAction()
//                     begin
//                         CancelBackgroundPosting;
//                     end;
//                 }
//                 separator()
//                 {
//                 }
//                 group("Prepa&yment")
//                 {
//                     Caption = 'Prepa&yment';
//                     Image = Prepayment;
//                     action("Prepayment Test &Report")
//                     {
//                         ApplicationArea = Prepayments;
//                         Caption = 'Prepayment Test &Report';
//                         Ellipsis = true;
//                         Image = PrepaymentSimulation;
//                         ToolTip = 'Preview the prepayment transactions that will results from posting the sales document as invoiced. ';

//                         trigger OnAction()
//                         begin
//                             ReportPrint.PrintPurchHeaderPrepmt(Rec);
//                         end;
//                     }
//                     action(PostPrepaymentInvoice)
//                     {
//                         ApplicationArea = Prepayments;
//                         Caption = 'Post Prepayment &Invoice';
//                         Ellipsis = true;
//                         Image = PrepaymentPost;
//                         ToolTip = 'Post the specified prepayment information. ';

//                         trigger OnAction()
//                         var
//                             ApprovalsMgmt: Codeunit "1535";
//                             PurchPostYNPrepmt: Codeunit "445";
//                         begin
//                             IF ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) THEN
//                               PurchPostYNPrepmt.PostPrepmtInvoiceYN(Rec,FALSE);
//                         end;
//                     }
//                     action("Post and Print Prepmt. Invoic&e")
//                     {
//                         ApplicationArea = Prepayments;
//                         Caption = 'Post and Print Prepmt. Invoic&e';
//                         Ellipsis = true;
//                         Image = PrepaymentPostPrint;
//                         ToolTip = 'Post the specified prepayment information and print the related report. ';

//                         trigger OnAction()
//                         var
//                             ApprovalsMgmt: Codeunit "1535";
//                             PurchPostYNPrepmt: Codeunit "445";
//                         begin
//                             IF ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) THEN
//                               PurchPostYNPrepmt.PostPrepmtInvoiceYN(Rec,TRUE);
//                         end;
//                     }
//                     action(PostPrepaymentCreditMemo)
//                     {
//                         ApplicationArea = Prepayments;
//                         Caption = 'Post Prepayment &Credit Memo';
//                         Ellipsis = true;
//                         Image = PrepaymentPost;
//                         ToolTip = 'Create and post a credit memo for the specified prepayment information.';

//                         trigger OnAction()
//                         var
//                             ApprovalsMgmt: Codeunit "1535";
//                             PurchPostYNPrepmt: Codeunit "445";
//                         begin
//                             IF ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) THEN
//                               PurchPostYNPrepmt.PostPrepmtCrMemoYN(Rec,FALSE);
//                         end;
//                     }
//                     action("Post and Print Prepmt. Cr. Mem&o")
//                     {
//                         ApplicationArea = Prepayments;
//                         Caption = 'Post and Print Prepmt. Cr. Mem&o';
//                         Ellipsis = true;
//                         Image = PrepaymentPostPrint;
//                         ToolTip = 'Create and post a credit memo for the specified prepayment information and print the related report.';

//                         trigger OnAction()
//                         var
//                             ApprovalsMgmt: Codeunit "1535";
//                             PurchPostYNPrepmt: Codeunit "445";
//                         begin
//                             IF ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) THEN
//                               PurchPostYNPrepmt.PostPrepmtCrMemoYN(Rec,TRUE);
//                         end;
//                     }
//                 }
//             }
//             group(Print)
//             {
//                 Caption = 'Print';
//                 Image = Print;
//                 action("&Print")
//                 {
//                     ApplicationArea = Suite;
//                     Caption = '&Print';
//                     Ellipsis = true;
//                     Image = Print;
//                     Promoted = true;
//                     PromotedCategory = Category10;
//                     ToolTip = 'Prepare to print the document. The report request window for the document opens where you can specify what to include on the print-out.';

//                     trigger OnAction()
//                     var
//                         PurchaseHeader: Record "38";
//                     begin
//                         PurchaseHeader := Rec;
//                         CurrPage.SETSELECTIONFILTER(PurchaseHeader);
//                         PurchaseHeader.PrintRecords(TRUE);
//                     end;
//                 }
//                 action(SendCustom)
//                 {
//                     ApplicationArea = Basic,Suite;
//                     Caption = 'Send';
//                     Ellipsis = true;
//                     Image = SendToMultiple;
//                     Promoted = true;
//                     PromotedCategory = Category10;
//                     PromotedIsBig = true;
//                     ToolTip = 'Prepare to send the document according to the vendor''s sending profile, such as attached to an email. The Send document to window opens first so you can confirm or select a sending profile.';

//                     trigger OnAction()
//                     var
//                         PurchaseHeader: Record "38";
//                     begin
//                         PurchaseHeader := Rec;
//                         CurrPage.SETSELECTIONFILTER(PurchaseHeader);
//                         PurchaseHeader.SendRecords;
//                     end;
//                 }
//             }
//             action("Purchase Order Analysis PDN")
//             {
//                 ApplicationArea = Suite;
//                 Caption = 'Purchase Order (PDN)  Analysis PDN';
//                 Ellipsis = true;
//                 Image = Print;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 ToolTip = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.';

//                 trigger OnAction()
//                 begin
//                     PurchaseHeader.RESET;
//                     PurchaseHeader.SETRANGE("No.","No.");
//                     IF PurchaseHeader.FINDFIRST THEN BEGIN
//                       CLEAR(PurchaseOrderAnalysisPDN);
//                       PurchaseOrderAnalysisPDN.SETTABLEVIEW(PurchaseHeader);
//                       PurchaseOrderAnalysisPDN.RUN;
//                     END;
//                 end;
//             }
//         }
//     }

//     trigger OnAfterGetCurrRecord()
//     begin
//         SetControlAppearance;
//         CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
//         CurrPage.ApprovalFactBox.PAGE.UpdateApprovalEntriesFromSourceRecord(RECORDID);
//         ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(RECORDID);
//     end;

//     trigger OnAfterGetRecord()
//     begin
//         CalculateCurrentShippingAndPayToOption;

//         IF Status = Status::Open THEN
//           Flag :=  TRUE;
//     end;

//     trigger OnDeleteRecord(): Boolean
//     begin
//         CurrPage.SAVERECORD;
//         EXIT(ConfirmDeletion);
//     end;

//     trigger OnInit()
//     var
//         PurchasesPayablesSetup: Record "312";
//         ApplicationAreaMgmtFacade: Codeunit "9179";
//     begin
//         JobQueueUsed := PurchasesPayablesSetup.JobQueueActive;
//         SetExtDocNoMandatoryCondition;
//         ShowShippingOptionsWithLocation := ApplicationAreaMgmtFacade.IsLocationEnabled OR ApplicationAreaMgmtFacade.IsAllDisabled;
//     end;

//     trigger OnNewRecord(BelowxRec: Boolean)
//     begin
//         "Responsibility Center" := UserMgt.GetPurchasesFilter;

//         IF (NOT DocNoVisible) AND ("No." = '') THEN
//           SetBuyFromVendorFromFilter;

//         CalculateCurrentShippingAndPayToOption;
//     end;

//     trigger OnOpenPage()
//     var
//         PermissionManager: Codeunit "9002";
//     begin
//         SetDocNoVisible;
//         IsSaaS := PermissionManager.SoftwareAsAService;

//         IF UserMgt.GetPurchasesFilter <> '' THEN BEGIN
//           FILTERGROUP(2);
//           SETRANGE("Responsibility Center",UserMgt.GetPurchasesFilter);
//           FILTERGROUP(0);
//         END;
//         IF ("No." <> '') AND ("Buy-from Vendor No." = '') THEN
//           DocumentIsPosted := (NOT GET("Document Type","No."));

//         ActivateFields;

//         Flag := TRUE;
//         IF Status = Status::Closed THEN
//           Flag :=  FALSE;
//     end;

//     trigger OnQueryClosePage(CloseAction: Action): Boolean
//     var
//         InstructionMgt: Codeunit "1330";
//     begin
//         IF ShowReleaseNotification THEN
//           IF NOT InstructionMgt.ShowConfirmUnreleased THEN
//             EXIT(FALSE);
//         IF NOT DocumentIsPosted THEN
//           EXIT(ConfirmCloseUnposted);
//     end;

//     var
//         CopyPurchDoc: Report "492";
//         MoveNegPurchLines: Report "6698";
//         ReportPrint: Codeunit "228";
//         UserMgt: Codeunit "5700";
//         ArchiveManagement: Codeunit "5063";
//         PurchCalcDiscByType: Codeunit "66";
//         FormatAddress: Codeunit "365";
//         ChangeExchangeRate: Page "511";
//         ShipToOptions: Option "Default (Company Address)",Location,"Customer Address","Custom Address";
//         PayToOptions: Option "Default (Vendor)","Another Vendor","Custom Address";
//         [InDataSet]
//         JobQueueVisible: Boolean;
//         [InDataSet]
//         JobQueueUsed: Boolean;
//         HasIncomingDocument: Boolean;
//         DocNoVisible: Boolean;
//         VendorInvoiceNoMandatory: Boolean;
//         OpenApprovalEntriesExistForCurrUser: Boolean;
//         OpenApprovalEntriesExist: Boolean;
//         ShowWorkflowStatus: Boolean;
//         CanCancelApprovalForRecord: Boolean;
//         DocumentIsPosted: Boolean;
//         OpenPostedPurchaseOrderQst: Label 'The order is posted as number %1 and moved to the Posted Purchase Invoices window.\\Do you want to open the posted invoice?', Comment='%1 = posted document number';
//         CanRequestApprovalForFlow: Boolean;
//         CanCancelApprovalForFlow: Boolean;
//         ShowShippingOptionsWithLocation: Boolean;
//         IsSaaS: Boolean;
//         IsBuyFromCountyVisible: Boolean;
//         IsPayToCountyVisible: Boolean;
//         IsShipToCountyVisible: Boolean;
//         PurchaseHeader: Record "38";
//         PurchaseOrderAnalysisPDN: Report "50078";
//         PurchaseLine: Record "39";
//         Flag: Boolean;
//         TEXT50000: Label 'Status of the Order must be Released';

//     local procedure ActivateFields()
//     begin
//         IsBuyFromCountyVisible := FormatAddress.UseCounty("Buy-from Country/Region Code");
//         IsPayToCountyVisible := FormatAddress.UseCounty("Pay-to Country/Region Code");
//         IsShipToCountyVisible := FormatAddress.UseCounty("Ship-to Country/Region Code");
//     end;

//     local procedure Post(PostingCodeunitID: Integer)
//     var
//         PurchaseHeader: Record "38";
//         InstructionMgt: Codeunit "1330";
//         ApplicationAreaMgmtFacade: Codeunit "9179";
//         LinesInstructionMgt: Codeunit "1320";
//         IsScheduledPosting: Boolean;
//     begin
//         IF ApplicationAreaMgmtFacade.IsFoundationEnabled THEN
//           LinesInstructionMgt.PurchaseCheckAllLinesHaveQuantityAssigned(Rec);

//         SendToPosting(PostingCodeunitID);

//         IsScheduledPosting := "Job Queue Status" = "Job Queue Status"::"Scheduled for Posting";
//         DocumentIsPosted := (NOT PurchaseHeader.GET("Document Type","No.")) OR IsScheduledPosting;

//         IF IsScheduledPosting THEN
//           CurrPage.CLOSE;
//         CurrPage.UPDATE(FALSE);

//         IF PostingCodeunitID <> CODEUNIT::"Purch.-Post (Yes/No)" THEN
//           EXIT;

//         IF InstructionMgt.IsEnabled(InstructionMgt.ShowPostedConfirmationMessageCode) THEN
//           ShowPostedConfirmationMessage;
//     end;

//     local procedure ApproveCalcInvDisc()
//     begin
//         CurrPage.PurchLines.PAGE.ApproveCalcInvDisc;
//     end;

//     local procedure SaveInvoiceDiscountAmount()
//     var
//         DocumentTotals: Codeunit "57";
//     begin
//         CurrPage.SAVERECORD;
//         DocumentTotals.PurchaseRedistributeInvoiceDiscountAmountsOnDocument(Rec);
//         CurrPage.UPDATE(FALSE);
//     end;

//     local procedure PurchaserCodeOnAfterValidate()
//     begin
//         CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
//     end;

//     local procedure ShortcutDimension1CodeOnAfterV()
//     begin
//         CurrPage.UPDATE;
//     end;

//     local procedure ShortcutDimension2CodeOnAfterV()
//     begin
//         CurrPage.UPDATE;
//     end;

//     local procedure PricesIncludingVATOnAfterValid()
//     begin
//         CurrPage.UPDATE;
//     end;

//     local procedure Prepayment37OnAfterValidate()
//     begin
//         CurrPage.UPDATE;
//     end;

//     local procedure SetDocNoVisible()
//     var
//         DocumentNoVisibility: Codeunit "1400";
//         DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Reminder,FinChMemo;
//     begin
//         DocNoVisible := DocumentNoVisibility.PurchaseDocumentNoIsVisible(DocType::Order,"No.");
//     end;

//     local procedure SetExtDocNoMandatoryCondition()
//     var
//         PurchasesPayablesSetup: Record "312";
//     begin
//         PurchasesPayablesSetup.GET;
//         VendorInvoiceNoMandatory := PurchasesPayablesSetup."Ext. Doc. No. Mandatory"
//     end;

//     local procedure SetControlAppearance()
//     var
//         ApprovalsMgmt: Codeunit "1535";
//         WorkflowWebhookMgt: Codeunit "1543";
//     begin
//         JobQueueVisible := "Job Queue Status" = "Job Queue Status"::"Scheduled for Posting";
//         HasIncomingDocument := "Incoming Document Entry No." <> 0;
//         SetExtDocNoMandatoryCondition;

//         OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID);
//         OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
//         CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);

//         WorkflowWebhookMgt.GetCanRequestAndCanCancel(RECORDID,CanRequestApprovalForFlow,CanCancelApprovalForFlow);
//     end;

//     local procedure ShowPostedConfirmationMessage()
//     var
//         OrderPurchaseHeader: Record "38";
//         PurchInvHeader: Record "122";
//         InstructionMgt: Codeunit "1330";
//     begin
//         IF NOT OrderPurchaseHeader.GET("Document Type","No.") THEN BEGIN
//           PurchInvHeader.SETRANGE("No.","Last Posting No.");
//           IF PurchInvHeader.FINDFIRST THEN
//             IF InstructionMgt.ShowConfirm(STRSUBSTNO(OpenPostedPurchaseOrderQst,PurchInvHeader."No."),
//                  InstructionMgt.ShowPostedConfirmationMessageCode)
//             THEN
//               PAGE.RUN(PAGE::"Posted Purchase Invoice",PurchInvHeader);
//         END;
//     end;

//     local procedure ValidateShippingOption()
//     begin
//         CASE ShipToOptions OF
//           ShipToOptions::"Default (Company Address)",
//           ShipToOptions::"Custom Address":
//             BEGIN
//               VALIDATE("Location Code",'');
//               VALIDATE("Sell-to Customer No.",'');
//             END;
//           ShipToOptions::Location:
//             BEGIN
//               VALIDATE("Location Code");
//               VALIDATE("Sell-to Customer No.",'');
//             END;
//           ShipToOptions::"Customer Address":
//             BEGIN
//               VALIDATE("Sell-to Customer No.");
//               VALIDATE("Location Code",'');
//             END;
//         END;
//     end;

//     local procedure ShowReleaseNotification(): Boolean
//     var
//         LocationsQuery: Query "5002";
//     begin
//         IF Status <> Status::Released THEN BEGIN
//           LocationsQuery.SETRANGE(Document_No,"No.");
//           LocationsQuery.SETRANGE(Require_Receive,TRUE);
//           LocationsQuery.OPEN;
//           IF LocationsQuery.READ THEN
//             EXIT(TRUE);
//           LocationsQuery.SETRANGE(Document_No,"No.");
//           LocationsQuery.SETRANGE(Require_Receive);
//           LocationsQuery.SETRANGE(Require_Put_away,TRUE);
//           LocationsQuery.OPEN;
//           EXIT(LocationsQuery.READ);
//         END;
//         EXIT(FALSE);
//     end;

//     local procedure CalculateCurrentShippingAndPayToOption()
//     begin
//         CASE TRUE OF
//           "Sell-to Customer No." <> '':
//             ShipToOptions := ShipToOptions::"Customer Address";
//           "Location Code" <> '':
//             ShipToOptions := ShipToOptions::Location;
//           ELSE
//             IF ShipToAddressEqualsCompanyShipToAddress THEN
//               ShipToOptions := ShipToOptions::"Default (Company Address)"
//             ELSE
//               ShipToOptions := ShipToOptions::"Custom Address";
//         END;

//         CASE TRUE OF
//           ("Pay-to Vendor No." = "Buy-from Vendor No.") AND BuyFromAddressEqualsPayToAddress:
//             PayToOptions := PayToOptions::"Default (Vendor)";
//           ("Pay-to Vendor No." = "Buy-from Vendor No.") AND (NOT BuyFromAddressEqualsPayToAddress):
//             PayToOptions := PayToOptions::"Custom Address";
//           "Pay-to Vendor No." <> "Buy-from Vendor No.":
//             PayToOptions := PayToOptions::"Another Vendor";
//         END;
//     end;
// }

