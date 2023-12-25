pageextension 50002 "Employee Ext" extends "Employee Card"
{
    layout
    {
        addlast(Administration)
        {
            /*field("Time Sheet Owner User ID";Rec."Time Sheet Owner User ID")
            {
                ApplicationArea = All;
                Caption = 'Time Sheet Owner User ID';
                ToolTip = 'Time Sheet Owner User ID';
            }*/
            field("Time Sheet Approver User ID"; Rec."Time Sheet Approver User ID")
            {
                ApplicationArea = All;
                Caption = 'User ID';
                ToolTip = 'User ID';
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
                    Caption = 'Employee Leave Setup';
                    Image = Absence;
                    ApplicationArea = All;
                    RunObject = Page "Employee Leave Setup Page";
                    RunPageLink = "Employee No." = FIELD("No.");
                    ToolTip = 'View Employee Leave';
                }
                action(CSVImport)
                {
                    Caption = 'CSV Import';
                    Image = Import;
                    ApplicationArea = All;
                    RunObject = Page "CSV Import";
                    RunPageLink = "Employee ID" = FIELD("No.");
                    ToolTip = 'CSV Import';
                }
            }

        }
    }
}
