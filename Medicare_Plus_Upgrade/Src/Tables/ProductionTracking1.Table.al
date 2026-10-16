table 50055 "Production Tracking1"
{

    fields
    {
        field(1; "Production Order No."; Code[20])
        {
            TableRelation = "Prod. Order Line"."Prod. Order No." WHERE("Line No." = FILTER(10000));

            trigger OnValidate()
            begin
                ProdOrderLine.RESET;
                ProdOrderLine.SETRANGE(ProdOrderLine."Prod. Order No.", "Production Order No.");
                ProdOrderLine.SETRANGE(ProdOrderLine."Line No.", 10000);
                IF ProdOrderLine.FINDFIRST THEN BEGIN
                    "Item Code" := ProdOrderLine."Item No.";
                    "Item Description" := ProdOrderLine.Description;
                    Uom := ProdOrderLine."Unit of Measure Code";
                    Qty := ProdOrderLine."Quantity (Base)";
                END;
                ProdOrderRoutingLine.RESET;
                ProdOrderRoutingLine.SETRANGE(ProdOrderRoutingLine.Type, ProdOrderRoutingLine.Type::"Work Center");
                ProdOrderRoutingLine.SETRANGE(ProdOrderRoutingLine."Prod. Order No.", "Production Order No.");
                IF ProdOrderRoutingLine.FINDFIRST THEN BEGIN
                    "Room No." := ProdOrderRoutingLine."No.";
                END;
            end;
        }
        field(2; "Item Code"; Code[20])
        {
        }
        field(3; "Item Description"; Text[100])
        {
        }
        field(4; "On Sales Order"; Decimal)
        {
            CalcFormula = Sum("Sales Line"."Outstanding Quantity" WHERE("No." = FIELD("Item Code"),
                                                                         Type = CONST(Item)));
            FieldClass = FlowField;
        }
        field(5; "On Purchase Order"; Decimal)
        {
            CalcFormula = Sum("Purchase Line"."Outstanding Quantity" WHERE(Type = CONST(Item),
                                                                            "No." = FIELD("Item Code")));
            FieldClass = FlowField;
        }
        field(6; "Goods Check In"; Decimal)
        {
            TableRelation = "Warehouse Entry".Quantity WHERE("Item No." = FIELD("Item Code"),
                                                              "Zone Code" = CONST('CHECKED-Z'));
        }
        field(7; Production; Decimal)
        {
            TableRelation = "Warehouse Entry".Quantity WHERE("Item No." = FIELD("Item Code"),
                                                              "Zone Code" = CONST('PROD-Z'));
        }
        field(8; Free; Decimal)
        {
            TableRelation = "Warehouse Entry".Quantity WHERE("Item No." = FIELD("Item Code"),
                                                              "Zone Code" = CONST('FREE-Z'));
        }
        field(9; "Allocated To Sales For Disp."; Decimal)
        {
        }
        field(10; Qty; Decimal)
        {
        }
        field(11; Uom; Code[20])
        {
        }
        field(12; "Goods Receipt Date"; Date)
        {
        }
        field(13; "Date Of Production Order"; Date)
        {
        }
        field(14; "Room No."; Code[20])
        {
        }
        field(15; "Priority of the day"; Integer)
        {
        }
        field(16; "Production Begin Time"; Date)
        {
        }
        field(17; "Production End Time"; Date)
        {
        }
        field(18; "Labels Issues"; Code[1])
        {
        }
        field(19; "Component Issued"; Code[1])
        {
        }
    }

    keys
    {
        key(Key1; "Production Order No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        ProdOrderLine: Record 5406;
        ProdOrderRoutingLine: Record 5409;
}

