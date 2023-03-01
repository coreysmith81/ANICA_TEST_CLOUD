Report 50186 "POs - Not Received or Invoiced"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/POs - Not Received or Invoiced.rdlc';

    dataset
    {
        dataitem("Purchase Header";"Purchase Header")
        {
            DataItemTableView = sorting("Document Type","No.") order(ascending) where("Document Type"=const(Order));
            RequestFilterFields = "Posting Date";
            column(ReportForNavId_4458; 4458)
            {
            }
            column(Time;Time)
            {
            }
            column(FORMAT_TODAY_0_4_;Format(Today,0,4))
            {
            }
            column(CurrReport_PAGENO;CurrReport.PageNo)
            {
            }
            column(CompanyInformation_Name;CompanyInformation.Name)
            {
            }
            column(UserId;UserId)
            {
            }
            column(Purchase_Header__Purchase_Header___No__;"Purchase Header"."No.")
            {
            }
            column(Purchase_Header__Purchase_Header___Pay_to_Vendor_No__;"Purchase Header"."Pay-to Vendor No.")
            {
            }
            column(Purchase_Header__Purchase_Header___Pay_to_Name_;"Purchase Header"."Pay-to Name")
            {
            }
            column(Purchase_Header__Purchase_Header___Document_Date_;"Purchase Header"."Document Date")
            {
            }
            column(Not_Received_Purchase_Orders_Caption;Not_Received_Purchase_Orders_CaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption;CurrReport_PAGENOCaptionLbl)
            {
            }
            column(PO_No_Caption;PO_No_CaptionLbl)
            {
            }
            column(Vendor_No_Caption;Vendor_No_CaptionLbl)
            {
            }
            column(Vendor_NameCaption;Vendor_NameCaptionLbl)
            {
            }
            column(Document_DateCaption;Document_DateCaptionLbl)
            {
            }
            column(Purchase_Header_Document_Type;"Document Type")
            {
            }
            dataitem("Purchase Line";"Purchase Line")
            {
                DataItemLink = "Document No."=field("No.");
                column(ReportForNavId_6547; 6547)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //Determine if the line meets the unposted criteria
                    //Items that have not been received at all

                    PostedLine := false;
                    if "Purchase Line"."No." = '' then CurrReport.Skip;
                    if "Purchase Line"."Quantity Received" = 0
                       then PostedLine := true;


                    if PostedLine = false then CurrReport.Skip;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if "Purchase Header".Receive = true then CurrReport.Skip;
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

    trigger OnPreReport()
    begin
        CompanyInformation.Get;
    end;

    var
        CompanyInformation: Record "Company Information";
        PostedLine: Boolean;
        Not_Received_Purchase_Orders_CaptionLbl: label 'Not Received Purchase Orders ';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        PO_No_CaptionLbl: label 'PO No.';
        Vendor_No_CaptionLbl: label 'Vendor No.';
        Vendor_NameCaptionLbl: label 'Vendor Name';
        Document_DateCaptionLbl: label 'Document Date';
}

