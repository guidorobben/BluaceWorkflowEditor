pageextension 83803 "Workflow Subpage WPTE" extends "Workflow Subpage"
{
    actions
    {
        addlast(processing)
        {
            group(WorkflowEditorWPTE)
            {
                Caption = 'Workflow Editor';
                Image = Workflow;

                action(ShowBuffer)
                {
                    ApplicationArea = All;
                    Caption = 'Show Function Name';

                    trigger OnAction()
                    var
                        WorkflowHelper: Codeunit "Workflow Helper WPTE";
                    begin
                        Message(WorkflowHelper.GetFunctionName(rec."Workflow Code", rec."Event Step ID"));
                    end;
                }
            }
        }
    }
}
