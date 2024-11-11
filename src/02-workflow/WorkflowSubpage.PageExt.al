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

                action(ShowBufferWPTE)
                {
                    ApplicationArea = All;
                    Caption = 'Show Function Name';
                    Image = ShowList;

                    trigger OnAction()
                    var
                        WorkflowHelper: Codeunit "Workflow Helper WPTE";
                    begin
                        Message(WorkflowHelper.GetFunctionName(Rec."Workflow Code", Rec."Event Step ID"));
                    end;
                }
            }
        }
    }
}
