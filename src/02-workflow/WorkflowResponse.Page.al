page 83817 "Workflow Response WFE"
{
    ApplicationArea = All;
    Caption = 'Workflow Response';
    Editable = false;
    PageType = List;
    SourceTable = "Workflow Response";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Function Name"; Rec."Function Name")
                {
                    ToolTip = 'Specifies the value of the Function Name field.', Comment = '%';
                }
                field("Table ID"; Rec."Table ID")
                {
                    ToolTip = 'Specifies the value of the Table ID field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the workflow response.';
                }
                field(Independent; Rec.Independent)
                {
                    ToolTip = 'Specifies the value of the Independent field.', Comment = '%';
                }
                field("Response Option Group"; Rec."Response Option Group")
                {
                    ToolTip = 'Specifies the value of the Response Option Group field.', Comment = '%';
                }
            }
        }
    }
}