Report 50139 "ANICA/WHSE Entry Repair"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ANICAWHSE Entry Repair.rdlc';

    dataset
    {
        dataitem(result;UnknownTable50046)
        {
            column(ReportForNavId_1000000000; 1000000000)
            {
            }
            column(DocNo;result.Document_No)
            {
            }
            column(DocLineNo;result.Doc_Line_No)
            {
            }
            column(Month;result.Month)
            {
            }
            column(Account;result.Account)
            {
            }
            column(Amount;result.Amount)
            {
            }
            column(Department;result.Dept)
            {
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

    labels
    {
    }
}

