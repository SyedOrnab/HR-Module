page 50006 "Employee Leave Page"
{
    ApplicationArea = All;
    Caption = 'Employee Leave Page';
    PageType = List;
    SourceTable = "Employee Leave Setup";
    UsageCategory = Lists;
    AutoSplitKey = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Employee No."; Rec."Employee No.")
                {
                    ToolTip = 'Specifies the value of the Employee No. field.';
                    Visible = false;
                }
                field(Line_No; Rec.Line_No)
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
                    Visible = false;
                }
                field("Leave Type"; Rec."Leave Type")
                {
                    ToolTip = 'Specifies the value of the Leave Type field.';
                }

                field("Leave Quantity"; Rec."Leave Quantity")
                {
                    ToolTip = 'Specifies the value of the Leave Quantity field.';
                }
                field("Leave Taken"; Rec."Leave Taken")
                {
                    ToolTip = 'Specifies the value of the Leave Taken field.';
                    Editable = false;
                }
                field("Leave Remaining"; Rec."Leave Remaining")
                {
                    ToolTip = 'Specifies the value of the Leave Remaining field.';
                    Editable = false;
                }
                field("Total Leave"; Rec."Total Leave")
                {
                    ToolTip = 'Specifies the value of the Total Leave field.';
                    Visible = false;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ToolTip = 'Specifies the value of the Unit of Measure Code field.';
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
                Caption = 'Leave Update';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = CalculateRemainingUsage;

                trigger OnAction()
                begin
                    CalculateRemainingLeave();
                end;
            }
            action(TotalLeaveTaken)
            {
                ApplicationArea = All;
                Caption = 'Leave Taken';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = CalculateRemainingUsage;

                trigger OnAction()
                begin
                    LeaveTaken();
                end;
            }
        }
    }
    local procedure CalculateRemainingLeave()
    var
        EmployeeLeave: Record "Employee Leave Setup";
        Absence: Record "Employee Absence";
        Total: Integer;
    begin
        EmployeeLeave.SetRange("Employee No.", Rec."Employee No.");
        if EmployeeLeave.FindSet() then
            repeat begin
                Absence.SetRange("Employee No.", EmployeeLeave."Employee No.");
                Absence.SetRange("Cause of Absence Code", EmployeeLeave."Leave Type");
                if Absence.FindSet() then
                    repeat begin
                        begin
                            repeat begin
                                Total += Absence.Quantity;
                            end until Absence.Next() = 0;
                        end;
                    end until Absence.Next() = 0;
                EmployeeLeave."Leave Remaining" := EmployeeLeave."Leave Quantity" - Total;
                EmployeeLeave.Modify();
                Total := 0;
            end until EmployeeLeave.Next() = 0;
    end;

    local procedure LeaveTaken()
    var
        EmployeeLeave: Record "Employee Leave Setup";
        Absence: Record "Employee Absence";
        TotalLeaveTaken: Integer;
    begin
        EmployeeLeave.SetRange("Employee No.", Rec."Employee No.");
        if EmployeeLeave.FindSet() then
            repeat begin
                Absence.SetRange("Employee No.", EmployeeLeave."Employee No.");
                Absence.SetRange("Cause of Absence Code", EmployeeLeave."Leave Type");
                if Absence.FindSet() then
                    repeat begin
                        begin
                            repeat begin
                                TotalLeaveTaken += Absence.Quantity;
                            end until Absence.Next() = 0;
                        end;
                    end until Absence.Next() = 0;
                EmployeeLeave."Leave Taken" := TotalLeaveTaken;
                EmployeeLeave.Modify();
                TotalLeaveTaken := 0;
            end until EmployeeLeave.Next() = 0;
    end;

}
