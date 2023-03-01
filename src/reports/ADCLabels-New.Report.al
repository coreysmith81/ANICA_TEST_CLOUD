Report 50039 "ADC Labels - New"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ADC Labels - New.rdlc';
    UseSystemPrinter = false;

    dataset
    {
        dataitem("Sales Header";"Sales Header")
        {
            DataItemTableView = sorting("Document Type","Sell-to Customer No.","No.") order(ascending) where("Location Code"=const('ADC'),Status=const(Released));
            RequestFilterFields = "Document Date","No.","No. Printed","Sell-to Customer No.";
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
                DataItemLink = "Document Type"=field("Document Type"),"Document No."=field("No.");
                DataItemTableView = sorting("Document No.","Document Type","Shelf/Bin No.") order(ascending) where(Type=filter(Item),"Location Code"=filter('ADC'),"Drop Shipment"=filter(false));
                column(ReportForNavId_2844; 2844)
                {
                }
                column(Sales_Line_Document_Type;"Document Type")
                {
                }
                column(Sales_Line_Document_No_;"Document No.")
                {
                }
                column(Sales_Line_Line_No_;"Line No.")
                {
                }
                dataitem("Integer";"Integer")
                {
                    DataItemLinkReference = "Sales Line";
                    DataItemTableView = sorting(Number);
                    column(ReportForNavId_5444; 5444)
                    {
                    }
                    column(Control11;Addr[1][6])
                    {
                    }
                    column(Control12;Addr[1][7])
                    {
                    }
                    column(Control20;Addr[1][11])
                    {
                    }
                    column(Control21;Addr[1][12])
                    {
                    }
                    column(Control13;Addr[1][8])
                    {
                    }
                    column(Control22;Addr[1][13])
                    {
                    }
                    column(Control14;Addr[1][9])
                    {
                    }
                    column(Control15;Addr[2][6])
                    {
                    }
                    column(Addr_2__7_;Addr[2][7])
                    {
                    }
                    column(Addr_2__11_;Addr[2][11])
                    {
                    }
                    column(Control25;Addr[2][12])
                    {
                    }
                    column(Control17;Addr[2][8])
                    {
                    }
                    column(Control26;Addr[2][13])
                    {
                    }
                    column(Control18;Addr[2][9])
                    {
                    }
                    column(Control19;Addr[1][10])
                    {
                    }
                    column(Control23;Addr[2][10])
                    {
                    }
                    column(Addr_1__5_;Addr[1][5])
                    {
                    }
                    column(Addr_2__5_;Addr[2][5])
                    {
                    }
                    column(Addr_1__1_;Addr[1][1])
                    {
                    }
                    column(Addr_2__1_;Addr[2][1])
                    {
                    }
                    column(Addr_2__2_;Addr[2][2])
                    {
                    }
                    column(Addr_2__3_;Addr[2][3])
                    {
                    }
                    column(Addr_2__4_;Addr[2][4])
                    {
                    }
                    column(Addr_1__2_;Addr[1][2])
                    {
                    }
                    column(Addr_1__3_;Addr[1][3])
                    {
                    }
                    column(Addr_1__4_;Addr[1][4])
                    {
                    }
                    column(VBypass;VBypass)
                    {
                    }
                    column(VBypass_Control1000000002;VBypass)
                    {
                    }
                    column(Integer_Number;Number)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        if PrintCount > "Sales Line".Quantity then
                          CurrReport.Break;
                        if ColumnNo = 1 then
                          Clear(Addr);

                        repeat
                        Addr[ColumnNo][1] := Format(Today);
                        Addr[ColumnNo][2] := Format("Sales Header"."Sell-to Customer Name");
                        LookupCustomer;
                        Addr[ColumnNo][3] := Format(VCustomerLocation);

                        Addr[ColumnNo][4] := Format("Sales Header"."Ship-to City") +' '+ Format("Sales Header"."Ship-to County") +' '
                           +Format("Sales Header"."Sell-to Post Code");
                        Addr[ColumnNo][5] := 'ORDER: '+Format("Sales Header"."No.");
                        Addr[ColumnNo][6] := Format("Sales Line"."No.");
                        Addr[ColumnNo][7] := Format("Sales Line".Description);
                        Addr[ColumnNo][8] := Format("Sales Line".Pack);
                        Addr[ColumnNo][9] := Format("Sales Line"."Pack Description");
                        Addr[ColumnNo][10] := Format("Sales Line"."Shelf/Bin No.");
                        Addr[ColumnNo][11] := Format(Item."Vendor Item No.");
                        Addr[ColumnNo][12] := Format("Sales Line"."Gross Weight");
                        Addr[ColumnNo][13] := Format("Sales Line"."Retail Price Per Unit");
                        ColumnNo := ColumnNo + 1;
                        PrintCount := PrintCount + 1;
                        //MESSAGE('Print count %1',PrintCount);
                        until (ColumnNo > 2) or (PrintCount > "Sales Line".Quantity);
                    end;

                    trigger OnPreDataItem()
                    begin
                        VBypass := 'BYPASS MAIL';
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    if Item.Get("Sales Line"."No.") then vtemp :=  vtemp;
                    PrintCount := 1;
                    //IF Item.GET("Sales Line"."No.") THEN vtemp := vtemp;
                    if Item."No Label Printed" = true then CurrReport.Skip;
                    //MESSAGE('No label %1',Item."No Label Printed");
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //Print Promotional Orders Only
                if PPromoOnly = true then
                   begin
                   if "Sales Header"."Sales Order Type" <> 3 then CurrReport.Skip;
                   end;
            end;

            trigger OnPreDataItem()
            begin
                ColumnNo := 1;
            end;
        }
        dataitem(LeftOver;"Integer")
        {
            DataItemTableView = sorting(Number) where(Number=const(1));
            column(ReportForNavId_9037; 9037)
            {
            }
            column(Control37;Addr[1][6])
            {
            }
            column(Control38;Addr[1][7])
            {
            }
            column(Control39;Addr[1][8])
            {
            }
            column(Control40;Addr[1][9])
            {
            }
            column(Control41;Addr[2][6])
            {
            }
            column(Control42;Addr[2][7])
            {
            }
            column(Control43;Addr[2][8])
            {
            }
            column(Control44;Addr[2][9])
            {
            }
            column(Control46;Addr[1][11])
            {
            }
            column(Control47;Addr[1][12])
            {
            }
            column(Control48;Addr[1][13])
            {
            }
            column(Control50;Addr[2][11])
            {
            }
            column(Control51;Addr[2][12])
            {
            }
            column(Control52;Addr[2][13])
            {
            }
            column(Control45;Addr[1][10])
            {
            }
            column(Control49;Addr[2][10])
            {
            }
            column(Addr_1__5__Control28;Addr[1][5])
            {
            }
            column(Addr_2__5__Control31;Addr[2][5])
            {
            }
            column(Addr_1__1__Control18;Addr[1][1])
            {
            }
            column(Addr_2__1__Control22;Addr[2][1])
            {
            }
            column(Addr_2__2__Control40;Addr[2][2])
            {
            }
            column(Addr_2__3__Control52;Addr[2][3])
            {
            }
            column(Addr_2__4__Control57;Addr[2][4])
            {
            }
            column(Addr_1__2__Control50;Addr[1][2])
            {
            }
            column(Addr_1__3__Control53;Addr[1][3])
            {
            }
            column(Addr_1__4__Control55;Addr[1][4])
            {
            }
            column(VBypass_Control1000000001;VBypass)
            {
            }
            column(VBypass_Control1000000003;VBypass)
            {
            }
            column(LeftOver_Number;Number)
            {
            }
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
                    field(PPromoOnly;PPromoOnly)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Print Promotional Labels Only';
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

    var
        Addr: array [2,13] of Text[50];
        NoOfRecords: Integer;
        RecordNo: Integer;
        NoOfColumns: Integer;
        ColumnNo: Integer;
        i: Integer;
        VFirstRecord: Boolean;
        PrintCount: Integer;
        Item: Record Item;
        vtemp: Boolean;
        PPromoOnly: Boolean;
        CustomerRecord: Record Customer;
        VCustomerLocation: Text[40];
        VBypass: Text[12];


    procedure LookupCustomer()
    begin
        VCustomerLocation := '';
        CustomerRecord.SetCurrentkey("No.");
        CustomerRecord.SetFilter("No.","Sales Header"."Sell-to Customer No.");
        if CustomerRecord.Find('+') then
        VCustomerLocation := CustomerRecord."Store Physical Address";
        if CustomerRecord."No." = 'ENGL001' then
        begin
        VBypass := '';
        //PrintCount := PrintCount + 1;
        end;
        if CustomerRecord."No." = 'ATKA001' then
        begin
        VBypass := '';
        //PrintCount := PrintCount + 1;
        end;
        if CustomerRecord."No." = 'DIOM001' then VBypass := '';
        if CustomerRecord."No." = 'KIKI001' then VBypass := '';
    end;
}

