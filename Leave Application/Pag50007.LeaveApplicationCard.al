page 50007 "Leave Application Card"
{
    ApplicationArea = All;
    Caption = 'Leave Application';
    PageType = Card;
    SourceTable = "Leave Application";

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
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.';
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
                    trigger OnValidate()
                    begin
                        CalculateLeaveRemaining();
                    end;
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
        }
    }
    local procedure CalculateLeaveRemaining()
    var
        LeaveApplication: Record "Leave Application";
        Absence: Record "Employee Absence";
        Employee: Record Employee;
        Total: Integer;
        "Current Year": Integer;
        CurrRemaining: Integer;
    begin
        Employee.SetRange("No.", Rec."Employee No.");
        "Current Year" := Date2DMY(WorkDate, 3);
        LeaveApplication.SetRange("Employee No.", Rec."Employee No.");
        LeaveApplication.FindSet();
        LeaveApplication."Leave Quantity" := LeaveApplication."To Date" - LeaveApplication."From Date";
        LeaveApplication.Modify();
        Absence.SetRange("Employee No.", LeaveApplication."Employee No.");
        Absence.SetRange("Cause of Absence Code", LeaveApplication."Leave Type");
        Absence.SetRange("From Date", DMY2Date(1, 1, "Current Year"), DMY2Date(31, 12, "Current Year"));
        if Absence.FindSet() then
            repeat begin
                begin
                    repeat begin
                        Total += Absence.Quantity;
                    end until Absence.Next() = 0;
                end;
            end until Absence.Next() = 0;
        LeaveApplication."Leave Remaining" := Total - LeaveApplication."Leave Quantity";
        if LeaveApplication."Leave Remaining" < 0 then
            LeaveApplication."Leave Remaining" := 0;
        LeaveApplication.Modify();
    end;
}