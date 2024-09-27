codeunit 83806 "Approval Entry Helper WPTE"
{
    Permissions =
        tabledata "Approval Entry" = RMD;

    internal procedure DeleteEntry(var ApprovalEntry: Record "Approval Entry")
    var
        ConfirmManagement: Codeunit "Confirm Management";
        DeleteEntryQst: Label 'Delete Enty?';
    begin
        if ConfirmManagement.GetResponseOrDefault(DeleteEntryQst, true) then begin
            TestIsApprovalAdministrator();
            ApprovalEntry.Delete(false);
        end;
    end;

    internal procedure DeleteAllentries(var ApprovalEntry: Record "Approval Entry")
    begin

    end;

    internal procedure SetApprovalEntryToStatusApproved(var ApprovalEntry: Record "Approval Entry");
    begin
        SetApprovalEntryToStatus(ApprovalEntry, "approval status"::Approved);
    end;

    internal procedure SetApprovalEntryToStatusCanceled(var ApprovalEntry: Record "Approval Entry");
    begin
        SetApprovalEntryToStatus(ApprovalEntry, "approval status"::Canceled);
    end;

    internal procedure SetApprovalEntryToStatusCreated(var ApprovalEntry: Record "Approval Entry");
    begin
        SetApprovalEntryToStatus(ApprovalEntry, "approval status"::Created);
    end;

    internal procedure SetApprovalEntryToStatusOpen(var ApprovalEntry: Record "Approval Entry");
    begin
        SetApprovalEntryToStatus(ApprovalEntry, "approval status"::Open);
    end;

    internal procedure SetApprovalEntryToStatusRejected(var ApprovalEntry: Record "Approval Entry");
    begin
        SetApprovalEntryToStatus(ApprovalEntry, "approval status"::Rejected);
    end;

    internal procedure SetApprovalEntryToStatus(var ApprovalEntry: Record "Approval Entry"; ApprovalStatus: enum "Approval Status")
    begin
        TestIsApprovalAdministrator();

        ApprovalEntry.Status := ApprovalStatus;
        ApprovalEntry.Modify(false);
    end;

    local procedure TestIsApprovalAdministrator(): Boolean
    var
        UserManagement: Codeunit "User Management WPTE";
    begin
        UserManagement.TestIsApprovalAdministrator();
    end;
}