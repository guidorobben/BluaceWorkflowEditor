codeunit 83833 "Instances Per Workflow Hlp WFE"
{
    Access = Internal;
    Permissions =
        tabledata "Instances Per Workflow WFE" = r,
        tabledata Workflow = r,
        tabledata "Workflow Editor Setup WFE" = r,
        tabledata "Workflow Step Instance" = r;


    procedure BuildBuffer(var TempInstancesPerWorkflow: Record "Instances Per Workflow WFE" temporary)
    var
        Workflow: Record Workflow;
        WorkflowStepInstance: Record "Workflow Step Instance";
        EntryNo: Integer;
    begin
        WorkflowStepInstance.SetRange("Entry Point", true);
        WorkflowStepInstance.SetLoadFields("Created By User ID", "Created Date-Time", ID, "Record ID", "Workflow Code");
        if WorkflowStepInstance.FindSet() then
            repeat
                Workflow.SetLoadFields(Category, Enabled);
                if not Workflow.Get(WorkflowStepInstance."Workflow Code") then
                    Clear(Workflow);

                EntryNo += 1;

                TempInstancesPerWorkflow.Init();
                TempInstancesPerWorkflow."Entry No." := EntryNo;
                TempInstancesPerWorkflow."Instance ID" := WorkflowStepInstance.ID;
                TempInstancesPerWorkflow."Workflow Code" := WorkflowStepInstance."Workflow Code";
                TempInstancesPerWorkflow.Category := Workflow.Category;
                TempInstancesPerWorkflow."Workflow Enabled" := Workflow.Enabled;
                TempInstancesPerWorkflow."Record ID" := WorkflowStepInstance."Record ID";
                TempInstancesPerWorkflow."Document Status" := GetDocumentStatus(WorkflowStepInstance."Record ID");
                TempInstancesPerWorkflow."Created By User ID" := WorkflowStepInstance."Created By User ID";
                TempInstancesPerWorkflow."Created Date-Time" := WorkflowStepInstance."Created Date-Time";
                TempInstancesPerWorkflow.Insert(false);
            until WorkflowStepInstance.Next() = 0;

        if TempInstancesPerWorkflow.FindFirst() then; // Pointer
    end;

    procedure WorkflowCodeOnDrillDown(var InstancesPerWorkflow: Record "Instances Per Workflow WFE")
    var
        WorkFlow: Record Workflow;
    begin
        if not WorkFlow.Get(InstancesPerWorkflow."Workflow Code") then
            exit;

        Page.Run(Page::Workflow, WorkFlow);
    end;

    procedure OpenDocument(var InstancesPerWorkflow: Record "Instances Per Workflow WFE")
    var
        PageManagement: Codeunit "Page Management";
        DocumentRecordRef: RecordRef;
        DocumentDoesNotExistErr: Label 'Document does not exist.';
    begin
        DocumentRecordRef := InstancesPerWorkflow."Record ID".GetRecord();
        if not DocumentRecordRef.FindFirst() then
            Error(ErrorInfo.Create(DocumentDoesNotExistErr));

        PageManagement.PageRun(DocumentRecordRef);
    end;

    procedure GetDocumentStatus(DocumentRecordID: RecordId) DocumentStatus: Enum "Purchase Document Status"
    var
        WorkflowEditorSetup: Record "Workflow Editor Setup WFE";
        DocumentRecordRef: RecordRef;
    begin
        DocumentStatus := DocumentStatus::Open;

        DocumentRecordRef := DocumentRecordID.GetRecord();
#pragma warning disable PC0030
        if not DocumentRecordRef.FindFirst() then
#pragma warning restore PC0030
            exit;

        case DocumentRecordRef.Number() of
            Database::"Purchase Header":
                exit(DocumentRecordRef.Field('Status').Value());
            Database::"Purch. Inv. Header",
            Database::"Purch. Cr. Memo Hdr.":
                begin
                    if not WorkflowEditorSetup.Get() then
                        exit;

                    if WorkflowEditorSetup."Posted Purch. Inv. Status ID" = 0 then
                        exit;

                    exit(DocumentRecordRef.Field(WorkflowEditorSetup."Posted Purch. Inv. Status ID").Value());
                end;
        end;
    end;

    procedure OpenWorkflowStepInstances(var InstancesPerWorkflow: Record "Instances Per Workflow WFE")
    var
        WorkflowStepInstance: Record "Workflow Step Instance";
    begin
        WorkflowStepInstance.SetRange(ID, InstancesPerWorkflow."Instance ID");
        Page.Run(Page::"Workflow Step Instances WFE", WorkflowStepInstance);
    end;
}