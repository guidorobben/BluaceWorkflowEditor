pageextension 83809 "Notification Entries WFE" extends "Notification Entries"
{
    actions
    {
        addlast(processing)
        {
            group(WorkflowEditorWFE)
            {
                Caption = 'Workflow Editor';
                Image = Workflow;

                action(DeleteWFE)
                {
                    ApplicationArea = All;
                    Caption = 'Delete Notification';
                    Image = Delete;

                    trigger OnAction()
                    begin
                        Rec.DeleteNotificationWFE();
                    end;
                }
            }
        }
    }
}