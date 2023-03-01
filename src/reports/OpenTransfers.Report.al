Report 50033 "Open Transfers"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Open Transfers.rdlc';

    dataset
    {
        dataitem("Transfer Header";"Transfer Header")
        {
            RequestFilterFields = "Receipt Date","Shipment Date","No.";
            column(ReportForNavId_2957; 2957)
            {
            }
            column(Today;Today)
            {
            }
            column(Time;Time)
            {
            }
            column(CurrReport_PAGENO;CurrReport.PageNo)
            {
            }
            column(Transfer_Header__No__;"No.")
            {
            }
            column(Transfer_Header__Transfer_from_Name_;"Transfer-from Name")
            {
            }
            column(Transfer_Header__Transfer_to_Name_;"Transfer-to Name")
            {
            }
            column(Transfer_Header__Shipment_Date_;"Shipment Date")
            {
            }
            column(Transfer_Header__Receipt_Date_;"Receipt Date")
            {
            }
            column(Transfer_Header_Status;Status)
            {
            }
            column(Transfer_Header__Completely_Shipped_;"Completely Shipped")
            {
            }
            column(Transfer_Header__Completely_Received_;"Completely Received")
            {
            }
            column(PAGECaption;PAGECaptionLbl)
            {
            }
            column(OPEN_TRANSFERSCaption;OPEN_TRANSFERSCaptionLbl)
            {
            }
            column(Transfer_Header__No__Caption;FieldCaption("No."))
            {
            }
            column(Transfer_Header__Transfer_from_Name_Caption;FieldCaption("Transfer-from Name"))
            {
            }
            column(Transfer_Header__Transfer_to_Name_Caption;FieldCaption("Transfer-to Name"))
            {
            }
            column(Transfer_Header__Shipment_Date_Caption;FieldCaption("Shipment Date"))
            {
            }
            column(Transfer_Header__Receipt_Date_Caption;FieldCaption("Receipt Date"))
            {
            }
            column(Transfer_Header_StatusCaption;FieldCaption(Status))
            {
            }
            column(Transfer_Header__Completely_Shipped_Caption;FieldCaption("Completely Shipped"))
            {
            }
            column(Transfer_Header__Completely_Received_Caption;FieldCaption("Completely Received"))
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

    var
        PAGECaptionLbl: label 'PAGE';
        OPEN_TRANSFERSCaptionLbl: label 'OPEN TRANSFERS';
}

