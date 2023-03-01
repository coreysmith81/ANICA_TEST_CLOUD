Report 50126 "Rebates Un-flag Program"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Rebates Detail";"Rebates Detail")
        {
            DataItemTableView = sorting("Store No.","Customer No.") order(ascending);
            column(ReportForNavId_6931; 6931)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if VProcess = true then
                    begin
                        Processed := false;
                        Modify(true);
                    end
            end;

            trigger OnPreDataItem()
            begin
                SetCurrentkey("Store No.",Date);
                SetRange("Store No.",VStoreNo);
                SetRange("Rebates Detail".Date,FromDate,ToDate);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field("Enter Store Number";VStoreNo)
                    {
                        ApplicationArea = Basic;
                        TableRelation = Customer."No." where ("Customer Posting Group"=const('ANICA'));
                    }
                    field("Beginning Date";FromDate)
                    {
                        ApplicationArea = Basic;
                    }
                    field("Ending Date";ToDate)
                    {
                        ApplicationArea = Basic;
                    }
                    field("Change Processed Flag Back To False";VProcess)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Change Processed Flag Back To False';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        GetRebateInfo;
    end;

    var
        ToDate: Date;
        FromDate: Date;
        VStoreNo: Code[10];
        VProcess: Boolean;
        VStoreName: Text[30];
        GetStoreNo: Code[10];
        Text19015771: label 'Beginning Date';
        Text19001730: label 'Ending Date';
        Text19077832: label 'Change Processed Flag Back to False';


    procedure GetRebateInfo()
    begin
        if VStoreNo = '' then
        begin
        Message('Need Store Number in Options');
        CurrReport.Quit;
        end;

        if FromDate = 0D then
        begin
        Message('Need Beginning Date in Options');
        CurrReport.Quit;
        end;

        if ToDate = 0D then
        begin
        Message('Need Ending Date in Options');
        CurrReport.Quit;
        end;

        if FromDate > ToDate then
        begin
        Message('Beginning Date Must Be Before End Date');
        CurrReport.Quit;
        end;
    end;
}

