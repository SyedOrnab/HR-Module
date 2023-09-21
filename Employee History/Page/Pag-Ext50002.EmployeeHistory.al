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
            action(ShowEmployeeTraining)
            {
                Caption = 'Employee Training';
                Image = UserCertificate;
                ApplicationArea = All;
                RunObject = Page "Employee Training Page";
                RunPageLink = "Employee No." = FIELD("No.");
                ToolTip = 'View Employee Training';
            }
        }
    }
}
