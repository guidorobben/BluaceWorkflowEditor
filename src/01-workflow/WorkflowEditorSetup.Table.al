table 83801 "Workflow Editor Setup WPTE"
{
    Caption = 'Workflow Editor Setup';
    DataClassification = CustomerContent;
    LookupPageId = "Workflow Editor Setup WPTE";
    DrillDownPageId = "Workflow Editor Setup WPTE";

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            AllowInCustomizations = Never;
            Caption = 'Primary Key';
            NotBlank = false;
        }
        field(10; "Disable Mail Notifications"; Boolean)
        {
            Caption = 'Disable Mail Notifications';
            ToolTip = 'Specifies the value of the "Disable Mail Notifications field.', Comment = '%';
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    procedure InsertIfNotExists()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            rec.Init();
            Rec.Insert(true);
        end;
    end;
}