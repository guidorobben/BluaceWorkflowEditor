pageextension 83809 "Notification Entries WFE" extends "Notification Entries"
{
    layout
    {
        addlast(FactBoxes)
        {
            part("Approval Entry Part"; "Approval Entry Part WFE")
            {
                ApplicationArea = All;
                Visible = false;
                // SubPageLink = "Record ID to Approve" = field("Triggered By Record");
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
                action(DispatchAllWFE)
                {
                    ApplicationArea = All;
                    Caption = 'Dispatch All (Preview)';
                    Image = SendApprovalRequest;
                    ToolTip = 'Dispatches all notifications immediately.';

                    trigger OnAction()
                    begin
                        Rec.RunAllNotificationDispatcherWFE();
                    end;
                }
            }
        }

        addlast(Promoted)
        {
            group(WorkflowEditorWFE_Promoted)
            {
                Caption = 'Workflow Editor';
                Image = Workflow;

                actionref(SendNotificationsWFE_Promoted; SendNotificationsWFE) { }
                actionref(DeleteWFE_Promoted; DeleteWFE) { }
                actionref(DispatchAllWFE_Promoted; DispatchAllWFE) { }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        // CurrPage."Approval Entry Part".Page.SetNotificationEntry(Rec);
    end;
}