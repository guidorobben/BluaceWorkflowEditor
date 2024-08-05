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

                field("Table ID"; Rec."Table ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Table ID field.', Comment = '%';
                }
                field("Function Name"; Rec."Function Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Function Name field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the workflow event that comes before the workflow event in the workflow sequence.';
                }
                field("Dynamic Req. Page Entity Name"; Rec."Dynamic Req. Page Entity Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Dynamic Req. Page Entity Name field.', Comment = '%';
                }
                field(Independent; Rec.Independent)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Independent field.', Comment = '%';
                }
                field("Request Page ID"; Rec."Request Page ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Request Page ID field.', Comment = '%';
                }
                field("Used for Record Change"; Rec."Used for Record Change")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Used for Record Change field.', Comment = '%';
                }
            }
        }
    }
}
