table 83802 "Workflow Event Log WFE"
{
    Caption = 'Workflow Event Log';
    DataClassification = CustomerContent;
    DrillDownPageId = "Workflow Event Log WFE";
    LookupPageId = "Workflow Event Log WFE";

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
        field(11; "Record ID"; RecordId)
        {
            Caption = 'Record ID';
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
        field(83800; "Notification Req. Curr. User"; Boolean)
        {
            Caption = 'Notification Required Current User';
            ToolTip = 'Specifies the value of the Notification Required Current User field.', Comment = '%';
        }
        field(83810; "Notify Sender Required"; Boolean)
        {
            Caption = 'Notify Sender Required';
            ToolTip = 'Specifies the value of the Notify Sender Required field.', Comment = '%';
        }
        field(83820; "Approver ID"; Code[50])
        {
            Caption = 'Approver ID';
            DataClassification = EndUserIdentifiableInformation;
            TableRelation = User."User Name";
            ToolTip = 'Specifies the value of the Approver ID field.', Comment = '%';
        }
        field(83830; "Sender ID"; Code[50])
        {
            Caption = 'Sender ID';
            DataClassification = EndUserIdentifiableInformation;
            TableRelation = User."User Name";
            ToolTip = 'Specifies the value of the Sender ID field.', Comment = '%';
        }
        field(83840; "Notification Type"; Enum "Notification Entry Type")
        {
            Caption = 'Notification Type';
            ToolTip = 'Specifies the value of the Type field.', Comment = '%';
        }
        field(83850; "Record Trigger Type"; Enum "Record Trigger Type WFE")
        {
            AllowInCustomizations = Always;
            Caption = 'Record Trigger Type';
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
        WorkflowEventLogHlp: Codeunit "Workflow Event Log Hlp. WFE";

    procedure ClearLog()
    begin
        WorkflowEventLogHlp.ClearLog();
    end;

    procedure ShowRecord()
    begin
        WorkflowEventLogHlp.ShowRecord(Rec);
    end;
}