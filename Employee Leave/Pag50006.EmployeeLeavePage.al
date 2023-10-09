page 50006 "Employee Leave Page"
{
    ApplicationArea = All;
    Caption = 'Employee Leave Page';
    PageType = List;
    SourceTable = "Employee Leave";
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
                field("Leave Remaining"; Rec."Leave Remaining")
                {
                    ToolTip = 'Specifies the value of the Leave Remaining field.';
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
        }
    }
    local procedure CalculateRemainingLeave()
    var
        EmployeeLeave: Record "Employee Leave";
        Absence: Record "Employee Absence";
        Total: Integer;
    begin
        Absence.SetRange("Employee No.", Rec."Employee No.");
        if Absence.FindSet() then
            repeat begin
                if Absence."Cause of Absence Code" = 'ANNUAL' then
                    repeat begin
                        Total += Absence.Quantity;
                    end until Absence.Next() = 0;
            end until Absence.Next() = 0;
        Message(Absence."Employee No." + ' total leave: %1', Total);
        
        EmployeeLeave.SetRange("Employee No.", Rec."Employee No.");
        if EmployeeLeave.FindSet() then
            repeat begin
                EmployeeLeave."Leave Remaining" := EmployeeLeave."Leave Quantity" - Total;
                EmployeeLeave.Modify();
            end until EmployeeLeave.Next() = 0;

        // EmployeeLeave.SetRange("Employee No.", Rec."Employee No.");
        // if EmployeeLeave.FindSet() then begin
        //         EmployeeLeave."Leave Remaining" := EmployeeLeave."Leave Quantity" - Total;
        //         EmployeeLeave.Modify();
        // end;

        // EmployeeLeave.SetRange("Employee No.",Rec."Employee No.");
        // if EmployeeLeave.FindSet() then
        //     repeat
        //         Absence.SetRange("Employee No.",Rec."Employee No.");
        //         if Absence.FindSet() then
        //             Absence.CalcSums(Quantity);
        //             repeat
        //                     EmployeeLeave."Leave Remaining" := EmployeeLeave."Leave Quantity" - Absence.Quantity;
        //                     EmployeeLeave.Modify()
        //             until Absence.Next() = 0;
        //     until EmployeeLeave.Next() = 0;
    end;

}
