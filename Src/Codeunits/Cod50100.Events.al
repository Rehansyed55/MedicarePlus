codeunit 50000 Events
{

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnUpdateUnitPriceOnBeforeFindPrice, '', false, false)]
    local procedure "Sales Line_OnUpdateUnitPriceOnBeforeFindPrice"(SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; CalledByFieldNo: Integer; CallingFieldNo: Integer; var IsHandled: Boolean; xSalesLine: Record "Sales Line")
    begin
        if SalesLine.Quantity <> 0 then Ishandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnAfterUpdateUnitPrice, '', false, false)]
    local procedure "Sales Line_OnAfterUpdateUnitPrice"(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line"; CalledByFieldNo: Integer; CurrFieldNo: Integer)
    var
        Salesprice: Record "Sales Price";
    begin
        //Upgradation
        IF SalesLine.Quantity = 0 THEN BEGIN
            //IF "Unit Price" = 0 THEN
            //BEGIN
            Salesprice.SETRANGE(Salesprice."Sales Type", Salesprice."Sales Type"::"Customer Price Group");
            Salesprice.SETRANGE(Salesprice."Item No.", SalesLine."No.");
            Salesprice.SETRANGE(Salesprice."Sales Code", SalesLine."Customer Price Group");
            IF Salesprice.FINDFIRST THEN BEGIN
                SalesLine.VALIDATE("Unit Price", Salesprice."Unit Price");
            END;
        END;
        //Upgradation
    end;

    // [EventSubscriber(ObjectType::Table, Database::"Purchase Line", OnBeforeValidateDescription, '', false, false)]
    // local procedure "Purchase Line_OnBeforeValidateDescription"(var PurchaseLine: Record "Purchase Line"; xPurchaseLine: Record "Purchase Line"; CurrentFieldNo: Integer; var InHandled: Boolean)
    // var
    //     ItemCharge: record "Item Charge";
    //     ConfirmManagement: Codeunit 27;
    // begin
    //     case PurchaseLine.Type
    //         of
    //         "Purchase Line Type"::"Charge (Item)":
    //             begin
    //                 if PurchaseLine.Type = PurchaseLine.Type::" " then
    //                     exit;

    //                 if PurchaseLine."No." <> '' then
    //                     exit;

    //                 ItemCharge.SETFILTER(Description, '@%1', CONVERTSTR(PurchaseLine.Description, '''', '?'));
    //                 IF NOT ItemCharge.FINDFIRST THEN
    //                     EXIT;
    //                 IF ItemCharge."No." = PurchaseLine."No." THEN
    //                     EXIT;
    //                 IF ConfirmManagement.GetResponse(
    //                      STRSUBSTNO(AnotherChargeItemWithSameDescQst, ItemCharge."No.", ItemCharge.Description), TRUE)
    //                 THEN
    //                     PurchaseLine.VALIDATE("No.", ItemCharge."No.");

    //                 InHandled := true;
    //             end;
    //     end;
    // end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", OnValidateQuantityOnBeforeCheckWMS, '', false, false)]
    local procedure "Purchase Line_OnValidateQuantityOnBeforeCheckWMS"(var PurchaseLine: Record "Purchase Line"; var IsHandled: Boolean)
    begin
        //Alok For Qty  on Blanket
        IF PurchaseLine."Document Type" = PurchaseLine."Document Type"::"Blanket Order" THEN BEGIN
            PurchaseLine."Qty. on Blanket Order(Actual)" := PurchaseLine.Quantity;


            PurchaseLine."Qty. on Blanket Order(Actual)" := PurchaseLine."Qty. on Blanket Order(Actual)" * PurchaseLine."Qty. per Unit of Measure";
        END;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", OnUpdateDirectUnitCostOnBeforeFindPrice, '', false, false)]
    local procedure "Purchase Line_OnUpdateDirectUnitCostOnBeforeFindPrice"(PurchaseHeader: Record "Purchase Header"; var PurchaseLine: Record "Purchase Line"; CalledByFieldNo: Integer; CallingFieldNo: Integer; var IsHandled: Boolean; xPurchaseLine: Record "Purchase Line")
    var
        PurchPriceCalcMgt: codeunit 7010;
    begin
        //alok for UOM
        IF (CalledByFieldNo <> 5407) THEN BEGIN
            //(xRec."Unit of Measure Code"='') AND  THEN BEGIN
            IF PurchaseLine.Type = PurchaseLine.Type::Item THEN BEGIN
                PurchaseLine.GetPurchHeader;
                PurchPriceCalcMgt.FindPurchLinePrice(PurchaseHeader, PurchaseLine, CalledByFieldNo);
                PurchPriceCalcMgt.FindPurchLineLineDisc(PurchaseHeader, PurchaseLine);
                PurchaseLine.VALIDATE("Direct Unit Cost");
            END;
            //alok finish
            IF (CalledByFieldNo IN [PurchaseLine.FIELDNO("No."), PurchaseLine.FIELDNO("Variant Code"), PurchaseLine.FIELDNO("Location Code")])
            AND (PurchaseLine.Type = PurchaseLine.Type::Item) THEN  //robo-upgrade
                PurchaseLine.SetVendorItemNo;
        END;
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Production Order", OnBeforeAssignItemNo, '', false, false)]
    local procedure "Production Order_OnBeforeAssignItemNo"(var ProdOrder: Record "Production Order"; xProdOrder: Record "Production Order"; var Item: Record Item; CallingFieldNo: Integer)
    begin
        ProdOrder."No.of Actions" := Item."No.of Actions" + 2;//Nikhil_11/02/2021_(CAS-23877-S6C5N4)
    end;

    [EventSubscriber(ObjectType::Table, Database::"Prod. Order Line", OnAfterCopyFromItem, '', false, false)]
    local procedure "Prod. Order Line_OnAfterCopyFromItem"(var ProdOrderLine: Record "Prod. Order Line"; Item: Record Item; var xProdOrderLine: Record "Prod. Order Line"; CurrentFieldNo: Integer)
    var
        ProdHeader_Rec: Record 5405;
    begin
        //Upgraded Code from NAV 5.0
        //=================================================================
        IF ProdHeader_Rec.GET(ProdOrderLine.Status, ProdOrderLine."Prod. Order No.") THEN BEGIN
            IF ProdHeader_Rec."PLPI Item Code" = TRUE THEN BEGIN
                ProdOrderLine.VALIDATE("Production BOM No.", ProdHeader_Rec."Production BOM No.");
                ProdOrderLine.VALIDATE("Production BOM Version Code", ProdHeader_Rec."Production BOM Version No.");
                ProdOrderLine.VALIDATE("Routing No.", ProdHeader_Rec."Routing No.");
            END;
        END;
        //=================================================================================

    end;

    // Keep the Routing No. entered on the Production Order header during Refresh Production Order
    // instead of resetting it to the Item/SKU default. The header is already defaulted from Item/SKU
    // when Source No./Variant/Location is validated, so a non-blank value here is either the default or a user change.
    [EventSubscriber(ObjectType::Report, Report::"Refresh Production Order", OnAfterGetRoutingNo, '', false, false)]
    local procedure "Refresh Production Order_OnAfterGetRoutingNo"(var ProductionOrder: Record "Production Order"; var RoutingNo: Code[20])
    begin
        if (ProductionOrder."Source Type" = ProductionOrder."Source Type"::Item) and (ProductionOrder."Routing No." <> '') then
            RoutingNo := ProductionOrder."Routing No.";
    end;

    // Apply the header Routing No. to the main Prod. Order Line, so the Prod. Order Routing Lines
    // (used by Calculate Subcontracts) are built from the routing selected on the header.
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Prod. Order Lines", OnAfterInitProdOrderLine, '', false, false)]
    local procedure "Create Prod. Order Lines_OnAfterInitProdOrderLine"(var ProdOrderLine: Record "Prod. Order Line"; ProdOrder: Record "Production Order"; SalesLine: Record "Sales Line")
    begin
        if ProdOrder."Source Type" <> ProdOrder."Source Type"::Item then
            exit;
        if (ProdOrder."Routing No." = '') or (ProdOrderLine."Item No." <> ProdOrder."Source No.") then
            exit;
        if ProdOrderLine."Routing No." <> ProdOrder."Routing No." then
            ProdOrderLine.Validate("Routing No.", ProdOrder."Routing No.");
    end;



    var
        AnotherChargeItemWithSameDescQst: Label 'Item charge No. %1 also has the description "%2".\Do you want to change the current item charge no. to %1?', Comment = '%1=Item charge no., %2=item charge description';


}
