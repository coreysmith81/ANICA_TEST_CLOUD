XmlPort 50022 "KTT Check Export"
{
    // This program creates an export file of check information to be uploaded
    //   to the bank site for positive pay verification.
    //   The file created is at \\filestore\Company\Key Bank\KTTChecks.txt.

    Caption = 'KTT Check Export';
    Direction = Export;
    FileName = '\\filestore\Company\Key Bank\KTTChecks.txt';
    Format = FixedText;

    schema
    {
        textelement(Root)
        {
            tableelement("Check Ledger Entry";"Check Ledger Entry")
            {
                AutoUpdate = true;
                RequestFilterFields = "Posting Date";
                XmlName = 'CheckLedgerEntry';
                SourceTableView = sorting("Check No.") order(ascending) where("Bank Account No."=const('MAIN'),"Document Type"=const(1),Open=const(true),Amount=filter(<>0));
                textelement(Outputline)
                {
                    Width = 220;
                }

                trigger OnAfterGetRecord()
                begin
                    VSpace := ' ';
                    VZero := '0';
                    //LCC New 4-19-10
                    //Get vendor number and lookup address lines for payee line 2
                    TVendorNo := "Check Ledger Entry"."Bal. Account No.";
                    LookupVendor;
                    VDate := "Check Ledger Entry"."Posting Date";
                    VDay := Date2dmy(VDate,1);
                    VMonth := Date2dmy(VDate,2);
                    VYear := Date2dmy(VDate,3);
                    VTextDay := Format(VDay,2,'<Integer>');
                    VTextMonth := Format(VMonth,2,'<Integer>');
                    VTextYear := Format(VYear,4,'<Integer>');
                    VTextDate := VTextYear + VTextMonth + VTextDay;
                    VZeroDate := ConvertStr(VTextDate, VSpace, VZero);
                    CheckNo := Format("Check Ledger Entry"."Check No.",10,'<Text>');
                    VCheckNo := ConvertStr(CheckNo,VSpace,VZero);
                    VAmt := Format("Check Ledger Entry".Amount,10,'<Integer><Decimal,3>');
                    VTextAmt := CopyStr(VAmt,1,7);
                    VTextAmt2 := CopyStr(VAmt,9,2);
                    VTextAmt3 := ' ' + VTextAmt + VTextAmt2;
                    VAmount := ConvertStr(VTextAmt3, VSpace, VZero);
                    VPayeeName := "Check Ledger Entry".Description;
                    //Add filler for balance of payee name
                    VPayeeName := PadStr(VPayeeName,75,' ');

                    //LCC 10-29-12 New line with new account number
                    Outputline := '00' + '000020122005737' + VCheckNo + VZeroDate + VAmount + ' ' + '               ' + VPayeeName
                        + VPayeeName2 + '         ';
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    trigger OnPostXmlPort()
    begin
        //For Status Box
        Window.Close;
        Clear(Window);
        Message('Check Export is Done');
    end;

    trigger OnPreXmlPort()
    begin
        //For Status Box
        begin
            Clear(Window);
            Window.Open('Processing Item #1######');
        end;
    end;

    var
        VendorRecord: Record Vendor;
        CheckNo: Text;
        VZeroDate: Text;
        VSpace: Text;
        VZero: Text;
        VAmount: Text;
        VTextDate: Text;
        VPayeeName: Text;
        VPayeeName2: Text;
        VDay: Integer;
        VMonth: Integer;
        VYear: Integer;
        VTextDay: Text;
        VTextMonth: Text;
        VTextYear: Text;
        VDate: Date;
        VCheckNo: Text;
        VAmt: Text;
        VTextAmt: Text;
        VTextAmt2: Text;
        VTextAmt3: Text;
        TVendorNo: Text;
        Window: Dialog;

    local procedure LookupVendor()
    begin
        VendorRecord.SetCurrentkey("No.");
        VendorRecord.SetRange("No.",TVendorNo);
        if VendorRecord.Find('+') then
        begin
        //If Address line 1 is not blank, use that, then address 2, if both blank use city state and zip
        if VendorRecord.Address <> '' then VPayeeName2 := VendorRecord.Address else
          if VendorRecord."Address 2" <> '' then VPayeeName2 := VendorRecord."Address 2" else
             VPayeeName2 := VendorRecord.City + ', ' + VendorRecord.County + ' ' + VendorRecord."Post Code";
        end;
    end;
}

