Report 50038 "ADC Blank Labels"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ADC Blank Labels.rdlc';
    UseSystemPrinter = false;

    dataset
    {
        dataitem(Customer;Customer)
        {
            RequestFilterFields = "No.";
            column(ReportForNavId_6836; 6836)
            {
            }
            column(Customer_No_;"No.")
            {
            }
            dataitem("Integer";"Integer")
            {
                DataItemLinkReference = Customer;
                DataItemTableView = sorting(Number);
                column(ReportForNavId_5444; 5444)
                {
                }
                column(Addr_2__4_;Addr[2][4])
                {
                }
                column(Addr_2__3_;Addr[2][3])
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
                column(Addr_2__2_;Addr[2][2])
                {
                }
                column(VBypass;VBypass)
                {
                }
                column(VBypass_Control1000000002;VBypass)
                {
                }
                column(MANAGERCaption;MANAGERCaptionLbl)
                {
                }
                column(MANAGERCaption_Control10;MANAGERCaption_Control10Lbl)
                {
                }
                column(Integer_Number;Number)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if PrintCount > (TotalToPrint/2)-2 then
                      CurrReport.Break;

                    //IF ColumnNo = 1 THEN
                    //  CLEAR(Addr);

                    //REPEAT
                    //Message('before print %1 %2',Customer.Name,Customer.City);
                       Clear(Addr);
                       ColumnNo := 1;
                       repeat
                       Addr[ColumnNo][1] := Format(Today);
                       Addr[ColumnNo][2] := Format(Customer.Name);
                       Addr[ColumnNo][3] := Format(Customer."Store Physical Address");
                       Addr[ColumnNo][4] := Format(Customer.City) +' '+ Format(Customer.County) +' '
                          +Format(Customer."Post Code");
                       ColumnNo := ColumnNo + 1;
                       until (ColumnNo > 2);
                    PrintCount := PrintCount + 1;
                    //UNTIL PrintCount > (TotalToPrint/2)-2;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if Customer."No." = 'ENGL001' then VBypass := '';
                if Customer."No." = 'ATKA001' then VBypass := '';
                if Customer."No." = 'DIOM001' then VBypass := '';
                if Customer."No." = 'KIKI001' then VBypass := '';
            end;

            trigger OnPreDataItem()
            begin
                ColumnNo := 1;
                VBypass := 'BYPASS MAIL';
                //ELSE
            end;
        }
        dataitem(LeftOver;"Integer")
        {
            DataItemTableView = sorting(Number) where(Number=const(1));
            column(ReportForNavId_9037; 9037)
            {
            }
            column(Addr_1__2__Control18;Addr[1][2])
            {
            }
            column(Addr_1__4__Control20;Addr[1][4])
            {
            }
            column(Addr_2__2__Control29;Addr[2][2])
            {
            }
            column(Addr_2__4__Control30;Addr[2][4])
            {
            }
            column(Addr_1__3__Control7;Addr[1][3])
            {
            }
            column(Addr_2__3__Control8;Addr[2][3])
            {
            }
            column(VBypass_Control1000000001;VBypass)
            {
            }
            column(VBypass_Control1000000003;VBypass)
            {
            }
            column(MANAGERCaption_Control1;MANAGERCaption_Control1Lbl)
            {
            }
            column(MANAGERCaption_Control2;MANAGERCaption_Control2Lbl)
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
                    field(TotalToPrint;TotalToPrint)
                    {
                        ApplicationArea = Basic;
                    }
                    label(Control4)
                    {
                        ApplicationArea = Basic;
                        CaptionClass = Text19011332;
                    }
                    label(Control3)
                    {
                        ApplicationArea = Basic;
                        CaptionClass = Text19074667;
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
        Addr: array [2,12] of Text[50];
        NoOfRecords: Integer;
        RecordNo: Integer;
        NoOfColumns: Integer;
        ColumnNo: Integer;
        i: Integer;
        VFirstRecord: Boolean;
        PrintCount: Integer;
        Item: Record Item;
        vtemp: Boolean;
        TotalToPrint: Integer;
        VBypass: Text[12];
        Text19074667: label 'Note:  Odd numbers round down to an even total.  ';
        Text19011332: label 'Minimum 4 labels';
        MANAGERCaptionLbl: label 'MANAGER';
        MANAGERCaption_Control10Lbl: label 'MANAGER';
        MANAGERCaption_Control1Lbl: label 'MANAGER';
        MANAGERCaption_Control2Lbl: label 'MANAGER';
}

