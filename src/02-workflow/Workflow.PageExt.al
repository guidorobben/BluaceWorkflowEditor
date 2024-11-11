pageextension 83802 "Workflow WPTE" extends Workflow
{
    actions
    {
        addlast(processing)
        {
            group(WorkFlowEditorWPTE)
            {
                Caption = 'WorkFlow Editor';
                Image = Workflow;

                action(SetToWorkflowTemplateWPTE)
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
                action(SetToWorkflowWPTE)
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
                action(ShowWorkflowStepsWPTE)
                {
                    ApplicationArea = All;
                    Caption = 'Edit Workflow Steps';
                    Image = StepInto;

                    trigger OnAction()
                    var
                        WorkflowEditor: Codeunit "Workflow Editor WPTE";
                    begin
                        WorkflowEditor.EditWorkflowSteps(Rec.Code);
                    end;
                }
            }
        }

        addlast(Promoted)
        {
            group(WorkFlowEditorWPTE_Promoted)
            {
                Caption = 'WorkFlow Editor';
                Image = Workflow;

                actionref(ShowWorkflowStepsWPTE_Promoted; ShowWorkflowStepsWPTE) { }
            }
        }
    }

    var
        WorkflowHelperWPTE: Codeunit "Workflow Helper WPTE";

    procedure SetToWorkflow()
    begin
        WorkflowHelperWPTE.SetToWorkflow(Rec);
    end;

    procedure SetToWorkflowTemplate()
    begin
        WorkflowHelperWPTE.SetToWorkflowTemplate(Rec);
    end;
}