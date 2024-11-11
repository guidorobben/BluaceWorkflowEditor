page 83811 "Workflow Event Log WPTE"
{
    ApplicationArea = All;
    Caption = 'Workflow Event Log';
    Editable = false;
    PageType = List;
    SourceTable = "Workflow Event Log WPTE";
    UsageCategory = History;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    Editable = false;
                }
                field(ID; Rec.ID) { }
                field("Workflow Code"; Rec."Workflow Code") { }
                field("Workflow Step ID"; Rec."Workflow Step ID") { }
                field("Record ID"; Format(Rec."Record ID"))
                {
                    Caption = 'Record ID';
                }
                field(Type; Rec."Type") { }
                field("Function Name"; Rec."Function Name") { }
                field(Status; Rec.Status) { }
                field("Notification Req. Curr. User"; Rec."Notification Req. Curr. User") { }
                field("Notify Sender Required"; Rec."Notify Sender Required") { }
                field("Notification Type"; Rec."Notification Type") { }
                field("Approver ID"; Rec."Approver ID") { }
                field("Sender ID"; Rec."Sender ID") { }

                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ClearLog)
            {
                Caption = 'Clear Log';
                Image = ClearLog;
                ToolTip = 'Empties the log.';

                trigger OnAction()
                begin
                    Rec.ClearLog();
                end;
            }
        }

        area(Navigation)
        {
            action(ShowRecord)
            {
                ApplicationArea = Suite;
                Caption = 'Record';
                Image = Document;
                ToolTip = 'Open the document, journal line, or card that the event log is for.';

                trigger OnAction()
                begin
                    Rec.ShowRecord();
                end;
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process';

                actionref(ShowRecord_Promoted; ShowRecord) { }
                actionref(ClearLog_Promoted; ClearLog) { }

            }
        }
    }
}