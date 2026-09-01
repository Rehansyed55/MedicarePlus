codeunit 50101 "Subcon TA Reference Mgt."
{


    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertPurchaseLine(var Rec: Record "Purchase Line"; RunTrigger: Boolean)
    begin
        if Rec.IsTemporary() then
            exit;

        UpdateTARefOnPurchHeader(Rec);
        //UpdateItemDescriptionOnPurchLine(rec);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterModifyEvent', '', false, false)]
    local procedure OnAfterModifyPurchaseLine(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; RunTrigger: Boolean)
    begin
        if Rec.IsTemporary() then
            exit;


        UpdateItemDescriptionOnPurchLine(Rec);
    end;


    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterValidateEvent', 'Prod. Order No.', false, false)]
    local procedure OnAfterValidateProdOrderNoOnPurchLine(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line")
    begin
        if Rec.IsTemporary() then
            exit;

        UpdateTARefOnPurchHeader(Rec);
    end;


    local procedure UpdateTARefOnPurchHeader(var PurchLine: Record "Purchase Line")
    var
        PurchaseHeader: Record "Purchase Header";
        ProdOrder: Record "Production Order";
    begin

        if PurchLine."Prod. Order No." = '' then
            exit;

        if not ProdOrder.Get(ProdOrder.Status::Released, PurchLine."Prod. Order No.") then
            exit;

        if ProdOrder."Technical Agreement No." = '' then
            exit;

        if not PurchaseHeader.Get(PurchLine."Document Type", PurchLine."Document No.") then
            exit;

        if PurchaseHeader."Technical Agreement No." = ProdOrder."Technical Agreement No." then
            exit;

        PurchaseHeader."Technical Agreement No." := ProdOrder."Technical Agreement No.";
        PurchaseHeader.Modify(false);
    end;

    local procedure UpdateItemDescriptionOnPurchLine(var PurchLine: Record "Purchase Line")
    var
        Item: Record Item;
    begin

        if PurchLine."Prod. Order No." = '' then
            exit;

        if PurchLine.Type <> PurchLine.Type::Item then
            exit;

        if PurchLine."No." = '' then
            exit;

        if not Item.Get(PurchLine."No.") then
            exit;

        if PurchLine.Description = Item.Description then
            exit;

        PurchLine.Description := Item.Description;
        PurchLine."Description 2" := Item."Description 2";

        PurchLine.Modify(false);
    end;
}

