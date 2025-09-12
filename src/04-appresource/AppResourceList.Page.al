page 83821 "App Resource List WFE"
{
    ApplicationArea = All;
    Caption = 'App Resources';
    PageType = List;
    InsertAllowed = false;
    DeleteAllowed = false;
    Editable = false;
    SourceTable = "App Resource WFE";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    Visible = false;
                }
                field("Resource Name"; Rec."Name") { }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(DownloadResource)
            {
                Caption = 'Download';
                Image = Download;

                trigger OnAction()
                begin
                    Rec.Download();
                end;
            }
            action(LoadResources)
            {
                Caption = 'Load Resources';
                Image = Download;

                trigger OnAction()
                begin
                    Rec.LoadResources();
                end;
            }
        }
    }
}