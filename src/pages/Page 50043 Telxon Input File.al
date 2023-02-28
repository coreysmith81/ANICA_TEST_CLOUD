Page 50043 "Telxon Input File"
{
    AutoSplitKey = true;
    DataCaptionFields = "Batch Name";
    Editable = true;
    PageType = Worksheet;
    SaveValues = true;
    SourceTable = "Telxon Input File";
    UsageCategory = Lists;
    SourceTableView = sorting(Processed, "Batch Name", Sequence)
                      order(ascending)
                      where(Processed = filter(False));

    layout
    {
        area(content)
        {
            field("<Store>"; T."Store Filter")
            {
                ApplicationArea = Basic;
                Caption = 'Store';

                trigger OnValidate()
                begin
                    TStoreFilterOnAfterValidate;
                end;
            }
            field("T.""TelxonVendor Filter"""; T."TelxonVendor Filter")
            {
                ApplicationArea = Basic;
                Caption = 'Telxon Vendor';

                trigger OnValidate()
                begin
                    TTelxonVendorFilterOnAfterVali;
                end;
            }
            field("T.""Date Filter"""; T."Date Filter")
            {
                ApplicationArea = Basic;
                Caption = 'Date';

                trigger OnValidate()
                begin
                    TDateFilterOnAfterValidate;
                end;
            }
            field("T.""CustomerNo Filter"""; T."CustomerNo Filter")
            {
                ApplicationArea = Basic;
                Caption = 'Customer ';

                trigger OnValidate()
                begin
                    TCustomerNoFilterOnAfterValida;
                end;
            }
            field("T.""OrderItem Filter"""; T."OrderItem Filter")
            {
                ApplicationArea = Basic;
                Caption = 'Order Item';

                trigger OnValidate()
                begin
                    TOrderItemFilterOnAfterValidat;
                end;
            }
            field("T.""Location Filter"""; T."Location Filter")
            {
                ApplicationArea = Basic;
                Caption = 'Location';

                trigger OnValidate()
                begin
                    TLocationFilterOnAfterValidate;
                end;
            }
            repeater(Control1)
            {
                Editable = true;
                field(Sequence; Rec.Sequence)
                {
                    ApplicationArea = Basic;
                }
                field("Template Name"; Rec."Template Name")
                {
                    ApplicationArea = Basic;
                }
                field("Batch Name"; Rec."Batch Name")
                {
                    ApplicationArea = Basic;
                }
                field(Store; Rec.Store)
                {
                    ApplicationArea = Basic;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic;
                }
                field("Telxon Vendor"; Rec."Telxon Vendor")
                {
                    ApplicationArea = Basic;
                }
                field("Item Variant"; Rec."Item Variant")
                {
                    ApplicationArea = Basic;
                }
                field("Import Item No."; Rec."Import Item No.")
                {
                    ApplicationArea = Basic;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        //CS 9/16: Added to try and make Total Cost and Weight "real time"
                        Rec.CalcFields(TotalCostCalc, TotalWeightCalc);
                        CurrPage.Update;
                    end;
                }
                field("Order Unit of Measure"; Rec."Order Unit of Measure")
                {
                    ApplicationArea = Basic;
                }
                field(TotalCost; Rec.TotalCost)
                {
                    ApplicationArea = Basic;
                }
                field(TotalWeight; Rec.TotalWeight)
                {
                    ApplicationArea = Basic;
                }
                field("Store Use"; Rec."Store Use")
                {
                    ApplicationArea = Basic;
                }
                field("Customer Number"; Rec."Customer Number")
                {
                    ApplicationArea = Basic;
                }
                field("Order Type"; Rec."Order Type")
                {
                    ApplicationArea = Basic;
                }
                field("Allow Less 1000 lbs"; Rec."Allow Less 1000 lbs")
                {
                    ApplicationArea = Basic;
                }
                field("Allow HAZ Less 100 lbs"; Rec."Allow HAZ Less 100 lbs")
                {
                    ApplicationArea = Basic;
                }
                field(Processed; Rec.Processed)
                {
                    ApplicationArea = Basic;
                }
                field("Import Error"; Rec."Import Error")
                {
                    ApplicationArea = Basic;
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    ApplicationArea = Basic;
                }
                field(Manufacturer; Rec.Manufacturer)
                {
                    ApplicationArea = Basic;
                }
                field("Order Item No."; Rec."Order Item No.")
                {
                    ApplicationArea = Basic;
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = Basic;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = Basic;
                }
                field("Vendor Location"; Rec."Vendor Location")
                {
                    ApplicationArea = Basic;
                }
                field("Shipping Code"; Rec."Shipping Code")
                {
                    ApplicationArea = Basic;
                }
                field("FOB Code"; Rec."FOB Code")
                {
                    ApplicationArea = Basic;
                }
                field("Drop Ship"; Rec."Drop Ship")
                {
                    ApplicationArea = Basic;
                }
                field("Error Remark"; Rec."Error Remark")
                {
                    ApplicationArea = Basic;
                }
                field("Status Note"; Rec."Status Note")
                {
                    ApplicationArea = Basic;
                }
                field("Pick code"; Rec."Pick code")
                {
                    ApplicationArea = Basic;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = Basic;
                }
                field("On Hold"; Rec."On Hold")
                {
                    ApplicationArea = Basic;
                }
                field("Gross Weight"; Rec."Gross Weight")
                {
                    ApplicationArea = Basic;
                }
                field("WIC Code"; Rec."WIC Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = Basic;
                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = Basic;
                }
                field("Item Description2"; Rec."Item Description2")
                {
                    ApplicationArea = Basic;
                }
                field("Sales Unit of Measure"; Rec."Sales Unit of Measure")
                {
                    ApplicationArea = Basic;
                }
                field(Velocity; Rec.Velocity)
                {
                    ApplicationArea = Basic;
                }
                field("Sales Order Quantity"; Rec."Sales Order Quantity")
                {
                    ApplicationArea = Basic;
                }
                field(Pack; Rec.Pack)
                {
                    ApplicationArea = Basic;
                }
                field("Pack Description"; Rec."Pack Description")
                {
                    ApplicationArea = Basic;
                }
                field("Sales Order No."; Rec."Sales Order No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Import Quantity"; Rec."Import Quantity")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Processed Date"; Rec."Processed Date")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("ANICA Commodity Code"; Rec."ANICA Commodity Code")
                {
                    ApplicationArea = Basic;
                }
                field("Order Import Date"; Rec."Order Import Date")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Control22)
            {
                field(ItemDescription; ItemDescription)
                {
                    ApplicationArea = Basic;
                    Caption = 'Item Description';
                    Editable = false;
                }
                field(TotalCostCalc; Rec.TotalCostCalc)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(TotalWeightCalc; Rec.TotalWeightCalc)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("Batch F&unctions")
            {
                Caption = 'Batch F&unctions';
                Visible = false;
                action(AllOnHold)
                {
                    ApplicationArea = Basic;
                    Caption = '&On Hold (All Lines Below)';
                    Image = Lock;

                    trigger OnAction()
                    begin
                        VLineCount := Rec.Count;
                        Ok := Dialog.Confirm('This will place EVERYLINE in the table below On Hold.\\A total of %1 lines.\\Are you sure?', false, VLineCount);

                        if Ok then begin
                            Rec.ModifyAll("On Hold", true);
                            CurrPage.Update;
                        end;
                    end;
                }
                action(AllOffHold)
                {
                    ApplicationArea = Basic;
                    Caption = '&Off Hold (All Lines Below)';
                    Image = Add;

                    trigger OnAction()
                    begin
                        VLineCount := Rec.Count;
                        Ok := Dialog.Confirm('This will take EVERY LINE in the table below Off Hold.\\A total of %1 lines.\\Are you sure?', false, VLineCount);

                        if Ok then begin
                            Rec.ModifyAll("On Hold", false);
                            CurrPage.Update;
                        end;
                    end;
                }
            }
            group("Selected Lines Functions")
            {
                Caption = 'Selected Lines Functions';
                action(SelectedOnHold)
                {
                    ApplicationArea = Basic;
                    Caption = 'On Hold (Selected Lines)';
                    Image = Lock;

                    trigger OnAction()
                    begin
                        CurrPage.SetSelectionFilter(VSelection);

                        VLineCount := VSelection.Count;
                        Ok := Dialog.Confirm('A total of %1 lines are selected.\\All will be marked as On Hold.\\Continue?', false, VLineCount);

                        if Ok then begin
                            if VSelection.FindSet(true, true) then
                                repeat
                                begin
                                    VSelection."On Hold" := true;
                                    VSelection.Modify;
                                end
                                until VSelection.Next = 0;

                            VSelection.Reset;

                            Rec.CalcFields(TotalCostCalc, TotalWeightCalc);
                            CurrPage.Update;
                        end
                        else begin
                            VSelection.Reset;

                            Rec.CalcFields(TotalCostCalc, TotalWeightCalc);
                            CurrPage.Update;
                        end;


                        Rec.CalcFields(TotalCostCalc, TotalWeightCalc);
                        CurrPage.Update;
                    end;
                }
                action(SelectedOffHold)
                {
                    ApplicationArea = Basic;
                    Caption = 'Off Hold (Selected Lines)';
                    Image = Add;

                    trigger OnAction()
                    begin
                        CurrPage.SetSelectionFilter(VSelection);

                        VLineCount := VSelection.Count;
                        Ok := Dialog.Confirm('A total of %1 lines are selected.\\All will be marked as Off Hold.\\Continue?', false, VLineCount);

                        if Ok then begin
                            if VSelection.FindSet(true, true) then
                                repeat
                                begin
                                    VSelection."On Hold" := false;
                                    VSelection.Modify;
                                end
                                until VSelection.Next = 0;

                            VSelection.Reset;

                            Rec.CalcFields(TotalCostCalc, TotalWeightCalc);
                            CurrPage.Update;
                        end
                        else begin
                            VSelection.Reset;

                            Rec.CalcFields(TotalCostCalc, TotalWeightCalc);
                            CurrPage.Update;
                        end;


                        Rec.CalcFields(TotalCostCalc, TotalWeightCalc);
                        CurrPage.Update;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        AfterGetCurrRecord;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        //CS 9/15/15: Added to make the two fields at the bottom update "real time".
        Rec.CalcFields(TotalCostCalc, TotalWeightCalc);
        CurrPage.Update;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        AfterGetCurrRecord;
    end;

    trigger OnOpenPage()
    begin
        ItemJnlManagement.GetItem(Rec."Import Item No.", ItemDescription);
        Rec.SetCurrentkey(Processed, Store, "Telxon Vendor", Date, "Customer Number", "Vendor No.", "Order Item No.", Location);
    end;

    var
        ItemJnlManagement: Codeunit ItemJnlManagement;
        CurrentJnlBatchName: Code[10];
        ItemDescription: Text[50];
        T: Record 50029;
        VSelection: Record 50029;
        Ok: Boolean;
        VLineCount: Integer;
        CurrFilter: Integer;

    local procedure TStoreFilterOnAfterValidate()
    begin
        if T."Store Filter" <> '' then
            Rec.SetFilter(Store, T."Store Filter")
        else
            Rec.SetRange(Store);
        Rec.SetFilter("Store Filter", T."Store Filter");
        Rec.CalcFields(TotalCostCalc, TotalWeightCalc);
        CurrPage.Update;
    end;

    local procedure TDateFilterOnAfterValidate()
    begin
        if T."Date Filter" <> 0D then begin
            Rec.SetRange(Date, T."Date Filter");
            Rec.SetRange("Date Filter", T."Date Filter")
        end
        else begin
            Rec.SetRange(Date);
            Rec.SetRange("Date Filter");
        end;
        Rec.CalcFields(TotalCostCalc, TotalWeightCalc);
        CurrPage.Update;
    end;

    local procedure TCustomerNoFilterOnAfterValida()
    begin
        if T."CustomerNo Filter" <> '' then
            Rec.SetFilter("Customer Number", T."CustomerNo Filter")
        else
            Rec.SetRange("Customer Number");
        Rec.SetFilter("CustomerNo Filter", T."CustomerNo Filter");
        Rec.CalcFields(TotalCostCalc, TotalWeightCalc);
        CurrPage.Update;
    end;

    local procedure TOrderItemFilterOnAfterValidat()
    begin
        if T."OrderItem Filter" <> '' then
            Rec.SetFilter("Order Item No.", T."OrderItem Filter")
        else
            Rec.SetRange("Order Item No.");
        Rec.SetFilter("OrderItem Filter", T."OrderItem Filter");
        Rec.CalcFields(TotalCostCalc, TotalWeightCalc);
        CurrPage.Update;
    end;

    local procedure TLocationFilterOnAfterValidate()
    begin
        if T."Location Filter" <> '' then
            Rec.SetFilter(Location, T."Location Filter")
        else
            Rec.SetRange(Location);
        Rec.SetFilter("Location Filter", T."Location Filter");
        Rec.CalcFields(TotalCostCalc, TotalWeightCalc);
        CurrPage.Update;
    end;

    local procedure TTelxonVendorFilterOnAfterVali()
    begin
        if T."TelxonVendor Filter" <> '' then
            Rec.SetFilter("Telxon Vendor", T."TelxonVendor Filter")
        else
            Rec.SetRange("Telxon Vendor");
        Rec.SetFilter("TelxonVendor Filter", T."TelxonVendor Filter");
        Rec.CalcFields(TotalCostCalc, TotalWeightCalc);
        CurrPage.Update;
    end;

    local procedure AfterGetCurrRecord()
    begin
        xRec := Rec;
        ItemJnlManagement.GetItem(Rec."Import Item No.", ItemDescription);
        Rec.CalcFields(TotalCostCalc, TotalWeightCalc);
    end;

}

