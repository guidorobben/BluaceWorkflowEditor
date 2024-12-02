page 83806 "Approval Entry Part WPE"
{
    ApplicationArea = All;
    Caption = 'Approval Entry Part WPE';
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
            }
        }
    }

    var
        CurrNotificationEntry: Record "Notification Entry";
        RecipientEmailAddress: Text;
        JobQueueEntryNotificationCount: Integer;

    trigger OnAfterGetCurrRecord()
    begin
        GetRecipientEmailAddress();
        JobQueueEntryNotificationCount := NotificationJobQueueEntriesCount();
    end;


    local procedure GetRecipientEmailAddress(): Text
    var
        UserSetup: Record "User Setup";
    begin
        if not UserSetup.Get(CurrNotificationEntry."Recipient User ID") then
            Clear(UserSetup);

        RecipientEmailAddress := UserSetup."E-Mail";
    end;

    procedure SetNotification(NotificationEntry: Record "Notification Entry")
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
}