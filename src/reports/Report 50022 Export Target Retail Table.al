Report 50022 "Export Target Retail Table"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Export Target Retail Table.rdlc';

    dataset
    {
        dataitem("Item Target Retail";"Item Target Retail")
        {
            column(ReportForNavId_1000000000; 1000000000)
            {
            }
            column(ItemNo;"Item Target Retail"."Item No.")
            {
            }
            column(UPC;"Item Target Retail".UPC)
            {
            }
            column(Target;"Item Target Retail".Target)
            {
            }
            column(Retail;"Item Target Retail".Retail)
            {
            }
            column(PackageRetail;"Item Target Retail"."Package Retail")
            {
            }
            column(DateCreated;"Item Target Retail"."Date Created")
            {
            }
            column(LastModified;"Item Target Retail"."Last Modified")
            {
            }
            column(LastUser;"Item Target Retail"."Last User")
            {
            }
            column(Priority;"Item Target Retail".Priority)
            {
            }
            column(Description;"Item Target Retail".Description)
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

