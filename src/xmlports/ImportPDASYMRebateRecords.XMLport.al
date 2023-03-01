XmlPort 50004 "Import PDA SYM Rebate Records"
{
    // 
    // The separate R??????.TXT files in \\edi6\ANICA DATA\Rebate Process\
    //   are copied to the single file \\edi6\ANICA DATA\Rebate Process\SymRebate.txt.
    //   This file is processed and imported into Navision.
    //   After a successful import, the separate R??????.TXT files and SymRebate.txt
    //   are copied to \\edi6\Backup\

    Caption = 'Import PDA SYM Rebate Records';
    Direction = Import;
    FieldDelimiter = '<None>';
    FileName = '\\EDISVR\ANICA DATA\Rebate Process\symrebate.txt';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(Integer;Integer)
            {
                AutoSave = false;
                XmlName = 'Integer';
                textelement(TStoreNo)
                {
                }
                textelement(TxtDate)
                {

                    trigger OnAfterAssignVariable()
                    begin
                        //Convert date
                        if Evaluate(TDate,TxtDate) = false then Message('Invalid Date');
                    end;
                }
                textelement(TxtCustNo)
                {

                    trigger OnAfterAssignVariable()
                    begin
                        //Convert Customer No
                        if Evaluate(TCustno,TxtCustNo) = false then Message('Invalid Amount');
                    end;
                }
                textelement(TxtAmount)
                {

                    trigger OnAfterAssignVariable()
                    begin
                        //Convert Amount
                        if Evaluate(TAmount,TxtAmount) = false then Message('Invalid Amount');
                    end;
                }

                trigger OnAfterInsertRecord()
                begin

                    //Edit store number
                    CustomerRecord.SetCurrentkey("No.");
                    CustomerRecord.SetRange("No.",TStoreNo);
                    if not CustomerRecord.Find('+') then
                    begin
                    PCustNo := Format(TCustno,0,0);
                    PDate := Format(TDate,0,'<Month>/<DAY>/<Year>');
                    PAmount := Format(TAmount,0,'<Integer><Decimal,3>');
                    VOutputFileLine := TStoreNo + '   ' + PCustNo + '   ' + PDate + '   ' + PAmount + '    Store Number is Invalid';
                    VLineOutputFile.Write(VOutputFileLine);
                    end;
                    CustomerRecord.SetRange("No.");//clear filter

                    //Edit customer Number
                    RebatesCustomers.SetCurrentkey("Rebate Store No.","Rebate Customer No.");
                    RebatesCustomers.SetRange("Rebate Store No.",TStoreNo);
                    RebatesCustomers.SetRange("Rebate Customer No.",TCustno);
                    if not RebatesCustomers.Find('+') then
                    begin
                    PCustNo := Format(TCustno,0,0);
                    PDate := Format(TDate,0,'<Month>/<DAY>/<Year>');
                    PAmount := Format(TAmount,0,'<Integer><Decimal,3>');
                    VOutputFileLine := TStoreNo + '   ' + PCustNo + '   ' + PDate + '   ' + PAmount + '    Customer Number is Invalid';
                    VLineOutputFile.Write(VOutputFileLine);
                    end;
                    RebatesCustomers.SetRange("Rebate Store No.");//clear filters
                    RebatesCustomers.SetRange("Rebate Customer No.");

                    //Get the first customer value
                    if FirstRecord = false then
                      begin
                      LastCustomer := TStoreNo;
                      CustomersInImport := TStoreNo;
                      end;
                    FirstRecord := true;

                    //Add Customers to a message for the end of the process
                    if TStoreNo <> LastCustomer then CustomersInImport := CustomersInImport + ' ' + TStoreNo;

                    //Edit Amount field
                    if TAmount = 0 then
                    begin
                    PCustNo := Format(TCustno,0,0);
                    PDate := Format(TDate,0,'<Month>/<DAY>/<Year>');
                    PAmount := Format(TAmount,0,'<Integer><Decimal,3>');
                    VOutputFileLine := TStoreNo + '   ' + PCustNo + '   ' + PDate + '   ' + PAmount + '    Amount is zero';
                    VLineOutputFile.Write(VOutputFileLine);
                    end;

                    //Get next sequence number
                    RebatesDetail.SetCurrentkey(RebatesDetail."Sequence No.");
                    RebatesDetail.SetRange(RebatesDetail."Sequence No.");
                    if RebatesDetail.Find('+') then TSequence := RebatesDetail."Sequence No." + 1
                    else
                    TSequence := 1;

                    //Create a new rebate record
                    RebatesDetail.SetCurrentkey(RebatesDetail."Sequence No.");
                    RebatesDetail.Init;
                    RebatesDetail."Sequence No." := TSequence;
                    RebatesDetail."Customer No." := TCustno;
                    RebatesDetail."Store No." := TStoreNo;
                    if TDate < 20170101D then
                        RebatesDetail.Date := CalcDate('-1M',Today)
                    else
                        RebatesDetail.Date := TDate;
                    RebatesDetail.Amount := TAmount;
                    RebatesDetail.Insert(true);

                    LastCustomer := TStoreNo;
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

    trigger OnInitXmlPort()
    begin

        //Start with a blank file to avoid dup processing
        //Run DOS batch file to copy all files to \Rebate Process\SymRebate.TXT
        //SHELL('\\EDISVR\ANICA DATA\Rebate Process\CopySymRebate.bat');
    end;

    trigger OnPostXmlPort()
    begin
        //For Status Box
        Window.Close;
        Clear(Window);

        Message('Symbol and PDA Rebate Files Successfully Imported');
        Message('%1',CustomersInImport);
        //Run DOS batch file to copy all files to backup folder
        //SHELL('\\EDISVR\ANICA DATA\Rebate Process\MoveRebateFile.bat');
        //CLEARALL;
    end;

    trigger OnPreXmlPort()
    begin
        //For Status Box
        begin
            Clear(Window);
            Window.Open('Processing Item #1######');
        end;

        VLineOutputFile.Create('\\filestore\EDI\Rebates\Rebate_Errors.txt');
        VLineOutputFile.TextMode(true);
        VOutputFileLine := 'Store     Cust   Date     Amount  Error';
        VLineOutputFile.Write(VOutputFileLine);
        //MESSAGE('The Import Error File can be found at \\filestore\EDI\Rebates\rebate_errors.txt');
    end;

    var
        CustomerRecord: Record Customer;
        RebatesCustomers: Record "Rebates Customers";
        RebatesDetail: Record "Rebates Detail";
        VLineOutputFile: File;
        VOutputFileLine: Text;
        TSequence: Integer;
        TCustno: Integer;
        TDate: Date;
        TAmount: Decimal;
        PCustNo: Text;
        PDate: Text;
        PAmount: Text;
        CustomersInImport: Text;
        LastCustomer: Text;
        FirstRecord: Boolean;
        Window: Dialog;
}

