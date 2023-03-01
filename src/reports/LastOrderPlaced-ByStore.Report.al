Report 50147 "Last Order Placed - By Store"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Last Order Placed - By Store.rdlc';

    dataset
    {
        dataitem(Customer;Customer)
        {
            DataItemTableView = sorting("No.") order(ascending) where(Balance=filter(<>0),"Member Code"=filter(<>'INAC'),"Credit Report"=filter(MEMBERS));
            column(ReportForNavId_6836; 6836)
            {
            }
            column(FORMAT_TODAY_0_4_;Format(Today,0,4))
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
            column(Customer__No__;"No.")
            {
            }
            column(Customer_Name;Name)
            {
            }
            column(VLastOrder;VLastOrder)
            {
            }
            column(V2ndToLastOrder;V2ndToLastOrder)
            {
            }

            trigger OnAfterGetRecord()
            begin
                VCustomerNo := "No.";
                VStore := "Telxon Store number";
                //VStore := '30';

                LookupTelxon;
            end;
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

    labels
    {
    }

    var
        Telxon: Record "Telxon Input File";
        Telxon2: Record "Telxon Input File";
        VCustomerNo: Code[20];
        VLastOrder: Date;
        V2ndToLastOrder: Date;
        VStore: Code[10];
        Last_Order_Placed___By_StoreCaptionLbl: label 'Last Order Placed - By Store';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Last_Order_ReceivedCaptionLbl: label 'Last Order Received';
        NoDate: Date;


    procedure LookupTelxon()
    begin
        //Get most recent date first.
        Telxon.SetCurrentkey(Date,Store);
        Telxon.SetRange(Store,VStore);
        Telxon.SetRange("Order Type",1);
        Telxon.SetFilter("Batch Name",'POS|PDA|SYMBOL');

        if Telxon.Find('+') then
            if Telxon."Order Import Date" <> NoDate then
              VLastOrder := Telxon."Order Import Date"
            else
              VLastOrder := Telxon.Date
        else
            CurrReport.Skip;

        Clear(Telxon);

        //Get Second most recent date next.
        Telxon2.SetCurrentkey(Date,Store);
        Telxon2.SetRange(Date,0D,VLastOrder-1);
        Telxon2.SetRange(Store,VStore);
        Telxon2.SetRange("Order Type",1);
        Telxon2.SetFilter("Batch Name",'POS|PDA|SYMBOL');

        if Telxon2.Find('+') then
            if Telxon2."Order Import Date" <> NoDate then
              V2ndToLastOrder := Telxon2."Order Import Date"
            else
              V2ndToLastOrder := Telxon2.Date
        else
            CurrReport.Skip;

        Clear(Telxon2);
    end;
}

