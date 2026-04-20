codeunit 83814 "Info Dialog Subscr. WFE"
{
    Access = Internal;
    Permissions =
        tabledata "Info Dialog WFE" = R,
        tabledata "User Setup" = R,
        tabledata Workflow = R;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Info Dialog Helper WFE", OnActivateEventCode, '', false, false)]
    local procedure OnActivateEventCode(var InfoDialog: Record "Info Dialog WFE"; EventCode: Enum "Info Dialog Event Code WFE"; RecordInfo: Codeunit "Record Info WFE")
    begin
        case EventCode of
            EventCode::"Instance ID":
                OpenActiveWorkflow(InfoDialog);
            EventCode::"Workflow Code":
                OpenWorkFlow(InfoDialog);
            EventCode::"User Setup":
                OpenUserSetup(InfoDialog);
            EventCode::"Workflow Step Instance":
                OpenWorkflowStepInstance(RecordInfo.WorkFlowCode());
            EventCode::"Record Restriction":
                OpenRecordRestriction(RecordInfo);
            EventCode::"Approval Entries":
                OpenApprovalEntries(RecordInfo);
        end;
    end;

    local procedure OpenActiveWorkflow(InfoDialog: Record "Info Dialog WFE")
    var
        WorkflowEditor: Codeunit "Workflow Editor WFE";
    begin
        WorkflowEditor.OpenActiveWorkflow(InfoDialog.GetValueAsGuid());
    end;

    local procedure OpenWorkFlow(InfoDialog: Record "Info Dialog WFE")
    var
        Workflow: Record Workflow;
        WorkFlowCode: Code[20];
    begin
        WorkFlowCode := CopyStr(InfoDialog.Value, 1, 20);
        if Workflow.Get(WorkFlowCode) then
            Page.Run(Page::Workflow, Workflow);
    end;

    local procedure OpenUserSetup(InfoDialog: Record "Info Dialog WFE")
    var
        UserSetup: Record "User Setup";
        IDUser: Code[50];
    begin
        IDUser := CopyStr(InfoDialog.Value, 1, 50);
        if UserSetup.Get(IDUser) then
#pragma warning disable AC0006
            Page.Run(Page::"Approval User Setup", UserSetup);
#pragma warning restore AC0006
    end;

    local procedure OpenWorkflowStepInstance(WorkflowCode: Code[20])
    var
        WorkflowStepInstance: Record "Workflow Step Instance";
    begin
        if WorkflowCode = '' then
            exit;

        WorkflowStepInstance.SetRange("Workflow Code", WorkflowCode);
        Page.Run(Page::"Workflow Step Instance WFE", WorkflowStepInstance);
    end;

    local procedure OpenRecordRestriction(var RecordInfo: Codeunit "Record Info WFE")
    var
        Customer: Record Customer;
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchaseHeader: Record "Purchase Header";
        SalesHeader: Record "Sales Header";
        Vendor: Record Vendor;
        SourceRecordRef: RecordRef;
        SourceVariant: Variant;
    begin
        SourceVariant := RecordInfo.SourceRecord();
        SourceRecordRef.GetTable(SourceVariant);
        case SourceRecordRef.Number() of
            Database::Customer:
                begin
                    Customer := SourceRecordRef;
                    Customer.OpenRestrictedRecordWFE();
                end;
            Database::Vendor:
                begin
                    Vendor := SourceRecordRef;
                    Vendor.OpenRestrictedRecordWFE();
                end;
            Database::"Sales Header":
                begin
                    SalesHeader := SourceRecordRef;
                    SalesHeader.OpenRestrictedRecordWFE();
                end;
            Database::"Purchase Header":
                begin
                    PurchaseHeader := SourceRecordRef;
                    PurchaseHeader.OpenRestrictedRecordWFE();
                end;
            Database::"Purch. Inv. Header":
                begin
                    PurchInvHeader := SourceRecordRef;
                    PurchInvHeader.OpenRestrictedRecordWFE();
                end;
            Database::"Purch. Cr. Memo Hdr.":
                begin
                    PurchCrMemoHdr := SourceRecordRef;
                    PurchCrMemoHdr.OpenRestrictedRecordWFE();
                end;
        end;
    end;

    local procedure OpenApprovalEntries(var RecordInfo: Codeunit "Record Info WFE")
    var
        ApprovalMgt: Codeunit "Approval Mgt. WFE";
        SourceRecordRef: RecordRef;
        SourceVariant: Variant;
    begin
        SourceVariant := RecordInfo.SourceRecord();
        SourceRecordRef.GetTable(SourceVariant);
        ApprovalMgt.OpenApprovalEntries(SourceRecordRef.RecordId().TableNo(), SourceRecordRef.RecordId());
    end;
}