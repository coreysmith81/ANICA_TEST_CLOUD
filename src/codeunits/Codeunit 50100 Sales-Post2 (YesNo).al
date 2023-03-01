Codeunit 50100 "Sales-Post2 (Yes/No)"
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
                 'Do you want to post the %1?', false,
                 SalesHeader."Document Type")
            then
                exit;

        SalesPost.Run(SalesHeader);
    end;
}

