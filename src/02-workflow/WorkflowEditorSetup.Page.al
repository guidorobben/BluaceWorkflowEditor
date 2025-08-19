page 83807 "Workflow Editor Setup WFE"
{
    ApplicationArea = All;
    Caption = 'Workflow Editor Setup';
    PageType = Card;
    SourceTable = "Workflow Editor Setup WFE";
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
            group(Extensions)
            {
                Caption = 'Extensions';

                field("Posted Purch. Inv. Status ID"; Rec."Posted Purch. Inv. Status ID") { }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.InsertIfNotExists();
    end;
}