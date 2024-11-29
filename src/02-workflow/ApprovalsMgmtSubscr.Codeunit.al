codeunit 83800 "Approvals Mgmt Subscr. WFE"
{
    Permissions = tabledata "Workflow Editor Setup WFE" = R;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnBeforeCreateApprovalEntryNotification, '', false, false)]
    local procedure OnBeforeCreateApprovalEntryNotification(ApprovalEntry: Record "Approval Entry"; var IsHandled: Boolean; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        WorkflowEditorSetup: Record "Workflow Editor Setup WFE";
    begin
        if not WorkflowEditorSetup.Get() then
            exit;

        LogEvent(ApprovalEntry, WorkflowStepInstance);
        DisableMail(WorkflowEditorSetup, IsHandled);
    end;

    local procedure DisableMail(var WorkflowEditorSetup: Record "Workflow Editor Setup WFE"; var IsHandled: Boolean)
    begin
        if WorkflowEditorSetup."Disable Mail Notifications" then
            IsHandled := true;
    end;

    local procedure LogEvent(ApprovalEntry: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        WorkflowEventLog: Codeunit "Workflow Event Log WFE";
    begin
        WorkflowEventLog.AddEvent(ApprovalEntry, WorkflowStepInstance);
    end;
}