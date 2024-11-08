// page 83806 "Workflow Event Monitor WPTE"
// {
//     ApplicationArea = All;
//     Caption = 'Workflow Event Monitor';
//     DeleteAllowed = false;
//     Editable = false;
//     InsertAllowed = false;
//     ModifyAllowed = false;
//     PageType = List;
//     SourceTable = "Workflow Event Monitor WPTE";
//     UsageCategory = History;

//     layout
//     {
//         area(Content)
//         {
//             repeater(General)
//             {
//                 field("Entry No."; Rec."Entry No.") { }
//                 field("Function Name"; Rec."Function Name") { }
//                 field("Record-Id"; Rec."Record-Id") { }
//                 field(SystemCreatedAt; Rec.SystemCreatedAt)
//                 {
//                     ToolTip = 'Specifies the value of the SystemCreatedAt field.', Comment = '%'; //FIXME
//                 }
//             }
//         }
//     }
// }
