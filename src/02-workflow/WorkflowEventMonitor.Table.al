// table 83800 "Workflow Event Monitor WPTE"
// {
//     Caption = 'Workflow Event Monitor';
//     DataClassification = CustomerContent;
//     DrillDownPageId = "Workflow Event Monitor WPTE";
//     LookupPageId = "Workflow Event Monitor WPTE";

//     //TODO Vinkjes
//     //Velden voor EVENTS en codes etc
//     fields
//     {
//         field(1; "Entry No."; Integer)
//         {
//             AutoIncrement = true;
//             Caption = 'Entry No.';
//             ToolTip = 'Specifies the value of the Entry No. field.';
//         }
//         field(10; "Function Name"; Code[128])
//         {
//             Caption = 'Function Name';
//             ToolTip = 'Fix.';
//         }
//         field(20; "Record-Id"; RecordId)
//         {
//             Caption = 'Record-Id';
//             ToolTip = 'Fix.';
//         }
//     }

//     keys
//     {
//         key(PK; "Entry No.")
//         {
//             Clustered = true;
//         }
//     }
// }