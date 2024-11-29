page 83800 "WF Event/Response Combi. WFE"
{
    ApplicationArea = All;
    Caption = 'WF Event/Response Combinations';
    PageType = List;
    SourceTable = "WF Event/Response Combination";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Function Name"; Rec."Function Name")
                {
                    ToolTip = 'Specifies the value of the Function Name field.';
                }
                field("Predecessor Function Name"; Rec."Predecessor Function Name")
                {
                    ToolTip = 'Specifies the value of the Predecessor Function Name field.';
                }
                field("Predecessor Type"; Rec."Predecessor Type")
                {
                    ToolTip = 'Specifies the value of the Predecessor Type field.';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.';
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.';
                }
                field(Type; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
            }
        }
    }
}
