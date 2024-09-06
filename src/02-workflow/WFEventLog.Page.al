page 83811 "WF Event Log WPTE"
{
    ApplicationArea = All;
    Caption = 'Workflow Event Log';
    PageType = List;
    SourceTable = "WF Event Log WPTE";
    UsageCategory = History;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.") { }
                field(ID; Rec.ID) { }
                field("Workflow Code"; Rec."Workflow Code") { }
                field("Workflow Step ID"; Rec."Workflow Step ID") { }
                field("Record ID"; format(Rec."Record ID"))
                {
                    Caption = 'Record ID';
                }
                field("Type"; Rec."Type") { }
                field("Function Name"; Rec."Function Name") { }
                field(Status; Rec.Status) { }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                }
            }
        }
    }
}
