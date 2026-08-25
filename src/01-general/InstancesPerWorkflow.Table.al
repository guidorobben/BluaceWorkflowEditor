table 83806 "Instances Per Workflow WFE"
{
    Caption = 'Instances Per Workflow';
    DataClassification = SystemMetadata;
    Permissions =
        tabledata "Instances Per Workflow WFE" = r,
        tabledata Workflow = r;
    TableType = Temporary;

    fields
    {
        field(666; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(1; "Instance ID"; Guid)
        {
            Caption = 'Instance ID';
        }
        field(2; "Workflow Code"; Code[20])
        {
            Caption = 'Workflow Code';
            TableRelation = "Workflow Step"."Workflow Code";
        }
        field(4; Description; Text[100])
        {
            CalcFormula = lookup(Workflow.Description where(Code = field("Workflow Code")));
            Caption = 'Description';
            Editable = false;
            FieldClass = FlowField;
        }
        // field(9; "Entry Point"; Boolean)
        // {
        //     Caption = 'Entry Point';
        // }
        field(11; "Record ID"; RecordId)
        {
            Caption = 'Record ID';
            DataClassification = CustomerContent;
        }
        field(12; "Created Date-Time"; DateTime)
        {
            Caption = 'Created Date-Time';
            Editable = false;
        }
        field(13; "Created By User ID"; Code[50])
        {
            Caption = 'Created By User ID';
            DataClassification = EndUserIdentifiableInformation;
            Editable = false;
            TableRelation = User."User Name";
        }
        // field(14; "Last Modified Date-Time"; DateTime)
        // {
        //     Caption = 'Last Modified Date-Time';
        //     Editable = false;
        // }
        // field(15; "Last Modified By User ID"; Code[50])
        // {
        //     Caption = 'Last Modified By User ID';
        //     DataClassification = EndUserIdentifiableInformation;
        //     Editable = false;
        //     TableRelation = User."User Name";
        // }
        // field(17; Status; Option)
        // {
        //     Caption = 'Status';
        //     OptionCaption = 'Inactive,Active,Completed,Ignored,Processing';
        //     OptionMembers = Inactive,Active,Completed,Ignored,Processing;
        // }
        // field(18; "Previous Workflow Step ID"; Integer)
        // {
        //     Caption = 'Previous Workflow Step ID';
        // }
        // field(19; "Next Workflow Step ID"; Integer)
        // {
        //     Caption = 'Next Workflow Step ID';
        // }
        // field(21; Type; Option)
        // {
        //     Caption = 'Type';
        //     OptionCaption = 'Event,Response';
        //     OptionMembers = "Event",Response;
        // }
        // field(22; "Function Name"; Code[128])
        // {
        //     Caption = 'Function Name';
        //     TableRelation = if (Type = const(Event)) "Workflow Event"
        //     else
        //     if (Type = const(Response)) "Workflow Response";
        // }
        // field(23; Argument; Guid)
        // {
        //     Caption = 'Argument';
        //     TableRelation = "Workflow Step Argument" where(Type = field(Type));
        // }
        // field(30; "Original Workflow Code"; Code[20])
        // {
        //     Caption = 'Original Workflow Code';
        //     TableRelation = "Workflow Step"."Workflow Code";
        // }
        // field(31; "Original Workflow Step ID"; Integer)
        // {
        //     Caption = 'Original Workflow Step ID';
        //     TableRelation = "Workflow Step".ID where("Workflow Code" = field("Original Workflow Code"));
        // }
        // field(32; "Sequence No."; Integer)
        // {
        //     Caption = 'Sequence No.';
        // }
        field(83800; "Document Status"; Enum "Purchase Document Status")
        {
            Caption = 'Document Status';
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
        InstancesPerWorkflowHlp: Codeunit "Instances Per Workflow Hlp WFE";

    internal procedure WorkflowCodeOnDrillDown()
    begin
        InstancesPerWorkflowHlp.WorkflowCodeOnDrillDown(Rec);
    end;

    internal procedure OpenDocument()
    begin
        InstancesPerWorkflowHlp.OpenDocument(Rec);
    end;
}