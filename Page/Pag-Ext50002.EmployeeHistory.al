pageextension 50002 "Employee History" extends "Employee Card"
{
    actions
    {
        addafter(AlternativeAddresses)
        {
            action(ShowEmployeeHistory)
            {
                Caption = 'Employee History';
                Image = History;
                ApplicationArea = All;
                RunObject = Page EmployeeRecordP;
                RunPageLink = "Emplyee No." = FIELD("No.");
                ToolTip = 'View Employee History';
            }
        }
    }
}
