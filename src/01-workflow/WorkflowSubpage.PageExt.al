pageextension 83801 "Workflow Subpage WPTE" extends "Workflow Subpage"
{
    actions
    {
        addlast(processing)
        {
            group(TestExt)
            {
                Caption = 'Test Ext.';
                Image = TestDatabase;

                action(ShowBuffer)
                {
                    ApplicationArea = All;
                    Caption = 'Show Buffer';

                    trigger OnAction()
                    begin
                        Page.Run(Page::"Workflow Step Buffer WPTE", Rec);
                    end;
                }
            }
        }
    }
}
