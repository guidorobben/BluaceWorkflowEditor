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

    procedure DeleteNotificationsWFE()
    begin
        NotificationEntryHlpWFE.DeleteNotifications(Rec);
    end;

    procedure GetRecordToApproveWFE(): RecordId
    begin
        exit(NotificationEntryHlpWFE.GetRecordToApprove(Rec));
    end;

    procedure RunCurrentNotificationViaDispatcherWFE()
    begin
        NotificationEntryHlpWFE.RunCurrentNotificationViaDispatcher(Rec);
    end;

    procedure RunAllNotificationDispatcherWFE()
    begin
        NotificationEntryHlpWFE.RunAllNotificationDispatcher();
    end;

    procedure ShowRecordToApproveWFE()
    begin
        NotificationEntryHlpWFE.ShowRecordToApprovevar(Rec);
    end;
}
