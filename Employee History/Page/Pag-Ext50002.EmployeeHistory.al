pageextension 50002 "Employee History" extends "Employee Card"
{
    layout
    {
        addlast(Administration)
        {
            field("User ID";Rec."User ID")
            {
                ApplicationArea = All;
                Caption='User ID';
            }
        }
    }
    actions
    {
        addafter("E&mployee")
        {
            group("HR-module")
            {
                Image = HumanResources;
                action(ShowLeaveApplication)
                {
                    Caption = 'Leave Application';
                    Image = AbsenceCategories;
                    ApplicationArea = All;
                    RunObject = Page "Leave Application Page";
                    RunPageLink = "Employee No." = FIELD("No.");
                    ToolTip = 'View Leave Application';
                }
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
                action(ShowEmployeeLeave)
                {
                    Caption = 'Employee Leave';
                    Image = Absence;
                    ApplicationArea = All;
                    RunObject = Page "Employee Leave Page";
                    RunPageLink = "Employee No." = FIELD("No.");
                    ToolTip = 'View Employee Leave';
                }
            }

        }
    }
}
