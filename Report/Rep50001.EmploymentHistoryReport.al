report 50001 "Employment History Report"
{
    ApplicationArea = All;
    Caption = 'Employment History Report';
    // WordLayout = 'Employment History.docx';
    // DefaultLayout = Word;
    // UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'Employment History.rdlc';
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Employee; "Employee")
        {
            column(FullName; FullName)
            {
            }
            column(No; "No.")
            {
            }
            dataitem("Employee Record T"; "Employee Record T")
            {
                DataItemLink = "Emplyee No." = field("No.");
                column(Designation;Designation)
                {
                }
                column(From_Date;"From Date")
                {
                }
                column(To_Date;"To Date")
                {
                }
                column(Status; Status)
                {
                }
            }
        }
    }
}
