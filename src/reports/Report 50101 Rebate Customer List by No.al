Report 50101 "Rebate Customer List by No"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Rebate Customer List by No.rdlc';

    dataset
    {
        dataitem("Rebates Customers"; "Rebates Customers")
        {
            DataItemTableView = sorting("Rebate Store No.", "Rebate Customer No.") order(ascending);
            RequestFilterFields = "Rebate Store No.";
            column(ReportForNavId_3624; 3624)
            {
            }
            column(Today; Today)
            {
            }
            column(UserId; UserId)
            {
            }
            column(Rebates_Customers__Rebate_Store_No__; "Rebate Store No.")
            {
            }
            column(VName; VName)
            {
            }
            column(Rebates_Customers__Rebate_Customer_No__; "Rebate Customer No.")
            {
            }
            column(Rebates_Customers__Customer_Name_; "Customer Name")
            {
            }
            column(Rebates_Customers_Address; Address)
            {
            }
            column(Rebates_Customers_City; City)
            {
            }
            column(Rebates_Customers_State; State)
            {
            }
            column(Rebates_Customers__Zip_Code_; "Zip Code")
            {
            }
            column(Rebates_CustomersCaption; Rebates_CustomersCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Rebate_Cust__No_Caption; Rebate_Cust__No_CaptionLbl)
            {
            }
            column(Rebates_Customers__Customer_Name_Caption; FieldCaption("Customer Name"))
            {
            }
            column(Rebates_Customers_AddressCaption; FieldCaption(Address))
            {
            }
            column(Rebates_Customers_CityCaption; FieldCaption(City))
            {
            }
            column(Rebates_Customers_StateCaption; FieldCaption(State))
            {
            }
            column(Rebates_Customers__Zip_Code_Caption; FieldCaption("Zip Code"))
            {
            }

            trigger OnPreDataItem()
            begin
                //Customer.SETCURRENTKEY(Customer."No.");
                //Customer.SETRANGE(Customer."No.","Rebates Customers"."Rebate Store No.");
                //IF Customer.FIND('-') THEN VName := Customer.Name;
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
        Customer: Record Customer;
        VName: Text[30];
        Rebates_CustomersCaptionLbl: label 'Rebates Customers';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Rebate_Cust__No_CaptionLbl: label 'Rebate Cust. No.';
}

