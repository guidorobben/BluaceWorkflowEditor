table 83805 "Workflow Tree WFE"
{
    Caption = 'Workflow Tree';
    DataClassification = SystemMetadata;

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
        field(40; "Function Name"; Text[250])
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
    }
}