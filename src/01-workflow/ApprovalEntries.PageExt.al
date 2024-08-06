pageextension 83800 "Approval Entries WPTE" extends "Approval Entries"
{
    
    actions
    {
        addlast(processing)
        {
            group(WorkflowEditorWPTE)
            {
                Caption = 'WF Editor';
                Image = TestDatabase;

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