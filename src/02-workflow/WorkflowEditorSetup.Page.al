page 83807 "Workflow Editor Setup WPTE"
{
    ApplicationArea = All;
    Caption = 'Workflow Editor Setup';
    PageType = Card;
    SourceTable = "Workflow Editor Setup WPTE";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Disable Mail Notifications"; Rec."Disable Mail Notifications") { }
                field("Log Workflow Events"; Rec."Log Workflow Events") { }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.InsertIfNotExists();
    end;
}
