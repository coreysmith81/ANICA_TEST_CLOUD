Table 50020 "ANICA Vendor Supplement"
{

    fields
    {
        field(1;"Vendor No.";Code[10])
        {
            TableRelation = Vendor."No.";
        }
        field(2;Division;Text[30])
        {
        }
        field(3;Broker;Option)
        {
            OptionMembers = " ",ACOSTA,"Advantage Bass",Asmak,Crossmark,Direct,"Pierce/Cartwright","Sales Corporation","WEST ";
        }
        field(4;"Stock Method";Option)
        {
            OptionMembers = " ",ADC,"Drop-Ship",Seasonal,Various;
        }
        field(5;Funds;Text[60])
        {
        }
        field(6;FOB;Option)
        {
            OptionMembers = " ",ADC,KENT,"WILL CALL";
        }
        field(7;Margin;Text[30])
        {
        }
        field(8;"No. of Commodity Groups";Integer)
        {
        }
        field(9;"Item Count";Text[30])
        {
        }
        field(10;"PO Miniumum";Text[30])
        {
        }
        field(11;Representative;Text[30])
        {
        }
        field(12;"Order Method";Option)
        {
            OptionMembers = " ",PO,"PO to EDI","Website/Portal";
        }
        field(13;"Lead Time";Text[30])
        {
        }
        field(14;"Order Confirguration";Option)
        {
            OptionMembers = " ","Case",Layer,Mixed,Pallet;
        }
        field(16;"Trade Allowance";Decimal)
        {
        }
        field(17;"Accrual Allowance";Decimal)
        {
        }
        field(18;"Bill Back";Decimal)
        {
        }
        field(19;"Case Weight Allowance";Decimal)
        {
        }
        field(20;"Office Invoice Allowance";Decimal)
        {
        }
        field(21;"Usables/Unsellable Allowance";Decimal)
        {
        }
        field(22;"Pallet Charge";Decimal)
        {
        }
        field(23;"Box Charge";Decimal)
        {
        }
        field(24;"Delivery Charge";Decimal)
        {
        }
        field(25;"Pick Up Freight";Decimal)
        {
        }
        field(26;"Water Freight";Decimal)
        {
        }
    }

    keys
    {
        key(Key1;"Vendor No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

