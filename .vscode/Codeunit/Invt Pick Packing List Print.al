codeunit 60032 "Invt. Pick Packing List Print"
{
    // Bound manually from the Inventory Pick page on Post and Print when "Print Packing List" is ticked.
    // It holds back the standard posted invoice print so the invoice and packing list can be downloaded
    // as one PDF - the web client only keeps the last file downloaded in a single action.
    EventSubscriberInstance = Manual;

    var
        SalesOrderNo: Code[20];
        PostedInvoiceNo: Code[20];
        InvoiceTxt: Label 'Invoice %1 - Packing List %2.pdf', Comment = '%1 = Posted Sales Invoice No., %2 = Posted Invt. Pick No.';

    procedure SetSalesOrderNo(NewSalesOrderNo: Code[20])
    begin
        SalesOrderNo := NewSalesOrderNo;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post + Print", 'OnBeforePrintInvoice', '', false, false)]
    local procedure HoldBackInvoicePrint(var SalesHeader: Record "Sales Header"; SendReportAsEmail: Boolean; var IsHandled: Boolean)
    begin
        if IsHandled or SendReportAsEmail then
            exit;
        // Only the invoice of the sales order being picked
        if (SalesHeader."Document Type" <> SalesHeader."Document Type"::Order) or (SalesHeader."No." <> SalesOrderNo) then
            exit;

        // Same posted invoice lookup as "Sales-Post + Print".PrintInvoice
        if SalesHeader."Last Posting No." = '' then
            PostedInvoiceNo := SalesHeader."No."
        else
            PostedInvoiceNo := SalesHeader."Last Posting No.";
        IsHandled := true;
    end;

    procedure PrintHeldBackInvoice()
    var
        SalesInvHeader: Record "Sales Invoice Header";
    begin
        if PostedInvoiceNo = '' then
            exit;

        SalesInvHeader.Get(PostedInvoiceNo);
        SalesInvHeader.SetRecFilter();
        SalesInvHeader.PrintRecords(false);
    end;

    procedure PrintInvoiceWithPackingList(var PostedInvtPickHeader: Record "Posted Invt. Pick Header")
    var
        SalesInvHeader: Record "Sales Invoice Header";
        SalesInvoiceReport: Report "Sales - Invoice";
        PackingListBlob: Codeunit "Temp Blob";
        MergedBlob: Codeunit "Temp Blob";
        PostedInvtPickRef: RecordRef;
        PackingListOutStr: OutStream;
        MergedOutStr: OutStream;
        MergedInStr: InStream;
        FileName: Text;
    begin
        if PostedInvoiceNo = '' then begin
            // No invoice was posted (e.g. Ship only) - print the packing list on its own
            Report.RunModal(Report::"Packing List new", false, false, PostedInvtPickHeader);
            exit;
        end;

        SalesInvHeader.Get(PostedInvoiceNo);
        SalesInvHeader.SetRecFilter();

        PostedInvtPickRef.GetTable(PostedInvtPickHeader);
        PackingListBlob.CreateOutStream(PackingListOutStr);
        Report.SaveAs(Report::"Packing List new", '', ReportFormat::Pdf, PackingListOutStr, PostedInvtPickRef);

        SalesInvoiceReport.SetTableView(SalesInvHeader);
        SalesInvoiceReport.UseRequestPage(false);
        SalesInvoiceReport.SetPdfToAppend(PackingListBlob);
        MergedBlob.CreateOutStream(MergedOutStr);
        SalesInvoiceReport.SaveAs('', ReportFormat::Pdf, MergedOutStr);

        MergedBlob.CreateInStream(MergedInStr);
        FileName := StrSubstNo(InvoiceTxt, SalesInvHeader."No.", PostedInvtPickHeader."No.");
        DownloadFromStream(MergedInStr, '', '', '', FileName);
    end;
}
