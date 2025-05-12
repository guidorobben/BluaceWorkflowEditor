page 83818 "Workflow - Record Change WFE"
{
    ApplicationArea = All;
    Caption = 'Workflow - Record Change';
    PageType = List;
    SourceTable = "Workflow - Record Change";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                }
                field("Workflow Step Instance ID"; Rec."Workflow Step Instance ID")
                {
                    ToolTip = 'Specifies the value of the Workflow Step Instance ID field.', Comment = '%';
                }
                field("Record ID"; Rec."Record ID")
                {
                    ToolTip = 'Specifies the value of the Record ID field.', Comment = '%';
                }
                field("Table No."; Rec."Table No.")
                {
                    ToolTip = 'Specifies the value of the Table No. field.', Comment = '%';
                }
                field("Field No."; Rec."Field No.")
                {
                    ToolTip = 'Specifies the value of the Field No. field.', Comment = '%';
                }
                field("Field Caption"; Rec."Field Caption")
                {
                    ToolTip = 'Specifies the caption of the field that changes.';
                }
                field(Inactive; Rec.Inactive)
                {
                    ToolTip = 'Specifies the value of the Inactive field.', Comment = '%';
                }
                field("Old Value"; Rec."Old Value")
                {
                    ToolTip = 'Specifies the value of the Old Value field.', Comment = '%';
                }
                field("New Value"; Rec."New Value")
                {
                    ToolTip = 'Specifies the value of the New Value field.', Comment = '%';
                }
            }
        }
    }
}