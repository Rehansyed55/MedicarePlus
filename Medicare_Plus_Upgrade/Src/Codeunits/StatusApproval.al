codeunit 50100 StatusApproval
{
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnBeforeValidateEvent', 'No.', true, true)]
    local procedure OnBeforeValidateEventPO(var Rec: Record "Purchase Line")
    var
        L_Item: Record Item;
    begin
        if (Rec.Type = Rec.Type::Item) AND ((Rec."Document Type" = Rec."Document Type"::Order) OR (Rec."Document Type" = Rec."Document Type"::"Blanket Order") or (Rec."Document Type" = Rec."Document Type"::Invoice) or (Rec."Document Type" = Rec."Document Type"::"Credit Memo") or (Rec."Document Type" = Rec."Document Type"::"Return Order")) then begin
            L_Item.Reset();
            if L_Item.Get(Rec."No.") then begin
                if L_Item.Status <> L_Item.Status::Released then
                    Error('Item status should be Released for item %1', L_Item."No.");
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeValidateEvent', 'No.', true, true)]
    local procedure OnBeforeValidateEventSO(var Rec: Record "Sales Line")
    var
        L_Item: Record Item;
    begin
        if (Rec.Type = Rec.Type::Item) and (Rec."Document Type" in [Rec."Document Type"::Order, Rec."Document Type"::"Blanket Order", Rec."Document Type"::"Credit Memo", Rec."Document Type"::"Return Order", rec."Document Type"::Invoice]) then begin
            L_Item.Reset();
            if L_Item.Get(Rec."No.") then begin
                if L_Item.Status <> L_Item.Status::Released then
                    Error('Item status should be Released for item %1', L_Item."No.");
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'Sell-to Customer No.', true, true)]
    local procedure OnBeforeValidateSellToCustomer(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer)
    var
        CustomerRec: Record Customer;
    begin
        if Rec."Sell-to Customer No." = '' then
            exit;
        //Sales Order and Sales Invoice Sales Credit Memos & Sales Return Order:
        if Rec."Document Type" in [Rec."Document Type"::"Credit Memo", Rec."Document Type"::Order, Rec."Document Type"::"Return Order", rec."Document Type"::Invoice] then begin
            if CustomerRec.Get(Rec."Sell-to Customer No.") then begin

                if CustomerRec.Status = CustomerRec.Status::Open then
                    Error('Customer %1 is in Open status. You cannot use this customer.', CustomerRec."No.");
            end;
        end;

    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterValidateEvent', 'Buy-from Vendor No.', true, true)]
    local procedure OnAfterValidateBuyFromVendor(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header"; CurrFieldNo: Integer)
    var
        VendorRec: Record Vendor;
    begin
        if Rec."Buy-from Vendor No." = '' then
            exit;
        //Blanket Purchase Order, Purchase Order, and Purchase Invoice:
        if Rec."Document Type" in [Rec."Document Type"::Order, Rec."Document Type"::"Blanket Order", Rec."Document Type"::Invoice] then begin
            if VendorRec.Get(Rec."Buy-from Vendor No.") then begin

                if VendorRec.Status = VendorRec.Status::Open then
                    Error('Vendor %1 is in Open status. You cannot use this vendor.', VendorRec."No.");
            end;
        end;
    end;


    var
        myInt: Integer;
}