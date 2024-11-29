codeunit 83812 "Notification Entry Hlp. WFE"
{
    Permissions =
        tabledata "Notification Entry" = RD;

    internal procedure DeleteNotification(var NotificationEntry: Record "Notification Entry")
    var
        UserManagement: Codeunit "User Management WFE";
    begin
        if not UserManagement.IsApprovalAdministrator() then
            exit;

        NotificationEntry.Delete(true);
    end;

    internal procedure OnAfterInsert(var NotificationEntry: Record "Notification Entry")
    var
        WorkflowEventLog: Codeunit "Workflow Event Log WFE";
    begin
        WorkflowEventLog.AddEvent(NotificationEntry, "Record Trigger Type WFE"::Insert);
    end;

    internal procedure OnAfterDelete(var NotificationEntry: Record "Notification Entry")
    var
        WorkflowEventLog: Codeunit "Workflow Event Log WFE";
    begin
        WorkflowEventLog.AddEvent(NotificationEntry, "Record Trigger Type WFE"::Delete);
    end;
}
