Page 50020 "MSA Reporting - HID Table"
{
    PageType = List;
    SourceTable = "MSA Reporting - HID";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Distributor ID Number"; Rec."Distributor ID Number")
                {
                    ApplicationArea = Basic;
                }
                field("Distributor Name"; Rec."Distributor Name")
                {
                    ApplicationArea = Basic;
                }
                field("Distributor Address"; Rec."Distributor Address")
                {
                    ApplicationArea = Basic;
                }
                field("Distributor City"; Rec."Distributor City")
                {
                    ApplicationArea = Basic;
                }
                field("Distributor State"; Rec."Distributor State")
                {
                    ApplicationArea = Basic;
                }
                field("Distributor Zip Code"; Rec."Distributor Zip Code")
                {
                    ApplicationArea = Basic;
                }
                field("Distributor Contact First Name"; Rec."Distributor Contact First Name")
                {
                    ApplicationArea = Basic;
                }
                field("Distributor Contact Last Name"; Rec."Distributor Contact Last Name")
                {
                    ApplicationArea = Basic;
                }
                field("Country/City Dialing Code (T)"; Rec."Country/City Dialing Code (T)")
                {
                    ApplicationArea = Basic;
                }
                field("Distributor Contact Phone No."; Rec."Distributor Contact Phone No.")
                {
                    ApplicationArea = Basic;
                }
                field("Country/City Dialing Code (F)"; Rec."Country/City Dialing Code (F)")
                {
                    ApplicationArea = Basic;
                }
                field("Distributor Contact Fax No."; Rec."Distributor Contact Fax No.")
                {
                    ApplicationArea = Basic;
                }
                field("Distributor Contact Email"; Rec."Distributor Contact Email")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

