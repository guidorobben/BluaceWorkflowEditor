codeunit 83811 "Workflow Event Log WPTE"
{
    procedure AddEvent(var Variant: Variant; ResponseWorkflowStepInstance: Record "Workflow Step Instance")
    var
        WFEventLog: Record "Workflow Event Log WPTE";
    begin
        if not IsLoggingEnabled() then
            exit;

        WFEventLog.Init();
        WFEventLog."Entry No." := GetNextEntryNo();
        WFEventLog.ID := ResponseWorkflowStepInstance.ID;
        WFEventLog."Workflow Code" := ResponseWorkflowStepInstance."Workflow Code";
        WFEventLog."Workflow Step ID" := ResponseWorkflowStepInstance."Workflow Step ID";
        WFEventLog."Record ID" := ResponseWorkflowStepInstance."Record ID";
        WFEventLog.Status := ResponseWorkflowStepInstance.Status;
        WFEventLog.Type := ResponseWorkflowStepInstance.Type;
        WFEventLog."Function Name" := ResponseWorkflowStepInstance."Function Name";
        WFEventLog.Insert(true);
    end;

    local procedure GetNextEntryNo() EntryNo: Integer
    var
        SequenceNoMgt: Codeunit "Sequence No. Mgt.";
    begin
        EntryNo := SequenceNoMgt.GetNextSeqNo(Database::"Workflow Event Log WPTE");
    end;

    procedure IsLoggingEnabled(): Boolean
    var
        WorkflowEditorSetup: Record "Workflow Editor Setup WPTE";
    begin
        if not WorkflowEditorSetup.Get() then
            exit;

        exit(WorkflowEditorSetup."Log Workflow Events");
    end;
}