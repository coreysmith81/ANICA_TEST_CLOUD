Table 50047 "MSA Reporting - HID"
{

    fields
    {
        field(1;"Distributor ID Number";Code[10])
        {
        }
        field(6;"Distributor Name";Text[32])
        {
        }
        field(7;"Distributor Address";Text[90])
        {
        }
        field(8;"Distributor City";Text[30])
        {
        }
        field(9;"Distributor State";Text[30])
        {
        }
        field(10;"Distributor Zip Code";Text[30])
        {
        }
        field(11;"Distributor Contact First Name";Text[30])
        {
        }
        field(12;"Distributor Contact Last Name";Text[30])
        {
        }
        field(13;"Country/City Dialing Code (T)";Text[30])
        {
        }
        field(14;"Distributor Contact Phone No.";Text[30])
        {
        }
        field(15;"Country/City Dialing Code (F)";Text[30])
        {
        }
        field(16;"Distributor Contact Fax No.";Text[30])
        {
        }
        field(17;"Distributor Contact Email";Text[60])
        {
        }
    }

    keys
    {
        key(Key1;"Distributor ID Number")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

