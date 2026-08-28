table 50032 "Item sub List"
{

    fields
    {
        field(1; "Entry No"; Integer)
        {
            AutoIncrement = false;
        }
        field(2; "Vendor No"; Code[20])
        {
            TableRelation = Vendor;

            trigger OnValidate()
            begin

                IF vendor.GET("Vendor No") THEN
                    Country := vendor."Country/Region Code";
                //INSERT;
            end;
        }
        field(3; "Item No"; Code[20])
        {
            TableRelation = Item;

            trigger OnValidate()
            begin
                IF "Vendor No" <> '' THEN BEGIN
                    IF Country <> '' THEN BEGIN
                        PL.RESET;
                        PL.SETRANGE(PL."Stock Code", "Item No");
                        PL.SETRANGE(PL.Country, Country);
                        IF PL.FINDFIRST THEN BEGIN
                            License := TRUE;
                            //INSERT;
                        END
                        ELSE BEGIN
                            License := FALSE;
                            //INSERT;
                        END;
                    END;
                END;
            end;
        }
        field(4; "Direct Unit Cost"; Decimal)
        {
        }
        field(5; Country; Code[10])
        {
        }
        field(6; License; Boolean)
        {
        }
        field(7; "Starting Date"; Date)
        {

            trigger OnValidate()
            begin
                /* PurchPrice.VALIDATE(PurchPrice."Starting Date","Starting Date");
                  "Starting Date":=PurchPrice."Starting Date";
                 */
                /*IF "Item No" = xRec."Item No" THEN BEGIN
                 IF "Vendor No" = xRec."Vendor No" THEN BEGIN
                  IF xRec."Starting Date"<>0D THEN BEGIN
                  IF "Starting Date" > xRec."Starting Date" THEN
                    LatestDate := TRUE;
                    xRec.LatestDate:=FALSE;
                   END;
                 END;
                END;
                 */

            end;
        }
        field(8; Quantity; Decimal)
        {

            trigger OnValidate()
            begin
                //IF "Vendor No"='' THEN
                // ERROR(Text001,"Item No");
            end;
        }
        field(9; LatestDate; Date)
        {
        }
        field(10; "Ordered Quantity"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Entry No", "Item No", "Vendor No")
        {
            Clustered = true;
        }
        key(Key2; LatestDate)
        {
        }
        key(Key3; "Vendor No")
        {
        }
    }

    fieldgroups
    {
    }

    var
        vendor: Record 23;
        PL: Record 50008;
        "Starting Date": Date;
        PurchPrice: Record 7012;
        Text001: Label 'Vendor is not present for item %1';
}

