reportextension 50000 "Absence Registration Record" extends "Employee - Staff Absences"
{
    dataset
    {
        add("Employee Absence")
        {
            column(Depertment; Emplo."Job Title") { }
        }
    }
     rendering
    {
        layout(Print)
        {
            Type = RDLC;
            LayoutFile = 'AbsenceRegRecord.rdlc';
        }

    }
    var
    Emplo: Record "Employee";
}