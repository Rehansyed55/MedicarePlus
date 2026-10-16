report 60043 "Zonewise quantity-Group by Bin"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Zonewise quantity-Group by Bin.rdl';

    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Inventory Bin Valuation';
    dataset
    {
        dataitem("Bin Content"; "Bin Content")
        {
            DataItemTableView = WHERE(Quantity = FILTER(> 0));
            RequestFilterFields = "Location Code", "Bin Code";
            column(BinContentTablecaption; "Bin Content".TABLECAPTION + ':' + Binfilter)
            {
            }
            column(ComapnyName; Companyinfo.Name)
            {
            }
            column(PostingDate; PostingDate)
            {
            }
            column(Quantity_BinContent; "Bin Content".Quantity)
            {
            }
            dataitem("Warehouse Entry1"; "Warehouse Entry")
            {
                DataItemLink = "Item No." = FIELD("Item No."),
                               "Bin Code" = FIELD("Bin Code"),
                               "Variant Code" = FIELD("Variant Code"),
                               "Location Code" = FIELD("Location Code"),
                               "Zone Code" = FIELD("Zone Code");
                DataItemTableView = SORTING("Lot No.")
                                    ORDER(Ascending);
                column(RegisteringDate_WarehouseEntry1; "Warehouse Entry1"."Registering Date")
                {
                }
                column(BinCode; "Warehouse Entry1"."Bin Code")
                {
                }
                column(itemNo; "Warehouse Entry1"."Item No.")
                {
                }
                column(ItemDescription; itemdescription)
                {
                }
                column(LotNo; "Warehouse Entry1"."Lot No.")
                {
                }
                column(ExpirationDate; FORMAT("Warehouse Entry1"."Expiration Date"))
                {
                }
                column(Quantity; "Warehouse Entry1".Quantity)
                {
                }
                column(UnitCost; ItemNo."Unit Cost")
                {
                }
                column(Amount; Amount)
                {
                }
                column(TotalQty; Quantity)
                {
                }
                column(Amounttotal; Amounttotal)
                {
                }
                column(GrandTotal; GrandTotal)
                {
                }
                column(PL_No; "PLNo.")
                {
                }
                column(Ecma; Ecma)
                {
                }
                column(Country; Country)
                {
                }
                column(Receipt_Date; ReceiptDate)
                {
                }
                column(Posting_date; FORMAT(WarehouseEntry."Registering Date"))
                {
                }
                column(RegisterDate; FORMAT("Warehouse Entry1"."Registering Date"))
                {
                }
                column(QTYWAREHOUSE; WarehouseEntry.Quantity)
                {
                }

                trigger OnAfterGetRecord()
                begin

                    ItemNo.GET("Warehouse Entry1"."Item No.");
                    itemdescription := ItemNo.Description;

                    IF Bincontent1 <> "Warehouse Entry1"."Bin Code" THEN
                        PrintBinText := TRUE
                    ELSE
                        PrintBinText := FALSE;


                    CLEAR("PLNo.");
                    CLEAR(Ecma);
                    CLEAR(Country);
                    ItemNo.RESET;
                    //ItemNo.SETFILTER(ItemNo."No.","Warehouse Entry1"."Item No.");
                    //IF ItemNo.FINDFIRST THEN
                    IF ItemNo.GET("Warehouse Entry1"."Item No.") THEN
                        WarehouseEntry.RESET;
                    WarehouseEntry.SETRANGE(WarehouseEntry."Source Type", 39);
                    WarehouseEntry.SETRANGE(WarehouseEntry."Item No.", ItemNo."No.");
                    WarehouseEntry.SETRANGE(WarehouseEntry."Lot No.", "Warehouse Entry1"."Lot No.");
                    //  WarehouseEntry.SETRANGE(WarehouseEntry."Location Code","Warehouse Entry1"."Location Code");

                    IF WarehouseEntry.FINDLAST THEN BEGIN

                        PurchaseReceiptLine.RESET;
                        PurchaseReceiptLine.SETRANGE(PurchaseReceiptLine."Order No.", WarehouseEntry."Source No.");
                        PurchaseReceiptLine.SETRANGE(PurchaseReceiptLine."No.", WarehouseEntry."Item No.");
                        IF PurchaseReceiptLine.FINDFIRST THEN BEGIN
                            ReceiptDate := PurchaseReceiptLine."Posting Date";
                            ProductLicense.RESET;
                            ProductLicense.SETRANGE(ProductLicense."Stock Code", ItemNo."No.");
                            ProductLicense.SETRANGE(ProductLicense."PL No.", PurchaseReceiptLine."PL No.");
                            ProductLicense.SETRANGE(ProductLicense.Blocked, FALSE);
                            IF ProductLicense.FINDFIRST THEN BEGIN
                                "PLNo." := ProductLicense."PL No.";
                                Country := ProductLicense.Country;
                                VariantProdLicenseLine.RESET;
                                VariantProdLicenseLine.SETRANGE(VariantProdLicenseLine."PL No.", "PLNo.");
                                VariantProdLicenseLine.SETRANGE(VariantProdLicenseLine."Stock Code", ItemNo."No.");
                                VariantProdLicenseLine.SETFILTER(VariantProdLicenseLine.Status, '%1|%2', VariantProdLicenseLine.Status::Certified, VariantProdLicenseLine.Status::New);
                                VariantProdLicenseLine.SETRANGE(VariantProdLicenseLine.Blocked, FALSE);
                                IF VariantProdLicenseLine.FINDFIRST THEN BEGIN
                                    Ecma := VariantProdLicenseLine."ECMA No.";
                                    //Country := VariantProdLicenseLine.Country;
                                END;
                            END;
                        END;
                    END;

                    //IF ItemNo.GET("Warehouse Entry1"."Item No.")THEN
                    //CLEAR(whseqty);
                    //whseqty+=whseqty+"Warehouse Entry1".Quantity;





                    IF Printtoexcel THEN BEGIN
                        IF "Warehouse Entry1"."Item No." = 'ALV245' THEN BEGIN
                            CurrRec := FORMAT("Warehouse Entry1"."Bin Code");
                        END
                        ELSE
                            IF ("Warehouse Entry1"."Item No." = 'ALV245') AND ("Warehouse Entry1"."Bin Code" = 'FLOOR3') THEN BEGIN
                                CurrRec := FORMAT("Warehouse Entry1"."Lot No.");
                            END
                            ELSE
                                CurrRec := FORMAT("Warehouse Entry1"."Lot No.");
                        //CurrRec:=FORMAT("Warehouse Entry1"."Lot No.");//vik
                        // CurrRec:=FORMAT("Warehouse Entry1"."Bin Code");


                        // first you have to create key for the fields which you want to group in respective table


                        IF (CurrRec <> PreRec) AND (STRLEN(PreRec) <> 0) AND (Qty <> 0) THEN BEGIN
                            //MESSAGE('%1\%2',Bin,Qty);//anikEt

                            //IF (Qty<>0) THEN BEGIN
                            //IF (Lot='D1627/001')AND (ItemN='ALV244')AND (Qty=21000) THEN
                            // CurrReport.SKIP;

                            MakeExcelDataBody;
                            //MESSAGE('%1***%2******%3',CurrRec,PreRec,Qty);

                            CLEAR(ItemN);
                            CLEAR(Des);
                            CLEAR(Zone);
                            CLEAR(PostDate);
                            CLEAR(Bin);
                            CLEAR(Lot);
                            CLEAR(Exp);
                            CLEAR(Qty);
                            CLEAR(UnitCost);
                            CLEAR(Amount);



                            // CLEAR(Qty);
                            //END;


                        END;
                        //ELSE
                        //BEGIN

                        ItemN := "Warehouse Entry1"."Item No.";
                        Des := itemdescription;
                        Zone := "Warehouse Entry1"."Zone Code";
                        Bin := "Warehouse Entry1"."Bin Code";
                        //PostDate:=FORMAT(WarehouseEntry."Registering Date");
                        PostDate := FORMAT("Warehouse Entry1"."Registering Date");
                        Lot := "Warehouse Entry1"."Lot No.";
                        Ecma1 := Ecma;
                        PLNo1 := "PLNo.";
                        Country1 := Country;
                        Exp := "Warehouse Entry1"."Expiration Date";
                        Qty += "Warehouse Entry1".Quantity;
                        UnitCost := ItemNo."Unit Cost";
                        Amount += ("Warehouse Entry1".Quantity * ItemNo."Unit Cost");





                        //END;

                        PreRec := CurrRec;
                    END;
                    //CLEAR(Quantity);
                    Amounttotal := 0;
                    Amount := "Warehouse Entry1".Quantity * ItemNo."Unit Cost";
                    Quantity := "Warehouse Entry1".Quantity;
                    Bintotal := Bintotal + "Warehouse Entry1".Quantity;
                    Bincontent1 := "Warehouse Entry1"."Bin Code";
                    Amounttotal := Amounttotal + Amount;
                    //MESSAGE(FORMAT(Quantity));

                    //Bincontent1:="Warehouse Entry1"."Bin Code";
                    /*
                    IF Printtoexcel THEN BEGIN
                    
                          ExcelBuf.AddColumn("Warehouse Entry1"."Item No.",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
                          ExcelBuf.AddColumn(itemdescription,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
                          ExcelBuf.AddColumn("Warehouse Entry1"."Zone Code",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
                          ExcelBuf.AddColumn("Warehouse Entry1"."Bin Code",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
                          ExcelBuf.AddColumn("Warehouse Entry1"."Lot No.",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
                          ExcelBuf.AddColumn("Warehouse Entry1"."Expiration Date",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Date);
                          ExcelBuf.AddColumn("Warehouse Entry1".Quantity,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
                          ExcelBuf.AddColumn(ItemNo."Unit Cost",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
                          ExcelBuf.AddColumn("Warehouse Entry1".Quantity * ItemNo."Unit Cost",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
                          ExcelBuf.NewRow;
                    
                    END;
                    */

                end;

                trigger OnPreDataItem()
                begin
                    //"Warehouse Entry1".SETCURRENTKEY("Warehouse Entry1"."Lot No.");//anikEt 140514
                    //"Warehouse Entry1".ASCENDING(TRUE);
                    //CurrReport.CREATETOTALS(Amount,Quantity);

                    IF (Startdate <> 0D) AND (enddate <> 0D) THEN
                        "Warehouse Entry1".SETFILTER("Warehouse Entry1"."Registering Date", '%1..%2', Startdate, enddate);
                end;
            }

            trigger OnAfterGetRecord()
            begin

                IF Quantity <> 0 THEN
                    GrandTotal := GrandTotal + Amounttotal;
            end;

            trigger OnPreDataItem()
            begin

                Companyinfo.GET;

                Amounttotal := 0;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(option)
                {
                    Caption = 'option';
                    field(PrintToexcel; Printtoexcel)
                    {
                        ApplicationArea = All;
                    }
                    field(Startdate; Startdate)
                    {
                        ApplicationArea = All;
                        Caption = '<Start date>';
                    }
                    field(enddate; enddate)
                    {
                        ApplicationArea = All;
                        Caption = '<Enddate>';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        IF Printtoexcel AND (Qty <> 0) THEN
            MakeExcelDataBody;


        IF Printtoexcel THEN
            CreateExcelbook;
    end;

    trigger OnPreReport()
    begin

        Binfilter := "Bin Content".GETFILTERS;

        IF Printtoexcel THEN
            MakeExcelInfo;
    end;

    var
        Binfilter: Text[250];
        Printtoexcel: Boolean;
        ExcelBuf: Record 370 temporary;
        Amount: Decimal;
        Total: Decimal;
        "itemno.": Code[30];
        Bincontent: Record 7302;
        Total1: Decimal;
        Groupby: Option Item,Bincontent;
        PrintItemText: Boolean;
        ItemNumber: Code[50];
        Bincontent1: Code[50];
        PrintBinText: Boolean;
        Quantity: Decimal;
        Bintotal: Decimal;
        Amounttotal: Decimal;
        GrandTotal: Decimal;
        itemdescription: Text[100];
        text000: Label 'DATA';
        text001: Label 'Zonewise Qty.';
        Companyinfo: Record 79;
        CurrRec: Text[1024];
        PreRec: Text[1024];
        ItemN: Code[30];
        Des: Text;
        Zone: Code[30];
        Lot: Code[30];
        Exp: Date;
        Qty: Decimal;
        UnitCost: Decimal;
        Bin: Code[30];
        ItemNo: Record 27;
        ProductLicense: Record 50008;
        "PLNo.": Code[30];
        Ecma: Code[30];
        Country: Code[30];
        VariantProdLicenseLine: Record 50010;
        WarehouseEntry: Record 7312;
        PurchaseReceiptLine: Record 121;
        ReceiptDate: Date;
        LotNoInfo: Record 6505;
        PLNo1: Code[30];
        Ecma1: Code[30];
        Country1: Code[30];
        PostDate: Text[50];
        PostingDate: Date;
        RecWarehouseEntry: Record 7312;
        RecBinContent: Record 7302;
        Quantityy: Decimal;
        whseqty: Decimal;
        Startdate: Date;
        enddate: Date;

    procedure MakeExcelInfo()
    begin
        ExcelBuf.SetUseInfoSheet;
        ExcelBuf.AddInfoColumn('Company Name', FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(COMPANYNAME, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn('Report Name', FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn('Zonewise Quantity', FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn('Reprot No', FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddInfoColumn(50022, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn('User Id', FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(USERID, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn('Date', FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Date);
        ExcelBuf.AddInfoColumn(TODAY, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Date);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn('Filter', FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn("Bin Content".GETFILTERS, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.ClearNewRow;
        MakeExcelDataHeader;
    end;

    procedure MakeExcelDataHeader()
    begin

        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Item No', FALSE, '', TRUE, FALSE, TRUE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Item Description', FALSE, '', TRUE, FALSE, TRUE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Posting Date', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Zone Code', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Bin Code', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('PL No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Country', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('ECMA No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Batch No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Expiration Date', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Quantity', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Average Cost', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Total Amount', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
    end;

    procedure MakeExcelDataBody()
    begin

        //IF "Warehouse Entry1".Quantity > 0  THEN BEGIN //anikEt 140514
        //IF Amount >0 THEN BEGIN
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(ItemN, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Des, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(PostDate, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Zone, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Bin, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(PLNo1, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Country1, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Ecma1, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Lot, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Exp, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Date);
        //  ExcelBuf.AddColumn("Warehouse Entry1".Quantity,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(ABS(Qty), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(UnitCost, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(Qty * UnitCost, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        // ExcelBuf.AddColumn(whseqty,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);


        // ExcelBuf.AddColumn(Amount,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        //  ExcelBuf.NewRow;
        //END;//anikEt
        //END;
    end;

    // procedure CreateExcelbook()
    // begin
    //     ExcelBuf.CreateBookAndOpenExcel('',text001,'',COMPANYNAME,USERID);
    //     ERROR('');
    // end;

    procedure CreateExcelbook()
    begin
        ExcelBuf.CreateNewBook(text001);
        ExcelBuf.WriteSheet(text001, CompanyName, UserId);
        ExcelBuf.CloseBook();
        ExcelBuf.SetFriendlyFilename(StrSubstNo(text001, CurrentDateTime, UserId));
        ExcelBuf.OpenExcel();
    end;
}

