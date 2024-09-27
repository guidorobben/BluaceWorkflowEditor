pageextension 83800 "Approval Entries WPTE" extends "Approval Entries"
{

    actions
    {
        addlast(processing)
        {
            group(WorkflowEditorWPTE)
            {
                Caption = 'Workflow Editor';
                Image = Workflow;

                group(DeleteEntryGroupWPTE)
                {
                    Caption = 'Delete';

                    action(DeleteEntryWPTE)
                    {
                        ApplicationArea = All;
                        Caption = 'Delete Entry';

                        trigger OnAction()
                        begin
                            ApprovalEntryHelperWPTE.DeleteEntry(Rec);
                        end;
                    }
                    // action(DeleteAllEntriesWPTE)
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'Delete All Entries';

                    //     trigger OnAction()
                    //     begin
                    //         ApprovalEntryHelperWPTE.DeleteAllentries(Rec);
                    //     end;
                    // }
                }
                group(EntryStatusWPTE)
                {
                    Caption = 'Status';

                    action(EntryStatusOpenWPTE)
                    {
                        ApplicationArea = All;
                        Caption = 'Open';

                        trigger OnAction()
                        begin
                            ApprovalEntryHelperWPTE.SetApprovalEntryToStatusOpen(Rec);
                        end;
                    }
                    action(EntryStatusApprovedWPTE)
                    {
                        ApplicationArea = All;
                        Caption = 'Approved';

                        trigger OnAction()
                        begin
                            ApprovalEntryHelperWPTE.SetApprovalEntryToStatusApproved(Rec);
                        end;
                    }
                    action(EntryStatusCanceledWPTE)
                    {
                        ApplicationArea = All;
                        Caption = 'Canceled';

                        trigger OnAction()
                        begin
                            ApprovalEntryHelperWPTE.SetApprovalEntryToStatusCanceled(Rec);
                        end;
                    }
                    action(EntryStatusCreatedWPTE)
                    {
                        ApplicationArea = All;
                        Caption = 'Created';

                        trigger OnAction()
                        begin
                            ApprovalEntryHelperWPTE.SetApprovalEntryToStatusCreated(Rec);
                        end;
                    }
                    action(EntryStatusRejectedWPTE)
                    {
                        ApplicationArea = All;
                        Caption = 'Rejected';

                        trigger OnAction()
                        begin
                            ApprovalEntryHelperWPTE.SetApprovalEntryToStatusApproved(Rec);
                        end;
                    }
                }
            }
        }
    }

    var
        ApprovalEntryHelperWPTE: Codeunit "Approval Entry Helper WPTE";
}