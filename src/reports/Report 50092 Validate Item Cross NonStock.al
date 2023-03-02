Report 50092 "Validate Item Cross NonStock"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Item Cross Reference"; "Item Reference") //changed from "Item Cross Reference"
        {
            DataItemTableView = sorting("Reference No.", "Reference Type", "Reference Type No.") order(ascending) where("Reference Type" = const(" "));
            RequestFilterFields = "Reference No.", "Item No.";
            column(ReportForNavId_4607; 4607)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //CS 05-24-17: Item No. 4918-0432 (Big Red) shows up in NAV, but the record doesn't exist in SQL Server. Cannot figure
                // out how to get rid of the record in NAV, so this is a work around.
                if ("Reference No." <> '4918-0432') and ("Item No." <> '4918-0432') then begin
                    Validate("Reference No.");
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
            Window.Update(1, "Item Cross Reference"."Reference No.");
        until "Item Cross Reference".Next = 0;
    end;

    var
        Window: Dialog;
}

