pageextension 83803 "Workflow Subpage WFE" extends "Workflow Subpage"
{
    actions
    {
        addlast(processing)
        {
            group(WorkflowEditorWFE)
            {
                Caption = 'Workflow Editor';
                Image = Workflow;

                action(ShowBufferWFE)
                {
                    ApplicationArea = All;
                    Caption = 'Show Function Name';
                    Image = ShowList;

                    trigger OnAction()
                    var
                        WorkflowHelper: Codeunit "Workflow Helper WFE";
                    begin
                        Message(WorkflowHelper.GetFunctionName(Rec."Workflow Code", Rec."Event Step ID"));
                    end;
                }
            }
        }
    }
}
