Codeunit 50101 "Sales-Post2 + Print"
{
    // //MAS Modified ship/Invoice Menu-options .

    TableNo = "Sales Header";

    trigger OnRun()
    begin
        SalesHeader.Copy(Rec);
        Code;
        Rec := SalesHeader;
    end;

    var
        SalesHeader: Record "Sales Header";
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesInvHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        ReportSelection: Record "Report Selections";
        SalesPost: Codeunit "Sales-Post";
        Selection: Integer;

    local procedure "Code"()
    begin
        if SalesHeader."Document Type" = SalesHeader."document type"::Order then begin
            //>> MAs
            //  Selection := STRMENU('&Ship,&Invoice,Ship &and Invoice',3);
            Selection := StrMenu('&Ship', 1);
            //<<
            if Selection = 0 then
                exit;
            SalesHeader.Ship := Selection in [1, 3];
            SalesHeader.Invoice := Selection in [2, 3];
        end else
            if not
               Confirm(
                 'Do you want to post and print the %1?', false,
                 SalesHeader."Document Type")
            then
                exit;

        SalesPost.Run(SalesHeader);

        case SalesHeader."Document Type" of
            SalesHeader."document type"::Order:
                begin
                    if SalesHeader.Ship then begin
                        SalesShipmentHeader."No." := SalesHeader."Last Shipping No.";
                        SalesShipmentHeader.SetRecfilter;
                        PrintReport(ReportSelection.Usage::"S.Shipment");
                    end;
                    if SalesHeader.Invoice then begin
                        SalesInvHeader."No." := SalesHeader."Last Posting No.";
                        SalesInvHeader.SetRecfilter;
                        PrintReport(ReportSelection.Usage::"S.Invoice");
                    end;
                end;
            SalesHeader."document type"::Invoice:
                begin
                    if SalesHeader."Last Posting No." = '' then
                        SalesInvHeader."No." := SalesHeader."No."
                    else
                        SalesInvHeader."No." := SalesHeader."Last Posting No.";
                    SalesInvHeader.SetRecfilter;
                    PrintReport(ReportSelection.Usage::"S.Invoice");
                end;
            SalesHeader."document type"::"Credit Memo":
                begin
                    if SalesHeader."Last Posting No." = '' then
                        SalesCrMemoHeader."No." := SalesHeader."No."
                    else
                        SalesCrMemoHeader."No." := SalesHeader."Last Posting No.";
                    SalesCrMemoHeader.SetRecfilter;
                    PrintReport(ReportSelection.Usage::"S.Cr.Memo");
                end;
        end;
    end;

    local procedure PrintReport(ReportUsage: Enum "Report Selection Usage")
    begin
        ReportSelection.Reset;
        ReportSelection.SetRange(Usage, ReportUsage);
        ReportSelection.Find('-');
        repeat
            ReportSelection.TestField("Report ID");
            case ReportUsage of
                ReportSelection.Usage::"S.Invoice":
                    Report.Run(ReportSelection."Report ID", false, false, SalesInvHeader);
                ReportSelection.Usage::"S.Cr.Memo":
                    Report.Run(ReportSelection."Report ID", false, false, SalesCrMemoHeader);
                ReportSelection.Usage::"S.Shipment":
                    Report.Run(ReportSelection."Report ID", false, false, SalesShipmentHeader);
            end;
        until ReportSelection.Next = 0;
    end;
}

