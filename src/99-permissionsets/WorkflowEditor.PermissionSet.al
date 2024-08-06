permissionset 83800 "Workflow Editor WPTE"
{
    Assignable = true;
    Permissions = page "WF Event/Response Combi. WPTE" = X,
        page "Workflow Events WPTE" = X,
        page "Workflow List WPTE" = X,
        page "Workflow Step Buffer WPTE" = X,
        tabledata "Workflow Event Monitor WPTE" = RIMD,
        table "Workflow Event Monitor WPTE" = X,
        page "Workflow Editor WPTE" = X,
        page "Workflow Step Instance WPTE" = X,
        tabledata "Workflow Editor Setup WPTE" = RIMD,
        table "Workflow Editor Setup WPTE" = X,
        codeunit "Approvals Mgmt Subscr. WPTE" = X,
        page "Workflow Editor Setup WPTE" = X,
        page "Workflow Event Monitor WPTE" = X;
}