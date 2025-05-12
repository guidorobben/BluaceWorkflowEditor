page 83816 "Workflow Step Argument WFE"
{
    ApplicationArea = All;
    Caption = 'Workflow Step Argument Part';
    PageType = Card;
    SourceTable = "Workflow Step Argument";
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            field("Table No."; Rec."Table No.")
            {
                ToolTip = 'Specifies the value of the Table No. field.', Comment = '%';
            }
            field("Event Conditions"; Rec."Event Conditions")
            {
                ToolTip = 'Specifies the value of the Event Conditions field.', Comment = '%';
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ShowArgument)
            {
                Caption = 'Argument';
                Image = Info;

                trigger OnAction()
                var
                    TempBlob: Codeunit "Temp Blob";
                    // RequestPageParametersHelper: Codeunit "Request Page Parameters Helper";
                    // RecRef: RecordRef;
                    ParametersInStream: InStream;
                    Parameters: Text;
                begin
                    TempBlob.FromRecord(Rec, Rec.FieldNo("Event Conditions"));
                    // RecRef.Open(122);
                    if TempBlob.HasValue() then begin
                        TempBlob.CreateInStream(ParametersInStream, TextEncoding::UTF8);
                        ParametersInStream.ReadText(Parameters);
                        Message(Parameters);
                    end;
                    // RequestPageParametersHelper.ConvertParametersToFilters(RecRef, TempBlob, TextEncoding::UTF8)
                end;
            }
        }
    }
}