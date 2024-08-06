table 83800 "Workflow Event Monitor WPTE"
{
    Caption = 'Workflow Event Monitor';
    DataClassification = CustomerContent;
    DrillDownPageId = "Workflow Event Monitor WPTE";
    LookupPageId = "Workflow Event Monitor WPTE";

    //TODO Vinkjes
    //Velden voor EVENTS en codes etc
    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            ToolTip = 'Specifies the value of the Entry No. field.';
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}