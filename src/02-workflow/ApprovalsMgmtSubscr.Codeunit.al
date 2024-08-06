codeunit 83800 "Approvals Mgmt Subscr. WPTE"
{
    Permissions =
        tabledata "Workflow Editor Setup WPTE" = R;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnBeforeCreateApprovalEntryNotification, '', false, false)]
    local procedure OnBeforeCreateApprovalEntryNotification(ApprovalEntry: Record "Approval Entry"; var IsHandled: Boolean; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        WorkflowEditorSetup: Record "Workflow Editor Setup WPTE";
    begin
        if not WorkflowEditorSetup.Get() then
            exit;

        if WorkflowEditorSetup."Disable Mail Notifications" then
            IsHandled := true;
    end;
}