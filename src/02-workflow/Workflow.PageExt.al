pageextension 83802 "Workflow WFE" extends Workflow
{
    actions
    {
        addlast(processing)
        {
            group(WorkFlowEditorWFE)
            {
                Caption = 'WorkFlow Editor';
                Image = Workflow;

                action(ApprovalInfoWFE)
                {
                    ApplicationArea = All;
                    Caption = 'Approval Info';
                    Image = Info;

                    trigger OnAction()
                    begin
                        Rec.ShowApprovalInfoWFE();
                    end;
                }
                action(SetToWorkflowTemplateWFE)
                {
                    ApplicationArea = All;
                    Caption = 'Convert to Workflow Template';
                    Image = Template;
                    ToolTip = 'Convert the workflow to workflow template.';
                    Visible = not Rec.Template;

                    trigger OnAction()
                    begin
                        SetToWorkflowTemplate();
                    end;
                }
                action(SetToWorkflowWFE)
                {
                    ApplicationArea = All;
                    Caption = 'Convert to Workflow';
                    Image = Workflow;
                    ToolTip = 'Convert the workflow template to workflow.';
                    Visible = Rec.Template;

                    trigger OnAction()
                    begin
                        SetToWorkflow();
                    end;
                }
                action(ShowWorkflowStepsWFE)
                {
                    ApplicationArea = All;
                    Caption = 'Edit Workflow Steps';
                    Image = StepInto;

                    trigger OnAction()
                    var
                        WorkflowEditor: Codeunit "Workflow Editor WFE";
                    begin
                        WorkflowEditor.EditWorkflowSteps(Rec.Code);
                    end;
                }
                action(WorkflowStepInstancesWPTE)
                {
                    ApplicationArea = All;
                    Caption = 'Workflow Step Instances';
                    Image = List;
                    ToolTip = 'Show all instances of workflow steps in current workflows.';

                    trigger OnAction()
                    var
                        WorkflowStepInstance: Record "Workflow Step Instance";
                    begin
                        if Rec.Code = '' then
                            exit;

                        WorkflowStepInstance.SetRange("Workflow Code", Rec.Code);
                        Page.Run(Page::"Workflow Step Instance WFE", WorkflowStepInstance);
                    end;
                }
                action(ArchivedWorkflowStepInstancesWPTE)
                {
                    ApplicationArea = All;
                    Caption = 'Archived Workflow Step Instances';
                    Image = ListPage;
                    ToolTip = 'View all instances of workflow steps that are no longer used, either because they are completed or because they were manually archived.';

                    trigger OnAction()
                    var
                        ArchivedWFStepInstances: Page "Archived WF Step Instances";
                    begin
                        ArchivedWFStepInstances.SetWorkflowCode(Rec.Code);
                        ArchivedWFStepInstances.RunModal();
                    end;
                }
            }
        }

        addlast(Promoted)
        {
            group(WorkFlowEditorWFE_Promoted)
            {
                Caption = 'WorkFlow Editor';
                Image = Workflow;

                actionref(ApprovalInfoWFE_Promoted; ApprovalInfoWFE) { }
                actionref(ShowWorkflowStepsWFE_Promoted; ShowWorkflowStepsWFE) { }
                actionref(WorkflowStepInstancesWPTE_Promoted; WorkflowStepInstancesWPTE) { }
                actionref(ArchivedWorkflowStepInstancesWPTE_Promoted; ArchivedWorkflowStepInstancesWPTE) { }
                actionref(SetToWorkflowTemplateWFE_Promoted; SetToWorkflowTemplateWFE) { }
                actionref(SetToWorkflowWFE_Promoted; SetToWorkflowWFE) { }
            }
        }
    }

    var
        WorkflowHelperWFE: Codeunit "Workflow Helper WFE";

    procedure SetToWorkflow()
    begin
        WorkflowHelperWFE.SetToWorkflow(Rec);
    end;

    procedure SetToWorkflowTemplate()
    begin
        WorkflowHelperWFE.SetToWorkflowTemplate(Rec);
    end;
}