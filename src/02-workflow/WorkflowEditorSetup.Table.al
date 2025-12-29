table 83801 "Workflow Editor Setup WFE"
{
    Caption = 'Workflow Editor Setup';
    DataClassification = CustomerContent;
    DrillDownPageId = "Workflow Editor Setup WFE";
    LookupPageId = "Workflow Editor Setup WFE";
    Permissions =
        tabledata "Workflow Editor Setup WFE" = RI;
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
            ToolTip = 'Specifies the value of the "Disable Mail Notifications field.';
        }
        field(20; "Log Workflow Events"; Boolean)
        {
            Caption = 'Log Workflow Events';
            ToolTip = 'Specifies the value of the Log Workflow Events field.', Comment = '%';
        }
        field(30; "Posted Purch. Inv. Status ID"; Integer)
        {
            Caption = 'Posted Purch. Inv. Status ID';
            ToolTip = 'Specifies the status field id for the posted purchase invoice.';

            //TODO Lookup voor field
        }
        field(40; "Debug Modify Purchase Header"; Boolean)
        {
            Caption = 'Debug Modify Purchase Header';
            ToolTip = 'Enables debug logging for modifications to Purchase Header records.';
        }
        field(50; "Debug Modify Sales Header"; Boolean)
        {
            Caption = 'Debug Modify Sales Header';
            ToolTip = 'Enables debug logging for modifications to Sales Header records.';
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
            Rec.Init();
            Rec.Insert(true);
        end;
    end;
}