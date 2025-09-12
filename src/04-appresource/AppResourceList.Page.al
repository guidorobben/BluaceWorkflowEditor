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
                Enabled = ActionsEnabled;
                Visible = ActionsVisible;

                trigger OnAction()
                begin
                    Rec.Download();
                end;
            }
            action(LoadResources)
            {
                Caption = 'Load Resources';
                Image = Resource;
                Enabled = ActionsEnabled;
                Visible = ActionsVisible;

                trigger OnAction()
                begin
                    Rec.LoadResources();
                end;
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Home';

                actionref(DownloadResource_Promoted; DownloadResource) { }
                actionref(LoadResources_Promoted; LoadResources) { }
            }
        }
    }

    var
        ActionsEnabled, ActionsVisible : Boolean;

    trigger OnOpenPage()
    begin
        ActionsVisible := true;
        ActionsEnabled := true;
    end;
}