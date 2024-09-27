codeunit 83807 "Purchase Header Helper WPTE"
{
    Permissions =
        tabledata "Purchase Header" = RM;

    internal procedure SetStatusToOpen(var PurchaseHeader: Record "Purchase Header")
    begin
        SetStatusTo(PurchaseHeader, "Purchase Document Status"::Open);
    end;

    internal procedure SetStatusToPendingApproval(var PurchaseHeader: Record "Purchase Header")
    begin
        SetStatusTo(PurchaseHeader, "Purchase Document Status"::"Pending Approval");
    end;

    internal procedure SetStatusToPendingPrepayment(var PurchaseHeader: Record "Purchase Header")
    begin
        SetStatusTo(PurchaseHeader, "Purchase Document Status"::"Pending Prepayment");
    end;

    internal procedure SetStatusToReleased(var PurchaseHeader: Record "Purchase Header")
    begin
        SetStatusTo(PurchaseHeader, "Purchase Document Status"::"Released");
    end;

    internal procedure SetStatusTo(var PurchaseHeader: Record "Purchase Header"; PurchaseDocumentStatus: enum "Purchase Document Status")
    begin
        TestIsApprovalAdministrator();
        PurchaseHeader.Status := PurchaseDocumentStatus;
        PurchaseHeader.Modify(false);
    end;

    internal procedure AllowRecordUsage(var PurchaseHeader: Record "Purchase Header")
    var
        RecordRestrictionMgt: Codeunit "Record Restriction Mgt.";
    begin
        TestIsApprovalAdministrator();
        RecordRestrictionMgt.AllowRecordUsage(PurchaseHeader);
    end;

    local procedure TestIsApprovalAdministrator(): Boolean
    var
        UserManagement: Codeunit "User Management WPTE";
    begin
        UserManagement.TestIsApprovalAdministrator();
    end;
}