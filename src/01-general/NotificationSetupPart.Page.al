page 83814 "Notification Setup Part WFE"
{
    ApplicationArea = All;
    Caption = 'Workflow Notification Setup';
    PageType = ListPart;
    RefreshOnActivate = true;
    ShowFilter = false;
    SourceTable = "Notification Setup";
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Notification Type"; Rec."Notification Type")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies what type of event the notification is about.';
                }
                field("Notification Method"; Rec."Notification Method")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the code of the notification method that is used to create notifications for the user.';
                }
                field(Schedule; Rec.Schedule)
                {
                    ApplicationArea = Suite;
                    Editable = false;
                    ToolTip = 'Specifies when the user receives notifications. The value is copied from the Recurrence field in the Notification Schedule window.';
                }
            }
        }
    }

    // actions
    // {
    //     area(Processing)
    //     {
    //         action(DeleteNotificationSetup)
    //         {
    //             ApplicationArea = All;
    //             Caption = 'Delete';
    //             Image = Delete;

    //             trigger OnAction()
    //             var
    //                 UserManagement: Codeunit "User Management WFE";
    //             begin
    //                 UserManagement.TestIsApprovalAdministrator();
    //                 Rec.Delete(true);
    //             end;
    //         }
    //     }
    // }

    // actions
    // {
    //     area(processing)
    //     {
    //         action("Notification Schedule")
    //         {
    //             ApplicationArea = Suite;
    //             Caption = 'Notification Schedule';
    //             Image = DateRange;
    //             RunObject = Page "Notification Schedule";
    //             RunPageLink = "User ID" = field("User ID"),
    //                           "Notification Type" = field("Notification Type");
    //             ToolTip = 'Specify when the user receives notifications. The value is copied from the Recurrence field in the Notification Schedule window.';
    //         }
    //     }
    //     area(Promoted)
    //     {
    //         group(Category_Process)
    //         {
    //             Caption = 'Process';

    //             actionref("Notification Schedule_Promoted"; "Notification Schedule")
    //             {
    //             }
    //         }
    // }

    // trigger OnOpenPage()
    // begin
    //     if not Rec.HasFilter then
    //         Rec.SetRange("User ID", Rec."User ID")
    //     else
    //         CurrPage.Caption := CurrPage.Caption + ': ' + Rec."User ID";
    // end;
}
