page 83804 "Workflow Step Instance WPTE"
{
    ApplicationArea = All;
    Caption = 'Workflow Step Instance';
    PageType = List;
    SourceTable = "Workflow Step Instance";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(ID; Rec.ID)
                {
                    ToolTip = 'Specifies the ID of the workflow step instance.';
                }
                field("Function Name"; Rec."Function Name")
                {
                    ToolTip = 'Specifies the name of the function that is used by the workflow step instance.';
                }
                field(Type; Rec."Type")
                {
                    ToolTip = 'Specifies if the workflow step instance is an event, a response, or a sub-workflow.';
                }
                field("Sequence No."; Rec."Sequence No.")
                {
                    ToolTip = 'Specifies the value of the Sequence No. field.', Comment = '%';
                }
                field("Entry Point"; Rec."Entry Point")
                {
                    ToolTip = 'Specifies the workflow step that starts the workflow. The first workflow step is always of type Entry Point.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the status of the workflow step instance. Active means that the step instance in ongoing. Completed means that the workflow step instance is done. Ignored means that the workflow step instance was skipped in favor of another path.';
                }
                field("Workflow Step ID"; Rec."Workflow Step ID")
                {
                    ToolTip = 'Specifies the ID of workflow step in the workflow that the workflow step instance belongs to.';
                }
                field("Original Workflow Step ID"; Rec."Original Workflow Step ID")
                {
                    ToolTip = 'Specifies the value of the Original Workflow Step ID field.', Comment = '%';
                }
                field("Next Workflow Step ID"; Rec."Next Workflow Step ID")
                {
                    ToolTip = 'Specifies another workflow step than the next one in the sequence that you want to start, for example, because the event on the workflow step failed to meet a condition.';
                }
                field("Previous Workflow Step ID"; Rec."Previous Workflow Step ID")
                {
                    ToolTip = 'Specifies the step that you want to precede the step that you are specifying on the line. You use this field to specify branching of steps when one of multiple possible events does not occur and you want the following step to specify another possible event as a branch of the previous step. In this case, both steps have the same value in the Previous Workflow Step ID field.';
                }
                field(Argument; Rec.Argument)
                {
                    ToolTip = 'Specifies the values of the parameters that are required by the workflow step instance.';
                }
                field("Created By User ID"; Rec."Created By User ID")
                {
                    ToolTip = 'Specifies the user who created the workflow step instance.';
                }
                field("Created Date-Time"; Rec."Created Date-Time")
                {
                    ToolTip = 'Specifies the date and time when the workflow step instance was created.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the workflow step instance.';
                }
                field("Last Modified By User ID"; Rec."Last Modified By User ID")
                {
                    ToolTip = 'Specifies the user who last participated in the workflow step instance.';
                }
                field("Last Modified Date-Time"; Rec."Last Modified Date-Time")
                {
                    ToolTip = 'Specifies the date and time when a user last participated in the workflow step instance.';
                }
                field("Original Workflow Code"; Rec."Original Workflow Code")
                {
                    ToolTip = 'Specifies the value of the Original Workflow Code field.', Comment = '%';
                }
                field("Record ID"; Rec."Record ID")
                {
                    ToolTip = 'Specifies the value of the Record ID field.', Comment = '%';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.', Comment = '%';
                }
                field("Workflow Code"; Rec."Workflow Code")
                {
                    ToolTip = 'Specifies the workflow that the workflow step instance belongs to.';
                }
            }
        }
    }
}
