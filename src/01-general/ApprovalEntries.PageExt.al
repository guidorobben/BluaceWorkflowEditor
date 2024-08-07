pageextension 83800 "Approval Entries WPTE" extends "Approval Entries"
{

    actions
    {
        addlast(processing)
        {
            group(WorkflowEditorWPTE)
            {
                Caption = 'Workflow Editor';
                Image = Workflow;

                action(DeleteRecordTPTEWPTE)
                {
                    ApplicationArea = All;
                    Caption = 'Delete';

                    trigger OnAction()
                    begin
                        Rec.Delete(true);
                    end;
                }
            }
        }
    }
}