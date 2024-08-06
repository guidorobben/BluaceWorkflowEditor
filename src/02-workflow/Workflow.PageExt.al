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
                    var
                        ConfirmManagement: Codeunit "Confirm Management";
                        ConvertToWorkflowTemplateQst: Label 'Do you want to convert the workflow to a workflow template?';
                    begin
                        if ConfirmManagement.GetResponse(ConvertToWorkflowTemplateQst, false) then begin
                            Rec.TestField(Enabled, false);
                            Rec.Validate(Template, true);
                        end;
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
                    var
                        ConfirmManagement: Codeunit "Confirm Management";
                        ConvertToWorkflowQst: Label 'Do you want to convert the workflow template to a workflow?';
                    begin
                        if ConfirmManagement.GetResponse(ConvertToWorkflowQst, false) then begin
                            Rec.TestField(Enabled, false);
                            Rec.Validate(Template, false);
                            Rec.Modify(true);
                        end;
                    end;
                }
                action(ShowWorkflowStepsWPTE)
                {
                    ApplicationArea = All;
                    Caption = 'Edit Workflow Steps';

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
}