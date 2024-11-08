table 83802 "Workflow Event Log WPTE"
{
    Caption = 'Workflow Event Log';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
        }
        field(2; ID; Guid)
        {
            Caption = 'ID';
            ToolTip = 'Specifies the value of the ID field.', Comment = '%';
        }
        field(3; "Workflow Code"; Code[20])
        {
            Caption = 'Workflow Code';
            TableRelation = "Workflow Step"."Workflow Code";
            ToolTip = 'Specifies the value of the Workflow Code field.', Comment = '%';
        }
        field(4; "Workflow Step ID"; Integer)
        {
            Caption = 'Workflow Step ID';
            TableRelation = "Workflow Step".ID where("Workflow Code" = field("Workflow Code"));
            ToolTip = 'Specifies the value of the Workflow Step ID field.', Comment = '%';
        }
        field(11; "Record ID"; RecordID)
        {
            Caption = 'Record ID';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the value of the Record ID field.', Comment = '%';
        }
        field(17; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Inactive,Active,Completed,Ignored,Processing';
            OptionMembers = Inactive,Active,Completed,Ignored,Processing;
            ToolTip = 'Specifies the value of the Status field.', Comment = '%';
        }
        field(21; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Event,Response';
            OptionMembers = "Event",Response;
            ToolTip = 'Specifies the value of the Type field.', Comment = '%';
        }
        field(22; "Function Name"; Code[128])
        {
            Caption = 'Function Name';
            TableRelation = if (Type = const(Event)) "Workflow Event"
            else
            if (Type = const(Response)) "Workflow Response";
            ToolTip = 'Specifies the value of the Function Name field.', Comment = '%';
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