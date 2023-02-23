Page 50015 "Parcel Post Codes"
{
    PageType = Card;
    SourceTable = "Parcel Post Code";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Parcel Post Code"; Rec."Parcel Post Code")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
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

