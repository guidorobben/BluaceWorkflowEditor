codeunit 83823 "Approval Mgt. WFE"
{
    Access = Internal;

    procedure OpenApprovalEntries(TableID: Integer; SourceRecordID: RecordId)
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        if TableID = 0 then
            exit;

        ApprovalEntry.SetRange("Table ID", TableID);
        ApprovalEntry.SetRange("Record ID to Approve", SourceRecordID);
#pragma warning disable AC0006
        Page.RunModal(Page::"Approval Entries WFE", ApprovalEntry);
#pragma warning restore AC0006
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

    procedure ApprovalEntriesCount(TableID: Integer; SourceRecordID: RecordId; Status: Enum "Approval Status"; Overdue: Boolean): Integer
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        if TableID = 0 then
            exit;

        ApprovalEntry.SetRange("Table ID", TableID);
        ApprovalEntry.SetRange("Record ID to Approve", SourceRecordID);
        ApprovalEntry.SetRange(Status, Status);
        if Overdue then
            ApprovalEntry.SetFilter("Due Date", '<%1', Today());
        exit(ApprovalEntry.Count())
    end;
}