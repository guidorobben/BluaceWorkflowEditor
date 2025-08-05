page 83804 "Workflow Step Instance WFE"
{
    ApplicationArea = All;
    Caption = 'Workflow Step Instance';
    DeleteAllowed = false;
    // Editable = false;
    InsertAllowed = false;
    PageType = List;
    Permissions =
        tabledata "Table Metadata" = R,
        tabledata "Workflow - Table Relation" = R,
        tabledata "Workflow Event" = R,
        tabledata "Workflow Response" = R,
        tabledata "Workflow Step Argument" = R,
        tabledata "Workflow Step Instance" = RIMD;
    SourceTable = "Workflow Step Instance";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(ID; Rec.ID)
                {
                    ToolTip = 'Specifies the ID of the workflow step instance.';
                }
                field("Function Name"; Rec."Function Name")
                {
                    ToolTip = 'Specifies the name of the function that is used by the workflow step instance.';

                    trigger OnDrillDown()
                    begin
                        FunctionNameOnDrillDown();
                    end;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the workflow step instance.';
                    Visible = false;
                }
                field(Type; Rec."Type")
                {
                    ToolTip = 'Specifies if the workflow step instance is an event, a response, or a sub-workflow.';
                }
                field("Sequence No."; Rec."Sequence No.")
                {
                    ToolTip = 'Specifies the value of the Sequence No. field.', Comment = '%';
                }
                field("Entry Point"; Rec."Entry Point")
                {
                    ToolTip = 'Specifies the workflow step that starts the workflow. The first workflow step is always of type Entry Point.';
                }
                field(Status; Rec.Status)
                {
#pragma warning disable LC0038
                    ToolTip = 'Specifies the status of the workflow step instance. Active means that the step instance in ongoing. Completed means that the workflow step instance is done. Ignored means that the workflow step instance was skipped in favor of another path.';
#pragma warning restore LC0038
                }
                field("Workflow Step ID"; Rec."Workflow Step ID")
                {
                    ToolTip = 'Specifies the ID of workflow step in the workflow that the workflow step instance belongs to.';
                }
                field("Original Workflow Step ID"; Rec."Original Workflow Step ID")
                {
                    ToolTip = 'Specifies the value of the Original Workflow Step ID field.', Comment = '%';
                }
                field("Next Workflow Step ID"; Rec."Next Workflow Step ID")
                {
                    ToolTip = 'Specifies another workflow step than the next one in the sequence that you want to start, for example, because the event on the workflow step failed to meet a condition.';
                }
                field("Previous Workflow Step ID"; Rec."Previous Workflow Step ID")
                {
#pragma warning disable LC0038
                    ToolTip = 'Specifies the step that you want to precede the step that you are specifying on the line. You use this field to specify branching of steps when one of multiple possible events does not occur and you want the following step to specify another possible event as a branch of the previous step. In this case, both steps have the same value in the Previous Workflow Step ID field.';
#pragma warning restore LC0038
                }
                field(Argument; Rec.Argument)
                {
                    ToolTip = 'Specifies the values of the parameters that are required by the workflow step instance.';

                    trigger OnDrillDown()
                    begin
                        ArgumentOnDrillDown();
                    end;
                }
                field("Created By User ID"; Rec."Created By User ID")
                {
                    ToolTip = 'Specifies the user who created the workflow step instance.';
                    Visible = false;
                }
                field("Created Date-Time"; Rec."Created Date-Time")
                {
                    ToolTip = 'Specifies the date and time when the workflow step instance was created.';
                    Visible = false;
                }
                field("Last Modified By User ID"; Rec."Last Modified By User ID")
                {
                    ToolTip = 'Specifies the user who last participated in the workflow step instance.';
                    Visible = false;
                }
                field("Last Modified Date-Time"; Rec."Last Modified Date-Time")
                {
                    ToolTip = 'Specifies the date and time when a user last participated in the workflow step instance.';
                    Visible = false;
                }
                field("Original Workflow Code"; Rec."Original Workflow Code")
                {
                    ToolTip = 'Specifies the value of the Original Workflow Code field.', Comment = '%';
                    Visible = false;
                }
                field("Record ID"; Format(Rec."Record ID"))
                {
                    Caption = 'Record Id';
                    ToolTip = 'Specifies the value of the Record ID field.', Comment = '%';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.', Comment = '%';
                    Visible = false;
                }
                field("Workflow Code"; Rec."Workflow Code")
                {
                    ToolTip = 'Specifies the workflow that the workflow step instance belongs to.';
                    Visible = false;
                }
            }
            // part("Workflow Step Argument Part"; "Workflow Step Argument WFE")
            // {
            //     Editable = false;
            //     SubPageLink = ID = field(Argument);
            // }
            // part("Workflow Rule Part"; "Workflow Rule Part WFE")
            // {
            //     Editable = false;
            //     SubPageLink = "Workflow Code" = field("Workflow Code"), "Workflow Step ID" = field("Workflow Step ID"), "Workflow Step Instance ID" = field(ID);
            // }
        }
    }

    actions
    {
        area(Processing)
        {
            action(DeleteRecords)
            {
                ApplicationArea = All;
                Caption = 'Delete Records';
                Image = Delete;

                trigger OnAction()
                var
                    ConfirmManagement: Codeunit "Confirm Management";
                    UserManagement: Codeunit "User Management WFE";
                begin
                    if not ConfirmManagement.GetResponseOrDefault('Delete all records?', false) then
                        exit;

                    UserManagement.TestIsApprovalAdministrator();
                    Rec.DeleteAll(true); //Om linked records te verwijderen 
                end;
            }
        }

        area(Navigation)
        {
            action(WorkflowTableRelation)
            {
                Caption = 'Workflow Table Relations';
                // Enabled = Rec.Type = Rec.Type::"Event";
                Image = Relationship;


                trigger OnAction()
                var
                    WorkflowTableRelation: Record "Workflow - Table Relation";
                    RecRef: RecordRef;
                begin
                    if not RecRef.Get(Rec."Record ID") then
                        exit;

                    WorkflowTableRelation.SetRange("Table ID", RecRef.Number());
                    Page.Run(Page::"Workflow - Table Relations", WorkflowTableRelation);
                end;
            }
        }

        area(Promoted)
        {
            group(Process_Promoted)
            {
                Caption = 'Process';

                actionref(DeleteRecords_Promoted; DeleteRecords) { }
                actionref(WorkflowTableRelation_Promoted; WorkflowTableRelation) { }
            }
        }
    }

    views
    {
        view(Events)
        {
            Caption = 'Events';
            Filters = where(Type = filter(Event));
            SharedLayout = true;
        }
        view(Response)
        {
            Caption = 'Response';
            Filters = where(Type = filter(Response));
            SharedLayout = true;
        }
        view(Active)
        {
            Caption = 'Active';
            Filters = where(Status = filter(Active));
            SharedLayout = true;
        }
    }

    local procedure ArgumentOnDrillDown()
    // var
    //     WorkflowStepArgument: Record "Workflow Step Argument";
    begin
        // WorkflowStepArgument.Get(Rec.Argument);
        // WorkflowStepArgument.CalcFields("Event Conditions");
        // Page.RunModal(Page::"Workflow Step Argument WFE", WorkflowStepArgument);
        OpenEventConditions();
    end;

    procedure OpenEventConditions()
    var
        WorkflowEvent: Record "Workflow Event";
        WorkflowStepArgument: Record "Workflow Step Argument";
        UserClickedOK: Boolean;
        CurrentEventFilters: Text;
        ReturnFilters: Text;
    begin
        // TestField(Type, Type::"Event");
        // TestField("Function Name");

        if not WorkflowEvent.Get(Rec."Function Name") then
            exit;

        if WorkflowStepArgument.Get(Rec.Argument) then
            CurrentEventFilters := WorkflowStepArgument.GetEventFilters()
        else
            CurrentEventFilters := CreateDefaultRequestPageFilters(WorkflowEvent);

        UserClickedOK := RunRequestPage(WorkflowEvent, ReturnFilters, CurrentEventFilters);
        // if UserClickedOK and (ReturnFilters <> CurrentEventFilters) then begin
        //     CheckEditingIsAllowed();
        //     if ReturnFilters = WorkflowEvent.CreateDefaultRequestPageFilters() then
        //         DeleteEventConditions()
        //     else begin
        //         if IsNullGuid(Argument) then
        //             CreateEventArgument(WorkflowStepArgument, Rec);
        //         WorkflowStepArgument.SetEventFilters(ReturnFilters);
        //     end;
        // end;
    end;

    procedure CreateDefaultRequestPageFilters(WorkflowEvent: Record "Workflow Event"): Text
    var
        TableMetadata: Record "Table Metadata";
        RequestPageParametersHelper: Codeunit "Request Page Parameters Helper";
        FilterPageBuilder: FilterPageBuilder;
    begin
        if not TableMetadata.Get(WorkflowEvent."Table ID") then
            exit('');

        if not RequestPageParametersHelper.BuildDynamicRequestPage(FilterPageBuilder, WorkflowEvent."Dynamic Req. Page Entity Name", WorkflowEvent."Table ID") then
            exit('');

        exit(RequestPageParametersHelper.GetViewFromDynamicRequestPage(FilterPageBuilder, WorkflowEvent."Dynamic Req. Page Entity Name", WorkflowEvent."Table ID"));
    end;

    procedure RunRequestPage(WorkflowEvent: Record "Workflow Event"; var ReturnFilters: Text; Filters: Text): Boolean
    begin
        if WorkflowEvent."Request Page ID" > 0 then
            exit(RunCustomRequestPage(WorkflowEvent, ReturnFilters, Filters));

        exit(RunDynamicRequestPage(WorkflowEvent, ReturnFilters, Filters));
    end;

    local procedure RunCustomRequestPage(WorkflowEvent: Record "Workflow Event"; var ReturnFilters: Text; Filters: Text): Boolean
    begin
        ReturnFilters := Report.RunRequestPage(WorkflowEvent."Request Page ID", Filters);

        if ReturnFilters = '' then
            exit(false);

        exit(true);
    end;

    local procedure RunDynamicRequestPage(WorkflowEvent: Record "Workflow Event"; var ReturnFilters: Text; Filters: Text): Boolean
    var
        TableMetadata: Record "Table Metadata";
        RequestPageParametersHelper: Codeunit "Request Page Parameters Helper";
        FilterPageBuilder: FilterPageBuilder;
        EventConditionsCaptionTxt: Label 'Event Conditions - %1', Comment = '%1 = Event description';
    begin
        if not TableMetadata.Get(WorkflowEvent."Table ID") then
            exit(false);

        if not RequestPageParametersHelper.BuildDynamicRequestPage(FilterPageBuilder, WorkflowEvent."Dynamic Req. Page Entity Name", WorkflowEvent."Table ID") then
            exit(false);

        if Filters <> '' then
            if not RequestPageParametersHelper.SetViewOnDynamicRequestPage(FilterPageBuilder, Filters, WorkflowEvent."Dynamic Req. Page Entity Name", WorkflowEvent."Table ID") then
                exit(false);

        FilterPageBuilder.PageCaption := StrSubstNo(EventConditionsCaptionTxt, WorkflowEvent.Description);
        if not FilterPageBuilder.RunModal() then
            exit(false);

        ReturnFilters :=
          RequestPageParametersHelper.GetViewFromDynamicRequestPage(FilterPageBuilder, WorkflowEvent."Dynamic Req. Page Entity Name", WorkflowEvent."Table ID");

        exit(true);
    end;

    local procedure FunctionNameOnDrillDown()
    var
        WorkflowEvent: Record "Workflow Event";
        WorkflowResponse: Record "Workflow Response";
    begin
        if Rec.Type = Rec.Type::"Event" then
            if WorkflowEvent.Get(Rec."Function Name") then begin
                WorkflowEvent.SetRecFilter();
                Page.RunModal(Page::"Workflow Events WFE", WorkflowEvent);
            end;

        if Rec.Type = Rec.Type::Response then
            if WorkflowResponse.Get(Rec."Function Name") then begin
                WorkflowResponse.SetRecFilter();
                Page.RunModal(Page::"Workflow Response WFE", WorkflowResponse);
            end;
    end;
}
