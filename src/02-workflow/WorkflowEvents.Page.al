page 83801 "Workflow Events WPTE"
{
    ApplicationArea = All;
    Caption = 'Workflow Events';
    PageType = List;
    SourceTable = "Workflow Event";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                Caption = 'General';

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
                    ToolTip = 'Specifies the workflow event that comes before the workflow event in the workflow sequence.';
                }
                field("Dynamic Req. Page Entity Name"; Rec."Dynamic Req. Page Entity Name")
                {
                    ToolTip = 'Specifies the value of the Dynamic Req. Page Entity Name field.', Comment = '%';
                }
                field(Independent; Rec.Independent)
                {
                    ToolTip = 'Specifies the value of the Independent field.', Comment = '%';
                }
                field("Request Page ID"; Rec."Request Page ID")
                {
                    ToolTip = 'Specifies the value of the Request Page ID field.', Comment = '%';
                }
                field("Used for Record Change"; Rec."Used for Record Change")
                {
                    ToolTip = 'Specifies the value of the Used for Record Change field.', Comment = '%';
                }
            }
        }
    }
}
