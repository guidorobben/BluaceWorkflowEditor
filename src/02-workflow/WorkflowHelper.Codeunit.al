codeunit 83803 "Workflow Helper WFE"
{
    Permissions =
        tabledata Workflow = RM,
        tabledata "Workflow Step" = R,
        tabledata "Workflow Step Instance" = R;

    internal procedure GetFunctionName(WorkflowCode: Code[20]; StepId: Integer): Text[100]
    var
        WorkflowStep: Record "Workflow Step";
    begin
        WorkflowStep.SetRange("Workflow Code", WorkflowCode);
        WorkflowStep.SetRange(ID, StepId);
        if WorkflowStep.FindFirst() then
            exit(WorkflowStep."Function Name");
    end;

    internal procedure EnableWorkflow(var Workflow: Record Workflow)
    begin
        Workflow.Validate(Enabled, true);
        Workflow.Modify(true);
    end;

    internal procedure ToggleEnableWorkflow(var Workflow: Record Workflow)
    begin
        Workflow.Validate(Enabled, not Workflow.Enabled);
        Workflow.Modify(true);
    end;

    internal procedure SetToWorkflow(var Workflow: Record Workflow)
    var
        ConfirmManagement: Codeunit "Confirm Management";
        ConvertToWorkflowQst: Label 'Do you want to convert the workflow template to a workflow?';
    begin
        if ConfirmManagement.GetResponse(ConvertToWorkflowQst, false) then begin
            Workflow.TestField(Enabled, false);
            Workflow.Validate(Template, false);
            Workflow.Modify(true);
        end;
    end;

    internal procedure SetToWorkflowTemplate(var Workflow: Record Workflow)
    var
        ConfirmManagement: Codeunit "Confirm Management";
        ConvertToWorkflowTemplateQst: Label 'Do you want to convert the workflow to a workflow template?';
    begin
        if ConfirmManagement.GetResponse(ConvertToWorkflowTemplateQst, false) then begin
            Workflow.TestField(Enabled, false);
            Workflow.Validate(Template, true);
        end;
    end;

    internal procedure GetWorkflowInfo(SourceRecordId: RecordId; var InfoDialog: Codeunit "Info Dialog WFE")
    var
        Workflow: Record Workflow;
        WorkflowStepInstance: Record "Workflow Step Instance";
        WorkFlowCode: Code[20];
        InstanceID: Guid;
        WorkflowDescription: Text[100];
    begin
        WorkflowStepInstance.SetRange("Record ID", SourceRecordId);
        if WorkflowStepInstance.FindFirst() then begin
            InstanceID := WorkflowStepInstance.ID;
            WorkFlowCode := WorkflowStepInstance."Workflow Code";
            if Workflow.Get(WorkFlowCode) then
                WorkflowDescription := Workflow.Description;
        end;

        InfoDialog.AddHeader('Workflow');
        InfoDialog.Add('ID', InstanceID, "Info Dialog Event Code WFE"::"Instance ID");
        InfoDialog.Add('Code', WorkFlowCode, "Info Dialog Event Code WFE"::"Workflow Code");
        InfoDialog.Add('Description', WorkflowDescription);
    end;

    internal procedure ShowApprovalInfo(var Workflow: Record Workflow)
    var
        InfoDialog: Codeunit "Info Dialog WFE";
    begin
        InfoDialog.Initialize();
        InfoDialog.SetWorkFlowCode(Workflow.Code);
        InfoDialog.AddHeader('Workflow');
        InfoDialog.Add('Code', Workflow.Code, "Info Dialog Event Code WFE"::"Workflow Code");
        InfoDialog.Add('Description', Workflow.Description);
        InfoDialog.AddHeader('Instance');
        InfoDialog.Add('Instance record count', GetWorkflowStepInstanceCount(Workflow.Code), "Info Dialog Event Code WFE"::"Workflow Step Instance");
        InfoDialog.AddHeader('Validation');
        InfoDialog.Add('Next Work flow Step Count', GetNextWorkflowStepIDCount(Workflow));
        InfoDialog.OpenInfoDialog();
    end;

    local procedure GetNextWorkflowStepIDCount(Workflow: Record Workflow): Integer
    var
        WorkflowStep: Record "Workflow Step";
    begin
        if Workflow.Code = '' then
            exit;

        WorkflowStep.SetRange("Workflow Code", Workflow.Code);
        WorkflowStep.SetFilter("Next Workflow Step ID", '<>0');
        exit(WorkflowStep.Count());
    end;

    local procedure GetWorkflowStepInstanceCount(WorkflowCode: Code[20]): Integer
    var
        WorkflowStepInstance: Record "Workflow Step Instance";
    begin
        if WorkflowCode = '' then
            exit;

        WorkflowStepInstance.SetRange("Workflow Code", WorkflowCode);
        exit(WorkflowStepInstance.Count());
    end;
}