codeunit 83820 "Notification Entry Subscr. WFE"
{
    Access = Internal;
    Permissions =
        tabledata "Workflow Editor Setup WFE" = R;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Notification Entry Dispatcher", OnBeforeCreateMailAndDispatch, '', false, false)]
    local procedure OnBeforeCreateMailAndDispatch(var NotificationEntry: Record "Notification Entry"; var MailSubject: Text; var Email: Text; var IsHandled: Boolean)
    var
        WorkflowEditorSetup: Record "Workflow Editor Setup WFE";
    begin
        if not WorkflowEditorSetup.Get() then
            exit;

        DisableMail(WorkflowEditorSetup, IsHandled);
    end;

    local procedure DisableMail(var WorkflowEditorSetup: Record "Workflow Editor Setup WFE"; var IsHandled: Boolean)
    begin
        if WorkflowEditorSetup."Disable Mail Notifications" then
            IsHandled := true;
    end;
}