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
                field("Debug Modify Purchase Header"; Rec."Debug Modify Purchase Header") { }
                field("Debug Modify Purch. Inv Header"; Rec."Debug Modify Purch. Inv Header") { }
                field("Debug Modify Sales Header"; Rec."Debug Modify Sales Header") { }

            }
            group(Extensions)
            {
                Caption = 'Extensions';

                field("Posted Purch. Inv. Status ID"; Rec."Posted Purch. Inv. Status ID")
                {
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        OnLookupStatusFieldId();
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.InsertIfNotExists();
    end;

    local procedure OnLookupStatusFieldId()
    var
        AllField: Record Field;
    begin
        AllField.SetRange(TableNo, Database::"Purch. Inv. Header");
        if Page.RunModal(Page::"Fields Lookup", AllField) = Action::LookupOK then
            Rec."Posted Purch. Inv. Status ID" := AllField."No.";
    end;
}