reportextension 60032 "PostedSalesInvoice" extends 10572
{
    RDLCLayout = 'SalesInvoice.rdl';
    dataset
    {
        add("Sales Invoice Header")
        {
            column(CompanyPictureLatest; G_CompanyInfo.Picture)
            {

            }
            column(companyPhn; G_CompanyInfo."Phone No.")
            {

            }
            column(companyVat; G_CompanyInfo."VAT Registration No.")
            {

            }
            column(Your_Reference; "Your Reference")
            {

            }
            column(Order_Date; "Order Date")
            {

            }
            column(Salesperson_Code; "Salesperson Code")
            {

            }
            column(Due_Date; "Due Date")
            {

            }
            column(VAT_Registration_No_; "VAT Registration No.")
            {

            }

            column(Shipment_Method_Code; "Shipment Method Code")
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
        modify("Sales Invoice Header")
        {
            trigger OnAfterAfterGetRecord()
            var
                myInt: Integer;
            begin

                Clear(ShipToAdd);
                ShipToAdd[1] := "Sales Invoice Header"."Ship-to Name";
                ShipToAdd[2] := "Sales Invoice Header"."Ship-to Contact";
                ShipToAdd[3] := "Sales Invoice Header"."Ship-to Address";
                ShipToAdd[4] := "Sales Invoice Header"."Ship-to Address 2";

                ShipToAdd[5] := "Sales Invoice Header"."Ship-to City";
                ShipToAdd[6] := "Sales Invoice Header"."Ship-to Post Code";
                ShipToAdd[7] := "Sales Invoice Header"."Ship-to County";
                CompressArray(ShipToAdd);

                Clear(CountryofRegion);
                L_CountryRegion.Reset();
                L_CountryRegion.SetRange(Code, G_CompanyInfo."Country/Region Code");
                if L_CountryRegion.FindFirst() then begin
                    CountryofRegion := L_CountryRegion.Name;
                end;
            end;

        }
        add("Sales Invoice Line")
        {

            COLUMN(Item_Reference_No; "Item Reference No.")
            {

            }
            column(Amount_Including_VAT; "Amount Including VAT")
            {

            }
            column(VAT_P; "VAT %")
            {

            }
            column(PIPCode; PIPCode)
            {

            }
            column(VATAmount; VATAmount)
            {
            }
            column(TotalNoOfLines; TotalNoOfLine)
            {
            }
        }
        modify("Sales Invoice Line")
        {


            trigger OnAfterAfterGetRecord()
            var
                myInt: Integer;
            begin
                Clear(PIPCode);
                if "Sales Invoice Line".Type = "Sales Invoice Line".Type::Item then
                    if L_Item.Get("Sales Invoice Line"."No.") then begin
                        TotalNoOfLine := "Sales Invoice Line".Count();
                        PIPCode := L_Item."No. 2";
                    end;
                VATAmount := Round(Amount * "VAT %" / 100, 0.01);
            end;
        }
    }
    trigger OnPreReport()
    begin
        G_CompanyInfo.GET;
        G_CompanyInfo.CalcFields(G_CompanyInfo.Picture);
    end;

    var
        G_CompanyInfo: record "Company Information";
        L_CountryRegion: Record "Country/Region";
        CountryofRegion: Text[50];
        ShipToAdd: array[8] of Text;
        L_Item: record Item;
        PIPCode: code[20];
        VATAmount: Decimal;
        TotalNoOfLine: Integer;
        SIL: Record "Sales Invoice Line";
}