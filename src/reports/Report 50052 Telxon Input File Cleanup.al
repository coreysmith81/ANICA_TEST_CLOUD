Report 50052 "Telxon Input File Cleanup"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Telxon Input File Cleanup.rdlc';

    dataset
    {
        dataitem("Telxon Input File";"Telxon Input File")
        {
            column(ReportForNavId_1000000000; 1000000000)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if not Processed then
                    CurrReport.Skip
                else
                    begin
                        Delete;
                    end
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
}

