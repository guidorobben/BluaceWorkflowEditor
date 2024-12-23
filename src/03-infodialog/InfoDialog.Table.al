table 83803 "Info Dialog WFE"
{
    Caption = 'Info Buffer';
    DataClassification = SystemMetadata;
    DrillDownPageId = "Info Dialog WFE";
    LookupPageId = "Info Dialog WFE";
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
        field(30; "Event Code"; Enum "Info Dialog Event Code WFE")
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
        InfoDialogHelper: Codeunit "Info Dialog Helper WFE";
    begin
        InfoDialogHelper.ActivateEventCode(Rec);
    end;

    procedure GetValueAsGuid() Result: Guid
    begin
        if Evaluate(Result, Value) then; //No Error
    end;
}
