Report 50083 "Telxon Report Duplicate Lines"
{
    // Find duplicate item numbers for a store in either open Telxon
    //   or sales orders  LCC 4-26-10
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Telxon Report Duplicate Lines.rdlc';


    dataset
    {
        dataitem("Telxon Input File";"Telxon Input File")
        {
            DataItemTableView = sorting(Processed,Store,"Order Item No.") order(ascending) where(Processed=const(false));
            RequestFilterFields = Store,"Order Item No.";
            column(ReportForNavId_9733; 9733)
            {
            }
            column(Processed;Processed)
            {
            }
            column(Telxon_Input_File_Store;Store)
            {
            }
            column(Telxon_Input_File_Sequence;Sequence)
            {
            }
            column(Telxon_Input_File_Quantity;Quantity)
            {
            }
            column(Telxon_Input_File__Order_Item_No__;"Order Item No.")
            {
            }
            column(Telxon_Input_File__Item_Description_;"Item Description")
            {
            }
            column(Telxon_Input_File__Customer_Number_;"Customer Number")
            {
            }
            column(Telxon_Input_File__Error_Remark_;"Error Remark")
            {
            }
            column(Telxon_Input_File__On_Hold_;"On Hold")
            {
            }
            column(Telxon_Input_File_Date;Date)
            {
            }
            column(VPrintline;VPrintLine)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //The file is already in telxon vendor number order and item number order

                VPrintLine := false;

                //MESSAGE('before check Vprintline Store Item No %1 %2 %3',VPrintLine,"Telxon Input File"."Order Item No.","Telxon Input File".Store);
                //MESSAGE('before checkstore and checkitem %1 %2',CheckStore,CheckItem);

                if "Telxon Input File".Store = CheckStore then
                begin
                if ("Telxon Input File"."Order Item No." = CheckItem) and ("Telxon Input File"."Order Item No." <> '') then VPrintLine := true;
                end;

                CheckItem := "Telxon Input File"."Order Item No.";
                CheckStore := "Telxon Input File".Store;

                //MESSAGE('after check Vprintline Store Item No %1 %2 %3',VPrintLine,"Telxon Input File"."Order Item No.","Telxon Input File".Store);
                //MESSAGE('after checkstore and checkitem %1 %2',CheckStore,CheckItem);
            end;
        }
        dataitem("Sales Header";"Sales Header")
        {
            DataItemTableView = sorting("Document Type","No.") order(ascending);
            column(ReportForNavId_6640; 6640)
            {
            }
            column(Sales_Header_Document_Type;"Document Type")
            {
            }
            column(Sales_Header_No_;"No.")
            {
            }
            dataitem("Sales Line";"Sales Line")
            {
                DataItemLink = "Document No."=field("No.");
                DataItemTableView = sorting("Document Type","Document No.","No.") order(ascending);
                column(ReportForNavId_2844; 2844)
                {
                }
                column(Sales_Line__Document_No__;"Document No.")
                {
                }
                column(Sales_Line__Line_No__;"Line No.")
                {
                }
                column(Sales_Line_Quantity;Quantity)
                {
                }
                column(Sales_Line__Sell_to_Customer_No__;"Sell-to Customer No.")
                {
                }
                column(Sales_Line__No__;"No.")
                {
                }
                column(Sales_Line_Description;Description)
                {
                }
                column(VStatus;VStatus)
                {
                }
                column(VDate;VDate)
                {
                }
                column(VApproved;VApproved)
                {
                }
                column(Sales_Line_Document_Type;"Document Type")
                {
                }
                column(VSalesPrintLine;VSalesPrintLine)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //The file is already in sales order and item number order

                    //Check only item lines
                    if "Sales Line".Type <> 2 then CurrReport.Skip;
                    //Check only lines with a quantity
                    if "Sales Line".Quantity = 0 then CurrReport.Skip;

                    VSalesPrintLine := false;

                    if  "Sales Line"."Document No." = CheckOrder then
                    begin
                    if "Sales Line"."No." = CheckItem then VSalesPrintLine := true;
                    end;

                    CheckItem := "Sales Line"."No.";
                    CheckOrder := "Sales Line"."Document No.";
                end;

                trigger OnPreDataItem()
                begin
                    CheckItem := '';
                    CheckOrder := '';
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //Skip Quotes
                if  "Sales Header"."Document Type" = 0 then CurrReport.Skip;

                //Get record status
                case "Sales Header".Approved of
                1:VApproved := 'On_hold';
                2:VApproved := 'Approved';
                else
                VApproved := '';
                end;

                //Get record status
                case "Sales Header".Status of
                0:VStatus := 'Open';
                1:VStatus := 'Released';
                else
                VStatus := '';
                end;

                //Get date
                VDate := "Sales Header"."Document Date";
            end;

            trigger OnPreDataItem()
            begin
                VNewPage := true; //first time only
                CurrReport.Newpage;
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
        CheckItem := '';
        CheckStore := '';
    end;

    var
        CheckStore: Code[10];
        CheckItem: Code[20];
        CheckOrder: Code[20];
        VPrintLine: Boolean;
        VSalesPrintLine: Boolean;
        VNewPage: Boolean;
        VStatus: Text[20];
        VApproved: Text[20];
        VDate: Date;
        Duplicate_Items_in_Open_TelxonCaptionLbl: label 'Duplicate Items in Open Telxon';
        ErrorCaptionLbl: label 'Error';
        Sales_Orders_with_Duplicate_Items_CaptionLbl: label 'Sales Orders with Duplicate Items ';
        Customer_NoCaptionLbl: label 'Customer No';
        StatusCaptionLbl: label 'Status';
        Document_DateCaptionLbl: label 'Document Date';
}

