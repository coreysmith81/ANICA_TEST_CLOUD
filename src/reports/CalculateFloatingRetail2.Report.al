Report 50193 "Calculate Floating Retail 2"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Item;Item)
        {
            DataItemTableView = sorting("No.") order(ascending) where(Blocked=const(false));
            RequestFilterFields = "No.","Catalog Group Code";
            column(ReportForNavId_8129; 8129)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if (Item."Unit Price" = 0) or (Item."Commodity Code" = '') then
                  begin
                    Item."Floating GPM" := 0;
                    Item."Store Landed Cost" := 0;
                    exit;
                  end;

                Commodity.Get(Item."Commodity Code"); // for Commodity.Margin

                ParcelPostRate.Get(Item."Commodity Code",0,false);
                // 0=Continental-US and Priority=False
                // for ParcelPostRate."Rate per dollar";

                ItemUOM.Get(Item."No.",Item."Base Unit of Measure"); // for Pack
                _EstimatedFreight := ROUND(Item."Unit Price" * ParcelPostRate."Rate per dollar",0.01);
                Item."Store Landed Cost" := Item."Unit Price" + _EstimatedFreight;
                if Item."Store Landed Cost" = 0 then
                  Error('Store Landed Cost has been calculated as being zero.\\'+
                        'Check Item Unit Price or Rate per dollar in Parcel Post Rate Table.');

                ItemUOM.TestField(Pack);

                Item."Std Floating Retail" := (Item."Store Landed Cost" / ItemUOM.Pack) / ((100 - Commodity.Margin)/100);
                Item."Std Floating Retail" := RetailRounding(Item."Std Floating Retail",Item."Commodity Code");
                Item."Floating GPM" :=
                   ((Item."Std Floating Retail" - (Item."Store Landed Cost"/ItemUOM.Pack))/Item."Std Floating Retail") * 100;
                Item."Floating GPM" := ROUND(Item."Floating GPM",0.01);
                Item.Modify;
                //<<
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
        Commodity: Record "Commodity Code";
        ParcelPostRate: Record "Parcel Post Direct Rates";
        ItemUOM: Record "Item Unit of Measure";
        _EstimatedFreight: Decimal;


    procedure RetailRounding(_Amount: Decimal;CommodityCode: Code[10]): Decimal
    var
        _Decimals: Decimal;
        Commodity: Record "Commodity Code";
        _Amount2: Decimal;
    begin
        //>> MAS
        if (not Commodity.Get(CommodityCode)) or Commodity."Not Rounding" then
          exit(ROUND(_Amount,0.01));

        if _Amount < 10  then
          begin
            if ROUND(_Amount,1) = ROUND(_Amount) then
              exit(_Amount + 0.05);
            _Decimals := (_Amount * 100) - ROUND((_Amount*100),100,'<');
            _Decimals := _Decimals - ROUND(_Decimals,10,'<');
            if _Decimals > 5 then
              exit(ROUND(_Amount,0.1,'>') - 0.01)
            else
              exit(ROUND(_Amount,0.05,'>'));
          end;
        if (_Amount >= 10) and (_Amount < 100) then
          if _Amount - ROUND(_Amount,0.1) = 0 then
            exit(_Amount)
          else
            exit(ROUND(_Amount,0.1,'>') - 0.01);
        if (_Amount >= 100) and (_Amount < 1000) then
          if _Amount - ROUND(_Amount,1.0) = 0 then
            exit(_Amount)
          else
            exit(ROUND(_Amount,1.0,'>') - 0.01);
        if _Amount >= 1000 then
          exit(ROUND(_Amount,1.0,'='));
        //<<
    end;
}

