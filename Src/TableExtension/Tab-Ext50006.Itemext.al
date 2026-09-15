tableextension 50006 "Item ext" extends Item
{
    fields
    {
        field(50000; "Stock Value (LCY)"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Value Entry"."Cost Amount (Actual)" WHERE("Item No." = FIELD("No."),
                                                                          "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                          "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                          "Location Code" = FIELD("Location Filter"),
                                                                          "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                          "Variant Code" = FIELD("Variant Filter"),
                                                                          "Posting Date" = FIELD("Date Filter")));

        }
        field(50001; "Qty on Blanket Order"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Purchase Line"."Outstanding Qty. (Base)" WHERE("Document Type" = CONST("Purchase Document Type"::"Blanket Order"),
                                                                               Type = CONST(Item),
                                                                               "No." = FIELD("No."),
                                                                               "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                               "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                               "Location Code" = FIELD("Location Filter"),
                                                                               "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                               "Variant Code" = FIELD("Variant Filter"),
                                                                               "Expected Receipt Date" = FIELD("Date Filter"),
                                                                               Status = FILTER(<> Closed)));
            DecimalPlaces = 0 : 0;
            Description = '//Upgradation Nav13';
            Editable = false;
        }
        field(50002; "No.of Actions"; Integer)
        {
            Description = '//Upgradation Nav13';
        }
        field(50003; "Qty. on Blanket Order(Actual)"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Purchase Line"."Qty. on Blanket Order(Actual)" WHERE("Document Type" = CONST("Blanket Order"),
                                                                                     Type = CONST(Item),
                                                                                     "No." = FIELD("No."),
                                                                                     "Location Code" = FIELD("Location Filter"),
                                                                                     "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                                     "Variant Code" = FIELD("Variant Filter"),
                                                                                     "Expected Receipt Date" = FIELD("Date Filter"),
                                                                                     Status = FILTER(<> Closed),
                                                                                     "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                                     "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter")));
            Description = '//Upgradation Nav13';
            Editable = false;
        }
        field(50005; "Qty. on Planned Blanket Order"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Purchase Price".Quantity WHERE("Item No." = FIELD("No.")));
            Description = '//Upgradation Nav13';
        }
        field(50006; Inventory2; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("No."),
                                                                  "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                  "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                  "Location Code" = FIELD("Location Filter"),
                                                                  "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                  "Variant Code" = FIELD("Variant Filter"),
                                                                  "Lot No." = FIELD("Lot No. Filter"),
                                                                  "Serial No." = FIELD("Serial No. Filter"),
                                                                  "Location Code" = FILTER(<> 'SAMPLE')));
            Description = '//Upgradation Nav13';
        }
        field(50007; "Free Location Qty"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("No."),
                                                                  "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                  "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                  "Location Code" = FILTER('FREE'),
                                                                  "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                  "Variant Code" = FIELD("Variant Filter"),
                                                                  "Lot No." = FIELD("Lot No. Filter"),
                                                                  "Serial No." = FIELD("Serial No. Filter")));
            Description = '//Upgradation Nav13';
        }
        field(50008; "Chemilines Location Qty"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("No."),
                                                                  "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                  "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                  "Location Code" = FILTER('CHEMILINES'),
                                                                  "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                  "Variant Code" = FIELD("Variant Filter"),
                                                                  "Lot No." = FIELD("Lot No. Filter"),
                                                                  "Serial No." = FIELD("Serial No. Filter")));
            Description = '//Upgradation Nav13';
        }
        field(50009; "No of Licenses"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Product License" WHERE("Stock Code" = FIELD("No."),
                                                         Blocked = CONST(false)));
            Description = '//Upgradation Nav13';
            Editable = false;
        }
        field(50010; Barcode; Code[40])
        {
            Description = '//Upgradation Nav13';
        }
        field(50011; "Customer Filter"; Code[20])
        {
            Description = '//Upgradation Nav13';
            FieldClass = FlowFilter;
        }
        field(50013; "Import Traget"; Decimal)
        {
            Description = '//Upgradation Nav13';
        }
        field(50014; IMS; Text[30])
        {
            Description = '//Upgradation Nav13';
        }
        field(50015; "IMS Date"; Date)
        {
            Description = '//Upgradation Nav13';
        }
        field(50016; "Avarage Sales Price"; Decimal)
        {
            CalcFormula = Average("Sales Price"."Unit Price" WHERE("Item No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50017; "Lowest Sales price"; Decimal)
        {
            CalcFormula = Min("Sales Price"."Unit Price" WHERE("Item No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50018; "Display On B2B"; Boolean)
        {
            Description = 'B2B';

            trigger OnValidate()
            var
                RecUserSetup: Record "User Setup";
            begin
                //aditi ++
                RecUserSetup.RESET;
                RecUserSetup.SETRANGE(RecUserSetup."User ID", USERID);
                RecUserSetup.SETFILTER(RecUserSetup."Allow on B2B", '%1', TRUE);
                IF NOT RecUserSetup.FINDFIRST THEN
                    ERROR('You do not have permission to do changes, please contact system administrator for the details');
                //aditi --
            end;
        }
        field(50019; "Key Indication"; Text[250])
        {
            Description = 'Chem-280';
        }
        field(50020; "EU Grant Date"; Date)
        {
            Description = 'Chem-280';
        }
        field(50021; "UK Pack Size"; Code[30])
        {
            Description = 'Chem-280';
        }
        field(50022; "Temperature Required"; Option)
        {
            Description = 'CAS-01463-P3T5Y4';
            OptionCaption = 'None,2-8, 15-25, 2-25';
            OptionMembers = "None","2-8"," 15-25"," 2-25";
        }
        field(50027; "Purchase (Qty) Ex"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Entry Type" = CONST(Purchase),
                                                                  "Item No." = FIELD("No."),
                                                                  "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                  "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                  "Location Code" = FIELD("Location Filter"),
                                                                  "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                  "Variant Code" = FIELD("Variant Filter"),
                                                                  "Posting Date" = FIELD("Date Filter"),
                                                                  "Lot No." = FIELD("Lot No. Filter"),
                                                                  "Serial No." = FIELD("Serial No. Filter")));
        }
        field(50028; "Purchase Value Ex"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Value Entry"."Cost Amount (Expected)" WHERE("Item Ledger Entry Type" = CONST(Purchase),
                                                                            "Item No." = FIELD("No."),
                                                                            "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                            "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                            "Location Code" = FIELD("Location Filter"),
                                                                            "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                            "Variant Code" = FIELD("Variant Filter"),
                                                                            "Posting Date" = FIELD("Date Filter")));
        }
        field(50029; "Min. W/S Discount"; Text[30])
        {
        }
        field(50030; "Bill of Materials"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Exist("BOM Component" WHERE("Parent Item No." = FIELD("No.")));
            Caption = 'Bill of Materials';
            Editable = false;
        }
        field(50032; "Legal Status"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('GENRAL DRUG'));
        }
        field(50033; "Controlled Drug"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('CONTROLLED DRUG'));
        }
        field(50034; "Quantity Lic. Per Sales"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50035; "Quantity Lice. Monthly"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50100; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,Released;
        }

    }
}
