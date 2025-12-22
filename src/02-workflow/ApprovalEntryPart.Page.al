page 83806 "Approval Entry Part WFE"
{
    ApplicationArea = All;
    Caption = 'Approval Entry Part';
    PageType = CardPart;
    Permissions =
        tabledata "Approval Entry" = RIMD,
        tabledata "Job Queue Entry" = R,
        tabledata "Notification Entry" = R,
        tabledata "Overdue Approval Entry" = R,
        tabledata "Sent Notification Entry" = R,
        tabledata "User Setup" = R;
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field(ApprovalStatus; ApprovalStatus)
                {
                    Caption = 'Approval Status';
                    ToolTip = 'Specifies the approval status for the entry.';

                    trigger OnDrillDown()
                    var
                        ApprovalEntry: Record "Approval Entry";
                        PageManagement: Codeunit "Page Management";
                    begin
                        if GetApprovalEntry(CurrNotificationEntry, ApprovalEntry) then
                            PageManagement.PageRun(ApprovalEntry);
                    end;
                }
                field(RecordToApprove; Format(RecordToApprove))
                {
                    Caption = 'Record to Approve';
                    ToolTip = 'Specifies the value of the Record ID to Approve field.';

                    trigger OnDrillDown()
                    var
                        PageManagement: Codeunit "Page Management";
                    begin
                        PageManagement.PageRun(RecordToApprove);
                    end;

                }
                field(RecepientEmailAddressControl; RecipientEmailAddress)
                {
                    Caption = 'Recepient Email Address';
                }
                // field(JobQueueEntryNotificationCountControl; JobQueueEntryNotificationCount)
                // {
                //     Caption = 'Job Queue Entries';
                // }
                // field(PostedNotificationEntries; SendNotificationEntries)
                // {
                //     Caption = 'Posted Notification Entries';
                // }
            }
        }
    }

    var
        CurrNotificationEntry: Record "Notification Entry";
        RecordToApprove: RecordId;
        ApprovalStatus: Enum "Approval Status";
        JobQueueEntryNotificationCount: Integer;
        // SendNotificationEntries: Integer;
        RecipientEmailAddress: Text;

    trigger OnAfterGetCurrRecord()
    begin
        GetData();
    end;

    procedure GetData()
    begin
        GetRecipientEmailAddress();
        JobQueueEntryNotificationCount := NotificationJobQueueEntriesCount();
        // SendNotificationEntries := SendNotificationCount();
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
    var
        ApprovalEntry: Record "Approval Entry";
        OverdueApprovalEntry: Record "Overdue Approval Entry";
        UserManagement: Codeunit "User Management WFE";
        FoundRecord: Boolean;
    begin
        if not UserManagement.IsApprovalAdministrator() then
            exit;

        CurrNotificationEntry := NotificationEntry;
        case NotificationEntry.Type of
            NotificationEntry.Type::Approval:
                if GetApprovalEntry(NotificationEntry, ApprovalEntry) then begin
                    FoundRecord := true;
                    ApprovalStatus := ApprovalEntry.Status;
                    RecordToApprove := ApprovalEntry."Record ID to Approve";
                end;
            NotificationEntry.Type::"New Record":
                begin
                    RecordToApprove := NotificationEntry."Triggered By Record";
                    FoundRecord := true;
                end;
            NotificationEntry.Type::Overdue:
                if GetOverdueApprovalEntry(NotificationEntry, OverdueApprovalEntry) then begin
                    FoundRecord := true;
                    ApprovalStatus := ApprovalStatus::" ";
                    RecordToApprove := OverdueApprovalEntry."Record ID to Approve";
                end;
        end;

        if not FoundRecord then
            ClearData();
        CurrPage.Update(false);
    end;

    local procedure GetApprovalEntry(var NotificationEntry: Record "Notification Entry"; var ApprovalEntry: Record "Approval Entry"): Boolean
    begin
        if ApprovalEntry.Get(NotificationEntry."Triggered By Record") then
            exit(true);
    end;


    local procedure GetOverdueApprovalEntry(var NotificationEntry: Record "Notification Entry"; var OverdueApprovalEntry: Record "Overdue Approval Entry"): Boolean
    begin
        if OverdueApprovalEntry.Get(NotificationEntry."Triggered By Record") then
            exit(true);
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

    // local procedure SendNotificationCount(): Integer
    // var
    //     SentNotificationEntry: Record "Sent Notification Entry";
    // begin
    //     SentNotificationEntry.SetRange("Recipient User ID", CurrNotificationEntry."Recipient User ID");
    //     exit(SentNotificationEntry.Count());
    // end;

    local procedure ClearData()
    begin
        ApprovalStatus := ApprovalStatus::" ";
        RecipientEmailAddress := '';
        JobQueueEntryNotificationCount := 0;
        // SendNotificationEntries := 0;
        Clear(RecordToApprove);
    end;
}