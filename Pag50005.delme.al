page 50005 delme
{
    Caption = 'delme';
    PageType = List;
    SourceTable = "Employee Training";
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee Name field.';
                }
            }
        }
    }
}
