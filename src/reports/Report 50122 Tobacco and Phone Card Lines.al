Report 50122 "Tobacco and Phone Card Lines"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Tobacco and Phone Card Lines.rdlc';

    dataset
    {
        dataitem("Sales Header";"Sales Header")
        {
            DataItemTableView = sorting("Document Date") order(ascending);
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Document Date";
            column(ReportForNavId_6640; 6640)
            {
            }
            column(Sales_Header__No__;"No.")
            {
            }
            column(Sales_Header__Document_Date_;"Document Date")
            {
            }
            column(Sales_Header__Sell_to_Customer_Name_;"Sell-to Customer Name")
            {
            }
            column(Order_No_Caption;Order_No_CaptionLbl)
            {
            }
            column(Doc__DateCaption;Doc__DateCaptionLbl)
            {
            }
            column(StoreCaption;StoreCaptionLbl)
            {
            }
            column(EmptyStringCaption;EmptyStringCaptionLbl)
            {
            }
            column(Sales_Header_Document_Type;"Document Type")
            {
            }
            dataitem("Sales Line";"Sales Line")
            {
                DataItemLink = "Document No."=field("No.");
                DataItemTableView = sorting("Document Type","Document No.","Line No.") order(ascending);
                column(ReportForNavId_2844; 2844)
                {
                }
                column(Sales_Line__Line_No__;"Line No.")
                {
                }
                column(Sales_Line_Description;Description)
                {
                }
                column(VPickDesc;VPickDesc)
                {
                }
                column(Sales_Line_Quantity;Quantity)
                {
                }
                column(Sales_Line__No__;"No.")
                {
                }
                column(Line_No_Caption;Line_No_CaptionLbl)
                {
                }
                column(Sales_Line_DescriptionCaption;FieldCaption(Description))
                {
                }
                column(Pick_TypeCaption;Pick_TypeCaptionLbl)
                {
                }
                column(Qty_Caption;Qty_CaptionLbl)
                {
                }
                column(Item_No_Caption;Item_No_CaptionLbl)
                {
                }
                column(Sales_Line_Document_Type;"Document Type")
                {
                }
                column(Sales_Line_Document_No_;"Document No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //CS 08-24-16: Adding this to keep Drop Ship orders off of this report.
                    if "Purchasing Code" = 'DROP SHIP' then
                        CurrReport.Skip;

                    VItemNo := "Sales Line"."No.";

                    if VItemNo <> '' then
                        LookupPickType
                    else
                        CurrReport.Skip;

                    //IF (VPickType <> 6) AND (VPickType <> 5) AND (VPickType <> 13) THEN //CS 10-14-14: batteries removed per Jessica.
                    if (VPickType <> 18) and (VPickType <> 5) then
                        CurrReport.Skip;

                end;

                trigger OnPreDataItem()
                begin
                    SetCurrentkey("Document Type","Document No.","Line No.");
                    SetRange("Document No.",VDocNumber);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                VDocNumber := "No.";
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Document Type",1);
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
        Item: Record Item;
        VItemNo: Text[30];
        VPickType: Option;
        VIsCigPhone: Boolean;
        VDocNumber: Text[30];
        SalesLine: Record "Sales Line";
        VPickDesc: Text[30];
        Order_No_CaptionLbl: label 'Order No.';
        Doc__DateCaptionLbl: label 'Doc. Date';
        StoreCaptionLbl: label 'Store';
        EmptyStringCaptionLbl: label '--';
        Line_No_CaptionLbl: label 'Line No.';
        Pick_TypeCaptionLbl: label 'Pick Type';
        Qty_CaptionLbl: label 'Qty.';
        Item_No_CaptionLbl: label 'Item No.';


    procedure LookupSalesLine()
    begin
    end;


    procedure LookupPickType()
    begin
        VPickType := 0;

        Item.SetCurrentkey("No.");
        Item.SetRange("No.",VItemNo);

        if Item.Find('+') then
            begin
                VPickType := Item."Pick Type";
            end;

        //IF (VPickType = 6) OR (VPickType = 5) OR (VPickType = 13)  THEN //CS 10-14-14: batteries taken out per Jessica.
        //CS 6-30-16: Changed due to Pick Type changing to 18 from 6
        if (VPickType = 18) or (VPickType = 5) then
            case VPickType of
                5:VPickDesc := 'Phone Cards';
                18:VPickDesc := 'Tobacco';
                //13:VPickDesc := 'Batteries';  //CS 10-14-14: taken out per Jessica.
            end;
    end;
}

