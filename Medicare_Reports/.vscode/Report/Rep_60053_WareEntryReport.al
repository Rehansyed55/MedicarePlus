report 60053 "Warehouse entry report"
{


    DefaultLayout = RDLC;
    RDLCLayout = './Warehouse entry report.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Warehouse Entry Report';
    dataset
    {
        dataitem("Warehouse Entry"; 7312)
        {
            DataItemTableView = SORTING("Location Code", "Bin Code", "Item No.", "Zone Code");
            RequestFilterFields = "Item No.", "Lot No.", "Location Code", "Bin Code", "User ID";
            column(WhseEntry_CompnayName; COMPANYNAME)
            {
            }
            column(WhseEntry_UserId; "Warehouse Entry"."User ID")
            {
            }
            column(WhseEntry_TableCaption; "Warehouse Entry".TABLECAPTION + ':' + WhseRegFilter)
            {
            }
            column(WhseEntry_RegDate; "Warehouse Entry"."Registering Date")
            {
            }
            column(WhseEntry_SourceNo; "Warehouse Entry"."Source No.")
            {
            }
            column(WhseEntry_ItemNo; "Warehouse Entry"."Item No.")
            {
            }
            column(WhseEntry_VariantCode; "Warehouse Entry"."Variant Code")
            {
            }
            column(WhseEntry_Description; ItemDescription)
            {
            }
            column(WhseEntry_LotNo; "Warehouse Entry"."Lot No.")
            {
            }
            column(WhseEntry_BinCode; "Warehouse Entry"."Bin Code")
            {
            }
            column(WhseEntry_Quantity; "Warehouse Entry".Quantity)
            {
            }
            column(WhseEntry_UnitofMeasure; "Warehouse Entry"."Unit of Measure Code")
            {
            }
            column(WhseEntry_ExpiryDate; "Warehouse Entry"."Expiration Date")
            {
            }
            column(WhseEntry_SupplierCode; SupplierCode)
            {
            }
            column(WhseEntry_SupplierName; vendorname)
            {
            }
            column(WhseEntry_YourRef; YourRef)
            {
            }
            column(WhseEntry_PostingDate; "Warehouse Entry"."Posting Time")
            {
            }

            trigger OnAfterGetRecord()
            begin

                SupplierCode := '';
                YourRef := '';
                vendorname := '';
                IF Item."No." <> "Item No." THEN BEGIN
                    IF NOT Item.GET("Item No.") THEN
                        Item.INIT;
                    ItemDescription := Item.Description;
                END;


                ProductionOrder_Rec.RESET;
                ProductionOrder_Rec.SETRANGE(ProductionOrder_Rec.Status, ProductionOrder_Rec.Status::Finished);
                ProductionOrder_Rec.SETRANGE(ProductionOrder_Rec."No.", "Warehouse Entry"."Source No.");
                IF ProductionOrder_Rec.FINDFIRST THEN BEGIN
                    //IF PurchaseHeader.GET(PurchaseHeader."Document Type"::Order,ProductionOrder_Rec."Purchase order") THEN;

                    PurchRcptHeader.RESET;
                    IF PurchRcptHeader."Order No." <> '' THEN BEGIN
                        PurchRcptHeader.SETRANGE(PurchRcptHeader."Order No.", ProductionOrder_Rec."Purchase order");
                        IF PurchRcptHeader.FINDFIRST THEN BEGIN
                            // CLEAR(SupplierCode);
                            SupplierCode := PurchRcptHeader."Buy-from Vendor No.";
                            YourRef := PurchRcptHeader."Your Reference";
                        END;
                    END;
                END;


                //IF PurchaseHeader.GET(PurchaseHeader."Document Type"::Order,"Warehouse Entry"."Source No.") THEN
                //SupplierCode:=PurchaseHeader."Buy-from Vendor No.";


                PurchaseHeader.RESET;
                PurchaseHeader.SETRANGE(PurchaseHeader."Document Type", PurchaseHeader."Document Type"::Order);
                PurchaseHeader.SETRANGE(PurchaseHeader."No.", "Warehouse Entry"."Source No.");
                IF PurchaseHeader.FINDFIRST THEN BEGIN
                    SupplierCode := PurchaseHeader."Buy-from Vendor No.";
                    YourRef := PurchaseHeader."Your Reference";
                END;
                IF vendor.GET(SupplierCode) THEN
                    vendorname := vendor.Name;
                IF Sourceno <> "Warehouse Entry"."Source No." THEN BEGIN

                    counter := counter + 1;
                END;
                Sourceno := "Warehouse Entry"."Source No.";
                /*WarehouseEntryBuff.RESET;
                WarehouseEntryBuff.SETCURRENTKEY("Location Code","Bin Code","Item No.","Zone Code");
                //WarehouseEntryBuff.SETRANGE("Item No.",WarehouseEntryBuff."Item No.");
                IF WarehouseEntryBuff.FIND('-') THEN
                REPEAT
                  qty += WarehouseEntryBuff.Quantity;
                  Count1 := WarehouseEntryBuff.COUNT;
                //UNTIL WarehouseEntryBuff.NEXT =0;
                MESSAGE('%1',qty);
                MESSAGE('%1',Count1);
                 */
                IF Printtoexcel THEN
                    MakeExcelDataBody;

            end;

            trigger OnPostDataItem()
            begin
                IF Printtoexcel THEN
                    MakeExcelDataFooter;
            end;

            trigger OnPreDataItem()
            begin
                counter := 0;
                Sourceno := '';
                Count1 := 0;
                //CurrReport.CREATETOTALS(qty);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Option)
                {
                    field("Print To Excel"; Printtoexcel)
                    {
                        ApplicationArea = All;
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
        IF Printtoexcel THEN
            CreateExcelbook;
    end;

    trigger OnPreReport()
    begin
        WhseRegFilter := "Warehouse Entry".GETFILTERS;

        IF Printtoexcel THEN BEGIN
            ExcelBuf.DELETEALL;
            MakeExcelInfo;
        END;
    end;

    var
        Item: Record 27;
        WhseRegFilter: Text[250];
        ItemDescription: Text[50];
        total: Decimal;
        counter: Integer;
        Sourceno: Code[20];
        qty: Decimal;
        Printtoexcel: Boolean;
        PurchaseHeader: Record 38;
        ProductionOrder_Rec: Record 5405;
        vendorname: Text[100];
        vendor: Record 23;
        PurchRcptHeader: Record 120;
        SupplierCode: Code[20];
        YourRef: Text[35];
        text000: Label 'DATA';
        text001: Label 'Warehouse Entry Report';
        ExcelBuf: Record 370 temporary;
        RegDate: Date;
        Sourceno1: Code[100];
        Itemno: Code[20];
        VariantCode: Code[20];
        Description: Text;
        Lot: Code[20];
        Bin: Code[30];
        Quantity: Integer;
        UOM: Code[30];
        ExpDate: Date;
        user1: Code[50];
        SuppliarCode1: Code[20];
        Suppname: Text[100];
        YrReff: Text;
        Time1: Time;
        CurrRec: Text;
        PreRec: Text;
        Count1: Integer;
        WarehouseEntryBuff: Record 7312 temporary;

    procedure MakeExcelInfo()
    begin
        ExcelBuf.SetUseInfoSheet;
        ExcelBuf.AddInfoColumn('Company Name', FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(COMPANYNAME, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn('Report Name', FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn('Warehouse Entry Report', FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn('Reprot No', FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(60053, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn('User Id', FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(USERID, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn('Date', FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(TODAY, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Date);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn('Filter', FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn("Warehouse Entry".GETFILTERS, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.ClearNewRow;
        MakeExcelDataHeader;
    end;

    procedure MakeExcelDataHeader()
    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Registering Date', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Source No', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Item No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Variant Code', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Description', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Lot No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Bin Code', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Quantity', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Unit of Measure Code', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Expiry Date', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('User ID', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Suppliar Code', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Suppliar Name', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Your Refrence', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Time', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
    end;

    procedure MakeExcelDataBody()
    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn("Warehouse Entry"."Registering Date", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Date);
        ExcelBuf.AddColumn(Sourceno, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Warehouse Entry"."Item No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Warehouse Entry"."Variant Code", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(ItemDescription, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Warehouse Entry"."Lot No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Warehouse Entry"."Bin Code", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Warehouse Entry".Quantity, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn("Warehouse Entry"."Unit of Measure Code", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Warehouse Entry"."Expiration Date", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Date);
        ExcelBuf.AddColumn("Warehouse Entry"."User ID", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(SupplierCode, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(vendorname, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(YourRef, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Warehouse Entry"."Posting Time", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        qty += "Warehouse Entry".Quantity;
        Count1 := "Warehouse Entry".COUNT;
    end;

    // procedure CreateExcelbook()
    // begin
    //     ExcelBuf.CreateBookAndOpenExcel('','Warehouse Entries','',COMPANYNAME,USERID);
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

    procedure MakeExcelDataFooter()
    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('No. Of Records', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Count1, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

        //ExcelBuf.AddColumn(ROUND(TotalQty,0.01,'='),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        //ExcelBuf.AddColumn(ROUND(TotalVal,0.01,'='),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text)
        ExcelBuf.AddColumn('Total Quantity', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(qty, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
    end;
}

