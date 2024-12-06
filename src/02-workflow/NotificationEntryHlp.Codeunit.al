codeunit 83812 "Notification Entry Hlp. WFE"
{
    Permissions =
        tabledata "Approval Entry" = R,
        tabledata "Notification Entry" = RD;

    internal procedure DeleteNotifications(var NotificationEntry: Record "Notification Entry")
    var
        UserManagement: Codeunit "User Management WFE";
    begin
        UserManagement.TestIsApprovalAdministrator();
        NotificationEntry.DeleteAll(true);
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

    internal procedure GetRecordToApprove(NotificationEntry: Record "Notification Entry"): RecordId
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        if ApprovalEntry.Get(NotificationEntry."Triggered By Record") then
            exit(ApprovalEntry."Record ID to Approve");
    end;
}
