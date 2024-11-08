page 83811 "Workflow Event Log WPTE"
{
    ApplicationArea = All;
    Caption = 'Workflow Event Log';
    Editable = false;
    PageType = List;
    SourceTable = "Workflow Event Log WPTE";
    UsageCategory = History;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    Editable = false;
                }
                field(ID; Rec.ID) { }
                field("Workflow Code"; Rec."Workflow Code") { }
                field("Workflow Step ID"; Rec."Workflow Step ID") { }
                field("Record ID"; Format(Rec."Record ID"))
                {
                    Caption = 'Record ID';
                }
                field(Type; Rec."Type") { }
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