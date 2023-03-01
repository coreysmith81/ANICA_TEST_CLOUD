XmlPort 50030 "JBG Item Weekly Import"
{
    Caption = 'JBG Item Weekly Import';
    Direction = Import;
    Format = FixedText;

    schema
    {
        textelement(Root)
        {
            tableelement("JBG Item Weekly Table";"JBG Item Weekly Table")
            {
                AutoUpdate = true;
                XmlName = 'JBGItemWeeklyTable';
                fieldelement(VNCoGroup;"JBG Item Weekly Table".NCoGroup)
                {
                    Width = 4;
                }
                fieldelement(VVendorItemNo;"JBG Item Weekly Table"."Vendor Item No")
                {
                    Width = 6;
                }
                fieldelement(VPack;"JBG Item Weekly Table".Pack)
                {
                    Width = 4;
                }
                fieldelement(VPackDescrip;"JBG Item Weekly Table"."Pack Descrip")
                {
                    Width = 10;
                }
                fieldelement(VDescription;"JBG Item Weekly Table".Description)
                {
                    Width = 30;
                }
                fieldelement(VGrossWeight;"JBG Item Weekly Table"."Gross Weight")
                {
                    Width = 10;
                }
                fieldelement(VPostIndicator;"JBG Item Weekly Table"."Post Indicator")
                {
                    Width = 1;
                }
                fieldelement(VHazardous;"JBG Item Weekly Table".Hazardous)
                {
                    Width = 1;
                }
                fieldelement(VFoodNFood;"JBG Item Weekly Table".FoodNFood)
                {
                    Width = 1;
                }
                fieldelement(VUnitPrice;"JBG Item Weekly Table"."Unit Price")
                {
                    Width = 11;
                }
                fieldelement(VPriceAllow;"JBG Item Weekly Table"."Price Allow")
                {
                    Width = 8;
                }
                fieldelement(VTarget;"JBG Item Weekly Table".Target)
                {
                    Width = 8;
                }
                fieldelement(VUPC;"JBG Item Weekly Table".UPC)
                {
                    Width = 12;
                }
                fieldelement(VChange;"JBG Item Weekly Table".Change)
                {
                    Width = 1;
                }
                fieldelement(VDept;"JBG Item Weekly Table".Dept)
                {
                    Width = 4;
                }
                fieldelement(VVendor;"JBG Item Weekly Table".Vendor)
                {
                    Width = 6;
                }
                fieldelement(VDiscontinued;"JBG Item Weekly Table".Discontinued)
                {
                    Width = 1;
                }
                fieldelement(VWarehouseDept;"JBG Item Weekly Table"."Warehouse Dept.")
                {
                    Width = 3;
                }

                trigger OnAfterInsertRecord()
                begin
                    //For Status Box
                    begin
                      Window.Update(1,"JBG Item Weekly Table"."Vendor Item No");
                    end;
                end;

                trigger OnBeforeInsertRecord()
                begin
                    "JBG Item Weekly Table"."Import Date" := VImportDate;
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
                    field("Import Date";VImportDate)
                    {
                        ApplicationArea = Basic;
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
        Window: Dialog;
        MyFile: File;
        TempTextVariable: Text[1000];
        TotalRecNo: Integer;
        VImportDate: Date;
}

