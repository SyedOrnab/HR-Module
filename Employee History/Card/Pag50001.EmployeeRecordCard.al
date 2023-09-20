page 50003 EmployeeRecordCard
{
    // ApplicationArea = All;
    Caption = 'EmployeeRecordCard';
    PageType = Card;
    SourceTable = "Employee Record T";
    AutoSplitKey = true;
    
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                
                field("Emplyee No."; Rec."Emplyee No.")
                {
                    ToolTip = 'Specifies the value of the Emplyee No. field.';
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
                    
                }
                field("Emplyee Name"; Rec."Emplyee Name")
                {
                    ToolTip = 'Specifies the value of the Emplyee Name field.';
                }
                field(Department; Rec.Department)
                {
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
