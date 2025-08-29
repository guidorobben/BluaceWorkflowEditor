page 83806 "Approval Entry Part WFE"
{
    ApplicationArea = All;
    Caption = 'Approval Entry Part';
    PageType = CardPart;
    Permissions =
        tabledata "Approval Entry" = RIMD,
        tabledata "Notification Entry" = R,
        tabledata "User Setup" = R;
    SourceTable = "Approval Entry";
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the approval status for the entry.';
                }
                field("Record ID to Approve"; Format(Rec."Record ID to Approve"))
                {
                    Caption = 'Record to Approve';
                    ToolTip = 'Specifies the value of the Record ID to Approve field.', Comment = '%';
                }
                field(RecepientEmailAddressControl; RecipientEmailAddress)
                {
                    Caption = 'Recepient Email Address';
                }
                field(JobQueueEntryNotificationCountControl; JobQueueEntryNotificationCount)
                {
                    Caption = 'Job Queue Entries';
                }
                field(PostedNotificationEntries; SendNotificationEntries)
                {
                    Caption = 'Posted Notification Entries';
                }
            }
        }
    }

    var
        CurrNotificationEntry: Record "Notification Entry";
        JobQueueEntryNotificationCount: Integer;
        SendNotificationEntries: Integer;
        RecipientEmailAddress: Text;

    trigger OnAfterGetCurrRecord()
    begin
        GetRecipientEmailAddress();
        JobQueueEntryNotificationCount := NotificationJobQueueEntriesCount();
        SendNotificationEntries := SendNotificationCount();
    end;

    local procedure GetRecipientEmailAddress(): Text
    var
        UserSetup: Record "User Setup";
    begin
        if not UserSetup.Get(CurrNotificationEntry."Recipient User ID") then
            Clear(UserSetup);

        RecipientEmailAddress := UserSetup."E-Mail";
    end;

    procedure SetNotificationEntry(NotificationEntry: Record "Notification Entry")
    begin
        CurrNotificationEntry := NotificationEntry;
    end;

    local procedure NotificationJobQueueEntriesCount(): Integer
    var
        JobQueueEntry: Record "Job Queue Entry";
    begin
        JobQueueEntry.SetRange("Object Type to Run", JobQueueEntry."Object Type to Run"::Codeunit);
        JobQueueEntry.SetRange("Object ID to Run", Codeunit::"Notification Entry Dispatcher");
        JobQueueEntry.SetRange("User ID", CurrNotificationEntry."Created By");
        exit(JobQueueEntry.Count());
    end;

    local procedure SendNotificationCount(): Integer
    var
        SentNotificationEntry: Record "Sent Notification Entry";
    begin
        SentNotificationEntry.SetRange("Recipient User ID", CurrNotificationEntry."Recipient User ID");
        exit(SentNotificationEntry.Count());
    end;
}