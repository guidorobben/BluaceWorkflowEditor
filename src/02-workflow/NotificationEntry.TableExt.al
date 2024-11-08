tableextension 83804 "Notification Entry WPTE" extends "Notification Entry"
{
    var
        NotificationEntryHlpWPTE: Codeunit "Notification Entry Hlp. WPTE";

    procedure DeleteNotificationWPTE()
    begin
        NotificationEntryHlpWPTE.DeleteNotificationWPTE(Rec);
    end;
}
