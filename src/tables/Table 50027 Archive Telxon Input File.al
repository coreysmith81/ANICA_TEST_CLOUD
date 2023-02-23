Table 50027 "Archive Telxon Input File"
{
    // //CS 09-18-2014: 12 months worth of history will go in the Active input file, and 12 months in the archive.


    fields
    {
        field(1;Sequence;Integer)
        {
        }
        field(2;Store;Code[10])
        {
        }
        field(3;Date;Date)
        {
        }
        field(4;"Telxon Vendor";Code[10])
        {
        }
        field(5;"Import Item No.";Code[20])
        {
        }
        field(6;Quantity;Decimal)
        {
        }
        field(7;"Store Use";Boolean)
        {
        }
        field(8;"Customer Number";Code[10])
        {
        }
        field(9;"Order Type";Option)
        {
            OptionMembers = Barge,Supplemental,Seasonal,Promotional,Fuel,Equipment;
        }
        field(10;Processed;Boolean)
        {
        }
        field(11;"Import Error";Boolean)
        {
        }
        field(12;"Batch Name";Code[20])
        {
        }
        field(13;"Purchaser Code";Code[10])
        {
        }
        field(14;Manufacturer;Code[10])
        {
        }
        field(15;"Order Item No.";Code[20])
        {
        }
        field(16;Location;Code[10])
        {
        }
        field(17;"Vendor No.";Code[10])
        {
        }
        field(18;"Shipping Code";Code[10])
        {
        }
        field(19;"FOB Code";Code[10])
        {
        }
        field(20;"Drop Ship";Boolean)
        {
        }
        field(21;"Error Remark";Text[30])
        {
        }
        field(22;"Pick Code";Option)
        {
            OptionMembers = " ",Hazardous,"Freeze/Chill",Dry,Other,"Phone Cards",Tobacco,Oils,"Pick Type 2",Snacks,Pop;
        }
        field(23;"Vendor Name";Text[30])
        {
        }
        field(24;"On Hold";Boolean)
        {
        }
        field(25;"Gross Weight";Decimal)
        {
        }
        field(26;"Unit Price";Decimal)
        {
        }
        field(27;"Item Description";Text[30])
        {
        }
        field(28;"Sales Order No.";Code[10])
        {
        }
        field(29;"Processed Date";Date)
        {
        }
        field(31;"Template Name";Code[20])
        {
        }
        field(32;TotalCost;Decimal)
        {
            Editable = false;
        }
        field(33;TotalWeight;Decimal)
        {
            Editable = false;
        }
        field(34;TotalCostCalc;Decimal)
        {
            CalcFormula = sum("Telxon Input File".TotalCost where (Processed=const(false),
                                                                   Store=field("Store Filter"),
                                                                   "Telxon Vendor"=field("TelxonVendor Filter"),
                                                                   Date=field("Date Filter"),
                                                                   "Customer Number"=field("CustomerNo Filter"),
                                                                   "Vendor No."=field("VendorNo Filter"),
                                                                   "Order Item No."=field("OrderItem Filter"),
                                                                   Location=field("Location Filter")));
            FieldClass = FlowField;
        }
        field(35;TotalWeightCalc;Decimal)
        {
            CalcFormula = sum("Telxon Input File".TotalWeight where (Processed=const(false),
                                                                     Store=field("Store Filter"),
                                                                     "Telxon Vendor"=field("TelxonVendor Filter"),
                                                                     Date=field("Date Filter"),
                                                                     "Customer Number"=field("CustomerNo Filter"),
                                                                     "Vendor No."=field("VendorNo Filter"),
                                                                     "Order Item No."=field("OrderItem Filter"),
                                                                     Location=field("Location Filter")));
            FieldClass = FlowField;
        }
        field(40;"Store Filter";Code[10])
        {
            FieldClass = FlowFilter;
        }
        field(41;"TelxonVendor Filter";Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(42;"Date Filter";Date)
        {
            FieldClass = FlowFilter;
        }
        field(43;"CustomerNo Filter";Code[10])
        {
            FieldClass = FlowFilter;
        }
        field(44;"VendorNo Filter";Code[10])
        {
            FieldClass = FlowFilter;
        }
        field(45;"OrderItem Filter";Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(46;"Location Filter";Code[10])
        {
            FieldClass = FlowFilter;
        }
        field(47;"Requisition Number";Code[10])
        {
            Description = 'For Original conversion only';
        }
        field(48;"Requisition Line";Integer)
        {
            Description = 'Used only for conversion';
        }
        field(49;"Inventory Fill Amount";Decimal)
        {
        }
        field(50;"Pack Description";Text[10])
        {
        }
        field(51;Pack;Decimal)
        {
        }
        field(52;"Sales Unit of Measure";Code[10])
        {
        }
        field(53;"Archive Sequence";Integer)
        {
        }
        field(54;"Order Unit of Measure";Code[10])
        {
        }
        field(55;"Sales Order Quantity";Decimal)
        {
        }
        field(56;"Item Description2";Text[30])
        {
            Editable = false;
        }
        field(57;"Item Variant";Code[10])
        {
        }
        field(58;"WIC Code";Boolean)
        {
        }
        field(60;Velocity;Decimal)
        {
        }
        field(61;"Allow Less 1000 lbs";Boolean)
        {
        }
        field(62;"Import Quantity";Decimal)
        {
        }
        field(63;"Allow HAZ Less 100 lbs";Boolean)
        {
        }
        field(64;"Sales Line No.";Integer)
        {
        }
    }

    keys
    {
        key(Key1;"Archive Sequence")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

