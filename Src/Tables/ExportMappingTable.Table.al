table 50018 "Export-Mapping Table"
{

    fields
    {
        field(1; "Document No."; Code[10])
        {
        }
        field(2; TableID; Integer)
        {
            // TableRelation = Object.ID WHERE(Type = CONST(Table));

            // trigger OnLookup()
            // var
            //     "Object": Record 2000000001;
            //     Objects: Page 358;
            //     objectid: Integer;
            // begin
            //     Object.SETRANGE(Object.Type, Object.Type::Table);
            //     Objects.SETTABLEVIEW(Object);
            //     Objects.LOOKUPMODE := TRUE;
            //     IF Objects.RUNMODAL = ACTION::LookupOK THEN BEGIN
            //         Objects.GETRECORD(Object);
            //         VALIDATE(TableID, Object.ID);
            //     END;
            // end;
        }
        field(3; "Navision Table Name"; Text[50])
        {
            CalcFormula = Lookup(AllObjWithCaption."Object Name" WHERE("Object Type" = CONST(Table),
                                                                        "Object ID" = FIELD(TableID)));
            FieldClass = FlowField;
        }
        field(4; "Navision Table Field"; Integer)
        {
            TableRelation = Field."No." WHERE(TableNo = FIELD(TableID));

            trigger OnLookup()
            var
                "field": Record 2000000041;
            // "fields": Page 6218;
            begin
                // field.SETRANGE(field.TableNo,TableID);
                // fields.SETTABLEVIEW(field);
                // fields.LOOKUPMODE := TRUE;
                // IF fields.RUNMODAL = ACTION::LookupOK THEN BEGIN
                //   fields.GETRECORD(field);
                //   VALIDATE("Navision Table Field", field."No.");
                // END;
            end;
        }
        field(5; "Navision Table Field Name"; Text[50])
        {
            CalcFormula = Lookup(Field.FieldName WHERE(TableNo = FIELD(TableID),
                                                        "No." = FIELD("Navision Table Field")));
            FieldClass = FlowField;
        }
        field(6; Description; Text[50])
        {
        }
        field(7; "Sequence No."; Integer)
        {
        }
        field(8; Length; Integer)
        {
        }
        field(9; "Append Space"; Option)
        {
            OptionMembers = Before,After;
        }
        field(10; "Default Value"; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Document No.", TableID, "Navision Table Field", "Sequence No.")
        {
            Clustered = true;
        }
        key(Key2; "Sequence No.")
        {
        }
    }

    fieldgroups
    {
    }
}

