page 50001 EmployeeRecordP
{
    ApplicationArea = All;
    Caption = 'Employee Record';
    PageType = List;
    SourceTable = "Employee Record T";
    UsageCategory = Lists;
    // CardPageId = EmployeeRecordCard;
    AutoSplitKey = true;
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Emplyee No."; Rec."Emplyee No.")
                {
                    ToolTip = 'Specifies the value of the Emplyee No. field.';
                    Visible = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
                    Visible = false;
                }
                field("Emplyee Name"; Rec."Emplyee Name")
                {
                    ToolTip = 'Specifies the value of the Emplyee Name field.';
                }
                field(Department; Rec.Department)
                {
                    Caption = 'Department';
                    ToolTip = 'Specifies the value of the Department field.';
                }
                field(Designation; Rec.Designation)
                {
                    ToolTip = 'Specifies the value of the designation field.';
                }
                field("From Date"; Rec."From Date")
                {
                    ToolTip = 'Specifies the value of the From Date field.';
                }
                field("To Date"; Rec."To Date")
                {
                    ToolTip = 'Specifies the value of the To Date field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    
                }
            }
        }
    }
}
