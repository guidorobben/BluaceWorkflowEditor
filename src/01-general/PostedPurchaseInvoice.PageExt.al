pageextension 83801 "Posted Purchase Invoice WPTE" extends "Posted Purchase Invoice"
{
    actions
    {
        addlast(navigation)
        {
            group(WorkFlowEditorWPTE)
            {
                Caption = 'Workflow Editor';

                action(OpenActiveWorkflowWPTE)
                {
                    ApplicationArea = All;
                    Caption = 'Open active workflow';
                    Image = Open;

                    trigger OnAction()
                    var
                        WorkflowEditor: Codeunit "Workflow Editor WPTE";
                    begin
                        WorkflowEditor.OpenActiveWorkflow(Rec.RecordId);
                    end;
                }
            }
        }

        addlast(Promoted)
        {
            group(WorkFlowEditorWPTE_Promoted)
            {
                Caption = 'Workflow Editor';

                actionref(OpenActiveWorkflowWPTE_Promoted; OpenActiveWorkflowWPTE) { }
            }
        }
    }
}
