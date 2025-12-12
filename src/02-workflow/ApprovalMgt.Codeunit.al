codeunit 83823 "Approval Mgt. WFE"
{
    procedure OpenApprovalEntries(TableID: Integer; SourceRecordID: RecordId)
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        if TableID = 0 then
            exit;

        ApprovalEntry.SetRange("Table ID", TableID);
        ApprovalEntry.SetRange("Record ID to Approve", SourceRecordID);
        Page.RunModal(Page::"Approval Entries WFE", ApprovalEntry);
    end;

    procedure ApprovalEntriesCount(TableID: Integer; SourceRecordID: RecordId): Integer
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        if TableID = 0 then
            exit;

        ApprovalEntry.SetRange("Table ID", TableID);
        ApprovalEntry.SetRange("Record ID to Approve", SourceRecordID);
        exit(ApprovalEntry.Count())
    end;

    procedure ApprovalEntriesCount(TableID: Integer; SourceRecordID: RecordId; Status: Enum "Approval Status"): Integer
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        if TableID = 0 then
            exit;

        ApprovalEntry.SetRange("Table ID", TableID);
        ApprovalEntry.SetRange("Record ID to Approve", SourceRecordID);
        ApprovalEntry.SetRange(Status, Status);
        exit(ApprovalEntry.Count())
    end;
}