pageextension 50003 "Employee History Report" extends "Employee List"
{
    actions
    {
        addafter("E&mployee")
        {
            action("Print")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Print';
                    Ellipsis = true;
                    Image = Print;
                    ToolTip = 'Print an order confiörmation. A report request window opens where you can specify what to include on the print-out.';

                    trigger OnAction()
                    var
                        Employee: Record "Employee";
                    begin
                        Employee.Reset();
                        Employee.SetRange("No.", Rec."No.");
                        if Employee.FindFirst() then
                            Report.Run(Report::"Employment History Report", true,false,Employee);
                        
                    end;
                }
        }
    }
    var
    DocPrint: Codeunit "Document-Print";
}
