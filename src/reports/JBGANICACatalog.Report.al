Report 50017 "JBG/ANICA Catalog"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/JBGANICA Catalog.rdlc';

    dataset
    {
        dataitem("JBG Item Weekly Table";"JBG Item Weekly Table")
        {
            column(ReportForNavId_1000000000; 1000000000)
            {
            }
            column(VItemNo;"JBG Item Weekly Table"."Vendor Item No")
            {
            }
            column(VDescription;"JBG Item Weekly Table".Description)
            {
            }
            column(VDescription2;VDescription2)
            {
            }
            column(VPack;"JBG Item Weekly Table".Pack)
            {
            }
            column(VPackDescription;"JBG Item Weekly Table"."Pack Descrip")
            {
            }
            column(VNCoGroup;"JBG Item Weekly Table".NCoGroup)
            {
            }
            column(VPostIndicator;"JBG Item Weekly Table"."Post Indicator")
            {
            }
            column(VUnitPrice;"JBG Item Weekly Table"."Unit Price")
            {
            }
            column(VImportDate;VImportDate)
            {
            }

            trigger OnAfterGetRecord()
            begin
                VItemNo := "JBG Item Weekly Table"."Vendor Item No";
                LookupItem;
            end;

            trigger OnPreDataItem()
            begin
                SetRange("JBG Item Weekly Table"."Import Date",VImportDate);
            end;
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
                    Caption = 'JBG File Import Date';
                    field("JBG File Import Date";VImportDate)
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

    labels
    {
    }

    var
        Item: Record Item;
        VImportDate: Date;
        VItemNo: Code[10];
        VDescription2: Text[50];

    local procedure LookupItem()
    begin
        Item.SetRange("Vendor Item No.",VItemNo);

        if Item.Find('-') then
            VDescription2 := Item."Description 2";
    end;
}

