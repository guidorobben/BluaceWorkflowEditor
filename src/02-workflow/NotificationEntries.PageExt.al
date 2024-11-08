pageextension 83809 "Notification Entries WPTE" extends "Notification Entries"
{
    actions
    {
        addlast(processing)
        {
            group(WorkflowEditorWPTE)
            {
                Caption = 'Workflow Editor';
                Image = Workflow;

                action(DeleteWPTE)
                {
                    ApplicationArea = All;
                    Caption = 'Delete Notification';
                    Image = Delete;

                    trigger OnAction()
                    begin
                        Rec.DeleteNotificationWPTE();
                    end;
                }
            }
        }
    }
}