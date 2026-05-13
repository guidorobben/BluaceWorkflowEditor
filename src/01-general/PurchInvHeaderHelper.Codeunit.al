codeunit 83815 "Purch. Inv. Header Helper WFE"
{
    Access = Internal;
    Permissions =
        tabledata "Purch. Inv. Header" = RM,
        tabledata "Restricted Record" = R,
        tabledata "User Setup" = R,
        tabledata "Vendor Ledger Entry" = R,
        tabledata Workflow = R,
        tabledata "Workflow Editor Setup WFE" = R,
        tabledata "Workflow Step Instance" = R;

    internal procedure AllowRecordUsage(var PurchInvHeader: Record "Purch. Inv. Header")
    var
        RecordRestrictionMgt: Codeunit "Record Restriction Mgt.";
    begin
        TestIsApprovalAdministrator();
        RecordRestrictionMgt.AllowRecordUsage(PurchInvHeader);
    end;

    local procedure TestIsApprovalAdministrator(): Boolean
    var
        UserManagement: Codeunit "User Management WFE";
    begin
        UserManagement.TestIsApprovalAdministrator();
    end;

    internal procedure ShowApprovalInfo(PurchInvHeader: Record "Purch. Inv. Header")
    var
        Workflow: Record Workflow;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        InfoDialog: Codeunit "Info Dialog WFE";
        RecordInfo: Codeunit "Record Info WFE";
        RestrictionMgt: Codeunit "Restriction Mgt. WFE";
        UserManagement: Codeunit "User Management WFE";
    begin
        RecordInfo.Initialize();
        RecordInfo.SourceRecord(PurchInvHeader);

        InfoDialog.Initialize();
        InfoDialog.RecordInfo(RecordInfo);
        InfoDialog.SetCaption('Approval');
        UserManagement.GetUserInfo(InfoDialog);
        InfoDialog.AddHeader('Purchase Info');
        InfoDialog.Add('OpenApprovalEntriesExist', ApprovalsMgmt.HasOpenApprovalEntries(PurchInvHeader.RecordId()));
        InfoDialog.Add('OpenApprovalEntriesExistForCurrUser', ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(PurchInvHeader.RecordId()));
        InfoDialog.Add('CanCancelApprovalForRecord', ApprovalsMgmt.CanCancelApprovalForRecord(PurchInvHeader.RecordId()));
        Workflow.GetWorkflowInfoWFE(PurchInvHeader.RecordId(), InfoDialog);

        InfoDialog.AddHeader('Purchase Invoice');
        InfoDialog.Add('Record Restriction', RestrictionMgt.RecordHasUsageRestrictions(PurchInvHeader));
        InfoDialog.Add('Vendor Ledger Entries', VendorLedgerEntryCount(PurchInvHeader));
        InfoDialog.Add('Vendor Ledger Entries On Hold', VendorLedgerEntryOnHold(PurchInvHeader));

        InfoDialog.OpenInfoDialog();
    end;

    internal procedure OpenApprovals(var PurchInvHeader: Record "Purch. Inv. Header")
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        ApprovalsMgmt.RunWorkflowEntriesPage(PurchInvHeader.RecordId(), Database::"Purch. Inv. Header", Enum::"Approval Document Type"::Invoice, PurchInvHeader."No.");
    end;

    internal procedure SetStatusToOpen(var PurchInvHeader: Record "Purch. Inv. Header")
    begin
        SetStatusTo(PurchInvHeader, "Purchase Document Status"::Open);
    end;

    internal procedure SetStatusToPendingApproval(var PurchInvHeader: Record "Purch. Inv. Header")
    begin
        SetStatusTo(PurchInvHeader, "Purchase Document Status"::"Pending Approval");
    end;

    internal procedure SetStatusToPendingPrepayment(var PurchInvHeader: Record "Purch. Inv. Header")
    begin
        SetStatusTo(PurchInvHeader, "Purchase Document Status"::"Pending Prepayment");
    end;

    internal procedure SetStatusToReleased(var PurchInvHeader: Record "Purch. Inv. Header")
    begin
        SetStatusTo(PurchInvHeader, "Purchase Document Status"::Released);
    end;

    internal procedure SetStatusTo(var PurchInvHeader: Record "Purch. Inv. Header"; PurchaseDocumentStatus: Enum "Purchase Document Status")
    var
        WorkflowEditorSetup: Record "Workflow Editor Setup WFE";
        PurchInvHeaderRecordRef: RecordRef;
        StatusFieldRef: FieldRef;
    begin
        TestIsApprovalAdministrator();

        WorkflowEditorSetup.SetLoadFields("Posted Purch. Inv. Status ID");
        if not WorkflowEditorSetup.Get() then
            Clear(WorkflowEditorSetup);

        WorkflowEditorSetup.TestField("Posted Purch. Inv. Status ID");

        PurchInvHeaderRecordRef.GetTable(PurchInvHeader);
        StatusFieldRef := PurchInvHeaderRecordRef.Field(WorkflowEditorSetup."Posted Purch. Inv. Status ID");

        case PurchaseDocumentStatus of
            PurchaseDocumentStatus::Open: //0
                StatusFieldRef.Value := 0;
            PurchaseDocumentStatus::Released: //1
                StatusFieldRef.Value := 1;
            PurchaseDocumentStatus::"Pending Approval": //2
                StatusFieldRef.Value := 2;
            PurchaseDocumentStatus::"Pending Prepayment": //3
                StatusFieldRef.Value := 3;
        end;

        PurchInvHeaderRecordRef.Modify(false);
    end;

    internal procedure OpenRestrictedRecord(var PurchInvHeader: Record "Purch. Inv. Header")
    var
        RestrictedRecord: Record "Restricted Record";
    begin
        RestrictedRecord.SetRange("Record ID", PurchInvHeader.RecordId());
        Page.Run(Page::"Restricted Records", RestrictedRecord);
    end;

    local procedure VendorLedgerEntryCount(var PurchInvHeader: Record "Purch. Inv. Header"): Integer
    var
        VendorLedgerEntry: Record "Vendor Ledger Entry";
    begin
        VendorLedgerEntry.SetCurrentKey("Vendor No.", "Posting Date", "Currency Code");
        VendorLedgerEntry.SetRange("Document No.", PurchInvHeader."No.");
        VendorLedgerEntry.SetRange("Posting Date", PurchInvHeader."Posting Date");
        exit(VendorLedgerEntry.Count());
    end;

    local procedure VendorLedgerEntryOnHold(var PurchInvHeader: Record "Purch. Inv. Header"): Code[3]
    var
        VendorLedgerEntry: Record "Vendor Ledger Entry";
    begin
        VendorLedgerEntry.SetCurrentKey("Vendor No.", "Posting Date", "Currency Code");
        VendorLedgerEntry.SetRange("Document No.", PurchInvHeader."No.");
        VendorLedgerEntry.SetRange("Posting Date", PurchInvHeader."Posting Date");
        VendorLedgerEntry.SetFilter("On Hold", '<>%1', '');
        VendorLedgerEntry.SetLoadFields("On Hold");
        if VendorLedgerEntry.FindFirst() then
            exit(VendorLedgerEntry."On Hold");
    end;
}