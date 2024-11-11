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
                        Caption = 'Delete Current Entry';
                        Image = Delete;

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
                        Image = Open;

                        trigger OnAction()
                        begin
                            ApprovalEntryHelperWPTE.SetApprovalEntryToStatusOpen(Rec);
                        end;
                    }
                    action(EntryStatusApprovedWPTE)
                    {
                        ApplicationArea = All;
                        Caption = 'Approved';
                        Image = Approve;

                        trigger OnAction()
                        begin
                            ApprovalEntryHelperWPTE.SetApprovalEntryToStatusApproved(Rec);
                        end;
                    }
                    action(EntryStatusCanceledWPTE)
                    {
                        ApplicationArea = All;
                        Caption = 'Canceled';
                        Image = Cancel;

                        trigger OnAction()
                        begin
                            ApprovalEntryHelperWPTE.SetApprovalEntryToStatusCanceled(Rec);
                        end;
                    }
                    action(EntryStatusCreatedWPTE)
                    {
                        ApplicationArea = All;
                        Caption = 'Created';
                        Image = Create;

                        trigger OnAction()
                        begin
                            ApprovalEntryHelperWPTE.SetApprovalEntryToStatusCreated(Rec);
                        end;
                    }
                    action(EntryStatusRejectedWPTE)
                    {
                        ApplicationArea = All;
                        Caption = 'Rejected';
                        Image = Reject;

                        trigger OnAction()
                        begin
                            ApprovalEntryHelperWPTE.SetApprovalEntryToStatusRejected(Rec);
                        end;
                    }
                }
            }
        }
    }

    var
        ApprovalEntryHelperWPTE: Codeunit "Approval Entry Helper WPTE";
}