report 83800 "Resend Purch. Appr. Req. WFE"
{
    ApplicationArea = All;
    Caption = 'Resend Purchase Header Approval Request';
    Permissions =
        tabledata "Approval Entry" = R,
        tabledata "Purchase Header" = RM,
        tabledata "Vendor Ledger Entry" = RM;
    ProcessingOnly = true;
    UsageCategory = Tasks;

    dataset
    {
        dataitem(PurchHeader; "Purchase Header")
        {
            DataItemTableView = where(Status = filter(Released | Open | "Pending Approval"));
            RequestFilterFields = "Amount Including VAT", Status, "No.", "Buy-from Vendor No.";

            trigger OnAfterGetRecord()
            begin
                if Status = Status::Open then
                    ProcessOpenPurchaseHeader(PurchHeader);

                if Status = Status::"Pending Approval" then
                    ProcessPendingApprovalPurchaseHeader(PurchHeader);

                if Status = Status::Released then
                    ProcessReleasedPurchaseInvHeader(PurchHeader);
            end;
        }
    }

    trigger OnPreReport()
    var
        FilterErr: Label 'Enter filter for Amount including VAT.';
    begin
        if PurchHeader.GetFilter("Amount Including VAT") = '' then
            Error(FilterErr);

        TestIsApprovalAdministrator();
    end;

    local procedure ProcessReleasedPurchaseInvHeader(PurchaseHeader: Record "Purchase Header")
    var
        DocumentType: Enum "Gen. Journal Document Type";
    begin
        if not HasOpenApprovalEntries(PurchaseHeader) then begin
            RemoveOnHold(PurchaseHeader);
            SetToStatusPendingReleased(PurchaseHeader);
            ClearOnHoldVendorLedgerEntry(DocumentType::Invoice, PurchaseHeader."No.");
            exit;
        end;

        ReopenPurchaseDocument(PurchaseHeader);
        // SetOnHold(PurchInvHeader);
        SendApprovalRequest(PurchaseHeader);
    end;

    procedure ReopenPurchaseDocument(var PurchaseHeader: Record "Purchase Header")
    begin
        if PurchaseHeader.Status <> PurchaseHeader.Status::Released then
            exit;

        PurchaseHeader.Validate(Status, PurchaseHeader.Status::Open);
        PurchaseHeader.Modify(true);
    end;

    // local procedure SetOnHold(var PurchInvHeader: Record "Purchase Header")
    // var
    //     DocumentType: Enum "Gen. Journal Document Type";
    // begin
    //     // SetOnHoldVendorLedgerEntry(DocumentType::Invoice, PurchInvHeader."No.");
    //     // PurchInvHeader.Validate("On Hold", CustSpecificSetup."Vendor Ledg. Entry On Hold");
    //     // PurchInvHeader.Modify(true);
    // end;

    local procedure RemoveOnHold(var PurchaseHeader: Record "Purchase Header")
    begin
        if PurchaseHeader."On Hold" = '' then
            exit;

        PurchaseHeader.Validate("On Hold", '');
        PurchaseHeader.Modify(true);
    end;

    // local procedure RemoveOnHold(var PurchInvHeader: Record "Purch. InvHeader")
    // begin
    //     if PurchInvHeader."On Hold" = '' then
    //         exit;

    //     PurchInvHeader.Validate("On Hold", '');
    //     PurchInvHeader.Modify(true);
    // end;

    local procedure SendApprovalRequest(var PurchaseHeader: Record "Purchase Header")
    // begin
    //     PurchaseHeader.SendApprovalRequest()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        if ApprovalsMgmt.CheckPurchaseApprovalPossible(PurchaseHeader) then
            ApprovalsMgmt.OnSendPurchaseDocForApproval(PurchaseHeader);
    end;

    // local procedure SetOnHoldVendorLedgerEntry(DocumentType: Enum "Gen. Journal Document Type"; DocumentNo: Code[20])
    // var
    //     CurrentVendorLedgerEntry, VendorLedgerEntry : Record "Vendor Ledger Entry";
    //     VendEntryEdit: Codeunit "Vend. Entry-Edit";
    // begin
    //     VendorLedgerEntry.SetRange("Document Type", DocumentType);
    //     VendorLedgerEntry.SetRange("Document No.", DocumentNo);
    //     if VendorLedgerEntry.FindSet() then
    //         repeat
    //             CurrentVendorLedgerEntry := VendorLedgerEntry;
    //             VendEntryEdit.SetOnHold(CurrentVendorLedgerEntry, CustSpecificSetup."Vendor Ledg. Entry On Hold");
    //         until VendorLedgerEntry.Next() = 0;
    // end;

    local procedure ProcessOpenPurchaseHeader(PurchaseHeader: Record "Purchase Header")
    begin
        if not HasOpenApprovalEntries(PurchaseHeader) then begin
            SetToStatusPendingReleased(PurchaseHeader);
            exit;
        end;

        SetToStatusPendingApproval(PurchaseHeader);
        RemoveOnHold(PurchaseHeader);
    end;

    local procedure ProcessPendingApprovalPurchaseHeader(PurchaseHeader: Record "Purchase Header")
    var
        DocumentType: Enum "Gen. Journal Document Type";
    begin
        if not HasOpenApprovalEntries(PurchaseHeader) then begin
            RemoveOnHold(PurchaseHeader);
            SetToStatusPendingReleased(PurchaseHeader);
            ClearOnHoldVendorLedgerEntry(DocumentType::Invoice, PurchaseHeader."No.");
        end;
    end;

    local procedure ClearOnHoldVendorLedgerEntry(DocumentType: Enum "Gen. Journal Document Type"; DocumentNo: Code[20])
    var
        CurrentVendorLedgerEntry, VendorLedgerEntry : Record "Vendor Ledger Entry";
        VendEntryEdit: Codeunit "Vend. Entry-Edit";
    begin
        VendorLedgerEntry.SetRange("Document Type", DocumentType);
        VendorLedgerEntry.SetRange("Document No.", DocumentNo);
        // VendorLedgerEntry.SetRange("On Hold", CustSpecificSetup."Vendor Ledg. Entry On Hold");
        if VendorLedgerEntry.FindSet() then
            repeat
                CurrentVendorLedgerEntry := VendorLedgerEntry;
                VendEntryEdit.SetOnHold(CurrentVendorLedgerEntry, '');
            until VendorLedgerEntry.Next() = 0;
    end;

    local procedure SetToStatusPendingApproval(var PurchaseHeader: Record "Purchase Header")
    begin
        if PurchaseHeader.Status = PurchaseHeader.Status::"Pending Approval" then
            exit;

        PurchaseHeader.Validate(Status, PurchaseHeader.Status::"Pending Approval");
        PurchaseHeader.Modify(true);
    end;

    local procedure SetToStatusPendingReleased(var PurchaseHeader: Record "Purchase Header")
    begin
        if PurchaseHeader.Status = PurchaseHeader.Status::Released then
            exit;

        PurchaseHeader.Validate(Status, PurchaseHeader.Status::Released);
        PurchaseHeader.Modify(true);
    end;

    local procedure HasOpenApprovalEntries(PurchaseHeader: Record "Purchase Header"): Boolean
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        ApprovalEntry.SetCurrentKey("Table ID", "Document Type", "Document No.", "Date-Time Sent for Approval");
        ApprovalEntry.SetRange("Table ID", PurchaseHeader.RecordId.TableNo);
        ApprovalEntry.SetRange("Document Type", ApprovalEntry."Document Type"::Invoice);
        ApprovalEntry.SetRange("Document No.", PurchaseHeader."No.");
        ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
        exit(not ApprovalEntry.IsEmpty());
    end;

    local procedure TestIsApprovalAdministrator(): Boolean
    var
        UserManagement: Codeunit "User Management WFE";
    begin
        UserManagement.TestIsApprovalAdministrator();
    end;
}