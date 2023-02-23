tableextension 50004 Vendor extends Vendor
{
    fields
    {
        field(50000; "Vendor Type Code"; Option) { OptionMembers = ,Budget,Grocery,JBG,OMC,Polaris,Skidoo,Warehouse,Yakima,Breakout; }
        field(50001; "Prior Vendor Code"; Code[10]) { }
        field(50002; "Vendor Minimum"; Decimal) { }
        field(50003; "W9 Received"; Boolean) { }
        field(50004; OneLot; Boolean) { }
        field(50005; "Pmt. Disc. Calculation"; Option) { OptionMembers = "Total Invoice","Invoice Without Freight"; }
        field(50006; "Type of TIN"; Option) { OptionMembers = ,EIN,SSN; }
        field(50007; "Vendor Credit Limit"; Decimal) { }
        field(50008; "Used By"; Option) { OptionMembers = ,Seattle,Anchorage; }
        field(50009; Division; Text[30]) { }
        field(50010; Broker; Option) { OptionMembers = ,ACOSTA,"Advantage Bass",Asmak,Crossmark,Direct,"Pierce/Cartwright","Sales Corporation",WEST; }
        field(50011; "Stock Method"; Option) { OptionMembers = ,ADC,"Drop-Ship",Seasonal,Various; }
        field(50012; Funds; Text[30]) { }
        field(50013; FOB; Option) { OptionMembers = ,ADC,KENT,"WILL CALL"; }
        field(50014; Margin; Text[30]) { }
        field(50015; "No. of Commodity Groups"; Text[40]) { }
        field(50016; "Item Count"; Text[30]) { }
        field(50017; "PO Miniumum"; Text[30]) { }
        field(50018; Representative; Text[30]) { }
        field(50019; "Order Method"; Option) { OptionMembers = ,PO,"PO to EDI","Website/Portal"; }
        field(50020; "Lead Time"; Text[30]) { }
        field(50021; "Order Configuration"; Option) { OptionMembers = ,Case,Layer,Mixed,Pallet; }
    }

    var
        myInt: Integer;
}
