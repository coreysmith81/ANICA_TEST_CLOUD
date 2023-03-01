Codeunit 50121 BatchPrintPostedSalesInvoices
{
    // <changelog>
    //   <add id="WC0000" date="2015-05-12" dev="jnozzi" releaseversion="WC01"
    //        tracking="Issue126"  >
    //     Routine to print Posted Sales Invoices from the Job Queue.
    //   </add>
    // </changelog>

    TableNo = "Job Queue Entry";

    trigger OnRun()
    begin
        InvoiceHead.Reset;
        InvoiceHead.SetCurrentkey("Bill-to Customer No.");
        InvoiceHead.SetRange("No. Printed", 0);
        InvoiceHead.SetFilter("Payment Method Code", '<>%1', NoPaperText);

        case rec."Parameter String" of
            SubsText:
                InvoiceHead.SetRange("Shipping Instruction Code", true);
            NonSubsText:
                InvoiceHead.SetRange("Shipping Instruction Code", false);
        end;

        if InvoiceHead.Find('-') then
            repeat
                if InvoiceHead."Payment Method Code" = CrCardText then begin
                    if WasThisPaid(InvoiceHead) then
                        PrintThisInvoice(InvoiceHead);
                end else
                    PrintThisInvoice(InvoiceHead);
            until InvoiceHead.Next = 0;
    end;

    var
        InvoiceHead: Record "Sales Invoice Header";
        NoPaperText: label 'NOPAPER';
        CrCardText: label 'CR CARD';
        SubsText: label 'SUBSCRIPTIONS';
        NonSubsText: label 'NONSUBSCRIPTIONS';

    local procedure PrintThisInvoice(InvoiceHead: Record "Sales Invoice Header")
    var
        SalesInvoiceRept: Report "ANICA Check Format";
    begin
        InvoiceHead.Reset;
        InvoiceHead.SetRecfilter;

        Clear(SalesInvoiceRept);
        SalesInvoiceRept.SetTableview(InvoiceHead);
        SalesInvoiceRept.UseRequestPage(false);
        SalesInvoiceRept.RunModal;
    end;

    local procedure WasThisPaid(InvoiceHead: Record "Sales Invoice Header"): Boolean
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
    begin
        CustLedgEntry.Reset;
        CustLedgEntry.SetCurrentkey("Document No.", "Document Type", "Customer No.");
        CustLedgEntry.SetRange("Customer No.", InvoiceHead."Bill-to Customer No.");
        CustLedgEntry.SetRange("Document Type", CustLedgEntry."document type"::Invoice);
        CustLedgEntry.SetRange("Document No.", InvoiceHead."No.");
        if CustLedgEntry.FindFirst then begin
            CustLedgEntry.CalcFields("Original Amt. (LCY)", "Remaining Amt. (LCY)");
            if CustLedgEntry."Remaining Amt. (LCY)" < CustLedgEntry."Original Amt. (LCY)" then
                exit(true);
        end;
        exit(false);
    end;
}

