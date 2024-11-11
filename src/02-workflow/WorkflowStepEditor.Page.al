page 83808 "Workflow Step Editor WPTE"
{
    ApplicationArea = All;
    Caption = 'Workflow Step Editor';
    PageType = List;
    SourceTable = "Workflow Step";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Workflow Code"; Rec."Workflow Code")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Workflow Code field.', Comment = '%';
                }
                field(Type; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.', Comment = '%';
                }
                field("Function Name"; Rec."Function Name")
                {
                    ToolTip = 'Specifies the value of the Function Name field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Entry Point"; Rec."Entry Point")
                {
                    ToolTip = 'Specifies the value of the Entry Point field.', Comment = '%';
                }
                field(ID; Rec.ID)
                {
                    ToolTip = 'Specifies the value of the ID field.', Comment = '%';
                }
                field("Sequence No."; Rec."Sequence No.")
                {
                    ToolTip = 'Specifies the value of the Sequence No. field.', Comment = '%';
                }
                field("Previous Workflow Step ID"; Rec."Previous Workflow Step ID")
                {
                    ToolTip = 'Specifies the value of the Previous Workflow Step ID field.', Comment = '%';
                }
                field("Next Workflow Step ID"; Rec."Next Workflow Step ID")
                {
                    ToolTip = 'Specifies the value of the Next Workflow Step ID field.', Comment = '%';
                }
                field(Argument; Rec.Argument)
                {
                    ToolTip = 'Specifies the value of the Argument field.', Comment = '%';
                }
            }
            part(WorkflowEvent; "Workflow Event Part WPTE")
            {
                SubPageLink = "Function Name" = field("Function Name");
            }
            part(workflowstepargument; "Workflow Step Arg. Part WPTE")
            {
                SubPageLink = ID = field(Argument);
            }
        }
    }
}