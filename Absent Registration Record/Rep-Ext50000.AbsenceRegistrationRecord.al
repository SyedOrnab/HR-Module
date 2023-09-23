reportextension 50000 "Absence Registration Record" extends "Employee - Staff Absences"
{
    dataset
    {
        add("Employee Absence")
        {
            column(Depertment; Emplo."Job Title") { }
        }
    }
    //  rendering
    // {
    //     layout(Print)
    //     {
    //         Type = Word;
    //         LayoutFile = 'AbsenceRegRecord.docx';
    //     }

    // }
    var
    Emplo: Record "Employee";
}