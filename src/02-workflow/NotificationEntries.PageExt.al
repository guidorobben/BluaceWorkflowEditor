pageextension 83809 "Notification Entries WFE" extends "Notification Entries"
{
    layout
    {
        addlast(FactBoxes)
        {
            part("Approval Entry Part"; "Approval Entry Part WFE")
            {
                ApplicationArea = All;
                SubPageLink = "Record ID to Approve" = field("Triggered By Record");
            }
        }
    }

    actions
    {
        addlast(processing)
        {
            group(WorkflowEditorWFE)
            {
                Caption = 'Workflow Editor';
                Image = Workflow;

                action(SendNotificationsWFE)
                {
                    ApplicationArea = All;
                    Caption = 'Send Notifications';
                    Image = SendApprovalRequest;
                    RunObject = page "Sent Notification Entries";
                    ToolTip = 'Opens the send notification entries page.';
                }
                action(DeleteWFE)
                {
                    ApplicationArea = All;
                    Caption = 'Delete selected Notifications';
                    Image = Delete;
                    ToolTip = 'Deletes the selected records. You need to be approval administrator for this.';

                    trigger OnAction()
                    var
                        NotificationEntry: Record "Notification Entry";
                    begin
                        CurrPage.SetSelectionFilter(NotificationEntry);
                        NotificationEntry.DeleteNotificationsWFE();
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        CurrPage."Approval Entry Part".Page.SetNotificationEntry(Rec);
    end;
}