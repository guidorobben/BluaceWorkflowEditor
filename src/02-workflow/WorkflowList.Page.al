page 83802 "Workflow List WPTE"
{
    ApplicationArea = All;
    Caption = 'Workflow List';
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
}
