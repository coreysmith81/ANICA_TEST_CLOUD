XmlPort 50045 "Frito-Lay PO Export"
{
    // This program creates an export file for the Frito-Lay purchase order
    //   which is copied to their FTP site.
    //   The ouput file is at \\filestore\EDI\FritoLay\PO_Export\ANICA_ORDER_XXXX.TXT.

    Caption = 'Frito-Lay_EDI FTP Export';
    Direction = Export;
    FileName = '\\filestore\EDI\Frito-Lay\TESTFritoLayPO\Other\TESTtemp.txt';
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
                SourceTableView = sorting("Document Type","Buy-from Vendor No.","No.") order(ascending) where("Buy-from Vendor No."=filter('FRIT001'),"ANICA Confirmed"=const(0),Status=const(1));
                textelement(VOutputFileLine)
                {
                    Width = 60;
                }

                trigger OnAfterGetRecord()
                begin
                    //Get Header Info
                    VCustomerNo := "Purchase Header"."Sell-to Customer No.";

                    //Lookup Frito Lay's SAP/CIS number
                    LookupFritoCustomer;

                    VPoNumber := "Purchase Header"."No.";
                    //VDate := "Purchase Header"."Document Date";
                    VDay := Date2dmy(VDate,1);
                    VMonth := Date2dmy(VDate,2);
                    VYear := Date2dmy(VDate,3);
                    VTextDay := Format(VDay,2,'<Integer>');
                    VTextMonth := Format(VMonth,2,'<Integer>');
                    VTextYear := Format(VYear,4,'<Integer>');
                    VTextDate := VTextMonth + VTextDay + VTextYear;
                    VZeroDate := ConvertStr(VTextDate, VSpace, VZero);

                    VOutPutPo := "Purchase Header"."No.";
                    VPONo := PadStr(VOutPutPo,7);

                    VLinePO := VOutPutPo + ' ' + VFritoSAP + ' ' + "Purchase Header"."Ship-to Name";
                    VPOFile.Write(VLinePO);

                    //Now create the lines
                    WriteLineRecords;
                end;

                trigger OnPreXmlItem()
                begin
                    PurchaseSetup.Get;
                    PurchaseSetup."Frito-Lay File No." := PurchaseSetup."Frito-Lay File No." + 1;
                    PurchaseSetup.Modify(true);
                    VFileNo := PurchaseSetup."Frito-Lay File No.";
                    VSpace := ' ';
                    VZero := '0';
                    VTextFileNo := Format(VFileNo,4,'<Integer>');
                    VZeroFileNo := ConvertStr(VTextFileNo, VSpace, VZero);
                    VFileName := 'ANICA_ORDER_' + VZeroFileNo + '.TXT';
                    VFullFileName := '\\filestore\EDI\Frito-Lay\PO_Export\' + VFileName;
                    VLineOutputFile.Create(VFullFileName);
                    VLineOutputFile.TextMode(true);
                    //Create Header Line
                    VLineOutputFile.Write('SAP,Date,PO#,GTIN,Qty,UOM');
                    VPOFile.Create('\\filestore\EDI\Frito-Lay\TESTFritoLayPO\TESTFritoLayPO.TXT');
                    VPOFile.TextMode(true);
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(ImportDate)
                {
                    field("Delivery Date";VDate)
                    {
                        ApplicationArea = Basic;
                        ShowMandatory = true;
                    }
                }
            }
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
        Message('FritoLay Export is Done');
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
        FritoCustomer: Record "Frito Lay Customer Numbers";
        PurchaseLineRecord: Record "Purchase Line";
        PurchaseSetup: Record "Purchases & Payables Setup";
        VOutputLine: Text;
        VCustomerNo: Text;
        VFritoSAP: Code[10];
        VFritoGTIN: Code[30];
        VLineOutputFile: File;
        VPoNumber: Text;
        VTextQty: Text;
        VTextQty3: Text;
        VUOM: Text;
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

    local procedure LookupFritoCustomer()
    begin
        //CS 8-16-21: Adding this to skip POs that don't have a Sell-to-customer no. -- which should just be ad orders.
        if VCustomerNo = '' then
            currXMLport.Skip;

        FritoCustomer.SetCurrentkey("Customer No.");
        FritoCustomer.SetRange("Customer No.",VCustomerNo);

            if FritoCustomer.Find('+') then
                VFritoSAP := FritoCustomer."SAP No."
            else
                begin
                    Message('Could Not Find Customer No %1',VCustomerNo);
                    VFritoSAP := '';
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
                            VTextQty := Format(PurchaseLineRecord.Quantity,3,'<Integer>');
                            VTextQty3 := PadStr('',3 - StrLen(Format(PurchaseLineRecord.Quantity)),'0') + Format(PurchaseLineRecord.Quantity);
                            //Description 2 on Frito Item cards should have GTIN in it.
                            VFritoGTIN := CopyStr(PurchaseLineRecord."Vendor Item No.",1,13);
                            VUOM := CopyStr(PurchaseLineRecord."Unit of Measure Code",1,10);
                            VOutputFileLine := VFritoSAP + ',' + VZeroDate + ',' + VPONo + ',' + VFritoGTIN + ',' + VTextQty3 + ',' + VUOM;
                            VLineOutputFile.Write(VOutputFileLine);
                        end
                until PurchaseLineRecord.Next = 0;
            end;
    end;
}

