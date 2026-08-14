tableextension 83801 "Workflow Step Buffer WFE" extends "Workflow Step Buffer"
{
    fields
    {
        field(83800; "Function Name"; Text[100])
        {
            AllowInCustomizations = AsReadOnly;
            Caption = 'Function Name';
            DataClassification = CustomerContent;
        }
    }
}