XmlPort 50041 "Export GL Entry for Archive"
{
    // ANICA 5-30-13  This dataport exports GL entries for archive in another SQL table prior to compressing GL entries
    //                through Navision.  A from and to date is entered to set the range of entries to be exported.
    //                The export is in a fixed width format.

    Caption = '<Export GL Entry for Archive>';
    Direction = Export;
    Format = FixedText;

    schema
    {
        textelement(Root)
        {
            tableelement("G/L Entry";"G/L Entry")
            {
                AutoUpdate = true;
                XmlName = 'GLEntry';
                SourceTableView = sorting("Posting Date","G/L Account No.",Description) order(ascending);
                fieldelement(EntryNo;"G/L Entry"."Entry No.")
                {
                    Width = 10;
                }
                fieldelement(GLAccountNo;"G/L Entry"."G/L Account No.")
                {
                    Width = 20;
                }
                textelement(VPostDate)
                {
                    Width = 11;
                }
                fieldelement(DocumentType;"G/L Entry"."Document Type")
                {
                    Width = 20;
                }
                fieldelement(DocumentNo;"G/L Entry"."Document No.")
                {
                    Width = 20;
                }
                fieldelement(Description;"G/L Entry".Description)
                {
                    Width = 50;
                }
                fieldelement(BalAccountNo;"G/L Entry"."Bal. Account No.")
                {
                    Width = 20;
                }
                textelement(PrntAmount)
                {
                    Width = 20;
                }
                fieldelement(GlobalDimension1Code;"G/L Entry"."Global Dimension 1 Code")
                {
                    Width = 20;
                }
                fieldelement(GlobalDimension2Code;"G/L Entry"."Global Dimension 2 Code")
                {
                    Width = 20;
                }
                fieldelement(UserID;"G/L Entry"."User ID")
                {
                    Width = 20;
                }
                fieldelement(SourceCode;"G/L Entry"."Source Code")
                {
                    Width = 10;
                }
                fieldelement(SystemCreatedEntry;"G/L Entry"."System-Created Entry")
                {
                    Width = 10;
                }
                fieldelement(PriorYearEntry;"G/L Entry"."Prior-Year Entry")
                {
                    Width = 10;
                }
                textelement(PrntQuantity)
                {
                    Width = 20;
                }
                fieldelement(JournalBatchName;"G/L Entry"."Journal Batch Name")
                {
                    Width = 20;
                }
                fieldelement(ReasonCode;"G/L Entry"."Reason Code")
                {
                    Width = 10;
                }
                fieldelement(GenPostingType;"G/L Entry"."Gen. Posting Type")
                {
                    Width = 20;
                }
                fieldelement(GenBusPostingGroup;"G/L Entry"."Gen. Bus. Posting Group")
                {
                    Width = 10;
                }
                fieldelement(GenProdPostingGroup;"G/L Entry"."Gen. Prod. Posting Group")
                {
                    Width = 10;
                }
                fieldelement(BalAccountType;"G/L Entry"."Bal. Account Type")
                {
                    Width = 20;
                }
                fieldelement(TransactionNo;"G/L Entry"."Transaction No.")
                {
                    Width = 10;
                }
                textelement(PrntDebit)
                {
                    Width = 20;
                }
                textelement(PrntCredit)
                {
                    Width = 20;
                }
                textelement(VDocDate)
                {
                    Width = 11;
                }
                fieldelement(ExternalDocumentNo;"G/L Entry"."External Document No.")
                {
                    Width = 20;
                }
                fieldelement(SourceType;"G/L Entry"."Source Type")
                {
                    Width = 20;
                }
                fieldelement(SourceNo;"G/L Entry"."Source No.")
                {
                    Width = 20;
                }
                fieldelement(NoSeries;"G/L Entry"."No. Series")
                {
                    Width = 10;
                }
                fieldelement(UseTax;"G/L Entry"."Use Tax")
                {
                    Width = 10;
                }
                fieldelement(CloseIncomeStatementDimID;"G/L Entry"."Close Income Statement Dim. ID")
                {
                    Width = 10;
                }
                fieldelement(ValueEntryNo;"G/L Entry"."Value Entry No.")
                {
                    Width = 10;
                }
                textelement(VClosingEntry)
                {
                    Width = 1;
                }

                trigger OnAfterGetRecord()
                begin

                    //Skip GL entries with no amount
                    if "G/L Entry".Amount = 0 then currXMLport.Skip;

                    //Convert numbers to a non comma format for SQL import
                    PrntAmount   := Format("G/L Entry".Amount,18,'<Sign><Integer><Decimal,3>');
                    PrntQuantity := Format("G/L Entry".Quantity,18,'<Sign><Integer><Decimal,5>');
                    PrntDebit := Format("G/L Entry"."Debit Amount",18,'<Sign><Integer><Decimal,3>');
                    PrntCredit := Format("G/L Entry"."Credit Amount",18,'<Sign><Integer><Decimal,3>');

                    //Convert Dates to Text and remove the C from Closing Entry Dates, also set the Closing Entry Flag
                    VPostDate := Format("G/L Entry"."Posting Date",10,'<Month,2>/<Day,2>/<Year,2>');
                    VDocDate := Format("G/L Entry"."Document Date",10,'<Month,2>/<Day,2>/<Year,2>');
                    VCheckDate := Format("G/L Entry"."Posting Date",1,'<Closing,1>');
                    if VCheckDate = 'C' then VClosingEntry:= '1' else VClosingEntry:= '0';
                end;

                trigger OnPreXmlItem()
                begin
                    "G/L Entry".SetRange("G/L Entry"."Posting Date",VPostDateFrom,VPostDateTo);
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("<Control1900000002>")
                {
                    Caption = 'Options';
                    field("<Control1>";VPostDateFrom)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Enter the Start Date for Archive';
                    }
                    field("<Control2>";VPostDateTo)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Enter Ending Date for Archive';
                    }
                    field("<Control3>";VFileName)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Enter Item File Name to Export to';
                    }
                }
            }
        }

        actions
        {
        }
    }

    trigger OnInitXmlPort()
    begin
        VFileName := '\\filestore\EDI\Other\GL_Entries.txt';
    end;

    trigger OnPostXmlPort()
    begin
        //For Status Box
        Window.Close;
        Clear(Window);

        Message('Export Complete');
        Message('You have to manually enter a return on the last record in the file');
    end;

    trigger OnPreXmlPort()
    begin
        currXMLport.Filename(VFileName);

        //For Status Box
        begin
            Clear(Window);
            Window.Open('Processing Item #1######');
        end;
    end;

    var
        VPostDateFrom: Date;
        VPostDateTo: Date;
        VFileName: Text;
        VCheckDate: Text;
        Window: Dialog;
}

