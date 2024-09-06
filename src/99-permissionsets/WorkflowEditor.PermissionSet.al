permissionset 83800 "Workflow Editor WPTE"
{
    Assignable = true;
    Permissions =
        table "WF Event Log WPTE" = X,
        tabledata "WF Event Log WPTE" = RIMD,
        table "Workflow Editor Setup WPTE" = X,
        tabledata "Workflow Editor Setup WPTE" = RIMD,
        table "Workflow Event Monitor WPTE" = X,
        tabledata "Workflow Event Monitor WPTE" = RIMD,
        codeunit "Approvals Mgmt Subscr. WPTE" = X,
        codeunit "Purch. Inv. Header Subscr WPTE" = X,
        codeunit "User Setup Subscr. WPTE" = X,
        codeunit "WF Resp. Handling Subscr. WPTE" = X,
        codeunit "Workflow Editor WPTE" = X,
        codeunit "Workflow Helper WPTE" = X,
        page "WF Event/Response Combi. WPTE" = X,
        page "WF Event Log WPTE" = X,
        page "Workflow Editor Setup WPTE" = X,
        page "Workflow Editor WPTE" = X,
        page "Workflow Event Monitor WPTE" = X,
        page "Workflow Event Part WPTE" = X,
        page "Workflow Events WPTE" = X,
        page "Workflow List WPTE" = X,
        page "Workflow Step Arg. Part WPTE" = X,
        page "Workflow Step Buffer WPTE" = X,
        page "Workflow Step Editor WPTE" = X,
        page "Workflow Step Instance WPTE" = X;
}