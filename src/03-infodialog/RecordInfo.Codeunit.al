codeunit 83821 "Record Info WFE"
{
    var
        CurrentWorkflowCode: Code[20];
        CurrentSourceVariant: Variant;

    procedure Initialize()
    begin
        Clear(this.CurrentWorkflowCode);
        Clear(this.CurrentSourceVariant);
    end;

    procedure WorkFlowCode(NewWorkflowCode: Code[20])
    begin
        this.CurrentWorkflowCode := NewWorkflowCode;
    end;

    procedure WorkFlowCode(): Code[20]
    begin
        exit(CurrentWorkflowCode);
    end;

    procedure SourceRecord(SourceVariant: Variant)
    begin
        this.CurrentSourceVariant := SourceVariant;
    end;

    procedure SourceRecord() SourceVariant: Variant
    begin
        SourceVariant := this.CurrentSourceVariant;
    end;
}