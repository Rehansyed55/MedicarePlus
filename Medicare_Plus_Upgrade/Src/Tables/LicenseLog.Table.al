table 50021 "License Log"
{
    // DrillDownPageID = 50027;
    // LookupPageID = 50027;

    fields
    {
        field(1; "PL No."; Code[20])
        {
            TableRelation = "Variant Product license line"."PL No.";
        }
        field(2; "Stock Code"; Code[20])
        {
            TableRelation = "Variant Product license line"."Stock Code";
        }
        field(3; "ECMA No."; Code[50])
        {
            TableRelation = "Variant Product license line"."ECMA No.";
        }
        field(4; "Purchase Order No."; Code[20])
        {
        }
        field(5; "Supplier Name"; Text[100])
        {
        }
        field(6; "Warehouse Receipt Line No."; Integer)
        {
        }
        field(8; "Warehouse Receipt No."; Code[20])
        {
        }
        field(9; Status; Option)
        {
            OptionCaption = 'Stock on Hold,Release For Supplier Return,Release For Production';
            OptionMembers = "Stock on Hold","Release For Supplier Return","Release For Production";
        }
        field(10; "Batch No."; Code[30])
        {
        }
        field(11; "Serial No."; Code[20])
        {
        }
        field(12; "Location Code"; Code[20])
        {
        }
        field(13; "Zone Code"; Code[20])
        {
        }
        field(14; "Bin Code"; Code[20])
        {
        }
        field(15; Quantity; Decimal)
        {
            CalcFormula = Sum("Warehouse Entry".Quantity WHERE("Location Code" = FIELD("Location Code"),
                                                                "Zone Code" = FIELD("Zone Code"),
                                                                "Bin Code" = FIELD("Bin Code"),
                                                                "Item No." = FIELD("Stock Code"),
                                                                "Lot No." = FIELD("Batch No.")));
            FieldClass = FlowField;
        }
        field(16; "Warehouse Entry No."; Integer)
        {
        }
        field(17; "Source Line No."; Integer)
        {
        }
        field(18; Reason; Text[250])
        {
        }
        field(19; "Reason 1"; Text[250])
        {
        }
        field(20; "BPR Version No"; Code[20])
        {
            TableRelation = "Variant Product license line"."BPR Version No." WHERE("PL No." = FIELD("PL No."),
                                                                                    "Stock Code" = FIELD("Stock Code"),
                                                                                    "ECMA No." = FIELD("ECMA No."));
        }
        field(21; "Posted Purchse Recipt No"; Code[20])
        {
        }
        field(22; Activity; Option)
        {
            OptionCaption = ' ,New App In Process,BPR Identification';
            OptionMembers = " ","New App In Process","BPR Identification";
        }
        field(23; Comment; Text[150])
        {
        }
        field(24; "Comment 1"; Text[150])
        {
        }
        field(25; "Production Order No."; Code[20])
        {
        }
        field(26; "Posting Date"; Date)
        {
        }
        field(27; "Expiration Date"; Date)
        {
        }
        field(28; "Prod Comment"; Text[150])
        {
        }
        field(29; "Prod Comment 1"; Text[150])
        {
        }
        field(30; "Rebox/Overlabel"; Option)
        {
            OptionCaption = ' ,Rebox,Overlabel';
            OptionMembers = " ",Rebox,Overlabel;
        }
        field(31; "Line No"; Integer)
        {
        }
        field(32; Date; Date)
        {
        }
        field(33; "Previous Status"; Option)
        {
            OptionCaption = '  ,STOP,OK,Not Granted';
            OptionMembers = "  ",STOP,OK,"Not Granted";
        }
        field(34; Operator; Code[30])
        {
            Caption = 'Operator';
            Description = 'Chem-473';
            TableRelation = "Warehouse Employee"."User ID";
        }
        field(35; "Present Status"; Option)
        {
            OptionCaption = '  ,STOP,OK,Not Granted';
            OptionMembers = "  ",STOP,OK,"Not Granted";
        }
        field(36; Logger; Boolean)
        {

            trigger OnValidate()
            begin
                //Chem-474++
                IF Logger THEN
                    Operator := USERID;
                //Chem-474--
            end;
        }
    }

    keys
    {
        key(Key1; "PL No.", "Stock Code", "Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
    // NewReleaseForSupplierFrom: Page 50029;
    // NewReleaseForProdFrom: Page 50030;
    // DefaultSetup: Record 50012;
}

