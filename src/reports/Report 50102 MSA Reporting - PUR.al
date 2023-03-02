Report 50102 "MSA Reporting - PUR"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Sales Shipment Line";"Sales Shipment Line")
        {
            DataItemTableView = sorting("Shipment Date","Sell-to Customer No.","No.","Location Code","Posting Group");
            column(ReportForNavId_2502; 2502)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Clear(VItemNo);
                Clear(VIsMSAItem);
                Clear(VInvoiceNo);
                Clear(VSalesOrderNo);
                Clear(VSalesShipNo);

                if Quantity = 0 then
                    CurrReport.Skip;

                //Initialize Variables
                VItemNo := "No.";
                VInvoiceNo := "Document No.";
                VCustomerNo := "Sell-to Customer No.";

                //Lookup in Item table to see if it is an MSA Reporting item.
                LookupItem;

                //If so, Copy necessary fields to MSA Reporting - PUR table.
                if VIsMSAItem then
                    begin
                        GetStoreNumber;
                        WriteToPURTable;
                    end
                else
                    CurrReport.Skip;
            end;

            trigger OnPostDataItem()
            begin
                Report.Run(50104);
            end;

            trigger OnPreDataItem()
            begin
                //Clear out previous reports data.
                PURtable.DeleteAll;

                SetCurrentkey("Shipment Date","Sell-to Customer No.","No.","Location Code","Posting Group");
                SetRange("Shipment Date",VStartDate,VEndDate);
                SetRange("No.",'0001-0030','0001-0130'); //all SKU's are between 0001-0030 and 0001-0082 right now. Could change.
                SetRange("Location Code",'ADC');
                SetRange("Posting Group",'GROC');
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
                    field("Starting Date";VStartDate)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Starting Date';
                    }
                    field("Ending Date";VEndDate)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Ending Date';
                    }
                    field("Test Or Live?";VTestOrLive)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Test Or Live?';
                        OptionCaption = 'Live,Test';
                    }
                    field("Resubmission?";VIsResubmission)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Resubmission?';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            VStartDate := 0D;
        end;
    }

    labels
    {
    }

    var
        Item: Record Item;
        PURtable: Record "MSA Reporting - PUR";
        Customer: Record Customer;
        SID: Report "MSA Reporting - SID";
        VStartDate: Date;
        VEndDate: Date;
        VGetEndDate: Date;
        VItemNo: Code[10];
        VIsMSAItem: Boolean;
        VInvoiceNo: Code[10];
        VSalesOrderNo: Code[10];
        VSalesShipNo: Code[10];
        VCustomerNo: Code[10];
        VStoreNo: Code[10];
        VIsResubmission: Boolean;
        VTestOrLive: Option;
        VTestOrLiveText: Text[30];


    procedure LookupItem()
    begin
        Item.SetCurrentkey("No.");
        Item.SetRange("No.",VItemNo);

        if Item.Find('-') then
            begin
                if Item."MSA Reporting" then
                    begin
                        VIsMSAItem := true;
                    end
                else
                    VIsMSAItem := false;
            end;

        Clear(Item);
    end;


    procedure WriteToPURTable()
    begin
        PURtable.Init;
        PURtable."Customer No." := "Sales Shipment Line"."Sell-to Customer No.";
        PURtable."Item No." := "Sales Shipment Line"."No.";
        PURtable."Invoice No." := VInvoiceNo;
        PURtable."Line No." := "Sales Shipment Line"."Line No.";
        PURtable.Insert;
        PURtable."Customer Shipping No." := VStoreNo;
        PURtable.Date := Format("Sales Shipment Line"."Shipment Date",0,'<Year4><Month,2><Day,2>');
        PURtable."Customer Shipping No." := VStoreNo;
        PURtable.Quantity := "Sales Shipment Line".Quantity;
        PURtable.Amount := "Sales Shipment Line"."Unit Price";
        PURtable.Modify;

        Clear(PURtable);
    end;


    procedure GetStoreNumber()
    begin
        Customer.SetCurrentkey("No.");
        Customer.SetRange("No.",VCustomerNo);

        if Customer.Find('-') then
            VStoreNo := Customer."Telxon Store number";

        Clear(Customer);
    end;


    procedure GetWeekEndDate() VSendWeekEndDate: Date
    begin
        VSendWeekEndDate := VEndDate;
    end;


    procedure GetResubmissionFlag() VSendResubmissionFlag: Boolean
    begin
        VSendResubmissionFlag := VIsResubmission;
    end;


    procedure GetTestLiveFlag() VSendTestLiveFlag: Text[30]
    begin
        case VTestOrLive of
            0 : VTestOrLiveText := '';
            1 : VTestOrLiveText := 'T';
        end;

        VSendTestLiveFlag := VTestOrLiveText;
    end;
}

