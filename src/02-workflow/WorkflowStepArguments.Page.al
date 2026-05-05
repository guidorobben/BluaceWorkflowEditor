page 83825 "Workflow Step Arguments WFE"
{
    ApplicationArea = All;
    Caption = 'Workflow Step Argument';
    PageType = List;
    SourceTable = "Workflow Step Argument";
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(ID; Rec.ID) { }
                field("Table No."; Rec."Table No.") { }
                field("Approver Limit Type"; Rec."Approver Limit Type") { }
                field("Approver Type"; Rec."Approver Type") { }
                field("Approver User ID"; Rec."Approver User ID") { }
                field("Custom Link"; Rec."Custom Link") { }
                field("Delegate After"; Rec."Delegate After") { }
                field("Due Date Formula"; Rec."Due Date Formula") { }
                // field("Event Conditions"; Rec."Event Conditions") { }
                field("Field Caption"; Rec."Field Caption") { }
                field("Field No."; Rec."Field No.") { }
                field("Function Name Description WFE"; Rec."Function Name Description WFE") { }
                field("General Journal Batch Name"; Rec."General Journal Batch Name") { }
                field("General Journal Template Name"; Rec."General Journal Template Name") { }
                field("Link Target Page"; Rec."Link Target Page") { }
                field("Message"; Rec.Message) { }
                field("Notification Entry Type"; Rec."Notification Entry Type") { }
                field("Notification User ID"; Rec."Notification User ID") { }
                field("Notification User License Type"; Rec."Notification User License Type") { }
                field("Notify Sender"; Rec."Notify Sender") { }
                field("Response Function Name"; Rec."Response Function Name") { }
                field("Response Option Group"; Rec."Response Option Group") { }
                field("Response Type"; Rec."Response Type") { }
                field("Response User ID"; Rec."Response User ID") { }
                field("Show Confirmation Message"; Rec."Show Confirmation Message") { }

                field(Type; Rec."Type") { }
                field("Workflow User Group Code"; Rec."Workflow User Group Code") { }
            }
        }
    }
}