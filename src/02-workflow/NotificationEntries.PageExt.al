pageextension 83809 "Notification Entries WFE" extends "Notification Entries"
{
    layout
    {
        addlast(FactBoxes)
        {
            part("Approval Entry Part"; "Approval Entry Part WPE")
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

                action(DeleteWFE)
                {
                    ApplicationArea = All;
                    Caption = 'Delete Notification';
                    Image = Delete;
                    ToolTip = 'Deletes the selected record. YOu need to be approval administrator for this.';

                    trigger OnAction()
                    begin
                        Rec.DeleteNotificationWFE();
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        CurrPage."Approval Entry Part".Page.SetNotification(Rec);
    end;
}