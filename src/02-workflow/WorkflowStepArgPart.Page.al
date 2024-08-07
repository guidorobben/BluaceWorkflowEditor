page 83809 "Workflow Step Arg. Part WPTE"
{
    ApplicationArea = All;
    Caption = 'Response';
    PageType = ListPart;
    SourceTable = "Workflow Step Argument";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(ID; Rec.ID)
                {
                    ToolTip = 'Specifies the value of the ID field.', Comment = '%';
                    Visible = false;
                }
                field("Response Function Name"; Rec."Response Function Name")
                {
                    ToolTip = 'Specifies the value of the Response Function Name field.', Comment = '%';
                }
                field("Function Name Description WPTE"; Rec."Function Name Description WPTE")
                {
                    ToolTip = 'Specifies the value of the hh field.', Comment = '%';
                }
                field("Table No."; Rec."Table No.")
                {
                    ToolTip = 'Specifies the value of the Table No. field.', Comment = '%';
                }
                field("Approver Limit Type"; Rec."Approver Limit Type")
                {
                    ToolTip = 'Specifies how approvers'' approval limits affect when approval request entries are created for them. A qualified approver is an approver whose approval limit is above the value on the approval request.';
                }
                field("Approver Type"; Rec."Approver Type")
                {
                    ToolTip = 'Specifies who is notified first about approval requests.';
                }
                field("Approver User ID"; Rec."Approver User ID")
                {
                    ToolTip = 'Specifies the approver.';
                }
                field("Custom Link"; Rec."Custom Link")
                {
                    ToolTip = 'Specifies a link that is inserted in the notification to link to a custom location.';
                }
                field("Delegate After"; Rec."Delegate After")
                {
                    ToolTip = 'Specifies if and when an approval request will automatically be delegated to the relevant substitute. You can select to automatically delegate one, two, or five days after the date when the approval was requested.';
                }
                field("Due Date Formula"; Rec."Due Date Formula")
                {
                    ToolTip = 'Specifies in how many days the approval request must be resolved from the date when it was sent.';
                }
                field("Event Conditions"; Rec."Event Conditions")
                {
                    ToolTip = 'Specifies the value of the Event Conditions field.', Comment = '%';
                }
                field("Field Caption"; Rec."Field Caption")
                {
                    ToolTip = 'Specifies the value of the Field Caption field.', Comment = '%';
                }
                field("Field No."; Rec."Field No.")
                {
                    ToolTip = 'Specifies the value of the Field No. field.', Comment = '%';
                }
                field("General Journal Batch Name"; Rec."General Journal Batch Name")
                {
                    ToolTip = 'Specifies the name of the general journal batch that is used for this workflow step argument.';
                }
                field("General Journal Template Name"; Rec."General Journal Template Name")
                {
                    ToolTip = 'Specifies the name of the general journal template that is used for this workflow step argument.';
                }
                field("Link Target Page"; Rec."Link Target Page")
                {
                    ToolTip = 'Specifies a specific page that opens when a user chooses the link in a notification. If you do not fill this field, the page showing the involved record will open. The page must have the same source table as the record involved.';
                }
                field("Message"; Rec.Message)
                {
                    ToolTip = 'Specifies the message that will be shown as a response.';
                }
                field("Notification Entry Type"; Rec."Notification Entry Type")
                {
                    ToolTip = 'Specifies the type of the notification.';
                }
                field("Notification User ID"; Rec."Notification User ID")
                {
                    ToolTip = 'Specifies the ID of the user that will be notified in connection with this workflow step argument.';
                }
                field("Notification User License Type"; Rec."Notification User License Type")
                {
                    ToolTip = 'Specifies the value of the Notification User License Type field.', Comment = '%';
                }
                field("Notify Sender"; Rec."Notify Sender")
                {
                    ToolTip = 'Specifies if the approval sender will be notified in connection with this workflow step argument.';
                }
                field("Response Option Group"; Rec."Response Option Group")
                {
                    ToolTip = 'Specifies the value of the Response Option Group field.', Comment = '%';
                }
                field("Response Type"; Rec."Response Type")
                {
                    ToolTip = 'Specifies the response type for the workflow response. You cannot set options for this.';
                }
                field("Response User ID"; Rec."Response User ID")
                {
                    ToolTip = 'Specifies the user necessary for an acceptable response.';
                }
                field("Show Confirmation Message"; Rec."Show Confirmation Message")
                {
                    ToolTip = 'Specifies that a confirmation message is shown to users after they request an approval.';
                }
                field(Type; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.', Comment = '%';
                }
                field("Workflow User Group Code"; Rec."Workflow User Group Code")
                {
                    ToolTip = 'Specifies the workflow user group that is used in connection with this workflow step argument.';
                }
            }
        }
    }
}
