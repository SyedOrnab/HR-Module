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
        Total: Integer;
    begin
        LeaveApplication.SetRange("Employee No.", Rec."Employee No.");
        if LeaveApplication.FindSet() then
            repeat begin
                Absence.SetRange("Employee No.", LeaveApplication."Employee No.");
                Absence.SetRange("Cause of Absence Code", LeaveApplication."Leave Type");
                if Absence.FindSet() then
                    repeat begin
                        begin
                            repeat begin
                                Total += Absence.Quantity;
                            end until Absence.Next() = 0;
                        end;
                    end until Absence.Next() = 0;
                LeaveApplication."Leave Remaining" := LeaveApplication."Leave Quantity" - Total;
                LeaveApplication.Modify();
                Total := 0;
            end until LeaveApplication.Next() = 0;
    end;
}