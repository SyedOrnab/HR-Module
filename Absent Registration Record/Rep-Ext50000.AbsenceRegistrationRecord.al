reportextension 50000 "Absence Registration Record" extends "Employee - Staff Absences"
{
    dataset
    {
        add("Employee Absence")
        {
            column(Department;Department){}
        }
        modify("Employee Absence")
        {
            trigger OnAfterAfterGetRecord()
            var
                Emplo: Record Employee;
            begin
                Emplo.SetRange("No.","Employee Absence". "Employee No.");
                if Emplo.FindSet() then begin
                    "Department" := Emplo. "Global Dimension 1 Code";
                end;
            end;
        }
    }

    rendering
    {
        layout(AbsenceRegistration)
        {
            Type = RDLC;
            LayoutFile = 'EmployeeStaffAbsences.rdlc';
        }

    }
    var
        // Emplo: Record Employee;
        Department: Text[30];

}