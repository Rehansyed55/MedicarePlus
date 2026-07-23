reportextension 60034 "Credit Memo" extends 10573
{
    RDLCLayout = 'SalesCreditMemo.rdl';
    dataset
    {
        add("Sales Cr.Memo Header")
        {
            column(CompanyPictureLatest; compInfo.Picture)
            {

            }
            column(Ship_to_Name; ShipToAdd[1])
            {

            }
            column(Ship_to_Contact; ShipToAdd[2])
            {

            }
            column(Ship_to_Address; ShipToAdd[3])
            {

            }
            column(Ship_to_Address_2; ShipToAdd[4])
            {

            }
            column(Ship_to_City; ShipToAdd[5])
            {

            }
            column(Ship_to_Post_Code; ShipToAdd[6])
            {

            }
            column(Ship_to_County; ShipToAdd[7])
            {

            }
            column(CountryRegionCode; CountryofRegion)
            {

            }
        }
        modify("Sales Cr.Memo Header")
        {
            trigger OnAfterAfterGetRecord()
            var
                myInt: Integer;
            begin

                Clear(ShipToAdd);
                ShipToAdd[1] := "Sales Cr.Memo Header"."Ship-to Name";
                ShipToAdd[2] := "Sales Cr.Memo Header"."Ship-to Contact";
                ShipToAdd[3] := "Sales Cr.Memo Header"."Ship-to Address";
                ShipToAdd[4] := "Sales Cr.Memo Header"."Ship-to Address 2";

                ShipToAdd[5] := "Sales Cr.Memo Header"."Ship-to City";
                ShipToAdd[6] := "Sales Cr.Memo Header"."Ship-to Post Code";
                ShipToAdd[7] := "Sales Cr.Memo Header"."Ship-to County";
                CompressArray(ShipToAdd);

                Clear(CountryofRegion);
                L_CountryRegion.Reset();
                L_CountryRegion.SetRange(Code, G_CompanyInfo."Country/Region Code");
                if L_CountryRegion.FindFirst() then begin
                    CountryofRegion := L_CountryRegion.Name;
                end;
            end;

        }
    }

    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        compInfo.get();
        compInfo.CalcFields(compInfo.Picture);
    end;

    var
        G_CompanyInfo: record "Company Information";
        compInfo: record "Company Information";
        ShipToAdd: array[8] of Text;
        L_CountryRegion: Record "Country/Region";
        CountryofRegion: Text[50];


}