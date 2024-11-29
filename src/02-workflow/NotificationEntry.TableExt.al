tableextension 83804 "Notification Entry WFE" extends "Notification Entry"
{
    var
        NotificationEntryHlpWFE: Codeunit "Notification Entry Hlp. WFE";

    trigger OnAfterInsert()
    begin
        NotificationEntryHlpWFE.OnAfterInsert(Rec);
    end;

    trigger OnAfterDelete()
    begin
        NotificationEntryHlpWFE.OnAfterDelete(Rec);
    end;

    procedure DeleteNotificationWFE()
    begin
        NotificationEntryHlpWFE.DeleteNotification(Rec);
    end;
}
