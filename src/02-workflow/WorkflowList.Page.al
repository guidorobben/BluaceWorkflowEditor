page 83802 "Workflow List WFE"
{
    ApplicationArea = All;
    Caption = 'Workflow List';
    Editable = false;
    PageType = List;
    SourceTable = Workflow;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                    ToolTip = 'Specifies the workflow.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the description of the workflow.';
                }
                field(Category; Rec.Category)
                {
                    ToolTip = 'Specifies the category that the workflow belongs to.';
                }
                field(Template; Rec.Template)
                {
                    ToolTip = 'Specifies if the workflow is a template.';
                }
                field(Enabled; Rec.Enabled)
                {
                    ToolTip = 'Specifies that the workflow will start when the event in the first entry-point workflow step occurs.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Enable)
            {
                Caption = 'Enable';
                Image = Approval;
                ToolTip = 'Enables the selected workflow(s).';

                trigger OnAction()
                begin
                    Rec.ToggleEnableWorkflowWFE();
                end;
            }
        }
        area(Promoted)
        {
            actionref(Enable_Promoted; Enable) { }
        }
    }

    views
    {
        view(Workflows)
        {
            Caption = 'Workflows';
            Filters = where(Template = const(false));
            SharedLayout = true;
        }
        view(Templates)
        {
            Caption = 'Templates';
            Filters = where(Template = const(true));
            SharedLayout = true;
        }
    }
}
