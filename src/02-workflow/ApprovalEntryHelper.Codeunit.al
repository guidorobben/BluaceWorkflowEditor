codeunit 83806 "Approval Entry Helper WFE"
{
    Permissions = tabledata "Approval Entry" = RMD;

    internal procedure DeleteEntry(var ApprovalEntry: Record "Approval Entry")
    var
        ConfirmManagement: Codeunit "Confirm Management";
        DeleteEntryQst: Label 'Delete current Enty?';
    begin
        if ConfirmManagement.GetResponseOrDefault(DeleteEntryQst, true) then begin
            TestIsApprovalAdministrator();
            ApprovalEntry.Delete(false);
        end;
    end;

    internal procedure SetMeAsApprover(var ApprovalEntry: Record "Approval Entry")
    begin
        TestIsApprovalAdministrator();
        ApprovalEntry."Approver ID" := UserId();
        ApprovalEntry.Modify(false);
    end;

    internal procedure SetApprovalEntryToStatusApproved(var ApprovalEntry: Record "Approval Entry")
    begin
        SetApprovalEntryToStatus(ApprovalEntry, "Approval Status"::Approved);
    end;

    internal procedure SetApprovalEntryToStatusCanceled(var ApprovalEntry: Record "Approval Entry")
    begin
        SetApprovalEntryToStatus(ApprovalEntry, "Approval Status"::Canceled);
    end;

    internal procedure SetApprovalEntryToStatusCreated(var ApprovalEntry: Record "Approval Entry")
    begin
        SetApprovalEntryToStatus(ApprovalEntry, "Approval Status"::Created);
    end;

    internal procedure SetApprovalEntryToStatusOpen(var ApprovalEntry: Record "Approval Entry")
    begin
        SetApprovalEntryToStatus(ApprovalEntry, "Approval Status"::Open);
    end;

    internal procedure SetApprovalEntryToStatusRejected(var ApprovalEntry: Record "Approval Entry")
    begin
        SetApprovalEntryToStatus(ApprovalEntry, "Approval Status"::Rejected);
    end;

    internal procedure SetApprovalEntryToStatus(var ApprovalEntry: Record "Approval Entry"; ApprovalStatus: Enum "Approval Status")
    begin
        TestIsApprovalAdministrator();

        ApprovalEntry.Status := ApprovalStatus;
        ApprovalEntry.Modify(false);
    end;

    local procedure TestIsApprovalAdministrator(): Boolean
    var
        UserManagement: Codeunit "User Management WFE";
    begin
        UserManagement.TestIsApprovalAdministrator();
    end;
}