reportextension 60030 OrderConfirmation extends 10571
{
    RDLCLayout = 'SalesOrderConfirmation.rdl';
    dataset
    {
        add("Sales Header")
        {
            column(CompanyPictureLatest; compInfo.Picture)
            {

            }
            column(CompVatRegis; compInfo."VAT Registration No.")
            {

            }
            column(CompBankAcc; compInfo."Bank Account No.")
            {

            }
            column(Shipment_Date; Format("Shipment Date", 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(PriceIncludingVAT; "Prices Including VAT")
            {
            }
        }
    }

    requestpage
    {
        // Add changes to the requestpage here
    }
    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        compInfo.get();
        compInfo.CalcFields(compInfo.Picture);
    end;

    var
        compInfo: record "Company Information";
}