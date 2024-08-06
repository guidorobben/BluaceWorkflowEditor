page 83806 "Workflow Event Monitor WPTE"
{
    ApplicationArea = All;
    Caption = 'Workflow Event Monitor';
    PageType = List;
    SourceTable = "Workflow Event Monitor WPTE";
    UsageCategory = History;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.") { }
            }
        }
    }
}
