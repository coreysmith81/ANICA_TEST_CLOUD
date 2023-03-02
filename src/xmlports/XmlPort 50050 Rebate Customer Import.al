XmlPort 50050 "Rebate Customer Import"
{
    Caption = 'Rebate Customer Import';
    Direction = Import;
    FieldDelimiter = '~';
    FieldSeparator = '|';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Rebates Customers";"Rebates Customers")
            {
                AutoUpdate = true;
                XmlName = 'RebatesCustomers';
                fieldelement(RebateCustomerNo;"Rebates Customers"."Rebate Customer No.")
                {
                }
                fieldelement(RebateStoreNo;"Rebates Customers"."Rebate Store No.")
                {
                }
                textelement(ZName)
                {
                }
                textelement(Zaddress1)
                {
                }
                fieldelement(Address2;"Rebates Customers"."Address 2")
                {
                }
                fieldelement(City;"Rebates Customers".City)
                {
                }
                fieldelement(State;"Rebates Customers".State)
                {
                }
                fieldelement(ZipCode;"Rebates Customers"."Zip Code")
                {
                }
                fieldelement(FirstName;"Rebates Customers"."First Name")
                {
                }
                textelement(ZLastName)
                {
                }
                fieldelement(RiskLevel;"Rebates Customers"."Risk Level")
                {
                }
                fieldelement(CustomerGroup;"Rebates Customers"."Customer Group")
                {
                }

                trigger OnBeforeInsertRecord()
                begin
                    "Rebates Customers"."Customer Name" := CopyStr(ZName,1,30);
                    "Rebates Customers".Address := CopyStr(Zaddress1,1,30);
                    "Rebates Customers"."Last Name" := CopyStr(ZLastName,1,30);
                end;
            }
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
}

