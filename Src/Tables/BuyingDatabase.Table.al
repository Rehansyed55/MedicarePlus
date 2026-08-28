table 50023 "Buying Database"
{
    // DrillDownPageID = 50094;
    // LookupPageID = 50094;

    fields
    {
        field(1; "Price Workability"; Option)
        {
            OptionCaption = ' ,WM/WT,NWM/WT,NWM/NWT,WT,NWT,Need Price';
            OptionMembers = " ","WM/WT","NWM/WT","NWM/NWT",WT,NWT,"Need Price";
        }
        field(2; "Priority Rank"; Integer)
        {
        }
        field(3; PLPI; Code[30])
        {
        }
        field(4; "UK trade Name"; Text[100])
        {
        }
        field(5; Strength; Text[100])
        {
        }
        field(6; Country; Text[30])
        {
        }
        field(7; "EU trade Name"; Text[100])
        {
        }
        field(8; "Active Ingredient"; Text[100])
        {
        }
        field(9; "No."; Code[30])
        {
        }
        field(10; "PIP Codes"; Code[30])
        {
        }
        field(11; "Cost (Stock list)"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Item."Unit Cost" WHERE("No." = FIELD("No.")));
        }
        field(12; "PI price"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Price"."Unit Price" WHERE("Item No." = FIELD("No."),
                                                                   "Sales Type" = FILTER("Customer Price Group"),
                                                                   "Sales Code" = FILTER('C')));

        }
        field(13; "Wholesale Price"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Price"."Unit Price" WHERE("Item No." = FIELD("No."),
                                                                   "Sales Type" = FILTER("Customer Price Group"),
                                                                   "Sales Code" = FILTER('D')));
        }
        field(14; "Current Stock"; Decimal)
        {
        }
        field(15; "Total Prod. Qty (24 Months)"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Production Order".Quantity WHERE(Status = FILTER(Finished),
                                                                 "PLPI No." = FIELD(PLPI),
                                                                "Source No." = FIELD("No."),
                                                                 "Starting Date" = FIELD("Date Filter")));
        }
        field(16; "Total Cost Amount (24 months)"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Production Order"."Cost Amount" WHERE(Status = CONST(Finished),
                                                                      "PLPI No." = FIELD(PLPI),
                                                                      "Source No." = FIELD("No."),
                                                                      "Starting Date" = FIELD("Date Filter")));
        }
        field(17; "Total Prod. Qty (12 Months)"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Production Order".Quantity WHERE(Status = CONST(Finished),
                                                                 "PLPI No." = FIELD(PLPI),
                                                                 "Source No." = FIELD("No."),
                                                                 "Starting Date" = FIELD("Date Filter 2")));
        }
        field(18; "Total Cost Amount (12 months)"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Production Order"."Cost Amount" WHERE(Status = FILTER(Finished),
                                                                      "PLPI No." = FIELD(PLPI),
                                                                      "Source No." = FIELD("No."),
                                                                      "Starting Date" = FIELD("Date Filter 2")));
        }
        field(19; "Sales Qty (12months)"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Value Entry"."Invoiced Quantity" WHERE("Item Ledger Entry Type" = CONST(Sale),
                                                                       "Item No." = FIELD("No."),
                                                                       "Posting Date" = FIELD("Date Filter 2")));
        }
        field(20; "Sales Amount (12months)"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Value Entry"."Sales Amount (Actual)" WHERE("Item Ledger Entry Type" = CONST(Sale),
                                                                           "Item No." = FIELD("No."),
                                                                           "Posting Date" = FIELD("Date Filter 2")));
        }
        field(21; "NHS Rank"; Code[30])
        {
        }
        field(22; "NHS Pack Sales"; Text[50])
        {
            Description = 'use data type as text bcause they will enter text as well in this column';
        }
        field(23; "NHS Generic"; Text[30])
        {
            Description = 'use data type as text bcause they will enter text as well in this column';
        }
        field(24; "OTC Spot Buy Sales"; Decimal)
        {
        }
        field(25; "OTC Spot Buy Sales Avg."; Decimal)
        {
        }
        field(26; "IMS Rank"; Code[30])
        {
        }
        field(27; "IMS Value"; Decimal)
        {
        }
        field(28; "IMS Units"; Text[50])
        {
            Description = 'use data type as text bcause they will enter text as well in this column';
        }
        field(29; "IMS Brand for Brand"; Text[50])
        {
            Description = 'use data type as text bcause they will enter text as well in this column';
        }
        field(30; "IMS Brand for Generic"; Text[50])
        {
            Description = 'use data type as text bcause they will enter text as well in this column';
        }
        field(31; "IMS Generic"; Text[50])
        {
            Description = 'use data type as text bcause they will enter text as well in this column';
        }
        field(32; "% Sales- Brand Prescrition"; Decimal)
        {
        }
        field(33; "Patient Staus"; Option)
        {
            OptionCaption = ' ,Off-Patent,Patented';
            OptionMembers = " ","Off-Patent",Patented;
        }
        field(34; "Patient Expiry"; Text[50])
        {
            Description = 'use data type as text bcause they will enter text as well in this column along with date';
        }
        field(35; "SPC Expiry"; Text[50])
        {
            Description = 'use data type as text bcause they will enter text as well in this column along with date';
        }
        field(36; "Trade Price"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Price"."Unit Price" WHERE("Item No." = FIELD("No."),
                                                                   "Sales Type" = FILTER("Customer Price Group"),
                                                                   "Sales Code" = FILTER('A')));
        }
        field(37; "Supplier cost"; Decimal)
        {
            Description = 'use data type as text bcause they will enter text as well in this column along with date';
        }
        field(38; "Supplier Name"; Text[250])
        {
        }
        field(39; "Supplier Availability"; Text[50])
        {
        }
        field(40; "Month of Supplier Price"; Date)
        {
            Description = 'use data type as text bcause they will enter text as well in this column along with date';
        }
        field(41; "ECMA No."; Code[30])
        {
        }
        field(42; "UK pack size"; Code[30])
        {
        }
        field(43; "EU pack size"; Code[30])
        {
        }
        field(44; "EU Cost In Pound"; Decimal)
        {
        }
        field(45; "Percent of trade"; Decimal)
        {
        }
        field(46; "EU cost in Diff Rate"; Decimal)
        {
        }
        field(47; "Percent of trade Diff.Rate"; Decimal)
        {
        }
        field(48; Waymade; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Price"."Unit Price" WHERE("Item No." = FIELD("No."),
                                                                   "Sales Type" = FILTER("Customer Price Group"),
                                                                   "Sales Code" = FILTER('WAYMADE')));
        }
        field(49; Trident; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Price"."Unit Price" WHERE("Item No." = FIELD("No."),
                                                                   "Sales Type" = FILTER("Customer Price Group"),
                                                                   "Sales Code" = FILTER('TRIDENT')));
        }
        field(50; Phoenix; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Price"."Unit Price" WHERE("Item No." = FIELD("No."),
                                                                   "Sales Type" = FILTER("Customer Price Group"),
                                                                   "Sales Code" = FILTER('PHOENIX')));
        }
        field(51; OTC; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Price"."Unit Price" WHERE("Item No." = FIELD("No."),
                                                                   "Sales Type" = FILTER("Customer Price Group"),
                                                                   "Sales Code" = FILTER('OTC')));
        }
        field(52; Mawdsley; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Price"."Unit Price" WHERE("Item No." = FIELD("No."),
                                                                   "Sales Type" = FILTER("Customer Price Group"),
                                                                   "Sales Code" = FILTER('MAWDSLEY')));
        }
        field(53; Kosei; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Price"."Unit Price" WHERE("Item No." = FIELD("No."),
                                                                   "Sales Type" = FILTER("Customer Price Group"),
                                                                   "Sales Code" = FILTER('KOSEI')));
        }
        field(54; "DE Pharma"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Price"."Unit Price" WHERE("Item No." = FIELD("No."),
                                                                   "Sales Type" = FILTER("Customer Price Group"),
                                                                   "Sales Code" = FILTER('DEPHARMA')));
        }
        field(55; Lexon; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Price"."Unit Price" WHERE("Item No." = FIELD("No."),
                                                                   "Sales Type" = FILTER("Customer Price Group"),
                                                                   "Sales Code" = FILTER('LEXON')));
        }
        field(56; "Best Competitor price"; Decimal)
        {
        }
        field(57; "Competitor with best price"; Text[50])
        {
        }
        field(58; "% off-best competitor price"; Decimal)
        {
        }
        field(59; "Competitors with PLPI"; Text[250])
        {
        }
        field(60; "Competitor Licenced Countries"; Text[250])
        {
        }
        field(61; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(62; "Date Filter 2"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(63; "Date Filter 3"; Date)
        {
        }
        field(64; "AvgSalesPrice(3Months)"; Decimal)
        {
            CalcFormula = Average("Value Entry"."Sales Amount (Actual)" WHERE("Item Ledger Entry Type" = CONST(Sale),
                                                                               "Item No." = FIELD("No."),
                                                                               "Posting Date" = FIELD("Date Filter 3")));
            FieldClass = FlowField;
        }
        field(65; "B&S"; Decimal)
        {
            CalcFormula = Lookup("Sales Price"."Unit Price" WHERE("Item No." = FIELD("No."),
                                                                   "Sales Type" = FILTER("Customer Price Group"),
                                                                   "Sales Code" = FILTER('B AND S')));
            FieldClass = FlowField;
        }
        field(66; Colorama; Decimal)
        {
            CalcFormula = Lookup("Sales Price"."Unit Price" WHERE("Item No." = FIELD("No."),
                                                                   "Sales Type" = FILTER("Customer Price Group"),
                                                                   "Sales Code" = FILTER('COLORAMA')));
            FieldClass = FlowField;
        }
        field(67; "Elite Pharma"; Decimal)
        {
            CalcFormula = Lookup("Sales Price"."Unit Price" WHERE("Item No." = FIELD("No."),
                                                                   "Sales Type" = FILTER("Customer Price Group"),
                                                                   "Sales Code" = FILTER('ELITE PHARMA')));
            FieldClass = FlowField;
        }
        field(68; Ethigen; Decimal)
        {
            CalcFormula = Lookup("Sales Price"."Unit Price" WHERE("Item No." = FIELD("No."),
                                                                   "Sales Type" = FILTER("Customer Price Group"),
                                                                   "Sales Code" = FILTER('ETHIGEN')));
            FieldClass = FlowField;
        }
        field(69; MediCare; Decimal)
        {
            CalcFormula = Lookup("Sales Price"."Unit Price" WHERE("Item No." = FIELD("No."),
                                                                   "Sales Type" = FILTER("Customer Price Group"),
                                                                   "Sales Code" = FILTER('MEDICARE')));
            FieldClass = FlowField;
        }
        field(70; Sigma; Decimal)
        {
            CalcFormula = Lookup("Sales Price"."Unit Price" WHERE("Item No." = FIELD("No."),
                                                                   "Sales Type" = FILTER("Customer Price Group"),
                                                                   "Sales Code" = FILTER('SIGMA')));
            FieldClass = FlowField;
        }
        field(71; AAH; Decimal)
        {
            CalcFormula = Lookup("Sales Price"."Unit Price" WHERE("Item No." = FIELD("No."),
                                                                   "Sales Type" = FILTER("Customer Price Group"),
                                                                   "Sales Code" = FILTER('AAH')));
            FieldClass = FlowField;
        }
        field(72; Alliance; Decimal)
        {
            CalcFormula = Lookup("Sales Price"."Unit Price" WHERE("Item No." = FIELD("No."),
                                                                   "Sales Type" = FILTER("Customer Price Group"),
                                                                   "Sales Code" = FILTER('ALLIANCE')));
            FieldClass = FlowField;
        }
        field(73; "Beta Pharma"; Decimal)
        {
            CalcFormula = Lookup("Sales Price"."Unit Price" WHERE("Item No." = FIELD("No."),
                                                                   "Sales Type" = FILTER("Customer Price Group"),
                                                                   "Sales Code" = FILTER('BETA PHARMA')));
            FieldClass = FlowField;
        }
        field(74; AvgPurchPriceEUR; Decimal)
        {
            CalcFormula = Average("Purchase Price"."Direct Unit Cost" WHERE("Item No." = FIELD("No."),
                                                                             "Currency Code" = FILTER('EUR'),
                                                                             "Starting Date" = FIELD("Date Filter 3")));
            FieldClass = FlowField;
        }
        field(75; AvgPurchPriceCZK; Decimal)
        {
            CalcFormula = Average("Purchase Price"."Direct Unit Cost" WHERE("Item No." = FIELD("No."),
                                                                             "Currency Code" = FILTER('CZK'),
                                                                             "Starting Date" = FIELD("Date Filter 3")));
            FieldClass = FlowField;
        }
        field(76; AvgPurchPriceNOK; Decimal)
        {
            CalcFormula = Average("Purchase Price"."Direct Unit Cost" WHERE("Item No." = FIELD("No."),
                                                                             "Currency Code" = FILTER('NOK'),
                                                                             "Starting Date" = FIELD("Date Filter 3")));
            FieldClass = FlowField;
        }
        field(77; AvgPurchPricePLN; Decimal)
        {
            CalcFormula = Average("Purchase Price"."Direct Unit Cost" WHERE("Item No." = FIELD("No."),
                                                                             "Currency Code" = FILTER('PLN'),
                                                                             "Starting Date" = FIELD("Date Filter 3")));
            FieldClass = FlowField;
        }
        field(78; "Patient Expiry 1"; Date)
        {
            Description = 'use data type as text bcause they will enter text as well in this column along with date';
        }
        field(79; "SPC Expiry 1"; Date)
        {
            Description = 'use data type as text bcause they will enter text as well in this column along with date';
        }
        field(50000; "Medihealth North"; Decimal)
        {
            CalcFormula = Lookup("Sales Price"."Unit Price" WHERE("Item No." = FIELD("No."),
                                                                   "Sales Type" = FILTER("Customer Price Group"),
                                                                   "Sales Code" = FILTER('MEDIHEALTH')));
            FieldClass = FlowField;
        }
        field(50001; Numark; Decimal)
        {
            CalcFormula = Lookup("Sales Price"."Unit Price" WHERE("Item No." = FIELD("No."),
                                                                   "Sales Type" = FILTER("Customer Price Group"),
                                                                   "Sales Code" = FILTER('MEDIHEALTH')));
            FieldClass = FlowField;
        }
        field(50002; "Target Healthcare"; Decimal)
        {
            CalcFormula = Lookup("Sales Price"."Unit Price" WHERE("Item No." = FIELD("No."),
                                                                   "Sales Type" = FILTER("Customer Price Group"),
                                                                   "Sales Code" = FILTER('TARGET')));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; PLPI, "ECMA No.", "No.")
        {
            Clustered = true;
        }
        key(Key2; "EU Cost In Pound")
        {
        }
        key(Key3; "Priority Rank")
        {
        }
    }

    fieldgroups
    {
    }

    var
        "min": Decimal;
        CompName: Text[250];
}

