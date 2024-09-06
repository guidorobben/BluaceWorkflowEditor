table 83802 "WF Event Log WPTE"
{
    Caption = 'WF Event Log';
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

    procedure AddResponse(var Variant: Variant; ResponseWorkflowStepInstance: Record "Workflow Step Instance")
    var
        WFEventLog: Record "WF Event Log WPTE";
    begin
        if not IsLoggingEnabled() then
            exit;

        WFEventLog.Init();
        WFEventLog."Entry No." := GetNextEntryNo();
        WFEventLog.ID := ResponseWorkflowStepInstance.ID;
        WFEventLog."Workflow Code" := ResponseWorkflowStepInstance."Workflow Code";
        WFEventLog."Workflow Step ID" := ResponseWorkflowStepInstance."Workflow Step ID";
        WFEventLog."Record ID" := ResponseWorkflowStepInstance."Record ID";
        WFEventLog.Status := ResponseWorkflowStepInstance.Status;
        WFEventLog.Type := ResponseWorkflowStepInstance.Type;
        WFEventLog."Function Name" := ResponseWorkflowStepInstance."Function Name";
        WFEventLog.Insert(true);
    end;

    local procedure GetNextEntryNo() EntryNo: Integer
    var
        WFEventLog: Record "WF Event Log WPTE";
    begin
        WFEventLog.SetLoadFields("Entry No.");
        if WFEventLog.FindLast() then
            EntryNo := WFEventLog."Entry No.";
        EntryNo += 1;
    end;

    local procedure IsLoggingEnabled(): Boolean
    var
        WorkflowEditorSetup: Record "Workflow Editor Setup WPTE";
    begin
        if not WorkflowEditorSetup.Get() then
            exit;

        exit(WorkflowEditorSetup."Log Workflow Events");
    end;
}