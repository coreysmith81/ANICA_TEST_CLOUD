Report 50092 "Validate Item Cross NonStock"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Item Cross Reference";"Item Cross Reference")
        {
            DataItemTableView = sorting("Cross-Reference No.","Cross-Reference Type","Cross-Reference Type No.","Discontinue Bar Code") order(ascending) where("Cross-Reference Type"=const(" "));
            RequestFilterFields = "Cross-Reference No.","Item No.";
            column(ReportForNavId_4607; 4607)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //CS 05-24-17: Item No. 4918-0432 (Big Red) shows up in NAV, but the record doesn't exist in SQL Server. Cannot figure
                // out how to get rid of the record in NAV, so this is a work around.
                if ("Cross-Reference No." <> '4918-0432') and ("Item No." <> '4918-0432') then
                    begin
                        Validate("Cross-Reference No.");
                        Validate("Item No.");
                        Modify(true);
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

    trigger OnPostReport()
    begin
        Message('Cross Reference Number Validation Complete');
    end;

    trigger OnPreReport()
    begin
        Window.Open('Processing Record #1##########');
        repeat
        Window.Update(1,"Item Cross Reference"."Cross-Reference No.");
        until "Item Cross Reference".Next = 0;
    end;

    var
        Window: Dialog;
}

