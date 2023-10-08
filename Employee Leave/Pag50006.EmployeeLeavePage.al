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
                field(Line_No;Rec.Line_No)
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
                field("Total Leave";Rec."Total Leave")
                {
                    ToolTip = 'Specifies the value of the Total Leave field.';
                    Visible = false;
                }
                field("Unit of Measure Code";Rec."Unit of Measure Code")
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
            action(Calculate)
            {
                ApplicationArea = All;
                Caption = 'Calculate';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Calculate;

                trigger OnAction()
                begin
                    // CalculateRemainingLeave();
                end;
                // OnAction = Calculate;
            }
        }
    }
    // local procedure CalculateRemainingLeave()
    // var 
    //     EmployeeLeave: Record "Employee Leave";
    //     Absence: Record "Employee Absence";
    // begin
    //     EmployeeLeave.SetRange("Employee No.",Rec."Employee No.");
    //     if EmployeeLeave.FindSet() then
    // end;
    
}
