table 83803 "Info Dialog WPTE"
{
    Caption = 'Info Buffer';
    DataClassification = SystemMetadata;
    DrillDownPageId = "Info Dialog WPTE";
    LookupPageId = "Info Dialog WPTE";
    TableType = Temporary;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
        }
        field(10; Name; Text[100])
        {
            Caption = 'Name';
            ToolTip = 'Specifies the value of the Variable Name field.', Comment = '%';
        }
        field(20; Value; Text[100])
        {
            Caption = 'Value';
            ToolTip = 'Specifies the value of the Variable Value field.', Comment = '%';
        }
        field(30; "Event Code"; Code[128])
        {
            Caption = 'Event Code';
            ToolTip = 'Event Code.'; //FIXME
        }
        field(100; Header; Boolean)
        {
            Caption = 'Header';
            ToolTip = 'Specifies the value of the Header field.', Comment = '%';
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

    procedure ActivateEventCode()
    var
        InfoDialogHelper: Codeunit "Info Dialog Helper WPTE";
    begin
        InfoDialogHelper.ActivateEventCode(Rec);
    end;
}
