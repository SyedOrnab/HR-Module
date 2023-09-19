report 50002 "Employment History RDLC Report"
{
    ApplicationArea = All;
    Caption = 'Employment History Report';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Employee;Employee)
        {
            column(FullName;FullName)
            {
            }
            column(No_;"No.")
            {
            }
            dataitem(EmployeeHistory; "Employee Record T")
            {
                column(EmplyeeNo; "Emplyee No.")
                {
                }
                column(EmplyeeName; "Emplyee Name")
                {
                }
                column(Department; Department)
                {
                }
                column(Designation; Designation)
                {
                }
                column(FromDate; "From Date")
                {
                }
                column(ToDate; "To Date")
                {
                }
                column(Status; Status)
                {
                }
            }
        }
    }
}
