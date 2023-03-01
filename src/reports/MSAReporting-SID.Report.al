Report 50104 "MSA Reporting - SID"
{
    // // Had to change SID to SIDs in order for it to recognize the variable as a record.

    ProcessingOnly = true;
    UseRequestPage = false;

    dataset
    {
        dataitem("MSA Reporting - PUR";"MSA Reporting - PUR")
        {
            column(ReportForNavId_7674; 7674)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Clear(VCustomerNo);

                VCustomerNo := "Customer No.";

                LookupCustomers;
            end;

            trigger OnPreDataItem()
            begin
                SIDs.DeleteAll;

                SetCurrentkey("Customer No.","Item No.","Invoice No.");
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
        SIDs: Record "MSA Reporting - SID";
        PUR: Record "MSA Reporting - PUR";
        VCustomerNo: Code[10];


    procedure LookupCustomers()
    begin
        SIDs.SetRange("Customer No.",VCustomerNo);

        if SIDs.Find('-') then
            CurrReport.Skip
        else
            SIDs.Init;
            SIDs."Customer No." := VCustomerNo;
            SIDs.Insert;
    end;
}

