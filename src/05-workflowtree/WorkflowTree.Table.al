table 83805 "Workflow Tree WFE"
{
    Caption = 'Workflow Tree';
    DataClassification = SystemMetadata;
    Permissions =
        tabledata "Workflow Tree WFE" = r;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(10; "Step ID"; Integer)
        {
            Caption = 'Step ID';
        }
        field(20; "Previous Step ID"; Integer)
        {
            Caption = 'Previous Step ID';
        }
        field(30; "Next Step ID"; Integer)
        {
            Caption = 'Next Step ID';
        }
        field(40; "Function Name"; Text[128])
        {
            Caption = 'Function Name';
        }
        field(50; "Sequence No."; Integer)
        {
            Caption = 'Sequence No.';
        }
        field(60; Type; Enum "Workflow Step Type WFE")
        {
            Caption = 'Type';
        }
        field(70; Depth; Integer)
        {
            AllowInCustomizations = AsReadOnly;
            Caption = 'Depth';
        }
        field(80; "Value"; Text[2048])
        {
            Caption = 'Value';
        }
        field(90; Description; Text[250])
        {
            Caption = 'Description';
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(StepID; "Step ID") { }
    }

    procedure GotoNextStepID()
    begin
        if Rec."Next Step ID" = 0 then
            exit;

        Rec.Reset();
        Rec.SetRange("Step ID", Rec."Next Step ID");
        if Rec.FindFirst() then; // Pointer
        Rec.Reset();
    end;
}