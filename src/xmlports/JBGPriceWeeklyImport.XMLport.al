XmlPort 50031 "JBG Price Weekly Import"
{
    Caption = 'JBG Price Weekly Import';
    Direction = Import;
    Format = FixedText;

    schema
    {
        textelement(Root)
        {
            tableelement("JBG Price Weekly Table";"JBG Price Weekly Table")
            {
                AutoUpdate = true;
                XmlName = 'JBGPriceWeeklyTable';
                fieldelement(JBGItemNo;"JBG Price Weekly Table"."JBG Item No")
                {
                    Width = 6;
                }
                fieldelement(CapCode;"JBG Price Weekly Table"."Cap Code")
                {
                    Width = 3;
                }
                fieldelement(StoreNumber;"JBG Price Weekly Table"."Store Number")
                {
                    Width = 4;
                }
                fieldelement(TargetRetail;"JBG Price Weekly Table"."Target Retail")
                {
                    Width = 10;
                }

                trigger OnAfterInsertRecord()
                begin
                    //For Status Box
                    begin
                      Window.Update(1,"JBG Price Weekly Table"."JBG Item No");
                    end;

                    UpdateItemRecords;
                end;

                trigger OnBeforeInsertRecord()
                begin
                    "JBG Price Weekly Table"."Import Date" := VImportDate;
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(ImportDate)
                {
                    Caption = 'Price File Import Date';
                    field("Price File Import Date";VImportDate)
                    {
                        ApplicationArea = Basic;
                        NotBlank = true;
                        ShowMandatory = true;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            //CS 06-26-15: This will populate the Import Date Field with the correct Monday's date. Either the current day
             //if it's a Monday, or the previous Monday if it's any other date. Keeping it as editable for any exceptions.
            if Date2dwy(Today,1) <> 1 then
                VImportDate := CalcDate('<-WD1>')
            else
                VImportDate := Today;
        end;
    }

    trigger OnInitXmlPort()
    begin

        //Run the Item Import First
        Xmlport.Run(50030);
        ClearAll;
    end;

    trigger OnPostXmlPort()
    begin
        //For Status Box
        Window.Close;
        Clear(Window);
    end;

    trigger OnPreXmlPort()
    begin
        //For Status Box
        begin
            Clear(Window);
            Window.Open('Processing Item #1######');
        end;
    end;

    var
        JBGItemWeekly: Record "JBG Item Weekly Table";
        VImportDate: Date;
        Window: Dialog;


    procedure UpdateItemRecords()
    begin
        JBGItemWeekly.SetCurrentkey("Import Date","Vendor Item No");
        JBGItemWeekly.SetRange("Import Date",VImportDate);
        JBGItemWeekly.SetRange("Vendor Item No","JBG Price Weekly Table"."JBG Item No");
        if JBGItemWeekly.Find('+') then
            begin
                case "JBG Price Weekly Table"."Store Number" of
                '0108': JBGItemWeekly."Target Retail" := "JBG Price Weekly Table"."Target Retail"; //ANICA Cap Code 912 Zone 1/2, Akiachak
                '0117': JBGItemWeekly."Zone 3" := "JBG Price Weekly Table"."Target Retail"; //ANICA Cap Code 912 Zone 3, Ambler
                '0078': JBGItemWeekly."Zone N" := "JBG Price Weekly Table"."Target Retail"; //ANICA Cap Code 912 Zone N, Point Lay
                '0123': JBGItemWeekly."Cap 075" := "JBG Price Weekly Table"."Target Retail"; //ANICA Cap Code 075 Zone N, Kikitak
                end;

                JBGItemWeekly.Modify(true);
            end;
    end;
}

