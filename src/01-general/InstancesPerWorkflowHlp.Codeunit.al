codeunit 83833 "Instances Per Workflow Hlp WFE"
{
    Access = Internal;
    Permissions =
        tabledata "Instances Per Workflow WFE" = r,
        tabledata Workflow = r;


    procedure BuildBuffer(var TempInstancesPerWorkflow: Record "Instances Per Workflow WFE" temporary)
    var
        WorkflowStepInstance: Record "Workflow Step Instance";
        EntryNo: Integer;
    begin
        WorkflowStepInstance.SetRange("Entry Point", true);
        if WorkflowStepInstance.FindSet() then
            repeat
                EntryNo += 1;

                TempInstancesPerWorkflow.Init();
                TempInstancesPerWorkflow."Entry No." := EntryNo;
                TempInstancesPerWorkflow."Instance ID" := WorkflowStepInstance.ID;
                TempInstancesPerWorkflow."Workflow Code" := WorkflowStepInstance."Workflow Code";
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
    begin
        DocumentRecordRef := InstancesPerWorkflow."Record ID".GetRecord();
        DocumentRecordRef.Find('=');
        PageManagement.PageRun(DocumentRecordRef);
    end;

    procedure GetDocumentStatus(DocumentRecordID: RecordId): Enum "Purchase Document Status"
    var
        DocumentRecordRef: RecordRef;
    begin
        DocumentRecordRef := DocumentRecordID.GetRecord();
        DocumentRecordRef.Find('=');
        case DocumentRecordRef.Number() of
            Database::"Purchase Header":
                begin
                    // message(format(DocumentRecordRef.Field('Status').Value()));
                    exit(DocumentRecordRef.Field('Status').Value());
                end;
        end;
    end;
}