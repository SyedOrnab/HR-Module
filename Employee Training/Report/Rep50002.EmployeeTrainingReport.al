report 50002 "Employee Training Report"
{
    ApplicationArea = All;
    Caption = 'Employee Training Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = Word;
    WordLayout = 'Emp train.docx';
    dataset
    {
        dataitem(Employee; Employee)
        {
            // PrintOnlyIfDetail = true;  //Specifies whether to print data in a report for the parent data item when the child data item does not generate any output.
            column(No_; "No.") { }
            column(FullName; FullName) { }
            column(TotalTTarget; TotalTTarget) { }
            column(TotalTCompleted; TotalTCompleted) { }

            dataitem(Integer; Integer)
            {
                DataItemTableView = where(Number = const(1));

            

                trigger OnAfterGetRecord()
                var
                    EmpTrain: Record "Employee Training";
                begin

                    EmpTrain.SetRange("Employee No.", Employee."No.");
                    if Emptrain.FindFirst() then begin
                        repeat begin
                            TotalTTarget += EmpTrain.Duration;
                            if EmpTrain.Status = EmpTrain.Status::Completed then
                                TotalTCompleted += EmpTrain.Duration;
                        end until EmpTrain.Next() = 0;

                    end;
                end;
            }
            dataitem("Employee Training"; "Employee Training")
            {
                DataItemLink = "Employee No." = field("No.");
                column(Training_Name; "Training Name") { }
                column(Description; Description) { }
                column(Duration; Duration) { }
                column(Status; Status) { }
                column(Actual_Start_Date; "Actual Start Date") { }
                column(Actual_End_Date; "Actual End Date") { }
                column(Planned_Start_Date; "Planned Start Date") { }
                column(Planned_End_Date; "Planned End Date") { }
                column(Total_Training_Target; "Total Training Target") { }
                column(Total_Training_Completed; "Total Training Completed") { }
            }
            trigger OnAfterGetRecord()
             var
                emptrain : Record "Employee Training";
            begin
                TotalTTarget := 0;
                TotalTTarget := TotalTTarget;
                TotalTCompleted := 0;
                TotalTCompleted := TotalTCompleted;


                emptrain.SetRange("Employee No.", Employee."No.");  //Employee No. data inserted in local var emptrain.
                if not emptrain.FindFirst() then        //
                CurrReport.Skip;
            end;
        }
    }
    var
        TotalTTarget: Integer;
        TotalTCompleted: Integer;
}
