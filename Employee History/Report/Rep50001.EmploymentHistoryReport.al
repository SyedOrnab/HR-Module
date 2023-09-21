report 50001 "Employment History Report"
{
    ApplicationArea = All;
    Caption = 'Employment History Report';
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
            column(FullName; FullName)
            {
            }
            column(No; "No.")
            {
            }
            dataitem("Employee Record T"; "Employee Record T")
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
                // DataItemTableView = filter
                // {
                //     DataItemLink = "Emplyee No." = field("No.");
                //     // Add a filter condition to only include records with data in Employee Record T
                //     DataItemLink = field("From Date") IS NOT NULL;
                // }
                trigger OnPreDataItem()
                begin
                    if StartingDate <> 0D then
                        "Employee Record T".SetRange("From Date", StartingDate, EndingDate);
                    
                    Employee.SetRange("No.", "Employee Record T"."Emplyee No.");
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
            EndingDate : Date;
            // EmployeeRecordT: Record "Employee Record T";
}