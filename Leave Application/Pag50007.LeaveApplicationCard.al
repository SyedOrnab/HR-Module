page 50007 "Leave Application Card"
{
    ApplicationArea = All;
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
                    // Editable = IsEditable;
                    Editable = false;

                }
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.';
                    // Editable = IsEditable;
                    Editable = false;
                }
                field("Leave Type"; Rec."Leave Type")
                {
                    ToolTip = 'Specifies the value of the Leave Type field.';
                    // Editable = IsEditable;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    // Editable = IsEditable;
                    Editable = false;
                }
                field("From Date"; Rec."From Date")
                {
                    ToolTip = 'Specifies the value of the From Date field.';
                    // Editable = IsEditable;
                }
                field("To Date"; Rec."To Date")
                {
                    ToolTip = 'Specifies the value of the To Date  field.';
                    // Editable = IsEditable;
                }
                field("Leave Quantity"; Rec."Leave Quantity")
                {
                    ToolTip = 'Specifies the value of the Leave Quantity field.';
                    Editable = false;
                }
                field("Leave Remaining"; Rec."Leave Remaining")
                {
                    ToolTip = 'Specifies the value of the Leave Remaining field.';
                    Editable = false;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ToolTip = 'Specifies the value of the Unit of Measure Code field.';
                    Editable = false;
                }
                field(Comment; Rec.Comment)
                {
                    ToolTip = 'Specifies the value of the Comment field.';
                    // Editable = IsEditable;
                }
                field("Status"; Rec."Status")
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    // Editable = IsEditable;
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
            group(Release)
            {
                Caption = 'ApproveRequest';
                Image = ReleaseDoc;

                action(Released)
                {
                    ApplicationArea = Suite;
                    Image = ReleaseDoc;

                    trigger OnAction()
                    var
                        EmployeeLeave: Record "Employee Leave";
                        EmployeeAbsence: Record "Employee Absence";
                        LeaveApplication: Record "Leave Application";
                        Total: Integer;
                    begin
                        // EmployeeAbsence.SetRange("Employee No.", Rec."Employee No.");
                        // EmployeeAbsence.SetRange("Cause of Absence Code", Rec."Leave Type");
                        // if EmployeeAbsence.FindSet() then
                        //     repeat
                        //         Total += EmployeeAbsence.Quantity;
                        //     until EmployeeAbsence.Next() = 0;
                        // if Total > Rec."Leave Remaining" then
                        //     Message('You do nat have enough leave remaining.');
                        // Rec.Modify(true);
                        

                        Rec.Validate("Status", Rec.Status::Released);  //Calls the OnValidate trigger for the field that you specify.
                        
                        // EmployeeLeave.Get(Rec."Employee No.", Rec."Leave Type");
                        // if EmployeeLeave."Leave Remaining" < 0 then
                        //     Message('You do not have enough leave remaining.');
                    end;
                }
                action(ReOpen)
                {
                    ApplicationArea = Suite;
                    Image = ReOpen;

                    trigger OnAction()
                    begin
                        Rec.Get(Rec."Employee No.", Rec."Entry No.");
                        Rec.Status := Rec.Status::Open;
                        Rec.Modify(true);
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
            Message('You do not have enough leave remaining.');
        LeaveApplication.Modify();
    end;

    trigger OnInit()
    begin
        IsEditable := true;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        if (Rec.Status <> Rec.Status::Open) then
            CurrPage.Editable := false;
    end;
}