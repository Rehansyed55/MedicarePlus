report 50100 "Goods Inward Note"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Goods Inward Note';
    DefaultLayout = RDLC;
    RDLCLayout = 'GoodsInwardNote.rdl';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Posted Gate Entry Header"; "Posted Gate Entry Header 1")
        {
            DataItemTableView = sorting("Entry Type", "No.");
            RequestFilterFields = "No.";
            PrintOnlyIfDetail = false;

            // ---- Header fields (confirmed against table 50115) ----
            column(PostingDate; Format("Posting Date")) { }
            column(PostingTime; Format("Posting Time")) { }
            column(DocumentDate; "Document Date") { }
            column(DocumentTime; "Document Time") { }
            column(GateEntryNo; "Gate Entry No.") { }
            column(HeaderNo; "No.") { }
            column(EntryType; "Entry Type") { }
            column(CarrierCourier; "Carrier/Courier") { }
            column(Barcode; EncodedText)
            {
            }
            // ---- Calculated / accumulated values ----
            column(OrderNo; OrderNo) { }
            column(SuppInvNo; SuppInvNo) { }
            column(SuppName; SuppName) { }
            column(NoofUnits; NoofUnits) { }
            column(CarrierWeight; CarrierWeight) { }
            column(CompWeight; CompWeight) { }

            // ---- Static captions ----
            column(GoodsInwardsNoteCaption; GoodsInwardsNoteCaptionLbl) { }
            column(DateGoodsReceivedCaption; DateGoodsReceivedCaptionLbl) { }
            column(TimeCaption; TimeCaptionLbl) { }
            column(OurLogOnCaption; OurLogOnCaptionLbl) { }
            column(DateCheckedCaption; DateCheckedCaptionLbl) { }
            column(CommentsIfAnyCaption; CommentsIfAnyCaptionLbl) { }
            column(NoCaption; NoCaptionLbl) { }
            column(OurOrderRefCaption; OurOrderRefCaptionLbl) { }
            column(DetailsCaption; DetailsCaptionLbl) { }
            column(SupplierDelNoteInvoiceRefCaption; SupplierDelNoteInvoiceRefCaptionLbl) { }
            column(SupplierCaption; SupplierCaptionLbl) { }
            column(CarrierCaption; CarrierCaptionLbl) { }
            column(DeliveryOrderCaption; DeliveryOrderCaptionLbl) { }
            column(ConditionCaption; ConditionCaptionLbl) { }
            column(OKCaption; OKCaptionLbl) { }
            column(UnexaminedCaption; UnexaminedCaptionLbl) { }
            column(DamagedCaption; DamagedCaptionLbl) { }
            column(CompleteCaption; CompleteCaptionLbl) { }
            column(PartCaption; PartCaptionLbl) { }
            column(CarrierWeightLabelCaption; CarrierWeightLabelCaptionLbl) { }
            column(CompanyWeightLabelCaption; CompanyWeightLabelCaptionLbl) { }
            column(DamagedDiscrepancyReportAttachedCaption; DamagedDiscrepancyReportAttachedCaptionLbl) { }
            column(AttachToAllDeliveryNotesCaption; AttachToAllDeliveryNotesCaptionLbl) { }
            column(DeliveryReceivedCompleteCaption; DeliveryReceivedCompleteCaptionLbl) { }
            column(NoShortageDamageCaption; NoShortageDamageCaptionLbl) { }
            column(CheckedByCaption; CheckedByCaptionLbl) { }
            column(NameCaption; NameCaptionLbl) { }
            column(SignCaption; SignCaptionLbl) { }
            column(DateCaption; DateCaptionLbl) { }
            column(TimeLabelCaption; TimeLabelCaptionLbl) { }
            column(IfNotThenFillInReportCaption; IfNotThenFillInReportCaptionLbl) { }
            column(YesNoCaption; YesNoCaptionLbl) { }
            column(TotalCaption; TotalCaptionLbl) { }
            column(DebugPackingFilter; 'DEBUG: DocNo=[' + HeaderGateEntryNoForPacking + '] HeaderNo=[' + "No." + '] GateEntryNoField=[' + "Gate Entry No." + ']') { }

            dataitem("Posted Gate Entry Line"; "Posted Gate Entry Line 1")
            {
                DataItemLink = "Gate Entry No." = field("No.");
                DataItemTableView = sorting("Entry Type", "Gate Entry No.", "Line No.");

                dataitem("Doc Wise Packing Details"; "Doc Wise Packing Details")
                {
                    DataItemTableView = sorting("Document Type", "Document No.", "Line No./Item No.", "Entry Line No", "Source no.");

                    column(UOMDescription; UOMDescriptionText) { }
                    column(PackingNoOfUnits; "No of.Units") { }
                    column(PackingRemarks; Remarks) { }
                    column(PackingCarrierWeight; "Carrier Weight") { }
                    column(PackingCompanyWeight; "Company Weight") { }
                    column(PackingDocumentType; "Document Type") { }
                    column(PackingDocumentNo; "Document No.") { }
                    column(PackingLineNoItemNo; "Line No./Item No.") { }
                    column(PackingEntryLineNo; "Entry Line No") { }
                    column(PackingSourceNo; "Source no.") { }

                    trigger OnPreDataItem()
                    begin
                        SetRange("Document Type", "Document Type"::GateEntryIn);
                        SetRange("Document No.", HeaderGateEntryNoForPacking);
                        SetRange("Line No./Item No.", Format(LineLineNoForPacking));
                        SetRange("Source no.", LineSourceNoForPacking);
                    end;

                    trigger OnAfterGetRecord()
                    begin
                        UOMDescriptionText := UOM;

                        if UnitOfMeasureRec.Get(UOM) then
                            UOMDescriptionText := UnitOfMeasureRec.Description;
                    end;
                }
                trigger OnAfterGetRecord()
                begin
                    LineLineNoForPacking := "Line No.";
                    LineSourceNoForPacking := "Doc. Source No.";
                end;
            }
            trigger OnAfterGetRecord()
            var
                BarcodeString: Text;
                BarcodeSymbology: Enum "Barcode Symbology";
                BarcodeFontProvider: Interface "Barcode Font Provider";
            begin
                // Reset values for each header
                OrderNo := '';
                SuppName := '';
                SuppInvNo := '';

                NoofUnits := 0;
                CarrierWeight := 0;
                CompWeight := 0;

                TotalPallet := 0;
                TotalCarton := 0;
                PalletCount := 0;

                // Determine the Gate Entry No. to use for Packing Details
                if "Gate Entry No." <> '' then
                    HeaderGateEntryNoForPacking := "Gate Entry No."
                else
                    HeaderGateEntryNoForPacking := "No.";

                // Loop through Posted Gate Entry Lines
                PostedGELine.Reset();
                PostedGELine.SetRange("Gate Entry No.", "No.");

                if PostedGELine.FindSet() then
                    repeat

                        // Build Order No.
                        if OrderNo = '' then
                            OrderNo := PostedGELine."Doc. Source No."
                        else
                            OrderNo += ', ' + PostedGELine."Doc. Source No.";

                        // Get Supplier Information
                        if PostedGELine."Doc. Source Type" =
                           PostedGELine."Doc. Source Type"::"Purchase Order"
                        then begin
                            PurchHeader.Reset();
                            PurchHeader.SetRange("Document Type", PurchHeader."Document Type"::Order);
                            PurchHeader.SetRange("No.", PostedGELine."Doc. Source No.");

                            if PurchHeader.FindFirst() then begin
                                SuppName := PurchHeader."Buy-from Vendor Name";
                                SuppInvNo := PurchHeader."Buy-from Vendor No.";
                            end;
                        end;

                        // Calculate Packing Totals
                        PackingDetails.Reset();
                        PackingDetails.SetRange("Document Type", PackingDetails."Document Type"::GateEntryIn);
                        PackingDetails.SetRange("Document No.", HeaderGateEntryNoForPacking);
                        PackingDetails.SetRange("Line No./Item No.", Format(PostedGELine."Line No."));
                        PackingDetails.SetRange("Source no.", PostedGELine."Doc. Source No.");

                        if PackingDetails.FindSet() then
                            repeat
                                // Grand Totals
                                NoofUnits += PackingDetails."No of.Units";
                                CarrierWeight += PackingDetails."Carrier Weight";
                                CompWeight += PackingDetails."Company Weight";

                                // Pallet / Carton Totals
                                case PackingDetails.UOM of
                                    'PLT':
                                        begin
                                            TotalPallet += PackingDetails."No of.Units";
                                            PalletCount += 1;
                                        end;

                                    'BOX':
                                        TotalCarton += PackingDetails."No of.Units";
                                end;

                            until PackingDetails.Next() = 0;

                    until PostedGELine.Next() = 0;

                //barcode logic 
                BarcodeFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;
                BarcodeSymbology := Enum::"Barcode Symbology"::Code128;
                BarcodeString := "No.";
                BarcodeFontProvider.ValidateInput(BarcodeString, BarcodeSymbology);
                EncodedText := BarcodeFontProvider.EncodeFont(BarcodeString, BarcodeSymbology);


            end;

        }
    }

    // requestpage
    // {
    //     layout
    //     {
    //         area(Content)
    //         {
    //         }
    //     }
    // }

    var
        PurchHeader: Record "Purchase Header";
        PostedGELine: Record "Posted Gate Entry Line 1";
        PackingDetails: Record "Doc Wise Packing Details";
        UnitOfMeasureRec: Record "Unit of Measure";
        SuppName: Text[100];
        SuppInvNo: Code[35];
        OrderNo: Text[1024];
        PalletCount: Integer;
        TotalPallet: Integer;
        TotalCarton: Integer;
        CarrierWeight: Decimal;
        CompWeight: Decimal;
        NoofUnits: Integer;
        UOMDescriptionText: Text[50];
        HeaderGateEntryNoForPacking: Code[20];
        LineLineNoForPacking: Integer;
        LineSourceNoForPacking: Code[20];

        GoodsInwardsNoteCaptionLbl: Label 'GOODS INWARDS NOTE';
        DateGoodsReceivedCaptionLbl: Label 'Date Goods Received';
        TimeCaptionLbl: Label 'Time';
        OurLogOnCaptionLbl: Label 'Our Log on:';
        DateCheckedCaptionLbl: Label 'Date Checked';
        CommentsIfAnyCaptionLbl: Label 'Comments if Any';
        NoCaptionLbl: Label 'No.';
        OurOrderRefCaptionLbl: Label 'Our Order Ref.';
        DetailsCaptionLbl: Label 'DETAILS';
        SupplierDelNoteInvoiceRefCaptionLbl: Label 'Supplier Del. Note/Invoice Ref.';
        SupplierCaptionLbl: Label 'Supplier';
        CarrierCaptionLbl: Label 'Carrrier:';
        DeliveryOrderCaptionLbl: Label 'DELIVERY ORDER';
        ConditionCaptionLbl: Label 'CONDITION';
        OKCaptionLbl: Label 'OK';
        UnexaminedCaptionLbl: Label 'Unexamined';
        DamagedCaptionLbl: Label 'Damaged';
        CompleteCaptionLbl: Label 'Complete';
        PartCaptionLbl: Label 'Part';
        CarrierWeightLabelCaptionLbl: Label 'Carrier Weight';
        CompanyWeightLabelCaptionLbl: Label 'Company Weight';
        DamagedDiscrepancyReportAttachedCaptionLbl: Label 'Damaged /Discrepancy Report Attached: Y/N';
        AttachToAllDeliveryNotesCaptionLbl: Label 'Attach To All Delivery Notes:';
        DeliveryReceivedCompleteCaptionLbl: Label 'Delivery Received Complete ( In Good Condition)';
        NoShortageDamageCaptionLbl: Label '(I.E. No Shortage And Or Damage)';
        CheckedByCaptionLbl: Label 'Checked By:';
        NameCaptionLbl: Label 'Name:';
        SignCaptionLbl: Label 'Sign:';
        DateCaptionLbl: Label 'Date:';
        TimeLabelCaptionLbl: Label 'Time:';
        IfNotThenFillInReportCaptionLbl: Label 'If Not then Fill in Report:';
        YesNoCaptionLbl: Label 'YES/No';
        TotalCaptionLbl: Label 'Total';
        EncodedText: Text;
}


