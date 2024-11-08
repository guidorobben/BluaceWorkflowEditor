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
                    var
                        UserManagement: Codeunit "User Management WPTE";
                    begin
                        if not UserManagement.IsApprovalAdministrator() then
                            exit;

                        Rec.Delete(true);
                    end;
                }
            }
        }
    }
}