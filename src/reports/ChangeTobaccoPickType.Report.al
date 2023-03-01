Report 50021 "Change Tobacco Pick Type"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Change Tobacco Pick Type.rdlc';

    dataset
    {
        dataitem(Item;Item)
        {
            column(ReportForNavId_1000000000; 1000000000)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Item."Pick Type" := 18;
                Item.Modify;
            end;

            trigger OnPreDataItem()
            begin
                Item.SetCurrentkey("No.");
                Item.SetRange(Item."Pick Type",6);
            end;
        }
        dataitem("Nonstock Item";"Nonstock Item")
        {
            column(ReportForNavId_1000000001; 1000000001)
            {
            }

            trigger OnAfterGetRecord()
            begin
                "Nonstock Item"."Pick Type" := 18;
                "Nonstock Item".Modify;
            end;

            trigger OnPreDataItem()
            begin
                "Nonstock Item".SetRange("Nonstock Item"."Pick Type",6);
            end;
        }
        dataitem("Telxon Input File";"Telxon Input File")
        {
            column(ReportForNavId_1000000002; 1000000002)
            {
            }

            trigger OnAfterGetRecord()
            begin
                "Telxon Input File"."Pick code" := 18;
                "Telxon Input File".Modify;
            end;

            trigger OnPreDataItem()
            begin
                "Telxon Input File".SetRange("Pick code",6);
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

