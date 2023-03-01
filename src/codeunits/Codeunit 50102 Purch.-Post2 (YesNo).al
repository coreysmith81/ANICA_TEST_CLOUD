Codeunit 50102 "Purch.-Post2 (Yes/No)"
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
        PurchPost: Codeunit "Purch.-Post";
        Selection: Integer;

    local procedure "Code"()
    begin
        if PurchHeader."Document Type" = PurchHeader."document type"::Order then begin
            Selection := StrMenu('&Receive', 1);
            //<<
            if Selection = 0 then
                exit;
            PurchHeader.Receive := Selection in [1, 3];
            PurchHeader.Invoice := Selection in [2, 3];
        end else
            if not
               Confirm(
                 'Do you want to post the %1?', false,
                 PurchHeader."Document Type")
            then
                exit;

        PurchPost.Run(PurchHeader);
    end;
}

