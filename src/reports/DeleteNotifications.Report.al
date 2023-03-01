Report 50171 "Delete Notifications"
{
    // LCC 11-2-16 Created to delete more than one notification at a time
    //   This was added to Role Center 50016 IT Admin

    ProcessingOnly = true;

    dataset
    {
        dataitem(UnknownTable470;UnknownTable470)
        {
            DataItemTableView = sorting(Code);
            RequestFilterFields = "Code";
            column(ReportForNavId_1000000000; 1000000000)
            {
            }
            dataitem("Record Link";"Record Link")
            {
                DataItemLink = "User ID"=field("Running as User ID");
                DataItemTableView = where(Type=const(Note));
                RequestFilterFields = Created,Company;
                column(ReportForNavId_1000000001; 1000000001)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                //If the user id has not been used before, it will be added to UsedUserIds
                //Therefore each user id will only be processed once
                if StrPos(Lowercase(UsedUserIds),Lowercase("Job Queue"."Running as User ID")) > 0 then
                  //It was found
                  CurrReport.Skip
                else
                  //It was not found
                  UsedUserIds += ' - ' + "Job Queue"."Running as User ID";

                //Remove all record linkds wihin the filter
                //The record link only serve on purpose: to enable filtering
                RecordLink.DeleteAll;
            end;

            trigger OnPreDataItem()
            begin
                if not Confirm(WarningTxt) then CurrReport.Quit;
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
        UsedUserIds: Text;
        WarningTxt: label 'Delete Notifications - Are You Sure?';
        RecordLink: Record "Record Link";
}

