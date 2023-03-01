Report 50162 "Add Vendor Check Formats"
{
    // This report populates the vendor file check formats to mm-dd-yyyy for check printing.
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Add Vendor Check Formats.rdlc';


    dataset
    {
        dataitem(Vendor;Vendor)
        {
            column(ReportForNavId_1000000000; 1000000000)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Vendor."Check Date Format" := 1;
                Vendor."Check Date Separator" := 1;
                Vendor.Modify(true);
            end;

            trigger OnPostDataItem()
            begin
                Message('Update Complete');
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

