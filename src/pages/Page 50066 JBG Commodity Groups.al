Page 50066 "JBG Commodity Groups"
{
    PageType = List;
    SourceTable = "ANICA-JBG Commodity Codes";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("JBG Commodity Group"; Rec."JBG Commodity Group")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ANICA Commodity Code"; Rec."ANICA Commodity Code")
                {
                    ApplicationArea = Basic;
                }
                field("JBG Description"; Rec."JBG Description")
                {
                    ApplicationArea = Basic;
                }
                field("ANICA Description"; Rec."ANICA Description")
                {
                    ApplicationArea = Basic;
                }
                field("Pick Type"; Rec."Pick Type")
                {
                    ApplicationArea = Basic;
                }
                field("Date Added"; Rec."Date Added")
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

