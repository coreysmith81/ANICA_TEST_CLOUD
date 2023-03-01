Codeunit 50103 "Purch.-Post2 + Print"
{
    // //MAS Modified ship/Invoice Menu-options .

    TableNo = "Purchase Header";

    trigger OnRun()
    begin
        PurchHeader.Copy(Rec);
        Code;
        Rec := PurchHeader;
    end;

    var
        PurchHeader: Record "Purchase Header";
        PurchReceiptHeader: Record "Purch. Rcpt. Header";
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
        ReportSelection: Record "Report Selections";
        PurchPost: Codeunit "Purch.-Post";
        Selection: Integer;

    local procedure "Code"()
    begin
        if PurchHeader."Document Type" = PurchHeader."document type"::Order then begin
            //>> MAS
            // Selection := STRMENU('&Receive,&Invoice,Receive &and Invoice',3);
            Selection := StrMenu('&Receive', 1);
            //<<
            if Selection = 0 then
                exit;
            PurchHeader.Receive := Selection in [1, 3];
            PurchHeader.Invoice := Selection in [2, 3];
        end else
            if not
               Confirm(
                 'Do you want to post and print the %1?', false,
                 PurchHeader."Document Type")
            then
                exit;

        PurchPost.Run(PurchHeader);

        case PurchHeader."Document Type" of
            PurchHeader."document type"::Order:
                begin
                    if PurchHeader.Receive then begin
                        PurchReceiptHeader."No." := PurchHeader."Last Receiving No.";
                        PurchReceiptHeader.SetRecfilter;
                        PrintReport(ReportSelection.Usage::"P.Receipt");
                    end;
                    if PurchHeader.Invoice then begin
                        PurchInvHeader."No." := PurchHeader."Last Posting No.";
                        PurchInvHeader.SetRecfilter;
                        PrintReport(ReportSelection.Usage::"P.Invoice");
                    end;
                end;
            PurchHeader."document type"::Invoice:
                begin
                    if PurchHeader."Last Posting No." = '' then
                        PurchInvHeader."No." := PurchHeader."No."
                    else
                        PurchInvHeader."No." := PurchHeader."Last Posting No.";
                    PurchInvHeader.SetRecfilter;
                    PrintReport(ReportSelection.Usage::"P.Invoice");
                end;
            PurchHeader."document type"::"Credit Memo":
                begin
                    if PurchHeader."Last Posting No." = '' then
                        PurchCrMemoHeader."No." := PurchHeader."No."
                    else
                        PurchCrMemoHeader."No." := PurchHeader."Last Posting No.";
                    PurchCrMemoHeader.SetRecfilter;
                    PrintReport(ReportSelection.Usage::"P.Cr.Memo");
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
                ReportSelection.Usage::"P.Invoice":
                    Report.Run(ReportSelection."Report ID", false, false, PurchInvHeader);
                ReportSelection.Usage::"P.Cr.Memo":
                    Report.Run(ReportSelection."Report ID", false, false, PurchCrMemoHeader);
                ReportSelection.Usage::"P.Receipt":
                    Report.Run(ReportSelection."Report ID", false, false, PurchReceiptHeader);
            end;
        until ReportSelection.Next = 0;
    end;
}

