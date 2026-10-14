codeunit 50102 Events2
{

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Activity-Post", 'OnBeforePostedInvtPickHeaderInsert', '', false, false)]
    local procedure OnAfterPostedInvtPickHeaderInsert(var PostedInvtPickHeader: Record "Posted Invt. Pick Header"; WarehouseActivityHeader: Record "Warehouse Activity Header")
    var
        SalesHeader: Record "Sales Header";
    begin
        PostedInvtPickHeader."Shipping Method" := WarehouseActivityHeader."Shipping Method";
        PostedInvtPickHeader."Requested Delivery Date" := WarehouseActivityHeader."Requested Delivery Date";
        PostedInvtPickHeader."Promised Delivery Date" := WarehouseActivityHeader."Promised Delivery Date";
        PostedInvtPickHeader."Ship-to code" := WarehouseActivityHeader."Ship-to code";
        PostedInvtPickHeader."Ship-to Name" := WarehouseActivityHeader."Ship-To Name";
        PostedInvtPickHeader."Ship-to Address" := WarehouseActivityHeader."Ship-To Address";
        PostedInvtPickHeader."Ship-to Address 2" := WarehouseActivityHeader."Ship-To Address 2";
        PostedInvtPickHeader."Ship-to City" := WarehouseActivityHeader."Ship-To City";
        PostedInvtPickHeader."Ship-to Post Code" := WarehouseActivityHeader."Ship-To Post Code";
        PostedInvtPickHeader."Ship-to Country/Region Code" := WarehouseActivityHeader."Ship-to Country/Region Code";
        PostedInvtPickHeader."Shipping Agent Code" := WarehouseActivityHeader."Shipping Agent Code";
        PostedInvtPickHeader."Shipping Agent Service Code" := WarehouseActivityHeader."Shipping Agent Service Code";
    end;

    //Rehan++
    // Inventory Picks must always post with today's date, regardless of the Posting Date
    // stored on the header when the pick was created. Whse.-Activity-Post re-reads the header
    // right after this event, so the new date flows into the sales header, item and warehouse entries.
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Activity-Post", 'OnBeforeCode', '', false, false)]
    local procedure OnBeforeWhseActivityPostSetInvtPickPostingDateToday(var WarehouseActivityLine: Record "Warehouse Activity Line"; var SuppressCommit: Boolean; var IsHandled: Boolean)
    var
        WarehouseActivityHeader: Record "Warehouse Activity Header";
    begin
        if WarehouseActivityLine."Activity Type" <> WarehouseActivityLine."Activity Type"::"Invt. Pick" then
            exit;
        if not WarehouseActivityHeader.Get(WarehouseActivityLine."Activity Type", WarehouseActivityLine."No.") then
            exit;
        if WarehouseActivityHeader."Posting Date" = Today() then
            exit;

        WarehouseActivityHeader.Validate("Posting Date", Today());
        WarehouseActivityHeader.Modify(true);
    end;
    //Rehan--


    [EventSubscriber(ObjectType::Report, Report::"Create Invt Put-away/Pick/Mvmt", 'OnAfterInitWhseActivHeader', '', false, false)]
    local procedure OnAfterInitWhseActivHeader(var WarehouseActivityHeader: Record "Warehouse Activity Header"; var WarehouseRequest: Record "Warehouse Request")
    var
        SalesHeader: Record "Sales Header";
    begin
        if WarehouseRequest."Source Document" <>
           WarehouseRequest."Source Document"::"Sales Order"
        then
            exit;

        if not SalesHeader.Get(SalesHeader."Document Type"::Order, WarehouseRequest."Source No.")
        then
            exit;

        WarehouseActivityHeader."Shipping Method" := SalesHeader."Shipment Method Code";
        WarehouseActivityHeader."Requested Delivery Date" := SalesHeader."Requested Delivery Date";
        WarehouseActivityHeader."Promised Delivery Date" := SalesHeader."Promised Delivery Date";
        WarehouseActivityHeader."Ship-to Code" := SalesHeader."Ship-to Code";
        WarehouseActivityHeader."Ship-To Name" := SalesHeader."Ship-To Name";
        WarehouseActivityHeader."Ship-To Address" := SalesHeader."Ship-To Address";
        WarehouseActivityHeader."Ship-To Address 2" := SalesHeader."Ship-To Address 2";
        WarehouseActivityHeader."Ship-To City" := SalesHeader."Ship-To City";
        WarehouseActivityHeader."Ship-To Post Code" := SalesHeader."Ship-To Post Code";
        WarehouseActivityHeader."Ship-to Country/Region Code" := SalesHeader."Ship-to Country/Region Code";
        WarehouseActivityHeader."Shipping Agent Code" := SalesHeader."Shipping Agent Code";
        WarehouseActivityHeader."Shipping Agent Service Code" := SalesHeader."Shipping Agent Service Code";
    end;


    // Subcontracting-generated Purchase Order lines carry a "Work Center No.", which makes
    // PurchaseLine.IsWorkCenter() return true. Codeunit "Whse.-Purch. Release" skips Warehouse
    // Request creation for such lines on Release, so "Create Whse. Receipt" later finds nothing
    // to pull in even though the location requires receiving. Re-create the missing request here.
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Purch. Release", 'OnAfterRelease', '', false, false)]
    local procedure OnAfterWhsePurchReleaseCreateMissingSubcontractWhseRequest(var PurchaseHeader: Record "Purchase Header")
    var
        PurchaseLine: Record "Purchase Line";
        Location: Record Location;
        WarehouseRequest: Record "Warehouse Request";
    begin
        if PurchaseHeader."Document Type" <> PurchaseHeader."Document Type"::Order then
            exit;

        PurchaseLine.SetRange("Document Type", PurchaseHeader."Document Type");
        PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
        PurchaseLine.SetRange(Type, PurchaseLine.Type::Item);
        PurchaseLine.SetRange("Drop Shipment", false);
        PurchaseLine.SetFilter("Work Center No.", '<>%1', '');
        if not PurchaseLine.FindSet() then
            exit;

        repeat
            if PurchaseLine.IsInventoriableItem() and (PurchaseLine.Quantity >= 0) and
               (Location.RequireReceive(PurchaseLine."Location Code") or Location.RequirePutaway(PurchaseLine."Location Code"))
            then begin
                WarehouseRequest.Reset();
                WarehouseRequest.SetRange("Source Type", Database::"Purchase Line");
                WarehouseRequest.SetRange("Source Subtype", PurchaseHeader."Document Type".AsInteger());
                WarehouseRequest.SetRange("Source No.", PurchaseHeader."No.");
                WarehouseRequest.SetRange("Location Code", PurchaseLine."Location Code");
                if WarehouseRequest.IsEmpty() then begin
                    WarehouseRequest.Init();
                    WarehouseRequest.Type := WarehouseRequest.Type::Inbound;
                    WarehouseRequest."Source Document" := WarehouseRequest."Source Document"::"Purchase Order";
                    WarehouseRequest."Source Type" := Database::"Purchase Line";
                    WarehouseRequest."Source Subtype" := PurchaseHeader."Document Type".AsInteger();
                    WarehouseRequest."Source No." := PurchaseHeader."No.";
                    WarehouseRequest."Shipment Method Code" := PurchaseHeader."Shipment Method Code";
                    WarehouseRequest."Document Status" := PurchaseHeader.Status::Released.AsInteger();
                    WarehouseRequest."Location Code" := PurchaseLine."Location Code";
                    WarehouseRequest."Destination Type" := WarehouseRequest."Destination Type"::Vendor;
                    WarehouseRequest."Destination No." := PurchaseHeader."Buy-from Vendor No.";
                    WarehouseRequest."External Document No." := PurchaseHeader."Vendor Shipment No.";
                    WarehouseRequest."Expected Receipt Date" := PurchaseHeader."Expected Receipt Date";
                    WarehouseRequest.Insert(true);
                end;
            end;
        until PurchaseLine.Next() = 0;
    end;

    // "Calculate Subcontract Orders" deliberately zeroes "Qty. per Unit of Measure" on the
    // Requisition Line for subcontracting lines (see report "Calculate Subcontracts"). When the
    // Requisition Line is carried out to a Purchase Order, "Req. Wksh.-Make Order" first sets
    // "Qty. per Unit of Measure" correctly via Validate("Unit of Measure Code", ...) but then
    // immediately overwrites it with that zeroed Requisition Line value, so the subsequent
    // Validate(Quantity, ...) computes "Quantity (Base)" / "Outstanding Qty. (Base)" as 0 even
    // though Quantity is correct. That silently blocks warehouse receiving. Manually-entered
    // Purchase Lines never hit this path, which is why only auto-created ones are affected.
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Req. Wksh.-Make Order", 'OnInitPurchOrderLineOnBeforeUpdateQuantity', '', false, false)]
    local procedure OnInitPurchOrderLineOnBeforeUpdateQuantityFixZeroQtyPerUOM(var PurchOrderLine: Record "Purchase Line"; var RequisitionLine: Record "Requisition Line")
    var
        Item: Record Item;
        UOMMgt: Codeunit "Unit of Measure Management";
    begin
        if PurchOrderLine."Qty. per Unit of Measure" <> 0 then
            exit;
        if PurchOrderLine."Unit of Measure Code" = '' then
            exit;
        if not Item.Get(PurchOrderLine."No.") then
            exit;

        PurchOrderLine."Qty. per Unit of Measure" := UOMMgt.GetQtyPerUnitOfMeasure(Item, PurchOrderLine."Unit of Measure Code");
    end;
    //Rehan++
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnValidateUnitOfMeasureCodeOnBeforeValidateQuantity', '', false, false)]
    local procedure OnValidateUoMFixSubcontractQtyPerUOM(var PurchaseLine: Record "Purchase Line"; xPurchaseLine: Record "Purchase Line"; Item: Record Item)
    var
        ItemRec: Record Item;
        UOMMgt: Codeunit "Unit of Measure Management";
    begin
        if (PurchaseLine.Type <> PurchaseLine.Type::Item) or (PurchaseLine."Prod. Order No." = '') then
            exit;
        if (PurchaseLine."Qty. per Unit of Measure" <> 0) or (PurchaseLine."Unit of Measure Code" = '') then
            exit;
        if ItemRec.Get(PurchaseLine."No.") then
            PurchaseLine."Qty. per Unit of Measure" := UOMMgt.GetQtyPerUnitOfMeasure(ItemRec, PurchaseLine."Unit of Measure Code");
    end;

    //Rehan--
    [EventSubscriber(ObjectType::Table, Database::"Tracking Specification", 'OnAfterValidateEvent', 'Expiration Date', false, false)]
    local procedure OnAfterValidateExpirationDate(var Rec: Record "Tracking Specification"; var xRec: Record "Tracking Specification"; CurrFieldNo: Integer)
    var
        PurchaseLine: Record "Purchase Line";
        WarehouseReceiptLine: Record "Warehouse Receipt Line";
        MaxExpiryDate: Date;
        ConfirmExpiry: Boolean;
    begin
        if not GuiAllowed() then
            exit;

        if Rec."Expiration Date" = 0D then
            exit;

        // Purchase Line
        if Rec."Source Type" = Database::"Purchase Line" then begin

            PurchaseLine.Reset();
            PurchaseLine.SetRange("Document No.", Rec."Source ID");
            PurchaseLine.SetRange("Line No.", Rec."Source Ref. No.");

            if not PurchaseLine.FindFirst() then
                exit;
        end

        // Warehouse Receipt Line
        else if Rec."Source Type" = Database::"Warehouse Receipt Line" then begin

            WarehouseReceiptLine.Reset();
            WarehouseReceiptLine.SetRange("No.", Rec."Source ID");
            WarehouseReceiptLine.SetRange("Line No.", Rec."Source Ref. No.");

            if not WarehouseReceiptLine.FindFirst() then
                exit;

            // Make sure the warehouse receipt line comes from a Purchase Line
            if WarehouseReceiptLine."Source Type" <> Database::"Purchase Line" then
                exit;

            PurchaseLine.Reset();
            PurchaseLine.SetRange("Document No.", WarehouseReceiptLine."Source No.");
            PurchaseLine.SetRange("Line No.", WarehouseReceiptLine."Source Line No.");

            if not PurchaseLine.FindFirst() then
                exit;
        end
        else
            exit;

        MaxExpiryDate := CalcDate('<12M>', Today);

        if (Rec."Expiration Date" >= Today) and (Rec."Expiration Date" <= MaxExpiryDate)
        then begin
            ConfirmExpiry := Confirm('The expiry date %1 is within 12 months from todays date %2.' + '\Do you want to keep this expiry date?', true, Rec."Expiration Date", Today);

            if not ConfirmExpiry then Rec."Expiration Date" := 0D;
        end;
    end;
}