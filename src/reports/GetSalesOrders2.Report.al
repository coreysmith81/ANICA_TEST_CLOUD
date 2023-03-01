Report 50056 "Get Sales Orders2"
{
    // // MAS Possibility to create approved orders.

    Caption = 'Batch Get Sales Orders';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Sales Header";"Sales Header")
        {
            DataItemTableView = where("Document Type"=const(Order));
            RequestFilterFields = "Salesperson Code","Document Date","No.","Sell-to Customer No.",Approved,Status,"Order Date","Posting Date","Location Code";
            column(ReportForNavId_6640; 6640)
            {
            }
            dataitem("Sales Line";"Sales Line")
            {
                DataItemLink = "Document Type"=field("Document Type"),"Document No."=field("No.");
                DataItemTableView = where("Document Type"=const(Order),Type=const(Item),"Purch. Order Line No."=const(0),"Outstanding Quantity"=filter(<>0));
                RequestFilterHeading = 'Sales Order Line';
                column(ReportForNavId_2844; 2844)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //>>  NonStocks - start
                    if not PurchasingCode.ReadPermission then begin
                      if "Sales Line"."Drop Shipment" then begin
                        LineCount := LineCount + 1;
                        Window.Update(1,LineCount);
                        InsertReqWkshLine("Sales Line");
                      end;
                      CurrReport.Skip;
                    end;

                    if PurchasingCode.Count = 0 then
                      if "Sales Line"."Drop Shipment" then begin
                        LineCount := LineCount + 1;
                        Window.Update(1,LineCount);
                        InsertReqWkshLine("Sales Line");
                      end;

                    if PurchasingCode.Count <> 0 then
                      if PurchasingCode.Get("Sales Line"."Purchasing Code") then
                        if (PurchasingCode."Drop Shipment") or (PurchasingCode."Special Order" and ("Special Order Purchase No." = '')) then begin
                          LineCount := LineCount + 1;
                          Window.Update(1,LineCount);
                          InsertReqWkshLine("Sales Line");
                        end;
                    //<<  NonStocks - end
                end;
            }

            trigger OnPostDataItem()
            begin
                if LineCount = 0 then
                  Error('There are no sales lines to retrieve.');
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
        ReqTemplate.Get(ReqLine."Worksheet Template Name");
        ReqWkshName.Get(ReqLine."Worksheet Template Name",ReqLine."Journal Batch Name");
        ReqLine.SetRange("Worksheet Template Name",ReqLine."Worksheet Template Name");
        ReqLine.SetRange("Journal Batch Name",ReqLine."Journal Batch Name");
        ReqLine.LockTable;
        if ReqLine.Find('+') then
          ReqLine.Init;
        Window.Open('Processing sales lines  #1######');
    end;

    var
        ReqTemplate: Record "Req. Wksh. Template";
        ReqWkshName: Record "Requisition Wksh. Name";
        ReqLine: Record "Requisition Line";
        SalesOrderHeader: Record "Sales Header";
        PurchasingCode: Record Purchasing;
        Window: Dialog;
        LineCount: Integer;


    procedure SetReqWkshLine(NewReqWkshLine: Record "Requisition Line")
    begin
        ReqLine := NewReqWkshLine;
    end;

    local procedure InsertReqWkshLine(SalesOrderLine: Record "Sales Line")
    begin
        with ReqLine do begin
          Init;
          "Line No." := "Line No." + 10000;
          Validate(Type,SalesOrderLine.Type);
        //>>  Non Stock - start
          "Location Code" := SalesOrderLine."Location Code";
          "Variant Code" := SalesOrderLine."Variant Code";
        //<<  Non Stock - end
          Validate("No.",SalesOrderLine."No.");
          "Unit of Measure Code" := SalesOrderLine."Unit of Measure Code";
        //  "Lot No." := SalesOrderLine."Lot No.";
          "Variant Code" := SalesOrderLine."Variant Code";
          "Bin Code" := SalesOrderLine."Bin Code";
          "Qty. per Unit of Measure" := SalesOrderLine."Qty. per Unit of Measure";
          Validate(Quantity,SalesOrderLine."Outstanding Quantity");
          "Due Date" := SalesOrderLine."Shipment Date";
          "Location Code" := SalesOrderLine."Location Code";
        //>>  Multi-Locations - start
          Validate("Location Code",SalesOrderLine."Location Code");
        //<<  Multi-Locations - end
        //  GetTransLine := SalesOrderLine."Serial No.";
          "Sales Order No." := SalesOrderLine."Document No.";
          "Sales Order Line No." := SalesOrderLine."Line No.";
        //>>  Non Stock - start
          "Item Category Code" := SalesOrderLine."Item Category Code";
          Nonstock := SalesOrderLine.Nonstock;
          "Purchasing Code" := SalesOrderLine."Purchasing Code";
        //  "Exclude from Usage" := SalesOrderLine."Exclude from Usage";
        //  "Product Code" := SalesOrderLine."Product Code";
        //>>  NonStock - End
          "Sell-to Customer No." := SalesOrderLine."Sell-to Customer No.";
          SalesOrderHeader.Get(1,SalesOrderLine."Document No.");
          "Ship-to Code" := SalesOrderHeader."Ship-to Code";
        //>> MAS
           ReqLine.Approved := SalesOrderHeader.Approved;
           ReqLine."Approval User" := SalesOrderHeader."Approval User";
           ReqLine."Shortcut Dimension 1 Code" := SalesOrderLine."Shortcut Dimension 1 Code";

           //>>CS 09-11-17: Added so that purchasing doesn't have to change every TXW + 025/026 combo to 024 manually.
           if (SalesOrderHeader."Salesperson Code" = 'TXW') and
            ((SalesOrderHeader."Shipping Instruction Code" = '025') or (SalesOrderHeader."Shipping Instruction Code" = '026')) then
              ReqLine."Shipping Instruction Code" := '024'
           else
              ReqLine."Shipping Instruction Code" := SalesOrderHeader."Shipping Instruction Code";
           //<<

           ReqLine."Direct Unit Cost" := SalesOrderLine."Unit Price";
        //<<
          Insert;
        end;
    end;
}

