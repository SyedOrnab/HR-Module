page 50008 "Leave Application Page"
{
    ApplicationArea = All;
    Caption = 'Leave Application Page';
    PageType = List;
    SourceTable = "Leave Application";
    UsageCategory = Lists;
    AutoSplitKey = true;
    CardPageId = "Leave Application Card";
    Editable = false;
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Employee No."; Rec."Employee No.")
                {
                    ToolTip = 'Specifies the value of the Employee No. field.';
                    // Editable = false;
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.';
                    // Editable = false;
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
                field("Unit of Measurement Code"; Rec."Unit of Measure Code")
                {
                    ToolTip = 'Specifies the value of the Unit of Measurement Code field.';
                }
                field(Comment; Rec.Comment)
                {
                    ToolTip = 'Specifies the value of the Comment field.';
                }
                field("Status"; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    // Editable = false;
                }
            }
        }
    }
}
