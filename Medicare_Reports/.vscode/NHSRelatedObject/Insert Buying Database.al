codeunit 60031 "Insert Buying Database"
{
    // version CHEM-280


    trigger OnRun()
    begin
        recPL.RESET;
        recPL.SETFILTER(recPL."Created Date",'%1',WORKDATE);
        IF recPL.FINDFIRST THEN
        BEGIN
             REPEAT
              IF NOT recBuyDB1.GET(recPL."PL No.",recPL."ECMA No.",recPL."Stock Code") THEN  //CAS-05212-R7B8Q3//AW++++230317++++
              BEGIN
                   CLEAR(recCountry);
                   recCountry.RESET;
                   IF recCountry.GET(recPL.Country) THEN;

                   recBuyDB.RESET;
                   IF recBuyDB.FINDLAST THEN
                   BEGIN
                        recBuyDB.INIT;
                        recBuyDB.PLPI := recPL."PL No.";
                        recBuyDB."ECMA No." := recPL."ECMA No.";
                        recBuyDB."No.":= recPL."Stock Code";
                        recBuyDB."UK trade Name" := recPL."UK Trade";
                        recBuyDB.Strength := recPL.Strength;
                        recBuyDB.Country := recCountry.Name;
                        recBuyDB."EU trade Name" := recPL."EU Trade";
                        recBuyDB."Active Ingredient" := recPL."Generic Name";
                        recBuyDB."UK pack size" := recPL."Pack Size";
                        recBuyDB."EU pack size" := recPL."Foreign Pack size";
                        recBuyDB.INSERT;
                   END;
                END;
             UNTIL recPL.NEXT = 0;

           InsertNHSIMSData; // moved inside if condition to check job queue17/12

        END;

        //InsertNHSIMSData;
    end;

    var
        recPL: Record 50008;
        recBuyDB: Record 50023;
        recCountry: Record 9;
        recBuyDB1: Record 50023;

    procedure InsertNHSIMSData()
    var
        recBuyDB1: Record 50023;
        recNHIMSData: Record 50022;
    begin
        recNHIMSData.RESET;
        recNHIMSData.SETFILTER(recNHIMSData."Created Date",'%1',WORKDATE);
        IF recNHIMSData.FINDFIRST THEN
        BEGIN
             REPEAT
                    recBuyDB1.RESET;
                    //recBuyDB1.SETRANGE(recBuyDB1.PLPI,recNHIMSData."PI No");
                    //recBuyDB1.SETRANGE(recBuyDB1."ECMA No.",recNHIMSData."ECMA No");
                    recBuyDB1.SETRANGE(recBuyDB1."No.",recNHIMSData."Item No");
                    IF recBuyDB1.FINDFIRST THEN
                    BEGIN
                      REPEAT
                         recBuyDB1."NHS Rank" := recNHIMSData."NHS Rank";
                         recBuyDB1."NHS Pack Sales" := recNHIMSData."NHS Pack Sales";
                         recBuyDB1."NHS Generic" := recNHIMSData."NHS Generic" ;
                         recBuyDB1."OTC Spot Buy Sales" := recNHIMSData."OTC Spot Buy Sales";
                         recBuyDB1."OTC Spot Buy Sales Avg." := recNHIMSData."OTC Spot Buy Sales Avg." ;
                         recBuyDB1."IMS Rank" := recNHIMSData."IMS Rank";
                         recBuyDB1."IMS Value" := recNHIMSData."IMS Value";
                         recBuyDB1."IMS Units" := recNHIMSData."IMS Units";
                         recBuyDB1."IMS Brand for Brand" := recNHIMSData."IMS Brand for Brand";
                         recBuyDB1."IMS Brand for Generic" := recNHIMSData."IMS Brand for Generic";
                         recBuyDB1."IMS Generic" := recNHIMSData."IMS Generic";
                         recBuyDB1."% Sales- Brand Prescrition" := recNHIMSData."% Sales- Brand Prescrition";
                         recBuyDB1."Patient Staus" := recNHIMSData."Patient Staus";
                         recBuyDB1."Patient Expiry 1":= recNHIMSData."Patient Expiry";
                         recBuyDB1."SPC Expiry 1" := recNHIMSData."SPC Expiry";
                         //recBuyDB1."EU Cost In Pound" :=  recNHIMSData."EU Cost In Pound";
                         //recBuyDB1."Percent of trade" :=  recNHIMSData."Percent of trade";
                         recBuyDB1.MODIFY(TRUE);
                       UNTIL recBuyDB1.NEXT = 0;
                      END
                      ELSE
                      BEGIN
                           recBuyDB1.RESET;
                           IF recBuyDB1.FINDLAST THEN
                           BEGIN
                                recBuyDB1.INIT;
                               // recBuyDB1.PLPI := recNHIMSData."PI No";
                                //recBuyDB1."ECMA No." := recNHIMSData."ECMA No";
                                recBuyDB1."No." := recNHIMSData."Item No";
                                recBuyDB1."NHS Rank" := recNHIMSData."NHS Rank";
                                recBuyDB1."NHS Pack Sales" := recNHIMSData."NHS Pack Sales";
                                recBuyDB1."NHS Generic" := recNHIMSData."NHS Generic" ;
                                recBuyDB1."OTC Spot Buy Sales" := recNHIMSData."OTC Spot Buy Sales";
                                recBuyDB1."OTC Spot Buy Sales Avg." := recNHIMSData."OTC Spot Buy Sales Avg." ;
                                recBuyDB1."IMS Rank" := recNHIMSData."IMS Rank";
                                recBuyDB1."IMS Value" := recNHIMSData."IMS Value";
                                recBuyDB1."IMS Units" := recNHIMSData."IMS Units";
                                recBuyDB1."IMS Brand for Brand" := recNHIMSData."IMS Brand for Brand";
                                recBuyDB1."IMS Brand for Generic" := recNHIMSData."IMS Brand for Generic";
                                recBuyDB1."IMS Generic"  := recNHIMSData."IMS Generic";
                                recBuyDB1."% Sales- Brand Prescrition" := recNHIMSData."% Sales- Brand Prescrition";
                                recBuyDB1."Patient Staus" := recNHIMSData."Patient Staus";
                                recBuyDB1."Patient Expiry 1" := recNHIMSData."Patient Expiry";
                                recBuyDB1."SPC Expiry 1" := recNHIMSData."SPC Expiry";
                                //recBuyDB1."EU Cost In Pound" :=  recNHIMSData."EU Cost In Pound";
                                //recBuyDB1."Percent of trade" :=  recNHIMSData."Percent of trade";
                                recBuyDB1.INSERT(TRUE);
                           END;
                      END;
              UNTIL recNHIMSData.NEXT = 0;
        END;
    end;
}

