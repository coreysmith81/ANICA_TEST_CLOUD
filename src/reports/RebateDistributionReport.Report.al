Report 50057 "Rebate Distribution Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Rebate Distribution Report.rdlc';
    UseRequestPage = true;

    dataset
    {
        dataitem("Rebates Customers";"Rebates Customers")
        {
            DataItemTableView = sorting("Rebate Store No.","Rebate Customer No.") order(ascending);
            PrintOnlyIfDetail = true;
            column(ReportForNavId_3624; 3624)
            {
            }
            column(Today;Today)
            {
            }
            column(COMPANYNAME;COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO;CurrReport.PageNo)
            {
            }
            column(UserId;UserId)
            {
            }
            column(Time;Time)
            {
            }
            column(TotalSales;TotalSales)
            {
            }
            column(DistAmt;DistAmt)
            {
            }
            column(MinRebate;MinRebate)
            {
            }
            column(FromDate;FromDate)
            {
            }
            column(ToDate;ToDate)
            {
            }
            column(CustAmt;CustAmt)
            {
            }
            column(Rebates_Customers__Rebates_Customers___Customer_Name_;"Rebates Customers"."Customer Name")
            {
            }
            column(Rebates_Detail___Store_No__;"Rebates Detail"."Store No.")
            {
            }
            column(Rebates_Detail___Customer_No__;"Rebates Detail"."Customer No.")
            {
            }
            column(CustRebate;CustRebate)
            {
            }
            column(CustMinRebate;CustMinRebate)
            {
            }
            column(GrandTotalRebate;GrandTotalRebate)
            {
            }
            column(GrandTotalMinimums;GrandTotalMinimums)
            {
            }
            column(CurrReport_PAGENOCaption;CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Rebates_Customers_Rebate_Store_No_;"Rebate Store No.")
            {
            }
            column(Rebates_Customers_Rebate_Customer_No_;"Rebate Customer No.")
            {
            }
            column(CustPercent;CustPercent)
            {
            }
            dataitem("Rebates Detail";"Rebates Detail")
            {
                DataItemLink = "Customer No."=field("Rebate Customer No."),"Store No."=field("Rebate Store No.");
                DataItemTableView = sorting("Store No.","Customer No.") order(ascending) where(Processed=const(false));
                PrintOnlyIfDetail = false;
                RequestFilterFields = Date;
                column(ReportForNavId_6931; 6931)
                {
                }
                column(Rebates_Customers___Customer_Name_;"Rebates Customers"."Customer Name")
                {
                }
                column(Rebates_Detail__Rebates_Detail__Amount;"Rebates Detail".Amount)
                {
                }
                column(Rebates_Detail_Sequence_No_;"Sequence No.")
                {
                }
                column(Rebates_Detail_Store_No_;"Store No.")
                {
                }
                column(Rebates_Detail_Customer_No_;"Customer No.")
                {
                }
                column(VPrintDetail;VPrintDetail)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CustAmt := "Rebates Detail".Amount + CustAmt;
                    CustPercent := CustAmt / TotalSales;
                    CustRebate := ROUND(DistAmt * CustPercent,0.01);

                    //Mark processed records for final update
                    if VProcess = true then Mark(true);

                    //Check for last record to process last customer rebate and totals
                    DetailCounter := DetailCounter + 1;
                    if DetailCounter = NoRebateDetailRecs then
                    begin
                      if CustRebate <> 0 then
                      begin
                         //Calc Minimums
                         if CustRebate > MinRebate  then
                            begin
                              if VProcess = true then
                              begin
                              CreateVendor;
                              CreateVendorCheckEntry;
                              end
                            end
                            else CustMinRebate := CustRebate;
                         end;
                      //Get GrandTotals
                      GrandTotalRebate := GrandTotalRebate + CustRebate;
                      GrandTotalMinimums := GrandTotalMinimums + CustMinRebate;
                    end;
                end;

                trigger OnPostDataItem()
                begin
                    //Mark all processed items
                    if VProcess = true then
                    begin
                    "Rebates Detail".MarkedOnly;
                    "Rebates Detail".ModifyAll(Processed,true,true);
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //Check to see if this is a new customer, if so calc totals and  determine processing
                if "Rebates Customers"."Rebate Customer No." <> LastCustomerNo then
                begin
                   CustMinRebate := 0;
                   if CustRebate <> 0 then
                   begin
                      //Calc Minimums
                      if CustRebate > MinRebate  then
                      begin
                          if VProcess = true then
                          begin
                          CreateVendor;
                          CreateVendorCheckEntry;
                          end
                      end
                      else CustMinRebate := CustRebate;
                   end;
                   //Get GrandTotals
                   GrandTotalRebate := GrandTotalRebate + CustRebate;
                   GrandTotalMinimums := GrandTotalMinimums + CustMinRebate;
                end;
                //Get Number to check for customer change
                LastCustomerNo := "Rebates Customers"."Rebate Customer No.";

                GetStoreNo := "Rebates Customers"."Rebate Store No.";
                CustAmt := 0;
                CustRebate := 0;
                if VProcess = true then
                begin
                VCustomerNo := "Rebates Customers"."Rebate Customer No.";
                VCustomerName := "Rebates Customers"."Customer Name";
                VCity := "Rebates Customers".City;
                VState := "Rebates Customers".State;
                VZip := "Rebates Customers"."Zip Code";
                end;
            end;

            trigger OnPostDataItem()
            begin
                //Process Last Customer
                CustMinRebate := 0;
                if CustRebate <> 0 then
                begin
                   //Calc Minimums
                   if CustRebate > MinRebate  then
                       begin
                          if VProcess = true then
                          begin
                          CreateVendor;
                          CreateVendorCheckEntry;
                          end
                      end
                      else CustMinRebate := CustRebate;
                   end;
                //Get GrandTotals
                GrandTotalRebate := GrandTotalRebate + CustRebate;
                GrandTotalMinimums := GrandTotalMinimums + CustMinRebate;
            end;

            trigger OnPreDataItem()
            begin
                //Next Document Number
                if VProcess = true then
                begin
                 VendorLedgerEntry.SetCurrentkey("Document Type","Document No.");
                 VendorLedgerEntry.SetRange("Document Type",2);
                 VendorLedgerEntry.SetRange("Document No.",'Z000001','Z999999');
                 if VendorLedgerEntry.Find('+') then
                 VDocumentNo := VendorLedgerEntry."Document No."
                 else
                 VDocumentNo := 'Z002526';
                end;

                SetRange("Rebates Customers"."Rebate Store No.",VStoreNo);
            end;
        }
    }

    requestpage
    {
        SourceTable = Customer;
        SourceTableView = sorting("No.")
                          order(ascending)
                          where("Customer Posting Group"=const('ANICA'));

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(VStoreNo;VStoreNo)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Enter Store Number';
                        TableRelation = Customer."No." where ("Customer Posting Group"=const('ANICA'));
                    }
                    field(VExternalDocNo;VExternalDocNo)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Enter Doc Number';
                    }
                    field(FromDate;FromDate)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Beginning Date';
                    }
                    field(ToDate;ToDate)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Ending Date';
                    }
                    field(DistAmt;DistAmt)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Amount to be Distributed';
                    }
                    field(MinRebate;MinRebate)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Minimum Rebate Amount';
                    }
                    field(VPrintDetail;VPrintDetail)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Print Detail';
                    }
                    field(VProcess;VProcess)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Create Actual Rebate Checks - This action cannont be reversed.';
                        Importance = Promoted;
                    }
                    field(VDueDate;VDueDate)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Due Date';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            //Clear variables

            VPrintDetail := false;
            VProcess := false;
        end;
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        if VProcess = true then
        Message('Purchase Journal Entries Created Batch REBATE');
    end;

    trigger OnPreReport()
    begin
        GetCustomerTotal;
    end;

    var
        RebateDetail: Record "Rebates Detail";
        RebateCustomers: Record "Rebates Customers";
        VendorRecord: Record Vendor;
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        GenJnlLine1: Record "Gen. Journal Line";
        GenJnlLine2: Record "Gen. Journal Line";
        TotalSales: Decimal;
        DistAmt: Decimal;
        MinRebate: Decimal;
        ToDate: Date;
        FromDate: Date;
        CustAmt: Decimal;
        CustPercent: Decimal;
        CustRebate: Decimal;
        CustMinRebate: Decimal;
        VStoreNo: Code[10];
        VLookupCustomer: Integer;
        VProcess: Boolean;
        VPrintDetail: Boolean;
        VCustomerNo: Integer;
        VStoreName: Text[30];
        VExternalDocNo: Text[30];
        VCustomerName: Text[30];
        VCity: Text[50];
        VState: Code[10];
        VZip: Code[15];
        VendorNumber: Code[20];
        VDocumentNo: Code[10];
        VTextCustNo: Text[30];
        GetStoreNo: Code[10];
        Text19015771: label 'Beginning Date';
        Text19001730: label 'Ending Date';
        Text19068719: label 'Amount to be Distributed';
        Text19001376: label 'Minimum Rebate Amount';
        Text19013305: label 'Print Detail';
        Text19039487: label 'Create Actual Rebate Checks - This action cannot be reversed';
        Rebates_CustomersCaptionLbl: label 'Rebates Customers';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        TOTAL_ELIGIBLE_PURCHASESCaptionLbl: label 'TOTAL ELIGIBLE PURCHASES';
        AMOUNT_TO_BE_DISTRIBUTEDCaptionLbl: label 'AMOUNT TO BE DISTRIBUTED';
        MINIMUM_REBATECaptionLbl: label 'MINIMUM REBATE';
        FOR_THE_MONTHS_OFCaptionLbl: label 'FOR THE MONTHS OF';
        TOCaptionLbl: label 'TO';
        Store_No_CaptionLbl: label 'Store No.';
        Customer_No_CaptionLbl: label 'Customer No.';
        Purchase_AmountCaptionLbl: label 'Purchase Amount';
        Rebate_AmountCaptionLbl: label 'Rebate Amount';
        Rebate_PercentageCaptionLbl: label 'Rebate Percentage';
        Total_RebatesCaptionLbl: label 'Total Rebates';
        Eligible_TotalCaptionLbl: label 'Eligible Total';
        Total_of_MinimumsCaptionLbl: label 'Total of Minimums';
        LastCustomerNo: Integer;
        GrandTotalRebate: Decimal;
        GrandTotalMinimums: Decimal;
        LastPosition: Text;
        NoRebateDetailRecs: Decimal;
        DetailCounter: Integer;
        StoreDetailSales: Decimal;
        VDueDate: Date;


    procedure GetCustomerTotal()
    begin
        if VStoreNo = '' then
        begin
        Message('Need Store Number in Options');
        CurrReport.Quit;
        end;

        if VExternalDocNo = '' then
        begin
        Message('Need Doc Number in Options');
        CurrReport.Quit;
        end;

        if DistAmt = 0 then
        begin
        Message('Need Distribution Amount in Options');
        CurrReport.Quit;
        end;

        if MinRebate = 0 then
        begin
        Message('Need Minimum Rebate Amount in Options');
        CurrReport.Quit;
        end;

        if FromDate = 0D then
        begin
        Message('Need Beginning Date in Options');
        CurrReport.Quit;
        end;

        if ToDate = 0D then
        begin
        Message('Need Ending Date in Options');
        CurrReport.Quit;
        end;

        if FromDate > ToDate then
        begin
        Message('Beginning Date Must Be Before End Date');
        CurrReport.Quit;
        end;

        TotalSales := 0;

        RebateDetail.SetCurrentkey(RebateDetail."Store No.");
        RebateDetail.SetRange(RebateDetail."Store No.",VStoreNo);
        RebateDetail.SetRange(RebateDetail.Date,FromDate,ToDate);

        //Get Total Number of rebate detail records to find last record
        NoRebateDetailRecs := RebateDetail.Count;

        if RebateDetail.Find('-') then
        begin
        repeat
        VLookupCustomer := RebateDetail."Customer No.";
        LookupCustomer;
        TotalSales := TotalSales + StoreDetailSales;
        until RebateDetail.Next = 0;
        end;
    end;


    procedure LookupCustomer()
    begin
        RebateCustomers.SetCurrentkey("Rebate Store No.","Rebate Customer No.");
        RebateCustomers.SetRange("Rebate Store No.",VStoreNo);
        RebateCustomers.SetRange("Rebate Customer No.",VLookupCustomer);
        if RebateCustomers.Find('+') then
        begin
        StoreDetailSales := RebateDetail.Amount;
        end
        else
        begin
        StoreDetailSales := 0;
        //9-8-15 Removed error.  Sometimes customers are deleted even when detail exists
        //MESSAGE('Customer %1 %2 is not in the Rebate Customer File',VStoreNo,VLookupCustomer);
        //If the customer does not exist, reduce the line count
        NoRebateDetailRecs := NoRebateDetailRecs - 1;
        end;
        //Clear filters
        RebateCustomers.SetRange("Rebate Store No.");
        RebateCustomers.SetRange("Rebate Customer No.");
    end;


    procedure GetLineNumber()
    begin
        //Line Number
        GenJnlLine2.SetRange(GenJnlLine2."Journal Template Name",GenJnlLine1."Journal Template Name");
        GenJnlLine2.SetRange(GenJnlLine2."Journal Batch Name",GenJnlLine1."Journal Batch Name");
        if GenJnlLine2.Find('+') then
           begin
           GenJnlLine1."Line No." := GenJnlLine2."Line No." + 10;
           end
        else
           begin
           GenJnlLine1."Line No." := 10;
           end;
    end;


    procedure CreateVendor()
    begin
        //Create Vendor Number
        VTextCustNo := Format(VCustomerNo,5,'<INTEGER>');
        VTextCustNo := ConvertStr(VTextCustNo,' ','0');
        VendorNumber := 'Z' + VStoreNo + VTextCustNo;
        //See If Vendor Record Already Exists
        VendorRecord.SetCurrentkey("No.");
        VendorRecord.SetRange("No.",VendorNumber);
        VendorRecord.SetRange("Vendor Posting Group",'REBATE');
        if VendorRecord.Find('+') then
        begin
        //If Found Update Name and Address Information
        VendorRecord.Name := VCustomerName;
        VendorRecord.City := VCity;
        VendorRecord.County := VState;
        VendorRecord."Post Code" := VZip;
        VendorRecord."Prior Vendor Code" := VStoreNo;
        VendorRecord."Our Account No." := CopyStr(VStoreName,1,20);
        VendorRecord."Vendor Posting Group" := 'REBATE';
        VendorRecord."Gen. Bus. Posting Group" := 'ALL';
        VendorRecord."Payment Terms Code" := 'NET 27-29';
        VendorRecord.Modify(true);
        end
        else
        begin
        //Create Vendor Record
        VendorRecord.Init;
        VendorRecord."No." := VendorNumber;
        VendorRecord.Insert(true);
        VendorRecord.Name := VCustomerName;
        VendorRecord.City := VCity;
        VendorRecord.County := VState;
        VendorRecord."Post Code" := VZip;
        VendorRecord."Prior Vendor Code" := VStoreNo;
        VendorRecord."Our Account No." := CopyStr(VStoreName,1,20);
        VendorRecord."Vendor Posting Group" := 'REBATE';
        VendorRecord."Gen. Bus. Posting Group" := 'ALL';
        VendorRecord."Payment Terms Code" := 'NET 27-29';
        VendorRecord.Modify(true);
        end;
    end;


    procedure CreateVendorCheckEntry()
    begin
        with GenJnlLine1 do
        begin
                   Init;
                  "Journal Template Name" := 'PURCH';
                  "Journal Batch Name" := 'REBATES';
                  GetLineNumber;
                  "Shortcut Dimension 1 Code" := 'ANICA';
                  Insert(true);
                  "Posting Date" := Today;
                  Validate("Posting Date");
                  "Document Date" := Today;
                  Validate("Document Date");
                  "Document Type" := 2;
                  Validate("Document Type");
                  VDocumentNo := IncStr(VDocumentNo);
                  "Document No." := VDocumentNo;
                  Validate("Document No.");
                  "External Document No." := VExternalDocNo;
                  Validate("External Document No.");
                  "Account Type" := 2;
                  Validate("Account Type");
                  CreateVendor;
                  "Account No." := VendorNumber;
                  Validate("Account No.");
                  //Description := VDescrip;
                  Validate(Description);
                  Amount := CustRebate * -1;
                  Validate(Amount);
                  Validate("Shortcut Dimension 1 Code");
                  "Bal. Account Type" := 0;
                  Validate("Bal. Account Type");
                  "Bal. Account No." := '144-01';
                  Validate("Bal. Account No.");
                  //"Due Date" := TODAY;
                  //CS 05-09-17: Changed this to have the "Due Date" set on the request page, per Jessica
                  if VDueDate <> 0D then
                      "Due Date" := VDueDate
                  else
                      "Due Date" := Today;

                  Modify(true);
        end;
    end;
}

