page 83803 "Workflow Step Buffer WPTE"
{
    ApplicationArea = All;
    Caption = 'Workflow Step Buffer';
    PageType = List;
    SourceTable = "Workflow Step Buffer";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Workflow Code"; Rec."Workflow Code")
                {
                    ToolTip = 'Specifies the value of the Workflow Code field.';
                }
                field(Argument; Rec.Argument)
                {
                    ToolTip = 'Specifies the value of the Argument field.';
                }
                field(Condition; Rec.Condition)
                {
#pragma warning disable LC0038
                    ToolTip = 'Specifies the condition that moderates the workflow event that you specified in the Event Description field. When you choose the field, the Event Conditions window opens in which you can specify condition values for predefined lists of relevant fields.';
#pragma warning restore LC0038
                }
                field("Entry Point"; Rec."Entry Point")
                {
                    ToolTip = 'Specifies the workflow step that starts the workflow. The first workflow step is always of type Entry Point.';
                }
                field("Event Description"; Rec."Event Description")
                {
                    ToolTip = 'Specifies the workflow event that triggers the related workflow response.';
                }
                field("Event Step ID"; Rec."Event Step ID")
                {
                    ToolTip = 'Specifies the value of the Event Step ID field.';
                }
                field(Indent; Rec.Indent)
                {
                    ToolTip = 'Specifies the relationship of the workflow step under parent workflow steps.';
                }
                field("Next Step Description"; Rec."Next Step Description")
                {
                    ToolTip = 'Specifies another workflow step than the next one in the sequence that you want to start, for example, because the event on the workflow step failed to meet a condition.';
                }
                field("Order"; Rec."Order")
                {
                    ToolTip = 'Specifies the value of the Order field.';
                }
                field("Parent Event Step ID"; Rec."Parent Event Step ID")
                {
                    ToolTip = 'Specifies the value of the Parent Event Step ID field.';
                }
                field("Previous Workflow Step ID"; Rec."Previous Workflow Step ID")
                {
                    ToolTip = 'Specifies the value of the Previous Workflow Step ID field.';
                }
                field("Response Description"; Rec."Response Description")
                {
                    ToolTip = 'Specifies the workflow response.';
                }
                field("Response Description Style"; Rec."Response Description Style")
                {
                    ToolTip = 'Specifies the value of the Response Description Style field.';
                }
                field("Response Step ID"; Rec."Response Step ID")
                {
                    ToolTip = 'Specifies the value of the Response Step ID field.';
                }
                field("Sequence No."; Rec."Sequence No.")
                {
                    ToolTip = 'Specifies the value of the Sequence No. field.';
                }
                field(Template; Rec.Template)
                {
                    ToolTip = 'Specifies the value of the Template field.';
                }
            }
        }
    }
}
