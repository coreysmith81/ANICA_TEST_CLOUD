Report 50074 "JBG Item Weekly Table Cleanup"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Rebates Detail";"Rebates Detail")
        {
            column(ReportForNavId_1000000000; 1000000000)
            {
            }

            trigger OnPostDataItem()
            begin
                DeleteAll;
            end;

            trigger OnPreDataItem()
            begin
                SetRange(Date,0D,20181231D);
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

