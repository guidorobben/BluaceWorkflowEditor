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
            }
        }

        addlast(Promoted)
        {
            group(WorkFlowEditorWFE_Promoted)
            {
                Caption = 'WorkFlow Editor';
                Image = Workflow;

                actionref(ShowWorkflowStepsWFE_Promoted; ShowWorkflowStepsWFE) { }
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