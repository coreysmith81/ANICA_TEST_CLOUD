Report 50073 "Saleable Merchandise Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Saleable Merchandise Report.rdlc';

    dataset
    {
        dataitem(Customer;Customer)
        {
            DataItemTableView = sorting("No.") order(ascending) where("Global Dimension 1 Code"=filter('ANICA'));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.","Member Code";
            column(ReportForNavId_6836; 6836)
            {
            }
            column(Today;Today)
            {
            }
            column(CurrReport_PAGENO;CurrReport.PageNo)
            {
            }
            column(FilterString;FilterString)
            {
            }
            column(Customer_Customer_Name;Customer.Name)
            {
            }
            column(CustomerMemberCode;Customer."Member Code")
            {
            }
            column(Customer_Customer_Name_Control15;Customer.Name)
            {
            }
            column(TotSales;TotSales)
            {
            }
            column(MembSales;MembSales)
            {
            }
            column(MembStoreUse;MembStoreUse)
            {
            }
            column(MembSnowMachine;MembSnowMachine)
            {
            }
            column(NonMembSales;NonMembSales)
            {
            }
            column(NonMembStoreUse;NonMembStoreUse)
            {
            }
            column(NonMembSnowMachine;NonMembSnowMachine)
            {
            }
            column(AssocSales;AssocSales)
            {
            }
            column(AssocStoreUse;AssocStoreUse)
            {
            }
            column(AssocSnowMachine;AssocSnowMachine)
            {
            }
            column(OtherSales;OtherSales)
            {
            }
            column(OtherStoreUse;OtherStoreUse)
            {
            }
            column(OtherSnowMachine;OtherSnowMachine)
            {
            }
            column(MembStoreUseFee;MembStoreUseFee)
            {
            }
            column(AssocStoreUseFee;AssocStoreUseFee)
            {
            }
            column(NonmemStoreUseFee;NonmemStoreUseFee)
            {
            }
            column(OtherStoreUseFee;OtherStoreUseFee)
            {
            }
            column(MembStoreUseFee_AssocStoreUseFee_NonmemStoreUseFee_OtherStoreUseFee;MembStoreUseFee+AssocStoreUseFee+NonmemStoreUseFee+OtherStoreUseFee)
            {
            }
            column(MembSnowMachine_AssocSnowMachine_NonMembSnowMachine_OtherSnowMachine;MembSnowMachine+AssocSnowMachine+NonMembSnowMachine+OtherSnowMachine)
            {
            }
            column(MembStoreUse_AssocStoreUse_NonMembStoreUse_OtherStoreUse;MembStoreUse+AssocStoreUse+NonMembStoreUse+OtherStoreUse)
            {
            }
            column(MembSales_AssocSales_NonMembSales_OtherSales;MembSales+AssocSales+NonMembSales+OtherSales)
            {
            }
            column(Page_Caption;Page_CaptionLbl)
            {
            }
            column(Customer_No_;"No.")
            {
            }
            column(PrintDetail;PrintDetail)
            {
            }
            dataitem("Cust. Ledger Entry";"Cust. Ledger Entry")
            {
                CalcFields = "Store Use","Snow Machines";
                DataItemLink = "Customer No."=field("No.");
                DataItemTableView = sorting("Customer No.","Posting Date","Currency Code") order(ascending);
                RequestFilterFields = "Posting Date","Global Dimension 1 Code";
                column(ReportForNavId_8503; 8503)
                {
                }
                column(Cust__Ledger_Entry__Cust__Ledger_Entry___Posting_Date_;"Cust. Ledger Entry"."Posting Date")
                {
                }
                column(Cust__Ledger_Entry__Cust__Ledger_Entry___Document_No__;"Cust. Ledger Entry"."Document No.")
                {
                }
                column(Cust__Ledger_Entry__Cust__Ledger_Entry__Description;"Cust. Ledger Entry".Description)
                {
                }
                column(Saleable;Saleable)
                {
                }
                column(Amount____Snow_Machines_____Store_Use_;Amount - "Snow Machines" - "Store Use")
                {
                }
                column(Customer_Name;Customer.Name)
                {
                }
                column(Cust__Ledger_Entry_Entry_No_;"Entry No.")
                {
                }
                column(Cust__Ledger_Entry_Customer_No_;"Customer No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    SkipThisRecord := true;
                    VDoc := CopyStr("Cust. Ledger Entry"."Document No.",1,1);
                    
                    //We need to check conversion records to see if they fall within the invoice range
                    DocumentNoInteger := 0;
                    
                    if Evaluate(DocumentNoInteger,"Cust. Ledger Entry"."Document No.") = true then
                        Evaluate(DocumentNoInteger,"Cust. Ledger Entry"."Document No.");
                    
                    if "Cust. Ledger Entry"."Document Type" = 0 then
                        begin
                            if VDoc = 'W' then
                                SkipThisRecord := false;
                    
                            if (DocumentNoInteger >= 9010000) and (DocumentNoInteger <= 9129999) then
                                SkipThisRecord := false;
                        end;
                    
                    //Include invoices
                    if "Cust. Ledger Entry"."Document Type" = 2 then
                        begin
                            SkipThisRecord := false;
                    
                            //Exclude invoices that are SJE's in the new records
                            if VDoc = 'E' then
                                SkipThisRecord := true;
                    
                            //Exclude invoices that are General Journal Entries in the new records
                            if VDoc = 'G' then
                                SkipThisRecord := true;
                    
                            //Exclude services for the customer - phone charges, etc.
                            if VDoc = 'V' then
                                SkipThisRecord := true;
                        end;
                    
                    //Added 2-18-13 LCC ADD Credit memo invoices
                    if "Cust. Ledger Entry"."Document Type" = 3 then
                        begin
                            SkipThisRecord := false;
                    
                            //Exclude invoices that are SJE's
                            if VDoc = 'E' then
                                SkipThisRecord := true;
                    
                            //Exclude invoices that are General Journal Entries
                            if VDoc = 'G' then
                                SkipThisRecord := true;
                    
                            //Exclude services for the customer - phone charges, etc.
                            if VDoc = 'V' then
                                SkipThisRecord := true;
                        end;
                    
                    if "Cust. Ledger Entry"."Convert Store Use" = true then
                        SkipThisRecord := true;
                    
                    "Cust. Ledger Entry".CalcFields("Cust. Ledger Entry".Amount);
                    
                    /*//\\Create text fields for file line output LCC 2-18-13
                    IF SkipThisRecord = TRUE THEN PrntSkipRecord := 'Yes' ELSE PrntSkipRecord := 'No';
                    
                    PrntDate := FORMAT("Cust. Ledger Entry"."Posting Date",10,'<Month,2>/<Day,2>/<Year,2>');
                    
                    CASE "Cust. Ledger Entry"."Document Type" OF
                    0:PrntDoc := '';
                    1:PrntDoc := 'Payment';
                    2:PrntDoc := 'Invoice';
                    3:PrntDoc := 'Credit Memo';
                    4:PrntDoc := 'Finance Charge';
                    5:PrntDoc := 'Reminder';
                    6:PrntDoc := 'Refund';
                    ELSE
                    PrntDoc := 'Not Listed';
                    END;
                    
                    PrntAmount := FORMAT("Cust. Ledger Entry".Amount,15,'<Sign><Integer><Decimal,3>');
                    
                    
                    //Output all Records
                    VOutPutFileLine := PrntSkipRecord + ',' + Customer."No." + ',' + Customer.Name  + ',' + PrntDate
                        + ',' + PrntDoc + ',' + "Cust. Ledger Entry"."Document No." + ',' + PrntAmount
                        + ',' + "Cust. Ledger Entry"."Customer Posting Group"
                         + ',' + "Cust. Ledger Entry"."Global Dimension 1 Code";
                    
                    VLineOutputFile.WRITE(VOutPutFileLine);
                    
                    //\\End of Create text fields for file line output section*/
                    
                    if SkipThisRecord = true then
                        CurrReport.Skip;
                    
                    Saleable := "Cust. Ledger Entry".Amount - "Cust. Ledger Entry"."Store Use" - "Cust. Ledger Entry"."Snow Machines";
                    
                    //CS 2-17-12 Get amount of the Store Use Fee on Store Use category
                    StoreUseFee := ("Cust. Ledger Entry"."Store Use" + "Cust. Ledger Entry"."Snow Machines") * StoreUseFeePerc;
                    TotalStoreUseFee := TotalStoreUseFee + StoreUseFee;//To get Aggregate
                    
                    //MESSAGE('Amount and store use amount %1 %2',"Cust. Ledger Entry".Amount,"Cust. Ledger Entry"."Store Use");
                    
                    //CS 2-17-12 Subtracting StoreUseFee from Total Sales
                    TotSales := TotSales + (Saleable-StoreUseFee);//For Grand Total
                    
                    
                    //LCC 2-9-12 New Section to get totals for the auditors
                    //CS 2-17-12 Added an aggregate Store Use Fee variable to get the total for each group.
                    case Customer."Member Code" of
                        'ASSOC':
                            begin
                                AssocSales := AssocSales + "Cust. Ledger Entry".Amount - StoreUseFee;
                                AssocStoreUse := AssocStoreUse +  + ("Cust. Ledger Entry"."Store Use");
                                AssocSnowMachine := AssocSnowMachine + ("Cust. Ledger Entry"."Snow Machines");
                                AssocStoreUseFee := AssocStoreUseFee + StoreUseFee;
                            end;
                        'MEMB':
                            begin
                                MembSales := MembSales + "Cust. Ledger Entry".Amount - StoreUseFee;
                                MembStoreUse := MembStoreUse +  + "Cust. Ledger Entry"."Store Use";
                                MembSnowMachine := MembSnowMachine + "Cust. Ledger Entry"."Snow Machines";
                                MembStoreUseFee := MembStoreUseFee + StoreUseFee;
                    
                            end;
                        'NONMEM':
                            begin
                                NonMembSales := NonMembSales + "Cust. Ledger Entry".Amount - StoreUseFee;
                                NonMembStoreUse := NonMembStoreUse +  + "Cust. Ledger Entry"."Store Use";
                                NonMembSnowMachine := NonMembSnowMachine + "Cust. Ledger Entry"."Snow Machines";
                                NonmemStoreUseFee := NonmemStoreUseFee + StoreUseFee;
                            end;
                        else
                            begin
                                OtherSales := OtherSales + "Cust. Ledger Entry".Amount - StoreUseFee;
                                OtherStoreUse := OtherStoreUse +  + "Cust. Ledger Entry"."Store Use";
                                OtherSnowMachine := OtherSnowMachine + "Cust. Ledger Entry"."Snow Machines";
                                OtherStoreUseFee := OtherStoreUseFee + StoreUseFee;
                            end;
                    end;

                end;
            }

            trigger OnAfterGetRecord()
            begin
                //Exclude employees
                if Customer."Member Code" = 'EMP' then CurrReport.Skip;
            end;

            trigger OnPostDataItem()
            begin
                //Exclude employees
                //IF Customer."Member Code" = 'EMP' THEN CurrReport.SKIP;
                //TotSales := 0;

                //StoreUseFee := 0;
            end;

            trigger OnPreDataItem()
            begin
                //TotSales := 0;
                //StoreUseFee := 0;

                GetStoreUseFee;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(PrintDetail;PrintDetail)
                    {
                        ApplicationArea = Basic;
                    }
                    label(Control2)
                    {
                        ApplicationArea = Basic;
                        CaptionClass = Text19013305;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        //VLineOutputFile.CLOSE;
    end;

    trigger OnPreReport()
    begin
        FilterString := CopyStr("Cust. Ledger Entry".GetFilters,1,MaxStrLen(FilterString));
        
        /*//LCC 2-18-13
        //Add an output to check sales
        VFileName := 'CheckSales2013.txt';
        VFullFileName := '\\filestore\Company\' + VFileName;
        VLineOutputFile.CREATE(VFullFileName);
        VLineOutputFile.TEXTMODE(TRUE);*/

    end;

    var
        SalesRecSetup: Record "Sales & Receivables Setup";
        Saleable: Decimal;
        FromDate: Date;
        ToDate: Date;
        VDoc: Code[10];
        TotSales: Decimal;
        PrintDetail: Boolean;
        SkipThisRecord: Boolean;
        DocumentNoInteger: Integer;
        FilterString: Text[100];
        AssocSales: Decimal;
        AssocStoreUse: Decimal;
        AssocSnowMachine: Decimal;
        MembSales: Decimal;
        MembStoreUse: Decimal;
        MembSnowMachine: Decimal;
        NonMembSales: Decimal;
        NonMembStoreUse: Decimal;
        NonMembSnowMachine: Decimal;
        OtherSales: Decimal;
        OtherStoreUse: Decimal;
        OtherSnowMachine: Decimal;
        StoreUseFee: Decimal;
        TotalStoreUseFee: Decimal;
        AssocStoreUseFee: Decimal;
        MembStoreUseFee: Decimal;
        NonmemStoreUseFee: Decimal;
        OtherStoreUseFee: Decimal;
        StoreUseFeePerc: Decimal;
        VLineOutputFile: File;
        VFileName: Text[50];
        VFullFileName: Text[50];
        VOutPutFileLine: Text[255];
        PrntSkipRecord: Text[30];
        PrntDate: Text[30];
        PrntDoc: Text[30];
        PrntAmount: Text[30];
        Text19013305: label 'Print Detail';
        ANICA_Saleable_Merchandise_ReportCaptionLbl: label 'ANICA Saleable Merchandise Report';
        Page_CaptionLbl: label 'Page:';
        Store_NameCaptionLbl: label 'Store Name';
        SalesCaptionLbl: label 'Sales';
        SalesCaption_Control9Lbl: label 'Sales';
        DescriptionCaptionLbl: label 'Description';
        Document_No_CaptionLbl: label 'Document No.';
        Posting_DateCaptionLbl: label 'Posting Date';
        TotalCaptionLbl: label 'Total';
        MembersCaptionLbl: label 'Members';
        Non_MembersCaptionLbl: label 'Non Members';
        Assoc_MembersCaptionLbl: label 'Assoc Members';
        OtherCaptionLbl: label 'Other';
        TotalCaption_Control1000000004Lbl: label 'Total';
        Store_UseCaptionLbl: label 'Store Use';
        Snow_MachinesCaptionLbl: label 'Snow Machines';
        Store_Use_FeesCaptionLbl: label 'Store Use Fees';
        Total_Store_Use_FeesCaptionLbl: label 'Total Store Use Fees';
        Total_Snow_MachinesCaptionLbl: label 'Total Snow Machines';
        Total_Store_UseCaptionLbl: label 'Total Store Use';
        Total_SalesCaptionLbl: label 'Total Sales';


    procedure GetStoreUseFee()
    begin
        SalesRecSetup.SetCurrentkey("Primary Key");

        if SalesRecSetup.Find('+') then
            StoreUseFeePerc := SalesRecSetup."Store Use Fee";
    end;
}

