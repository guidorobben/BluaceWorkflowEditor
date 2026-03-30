page 83823 "Workflow Steps WFE"
{
    ApplicationArea = All;
    Caption = 'Workflow Steps';
    PageType = List;
    SourceTable = "Workflow Step";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Workflow Code"; Rec."Workflow Code") { }
                field("Function Name"; Rec."Function Name") { }
                field(ID; Rec.ID) { }
                field(Description; Rec.Description) { }
                field(Argument; Rec.Argument) { }
                field("Entry Point"; Rec."Entry Point") { }
                field("Next Workflow Step ID"; Rec."Next Workflow Step ID") { }
                field("Previous Workflow Step ID"; Rec."Previous Workflow Step ID") { }
                field("Sequence No."; Rec."Sequence No.") { }
                field(Type; Rec."Type") { }
            }
        }
    }
}