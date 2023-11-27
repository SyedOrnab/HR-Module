report 50001 "Employment History Report"
{
    ApplicationArea = All;
    Caption = 'History Report';
    WordLayout = 'Employment History.docx';
    // DefaultLayout = Word;
    // UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'Employment History.RDLC';
    DefaultLayout = Word;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Employee; "Employee")
        {
            PrintOnlyIfDetail = true;
            column(FullName; FullName)
            {
            }
            column(No; "No.")
            {
            }
            dataitem("Employee Record T"; "Employee Record")
            {
                DataItemLink = "Emplyee No." = field("No.");
                column(Designation; Designation)
                {
                }
                column(From_Date; "From Date")
                {
                }
                column(To_Date; "To Date")
                {
                }
                column(Status; Status)
                {
                }
                trigger OnPreDataItem()
                begin
                    if StartingDate <> 0D then
                        "Employee Record T".SetRange("From Date", StartingDate, EndingDate);

                    // if EndingDate <> 0D then
                    //     "Employee Record T".SetRange("To Date", StartingDate, EndingDate);

                    //  if "Employee Record T"."Emplyee No." <> '' then
                    //  Employee.SetRange("No.", "Employee Record T"."Emplyee No.");
                end;
            }
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group("Filter By Date")
                {
                    field("Starting Date"; StartingDate)
                    {
                        ApplicationArea = All;
                    }
                    field("Ending Date"; EndingDate)
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }
    }
    var
        StartingDate: Date;
        EndingDate: Date;
    // EmployeeRecordT: Record "Employee Record T";
}