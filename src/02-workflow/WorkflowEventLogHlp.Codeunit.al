codeunit 83810 "Workflow Event Log Hlp. WFE"
{
    Permissions =
        tabledata "Workflow Event Log WFE" = RD;

    internal procedure ClearLog()
    var
        WorkflowEventLog: Record "Workflow Event Log WFE";
    begin
        WorkflowEventLog.DeleteAll(true);
    end;

    internal procedure ShowRecord(WorkflowEventLog: Record "Workflow Event Log WFE")
    var
        PageManagement: Codeunit "Page Management";
        RecRef: RecordRef;
    begin
        if not RecRef.Get(WorkflowEventLog."Record ID") then
            exit;

        RecRef.SetRecFilter();
        PageManagement.PageRun(RecRef);
    end;
}
