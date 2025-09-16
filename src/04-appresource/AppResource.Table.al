table 83800 "App Resource WFE"
{
    Caption = 'App Resource';
    DataClassification = CustomerContent;
    LookupPageId = "App Resource List WFE";
    DrillDownPageId = "App Resource List WFE";
    TableType = Temporary;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            ToolTip = 'Specifies the entry number of the resource.';
        }
        field(10; Name; Text[1024])
        {
            Caption = 'Name';
            ToolTip = 'Specifies the name of the resource.';
        }
        field(20; Folder; Boolean)
        {
            AllowInCustomizations = Always;
            Caption = 'Folder';
            ToolTip = 'Specifies if the entry is a folder.';
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

    var
        AppResourceHandler: Codeunit "App Resource Handler WFE";
        LastEntryNo: Integer;

    procedure SetNewEntryNo()
    begin
        LastEntryNo += 1;
        "Entry No." := LastEntryNo;
    end;

    procedure Download()
    begin
        AppResourceHandler.DownloadResource(Rec);
    end;

    procedure LoadResources()
    begin
        AppResourceHandler.GetResources(Rec, '');
    end;
}