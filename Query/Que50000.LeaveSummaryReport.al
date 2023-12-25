query 50000 "Leave Summary Report"
{
    Caption = 'Leave Summary Report';
    QueryType = Normal;
    
    elements
    {
        dataitem(EmployeeLeaveSetup; "Employee Leave Setup")
        {
            column(EmployeeNo; "Employee No.")
            {
            }
            column(LeaveTaken; "Leave Taken")
            {
            }
            column(LeaveType; "Leave Type")
            {
            }
            column(LeaveQuantity; "Leave Quantity")
            {
            }
            column(LeaveRemaining; "Leave Remaining")
            {
            }
            column(TotalLeave; "Total Leave")
            {
            }
        }
    }
    
    trigger OnBeforeOpen()
    begin
    
    end;
}
