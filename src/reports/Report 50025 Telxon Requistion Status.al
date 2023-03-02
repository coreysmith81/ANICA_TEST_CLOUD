Report 50025 "Telxon Requistion Status"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Telxon Requistion Status.rdlc';

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = sorting("Search Name") order(ascending) where("Customer Posting Group" = filter(<> 'BETHEL'));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Territory Code", "No.", Name, "Salesperson Code";
            column(ReportForNavId_6836; 6836)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(Customer_Name; Name)
            {
            }
            column(Customer_Contact; Contact)
            {
            }
            column(Customer__No__; "No.")
            {
            }
            column(Customer__Post_Code_; "Post Code")
            {
            }
            column(Customer__Telxon_Store_number_; "Telxon Store number")
            {
            }
            column(Customer__NoJBG_Cross_Flag_; "NoJBG Cross Flag")
            {
            }
            column(GrandHoldMerchTotal; GrandHoldMerchTotal)
            {
            }
            column(GrandApprMerchTotal; GrandApprMerchTotal)
            {
            }
            column(GrandCustMerchTotal; GrandCustMerchTotal)
            {
            }
            column(GrandCustQtyTotal; GrandCustQtyTotal)
            {
            }
            column(GrandHoldQtyTotal; GrandHoldQtyTotal)
            {
            }
            column(GrandApprQtyTotal; GrandApprQtyTotal)
            {
            }
            dataitem("Telxon Input File"; "Telxon Input File")
            {
                DataItemLink = "Customer Number" = field("No.");
                DataItemTableView = sorting("Customer Number", "Vendor No.", Date, "Order Item No.") order(ascending) where(Processed = const(false));
                PrintOnlyIfDetail = false;
                RequestFilterFields = Date;
                column(ReportForNavId_9733; 9733)
                {
                }
                column(Telxon_Input_File_Date; Date)
                {
                }
                column(VPrintDetail; VPrintDetail)
                {
                }
                column(Telxon_Input_File_Quantity; Quantity)
                {
                }
                column(VStoreUse; VStoreUse)
                {
                }
                column(Telxon_Input_File__Order_Type_; "Order Type")
                {
                }
                column(Telxon_Input_File__Purchaser_Code_; "Purchaser Code")
                {
                }
                column(Telxon_Input_File__Order_Item_No__; "Order Item No.")
                {
                }
                column(Telxon_Input_File_Location; Location)
                {
                }
                column(Telxon_Input_File__Vendor_No__; "Vendor No.")
                {
                }
                column(Telxon_Input_File__Shipping_Code_; "Shipping Code")
                {
                }
                column(Telxon_Input_File__Pick_code_; "Pick code")
                {
                }
                column(Telxon_Input_File__Vendor_Name_; "Vendor Name")
                {
                }
                column(VOnhold; VOnhold)
                {
                }
                column(TotWeight; TotWeight)
                {
                }
                column(Telxon_Input_File__Error_Remark_; "Error Remark")
                {
                }
                column(Telxon_Input_File__Item_Description_; "Item Description")
                {
                }
                column(VAmount; VAmount)
                {
                }
                column(ApprovedAmount; ApprovedAmount)
                {
                }
                column(ApprovedQuantity; ApprovedQuantity)
                {
                }
                column(HoldAmount; HoldAmount)
                {
                }
                column(HoldQuantity; HoldQuantity)
                {
                }
                column(VDropShip; VDropShip)
                {
                }
                column(Telxon_Input_File__Vendor_No___Control38; "Vendor No.")
                {
                }
                column(Telxon_Input_File__Vendor_Name__Control39; "Vendor Name")
                {
                }
                column(Telxon_Input_File_Location_Control40; Location)
                {
                }
                column(Telxon_Input_File_Date_Control42; Date)
                {
                }
                column(VAmount_Control25; VAmount)
                {
                }
                column(TotWeight_Control41; TotWeight)
                {
                }
                column(Telxon_Input_File__Error_Remark__Control67; "Error Remark")
                {
                }
                column(Telxon_Input_File__Shipping_Code__Control66; "Shipping Code")
                {
                }
                column(VDropShip_Control70; VDropShip)
                {
                }
                column(VOnhold_Control71; VOnhold)
                {
                }
                column(Telxon_Input_File__Order_Type__Control76; "Order Type")
                {
                }
                column(CustMerchTotal; CustMerchTotal)
                {
                }
                column(CustQtyTotal; CustQtyTotal)
                {
                }
                column(HoldMerchTotal; HoldMerchTotal)
                {
                }
                column(ApprMerchTotal; ApprMerchTotal)
                {
                }
                column(HoldQtyTotal; HoldQtyTotal)
                {
                }
                column(ApprQtyTotal; ApprQtyTotal)
                {
                }
                column(Telxon_Input_File_Sequence; Sequence)
                {
                }
                column(Telxon_Input_File_Customer_Number; "Customer Number")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    VAmount := "Unit Price" * Quantity;
                    TotWeight := "Gross Weight" * Quantity;
                    if "On Hold" = true then VOnhold := 'H' else VOnhold := '';
                    if "Store Use" = true then VStoreUse := 'X' else VStoreUse := '';
                    if "Drop Ship" = true then VDropShip := 'X' else VDropShip := '';

                    //Totals for Customer
                    if "On Hold" = true then begin
                        HoldAmount := VAmount;
                        HoldQuantity := TotWeight;
                        HoldMerchTotal := HoldMerchTotal + VAmount;
                        HoldQtyTotal := HoldQtyTotal + TotWeight;
                        GrandHoldMerchTotal := GrandHoldMerchTotal + VAmount;
                        GrandHoldQtyTotal := GrandHoldQtyTotal + TotWeight;
                    end
                    else begin
                        ApprovedAmount := VAmount;
                        ApprovedQuantity := TotWeight;
                    end;

                    CustMerchTotal := CustMerchTotal + VAmount;
                    CustQtyTotal := CustQtyTotal + TotWeight;

                    ApprMerchTotal := CustMerchTotal - HoldMerchTotal;
                    ApprQtyTotal := CustQtyTotal - HoldQtyTotal;

                    GrandCustMerchTotal := GrandCustMerchTotal + VAmount;
                    GrandCustQtyTotal := GrandCustQtyTotal + TotWeight;

                    GrandApprMerchTotal := GrandCustMerchTotal - GrandHoldMerchTotal;
                    GrandApprQtyTotal := GrandCustQtyTotal - GrandHoldQtyTotal;
                end;

                trigger OnPreDataItem()
                begin
                    // CurrReport.CreateTotals(VAmount);
                    // CurrReport.CreateTotals(Quantity);
                    // CurrReport.CreateTotals(TotWeight);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //Reset totals for each customer
                CustMerchTotal := 0.0;
                CustQtyTotal := 0.0;
                HoldMerchTotal := 0.0;
                HoldQtyTotal := 0.0;
                ApprMerchTotal := 0.0;
                ApprQtyTotal := 0.0;
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
                    field(VPrintDetail; VPrintDetail)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Print Detail';
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
        VPrintDetail: Boolean;
        VAmount: Decimal;
        VOnhold: Code[10];
        VStoreUse: Code[10];
        VDropShip: Code[10];
        TotWeight: Decimal;
        CustMerchTotal: Decimal;
        CustQtyTotal: Decimal;
        HoldMerchTotal: Decimal;
        HoldQtyTotal: Decimal;
        ApprMerchTotal: Decimal;
        ApprQtyTotal: Decimal;
        GrandApprMerchTotal: Decimal;
        GrandHoldMerchTotal: Decimal;
        GrandCustMerchTotal: Decimal;
        GrandApprQtyTotal: Decimal;
        GrandHoldQtyTotal: Decimal;
        GrandCustQtyTotal: Decimal;
        Text19013305: label 'Print Detail';
        Telxon_Requisition_Status_ReportCaptionLbl: label 'Telxon Requisition Status Report';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        TelxonCaptionLbl: label 'Telxon';
        No_JBG_CrossCaptionLbl: label 'No JBG Cross';
        Grand_Total_To_Be_ApprovedCaptionLbl: label 'Grand Total To Be Approved';
        Grand_Total_HeldCaptionLbl: label 'Grand Total Held';
        Grand_TotalCaptionLbl: label 'Grand Total';
        VOnholdCaptionLbl: label 'Hold';
        Telxon_Input_File__Purchaser_Code_CaptionLbl: label 'Purch';
        VendorCaptionLbl: label 'Vendor';
        Ship_CodeCaptionLbl: label 'Ship Code';
        S_UCaptionLbl: label 'S U';
        Item_No_CaptionLbl: label 'Item No.';
        Pick_CaptionLbl: label 'Pick ';
        WeightCaptionLbl: label 'Weight';
        TypeCaptionLbl: label 'Type';
        MerchCaptionLbl: label 'Merch';
        Drop_ShipCaptionLbl: label 'Drop Ship';
        Total_To_Be_ApprovedCaptionLbl: label 'Total To Be Approved';
        Total_HeldCaptionLbl: label 'Total Held';
        Customer_TotalCaptionLbl: label 'Customer Total';
        HoldAmount: Decimal;
        HoldQuantity: Decimal;
        ApprovedAmount: Decimal;
        ApprovedQuantity: Decimal;
}

