pageextension 83809 "Notification Entries WFE" extends "Notification Entries"
{
    layout
    {
        modify(ID)
        {
            Visible = true;
        }
        modify("Error Message")
        {
            trigger OnDrillDown()
            begin
                Message(Rec."Error Message");
            end;
        }

        addlast(FactBoxes)
        {
            part("Approval Entry Part"; "Approval Entry Part WFE")
            {
                ApplicationArea = All;
                Visible = true;
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
                action(DispatchCurrentWFE)
                {
                    ApplicationArea = All;
                    Caption = 'Dispatch Current (Preview)';
                    Image = SendApprovalRequest;
                    ToolTip = 'Dispatches current notification immediately.';

                    trigger OnAction()
                    begin
                        Rec.RunCurrentNotificationViaDispatcherWFE();
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
                action(ShowRecordToApproveWFE)
                {
                    ApplicationArea = All;
                    Caption = 'Show Record to Approve';
                    Image = View;
                    ToolTip = 'Opens the record that needs to be approved.';

                    trigger OnAction()
                    begin
                        Rec.ShowRecordToApproveWFE();
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

                actionref(ShowRecordToApproveWFE_Promoted; ShowRecordToApproveWFE) { }
                actionref(SendNotificationsWFE_Promoted; SendNotificationsWFE) { }
                actionref(DispatchCurrentWFE_Promoted; DispatchCurrentWFE) { }
                actionref(DispatchAllWFE_Promoted; DispatchAllWFE) { }
                actionref(DeleteWFE_Promoted; DeleteWFE) { }
            }
        }
    }

    views
    {
        addlast
        {
            view(TypeApprovalWFE)
            {
                Caption = 'Approval';
                Filters = where(Type = filter(Approval));
                SharedLayout = true;
            }
            view(TypeNewRecordWFE)
            {
                Caption = 'New Record';
                Filters = where(Type = filter("New Record"));
                SharedLayout = true;
            }
            view(TypeOverdueWFE)
            {
                Caption = 'Overdue';
                Filters = where(Type = filter(Overdue));
                SharedLayout = true;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        CurrPage."Approval Entry Part".Page.SetNotificationEntry(Rec);
    end;
}