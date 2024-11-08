codeunit 83812 "Notification Entry Hlp. WPTE"
{
    Permissions =
        tabledata "Notification Entry" = RD;

    internal procedure DeleteNotificationWPTE(var NotificationEntry: Record "Notification Entry")
    var
        UserManagement: Codeunit "User Management WPTE";
    begin
        if not UserManagement.IsApprovalAdministrator() then
            exit;

        NotificationEntry.Delete(true);
    end;
}
