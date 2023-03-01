XmlPort 50043 "Jensen PO Export"
{
    // This program creates an export file for the Jensen purchase order
    //   which is copied to their FTP site.
    //   The ouput file is at \\filestore\EDI\Jenson\PO_Export\JensenPO.TXT.

    Caption = 'Jensen_EDI FTP Export';
    Direction = Export;
    FileName = '\\filestore\EDI\Jenson\PO_Export\Other\TESTtemp.txt';
    Format = FixedText;
    TableSeparator = '<CR/LF>';

    schema
    {
        textelement(Root)
        {
            tableelement("Purchase Header";"Purchase Header")
            {
                AutoUpdate = true;
                RequestFilterFields = "Document Date";
                XmlName = 'PurchaseHeader';
                SourceTableView = sorting("Document Type","Buy-from Vendor No.","No.") order(ascending) where("Buy-from Vendor No."=filter('JENS001'),"ANICA Confirmed"=const(0),Status=const(1));
                textelement(VOutputFileLine)
                {
                    Width = 60;
                }

                trigger OnAfterGetRecord()
                begin
                    //Get Header Info
                    VCustomerNo := "Purchase Header"."Sell-to Customer No.";
                    LookupJenVendor;
                    VPoNumber := "Purchase Header"."No.";
                    VDate := "Purchase Header"."Document Date";
                    VDay := Date2dmy(VDate,1);
                    VMonth := Date2dmy(VDate,2);
                    VYear := Date2dmy(VDate,3);
                    VTextDay := Format(VDay,2,'<Integer>');
                    VTextMonth := Format(VMonth,2,'<Integer>');
                    VTextYear := Format(VYear,4,'<Integer>');
                    VTextDate := VTextMonth + '/' + VTextDay + '/' + VTextYear;
                    VZeroDate := ConvertStr(VTextDate, VSpace, VZero);

                    VOutPutPo := "Purchase Header"."No.";
                    VPONo := PadStr(VOutPutPo,15,' ');

                    VLinePO := VOutPutPo + ' ' + VJenCustNo + ' ' + "Purchase Header"."Ship-to Name";
                    VPOFile.Write(VLinePO);

                    //Now create the lines
                    WriteLineRecords;

                    //update confirmed flag on header
                    "Purchase Header"."ANICA Confirmed" := 4;
                    "Purchase Header".Modify(true);
                end;

                trigger OnPreXmlItem()
                begin
                    PurchaseSetup.Get;
                    PurchaseSetup."Jensen File No." := PurchaseSetup."Jensen File No." + 1;
                    PurchaseSetup.Modify(true);
                    VFileNo := PurchaseSetup."Jensen File No.";
                    VSpace := ' ';
                    VZero := '0';
                    VTextFileNo := Format(VFileNo,2,'<Integer>');
                    VZeroFileNo := ConvertStr(VTextFileNo, VSpace, VZero);
                    VFileName := 'an' + '100735' + VZeroFileNo + '.TXT';
                    VFullFileName := '\\filestore\EDI\Jenson\PO_Export\' + VFileName;
                    VLineOutputFile.Create(VFullFileName);
                    VLineOutputFile.TextMode(true);
                    VPOFile.Create('\\filestore\EDI\Jenson\PO_Export\TESTJensenPO.TXT');
                    VPOFile.TextMode(true);
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
        VLineOutputFile.Close;
        VPOFile.Close;

        //For Status Box
        Window.Close;
        Clear(Window);
        Message('Jensen Export is Done');
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
        JenCatalogRecord: Record "Catalog Customer Numbers";
        PurchaseLineRecord: Record "Purchase Line";
        PurchaseSetup: Record "Purchases & Payables Setup";
        VOutputLine: Text;
        VCustomerNo: Text;
        VJenCustNo: Text;
        VLineOutputFile: File;
        VPoNumber: Text;
        VTextQty: Text;
        VOutPutPo: Text;
        VTextItem: Text;
        VDate: Date;
        VTextDate: Text;
        VFileNo: Integer;
        VTextFileNo: Text;
        VZeroDate: Text;
        VSpace: Text;
        VZero: Text;
        VZeroFileNo: Text;
        VZeroQty: Text;
        VDay: Integer;
        VMonth: Integer;
        VYear: Integer;
        VTextDay: Text;
        VTextMonth: Text;
        VTextYear: Text;
        VPOFile: File;
        VLinePO: Text;
        VFileName: Text;
        VCheckItem: Text;
        VFullFileName: Text;
        VPONo: Text;
        VTextItem2: Text;
        Window: Dialog;

    local procedure LookupJenVendor()
    begin
        JenCatalogRecord.SetCurrentkey(Customer,"Catalog Vendor");
        JenCatalogRecord.SetRange(Customer,VCustomerNo);
        JenCatalogRecord.SetRange("Catalog Vendor",'Jen');
        if JenCatalogRecord.Find('+') then
        VJenCustNo := JenCatalogRecord."Vendor's customer number"
        else
        begin
        Message('Could Not Find Customer No %1',VCustomerNo);
        VJenCustNo := '';
        currXMLport.Skip;
        end;
    end;

    local procedure WriteLineRecords()
    begin
        PurchaseLineRecord.SetCurrentkey("Document Type","Document No.");
        PurchaseLineRecord.SetRange("Document Type",1);
        PurchaseLineRecord.SetRange("Document No.",VPoNumber);
        if PurchaseLineRecord.Find('-') then
        begin
             repeat
             if PurchaseLineRecord.Type = 2 then
             begin
             VTextQty := Format(PurchaseLineRecord.Quantity,6,'<Integer>');
             VTextItem := CopyStr(PurchaseLineRecord."Vendor Item No.",1,15);
             VTextItem2 := PadStr(VTextItem,15,' ');
             VOutputFileLine := VJenCustNo + ' ' + VZeroDate + ' ' + '  ' + ' ' + VPONo + ' ' + VTextItem2 + '         ' + VTextQty;
             VLineOutputFile.Write(VOutputFileLine);
             end
             until PurchaseLineRecord.Next = 0;
        end;
    end;
}

