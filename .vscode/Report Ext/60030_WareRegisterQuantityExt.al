reportextension 60030 WareRegQtyExt extends "Warehouse Register - Quantity"
{
    RDLCLayout = 'WareRegQtyExt.rdl';
    dataset
    {
        add("Warehouse Entry")
        {
            column(Source_No_; "Source No.")
            {

            }
        }
    }

    requestpage
    {
        // Add changes to the requestpage here
    }


}