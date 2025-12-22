codeunit 83812 "Notification Entry Hlp. WFE"
{
    Permissions =
        tabledata "Approval Entry" = R,
        tabledata "Notification Entry" = RD;

    var
        UserManagement: Codeunit "User Management WFE";

    internal procedure DeleteNotifications(var NotificationEntry: Record "Notification Entry")
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

    internal procedure RunAllNotificationDispatcher()
    var
        NotificationEntry: Record "Notification Entry";
    begin
        UserManagement.TestIsApprovalAdministrator();
        Codeunit.Run(Codeunit::"Notification Dispatcher WFE", NotificationEntry);
    end;

    internal procedure RunCurrentNotificationViaDispatcher(var NotificationEntry: Record "Notification Entry")
    var
        DispatchNotificationEntry: Record "Notification Entry";
    begin
        UserManagement.TestIsApprovalAdministrator();
        DispatchNotificationEntry := NotificationEntry;
        DispatchNotificationEntry.SetRecFilter();
        Codeunit.Run(Codeunit::"Notification Dispatcher WFE", DispatchNotificationEntry);
    end;

    internal procedure ShowRecordToApprovevar(Rec: Record "Notification Entry")
    var
        PageManagement: Codeunit "Page Management";
        RecordRef: RecordRef;
        RecordID: Variant;
    begin
        if not RecordRef.Get(RecordID) then
            exit;

        PageManagement.PageRun(RecordRef);
    end;
}