tableextension 50002 Customer extends Customer
{
    fields
    {
        field(50000; "Member Code"; Code[10]) { }
        field(50001; "Parcel Post Code"; Code[10]) { }
        field(50002; "Saleable Report Flag"; Option) { OptionMembers = ,"ONE First page","TWO Second page","THREE Bethel stores","FOUR Kaltag store"; }
        field(50003; "NoJBG Cross Flag"; Boolean) { }
        field(50004; "Store Deposit"; Decimal) { }
        field(50005; "Telxon Store number"; Code[2]) { } //Used for incoming Telxon orders
        field(50006; "Reserve Factor"; Decimal) { }
        field(50007; "ANICA Member Fee"; Decimal) { }
        field(50008; "Exempt from Insurance"; Boolean) { }
        field(50009; "Use Bethel Retail"; Boolean) { }
        field(50010; "Barge Zone"; Code[10]) { }
        field(50011; "Bethel Customer Number"; Text[4]) { }
        field(50012; "Previous Credit"; Decimal) { }
        field(50013; "Credit Report"; Option) { OptionMembers = ,MEMBERS,"NON-MEMBERS","Z-ANICA"; }
        field(50014; "Store Physical Address"; Text[40]) { }
        field(50016; "Balance ANICA"; Decimal) { }
        field(50017; "ADP Code"; Code[10]) { }
        field(50018; "Destination Code"; Code[10]) { }
        field(50019; "JBG Below 1000"; Boolean) { }
        field(50020; "Ship-To Cust. Shipping No."; Code[10]) { } //MSA Reporting
        field(50021; "Ship-To Cust. Shipping No. Ext"; Code[10]) { } //MSA Reporting
        field(50022; "Ship-To Cust. Country"; Code[10]) { } //MSA Reporting
        field(50023; "Ship-To Cust. Class of Trade"; Option) { OptionMembers = Retailer,Distributor,Other; } //MSA Reporting
        field(50024; "Ship-To Cust. TDLinx No."; Code[10]) { } //MSA Reporting
        field(50025; "Ship-To Cash and Carry"; Text[250]) { } //MSA Reporting
        field(50026; "Location No."; Code[10]) { } //MSA Reporting
        field(50027; "Machine Type"; Code[10]) { } //MSA Reporting
        field(50028; "Bill-To Cust. Group No."; Code[24]) { } //MSA Reporting
        field(50029; "Retailer Prod. Cat. Footage 1"; Code[10]) { } //MSA Reporting
        field(50030; "Retailer Prod. Cat. Footage 2"; Code[10]) { } //MSA Reporting
        field(50031; "Retailer Prod. Cat. Footage 3"; Code[10]) { } //MSA Reporting
        field(50032; "Cust. Prod. Promo Acceptance"; Boolean) { } //MSA Reporting
        field(50033; "Sales Rep ID No."; Code[10]) { } //MSA Reporting
        field(50034; "Tobacco Tax"; Boolean) { } //For Tobacco Tax Purposes
        field(50035; "Assigned Targets"; Code[10]) { }
    }

    keys
    {
        key(Key50000; "Credit Report") { }
    }
    var
        myInt: Integer;
}