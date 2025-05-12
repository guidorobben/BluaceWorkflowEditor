page 83815 "Workflow Rule Part WFE"
{
    ApplicationArea = All;
    Caption = 'Workflow Rule Part';
    PageType = ListPart;
    SourceTable = "Workflow Rule";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(ID; Rec.ID)
                {
                    ToolTip = 'Specifies the value of the ID field.', Comment = '%';
                }
                field("Field No."; Rec."Field No.")
                {
                    ToolTip = 'Specifies the value of the Field No. field.', Comment = '%';
                }
                field("Field Caption"; Rec."Field Caption")
                {
                    ToolTip = 'Specifies the value of the Field Caption field.', Comment = '%';
                }
                field(Operator; Rec.Operator)
                {
                    ToolTip = 'Specifies the type of change that can occur to the field on the record.';
                }
                field("Table ID"; Rec."Table ID")
                {
                    ToolTip = 'Specifies the value of the Table ID field.', Comment = '%';
                }
                field("Workflow Code"; Rec."Workflow Code")
                {
                    ToolTip = 'Specifies the value of the Workflow Code field.', Comment = '%';
                }
                field("Workflow Step ID"; Rec."Workflow Step ID")
                {
                    ToolTip = 'Specifies the value of the Workflow Step ID field.', Comment = '%';
                }
                field("Workflow Step Instance ID"; Rec."Workflow Step Instance ID")
                {
                    ToolTip = 'Specifies the value of the Workflow Step Instance ID field.', Comment = '%';
                }
            }
        }
    }
}