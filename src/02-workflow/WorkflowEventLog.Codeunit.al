codeunit 83811 "Workflow Event Log WPTE"
{
    Permissions =
        tabledata "Approval Entry" = R,
        tabledata "Workflow Editor Setup WPTE" = R,
        tabledata "Workflow Event Log WPTE" = RI,
        tabledata "Workflow Step Instance" = R;

    procedure AddEvent(var Variant: Variant; ResponseWorkflowStepInstance: Record "Workflow Step Instance")
    var
        WorkflowEventLog: Record "Workflow Event Log WPTE";
    begin
        if not IsLoggingEnabled() then
            exit;

        WorkflowEventLog.Init();
        WorkflowEventLog."Entry No." := GetNextEntryNo();
        WorkflowEventLog.ID := ResponseWorkflowStepInstance.ID;
        WorkflowEventLog."Workflow Code" := ResponseWorkflowStepInstance."Workflow Code";
        WorkflowEventLog."Workflow Step ID" := ResponseWorkflowStepInstance."Workflow Step ID";
        WorkflowEventLog."Record ID" := ResponseWorkflowStepInstance."Record ID";
        WorkflowEventLog.Status := ResponseWorkflowStepInstance.Status;
        WorkflowEventLog.Type := ResponseWorkflowStepInstance.Type;
        WorkflowEventLog."Function Name" := ResponseWorkflowStepInstance."Function Name";
        WorkflowEventLog.Insert(true);
    end;

    procedure AddEvent(ApprovalEntry: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        WorkflowEventLog: Record "Workflow Event Log WPTE";
    begin
        if not IsLoggingEnabled() then
            exit;

        WorkflowEventLog.Init();
        WorkflowEventLog."Entry No." := GetNextEntryNo();
        WorkflowEventLog.ID := WorkflowStepInstance.ID;
        WorkflowEventLog."Workflow Code" := WorkflowStepInstance."Workflow Code";
        WorkflowEventLog."Workflow Step ID" := WorkflowStepInstance."Workflow Step ID";
        WorkflowEventLog."Record ID" := WorkflowStepInstance."Record ID";
        WorkflowEventLog.Status := WorkflowStepInstance.Status;
        WorkflowEventLog.Type := WorkflowStepInstance.Type;
        WorkflowEventLog."Function Name" := WorkflowStepInstance."Function Name";
        WorkflowEventLog."Notification Req. Curr. User" := (ApprovalEntry."Approver ID" <> UserId) or IsBackground();
        WorkflowEventLog."Notify Sender Required" := ((ApprovalEntry."Sender ID" <> UserId) or IsBackground()) and (ApprovalEntry."Sender ID" <> ApprovalEntry."Approver ID");
        WorkflowEventLog."Approver ID" := ApprovalEntry."Approver ID";
        WorkflowEventLog."Sender ID" := ApprovalEntry."Sender ID";
        WorkflowEventLog.Insert(true);
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

    local procedure IsBackground(): Boolean
    var
        ClientTypeManagement: Codeunit "Client Type Management";
    begin
        exit(ClientTypeManagement.GetCurrentClientType() in [ClientType::Background]);
    end;
}