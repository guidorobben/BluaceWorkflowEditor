codeunit 83807 "Purchase Header Helper WFE"
{
    Permissions =
        tabledata "Purchase Header" = RM,
        tabledata "User Setup" = R,
        tabledata "Vendor Ledger Entry" = R,
        tabledata Workflow = R,
        tabledata "Workflow Step Instance" = R;

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
        SetStatusTo(PurchaseHeader, "Purchase Document Status"::Released);
    end;

    internal procedure SetStatusTo(var PurchaseHeader: Record "Purchase Header"; PurchaseDocumentStatus: Enum "Purchase Document Status")
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

    internal procedure RestrictRecordUsage(var PurchaseHeader: Record "Purchase Header")
    var
        RecordRestrictionMgt: Codeunit "Record Restriction Mgt.";
    begin
        TestIsApprovalAdministrator();
        RecordRestrictionMgt.RestrictRecordUsage(PurchaseHeader, 'Manual restriction by user');
    end;

    local procedure TestIsApprovalAdministrator(): Boolean
    var
        UserManagement: Codeunit "User Management WFE";
    begin
        UserManagement.TestIsApprovalAdministrator();
    end;

    internal procedure ShowApprovalInfo(var PurchaseHeader: Record "Purchase Header")
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        InfoDialog: Codeunit "Info Dialog WFE";
        RestrictionMgt: Codeunit "Restriction Mgt. WFE";
        UserManagement: Codeunit "User Management WFE";
        WorkflowHelper: Codeunit "Workflow Helper WFE";
        RecordInfo: Codeunit "Record Info WFE";
    begin
        RecordInfo.Initialize();
        RecordInfo.SourceRecord(PurchaseHeader);

        InfoDialog.Initialize();
        InfoDialog.RecordInfo(RecordInfo);
        InfoDialog.SetCaption('Approval');
        UserManagement.GetUserInfo(InfoDialog);
        InfoDialog.AddHeader('Purchase Info');
        InfoDialog.Add('OpenApprovalEntriesExist', ApprovalsMgmt.HasOpenApprovalEntries(PurchaseHeader.RecordId()));
        InfoDialog.Add('OpenApprovalEntriesExistForCurrUser', ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(PurchaseHeader.RecordId()));
        InfoDialog.Add('CanCancelApprovalForRecord', ApprovalsMgmt.CanCancelApprovalForRecord(PurchaseHeader.RecordId()));
        WorkflowHelper.GetWorkflowInfo(PurchaseHeader.RecordId(), InfoDialog);
        InfoDialog.AddHeader('Posting');
        InfoDialog.Add('Record Restriction', RestrictionMgt.RecordHasUsageRestrictions(PurchaseHeader), "Info Dialog Event Code WFE"::"Record Restriction");
        InfoDialog.Add('On Hold (Header)', PurchaseHeader."On Hold");
        InfoDialog.Add('On Hold (Vendor)', HasOnHoldVendorLedgerEntry(PurchaseHeader));
        InfoDialog.OpenInfoDialog();
    end;

    local procedure HasOnHoldVendorLedgerEntry(var PurchaseHeader: Record "Purchase Header"): Boolean
    begin
        if PurchaseHeader."No." = '' then
            exit;

        case PurchaseHeader."Document Type" of
            PurchaseHeader."Document Type"::Invoice:
                exit(HasOnHoldVendorLedgerEntry("Gen. Journal Document Type"::Invoice, PurchaseHeader."No."));
            PurchaseHeader."Document Type"::"Credit Memo":
                exit(HasOnHoldVendorLedgerEntry("Gen. Journal Document Type"::"Credit Memo", PurchaseHeader."No."));
        end;
    end;

    local procedure HasOnHoldVendorLedgerEntry(DocumentType: Enum "Gen. Journal Document Type"; DocumentNo: Code[20]): Boolean
    var
        VendorLedgerEntry: Record "Vendor Ledger Entry";
    begin
        VendorLedgerEntry.SetRange("Document Type", DocumentType);
        VendorLedgerEntry.SetRange("Document No.", DocumentNo);
        VendorLedgerEntry.SetFilter("On Hold", '<>%1', '');
        exit(not VendorLedgerEntry.IsEmpty());
    end;

    internal procedure ClearOnHoldVendorLedgerEntries(var PurchaseHeader: Record "Purchase Header")
    begin
        if PurchaseHeader."No." = '' then
            exit;

        case PurchaseHeader."Document Type" of
            PurchaseHeader."Document Type"::Invoice:
                ClearOnHoldVendorLedgerEntries("Gen. Journal Document Type"::Invoice, PurchaseHeader."No.");
            PurchaseHeader."Document Type"::"Credit Memo":
                ClearOnHoldVendorLedgerEntries("Gen. Journal Document Type"::"Credit Memo", PurchaseHeader."No.");
        end;
    end;

    internal procedure ClearOnHoldVendorLedgerEntries(DocumentType: Enum "Gen. Journal Document Type"; DocumentNo: Code[20])
    var
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        VendEntryEdit: Codeunit "Vend. Entry-Edit";
    begin
        VendorLedgerEntry.SetRange("Document Type", DocumentType);
        VendorLedgerEntry.SetRange("Document No.", DocumentNo);
        VendorLedgerEntry.SetRange("On Hold", '');
        if VendorLedgerEntry.FindSet() then
            repeat
                VendEntryEdit.SetOnHold(VendorLedgerEntry, '');
            until VendorLedgerEntry.Next() = 0;
    end;

    // local procedure GetWorkflowInfo(var PurchaseHeader: Record "Purchase Header"; var InfoDialog: Codeunit "Info Dialog WFE")
    // var
    //     Workflow: Record Workflow;
    //     WorkflowStepInstance: Record "Workflow Step Instance";
    //     WorkFlowCode: Code[20];
    //     InfoDialogEventCode: Enum "Info Dialog Event Code WFE";
    //     InstanceID: Guid;
    //     WorkflowDescription: Text[100];
    // begin
    //     WorkflowStepInstance.SetRange("Record ID", PurchaseHeader.RecordId);
    //     if WorkflowStepInstance.FindFirst() then begin
    //         InstanceID := WorkflowStepInstance.ID;
    //         WorkFlowCode := WorkflowStepInstance."Workflow Code";
    //         if Workflow.Get(WorkFlowCode) then
    //             WorkflowDescription := Workflow.Description;
    //     end;

    //     InfoDialog.AddHeader('Workflow');
    //     InfoDialog.Add('ID', InstanceID, InfoDialogEventCode::INSTANCEID);
    //     InfoDialog.Add('Code', WorkFlowCode, InfoDialogEventCode::WORKFLOWCODE);
    //     InfoDialog.Add('Description', WorkflowDescription);
    // end;

    internal procedure OpenRestrictedRecord(var PurchaseHeader: Record "Purchase Header")
    var
        RestrictedRecord: Record "Restricted Record";
    begin
        RestrictedRecord.SetRange("Record ID", PurchaseHeader.RecordId());
        Page.Run(Page::"Restricted Records", RestrictedRecord);
    end;
}