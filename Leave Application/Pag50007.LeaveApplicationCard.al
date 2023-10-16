page 50007 "Leave Application Card"
{
    // ApplicationArea = All;
    Caption = 'Leave Application';
    PageType = Card;
    SourceTable = "Leave Application";
    AutoSplitKey = true;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Employee No."; Rec."Employee No.")
                {
                    ToolTip = 'Specifies the value of the Employee No. field.';
                    Editable = false;
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.';
                    Editable = false;
                }
                field("From Date"; Rec."From Date")
                {
                    ToolTip = 'Specifies the value of the From Date field.';
                }
                field("To Date"; Rec."To Date")
                {
                    ToolTip = 'Specifies the value of the To Date  field.';
                }
                field("Leave Type"; Rec."Leave Type")
                {
                    ToolTip = 'Specifies the value of the Leave Type field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Leave Quantity"; Rec."Leave Quantity")
                {
                    ToolTip = 'Specifies the value of the Leave Quantity field.';
                }
                field("Leave Remaining"; Rec."Leave Remaining")
                {
                    ToolTip = 'Specifies the value of the Leave Remaining field.';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ToolTip = 'Specifies the value of the Unit of Measure Code field.';
                }
                field(Comment; Rec.Comment)
                {
                    ToolTip = 'Specifies the value of the Comment field.';
                }
                field("Status"; Rec."Status")
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(LeaveUpdate)
            {
                ApplicationArea = All;
                Caption = 'Calulate Leave Remaining';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = CalculateRemainingUsage;

                trigger OnAction()
                begin
                    CalculateLeaveRemaining();
                end;
            }
            action("Comments")
            {
                ApplicationArea = All;
                Caption = 'Comments';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = CalculateRemainingUsage;
                RunObject = Page "Human Resource Comment Sheet";
                RunPageLink = "Table Name" = CONST("Employee Absence"),
                                  "Table Line No." = FIELD("Entry No.");
                ToolTip = 'View or add comments for the record.';
            }
            group(ApproveRequest)
            {
                Caption = 'ApproveRequest';
                Image = Approval;

                action(Open)
                {
                    ApplicationArea = Suite;
                    Image = Open;

                    trigger OnAction()
                    var
                        leaveapplication: Record "Leave Application";
                    begin
                        leaveapplication.Get(Rec."Employee No.", Rec."Entry No.");
                        leaveapplication.Status := Rec.Status::Open;
                        leaveapplication.Modify(true);
                        IsEditable := true;
                    end;


                }
                action(SendApprovalRequest)
                {
                    ApplicationArea = Suite;
                    Image = SendApprovalRequest;

                    trigger OnAction()
                    var
                        leaveapplication: Record "Leave Application";
                    begin
                        leaveapplication.Get(Rec."Employee No.", Rec."Entry No.");
                        leaveapplication.Status := Rec.Status::Pending;
                        leaveapplication.Modify(true);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Suite;
                    Image = CancelApprovalRequest;

                    trigger OnAction()
                    var
                        leaveapplication: Record "Leave Application";
                    begin
                        leaveapplication.Get(Rec."Employee No.", Rec."Entry No.");
                        leaveapplication.Status := Rec.Status::Open;
                        leaveapplication.Modify(true);
                    end;
                }
                action(Approved)
                {
                    ApplicationArea = Suite;
                    Image = Approve;

                    trigger OnAction()
                    var
                        leaveapplication: Record "Leave Application";
                    begin
                        leaveapplication.Get(Rec."Employee No.", Rec."Entry No.");
                        leaveapplication.Status := Rec.Status::Approved;
                        leaveapplication.Modify(true);
                    end;
                }
            }
        }
    }
    var
        IsEditable: Boolean;

    local procedure CalculateLeaveRemaining()
    var
        LeaveApplication: Record "Leave Application";
        Absence: Record "Employee Absence";
        Employee: Record Employee;
        EmployeeLeave: Record "Employee Leave";
        Total: Integer;
        "Current Year": Integer;
        CurrRemaining: Integer;
    begin
        // Employee.SetRange("No.", Rec."Employee No.");
        "Current Year" := Date2DMY(WorkDate, 3);
        LeaveApplication.SetRange("Employee No.", Rec."Employee No.");
        LeaveApplication.FindSet();
        LeaveApplication."Leave Quantity" := LeaveApplication."To Date" - LeaveApplication."From Date";
        LeaveApplication.Modify();
        EmployeeLeave.SetRange("Employee No.", LeaveApplication."Employee No.");
        EmployeeLeave.SetRange("Leave Type", LeaveApplication."Leave Type");
        if EmployeeLeave.FindSet() then
            LeaveApplication."Leave Remaining" := EmployeeLeave."Leave Remaining";
        if LeaveApplication."Leave Remaining" < 1 then
            Message('You do nat have enough leave remaining.');
        LeaveApplication.Modify();
    end;

    trigger OnInit()
    begin
        IsEditable := true;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        if (Rec.Status <> Rec.Status::Open) then
            IsEditable := false;
    end;
}