pageextension 50003 "Employee History Report" extends "Employee List"
{
    actions
    {
        addfirst("E&mployee")
        {
            action("Employee History Print")
            {
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                ApplicationArea = Basic, Suite;
                Caption = 'E&mployee History Print';
                Ellipsis = true;
                Image = Print;
                ToolTip = 'Print an order confirmation. A report request window opens where you can specify what to include on the print-out.';

                trigger OnAction()
                var
                    Employee: Record "Employee";
                begin
                    Employee.Reset();
                    Employee.SetRange("No.", Rec."No.");
                    if Employee.FindFirst() then
                        Report.Run(Report::"Employment History Report", true, false, Employee);

                end;
            }
            action("Employee Training Print")
            {
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                ApplicationArea = Basic, Suite;
                Caption = 'Employee Training Print';
                Ellipsis = true;
                Image = Print;
                ToolTip = 'Print an order confirmation. A report request window opens where you can specify what to include on the print-out.';

                trigger OnAction()
                var
                    Employee: Record "Employee";
                begin
                    Employee.Reset();
                    Employee.SetRange("No.", Rec."No.");
                    if Employee.FindFirst() then
                        Report.Run(Report::"Employee Training Report", true, false, Employee);

                end;
            }
        }
    }
    var
        DocPrint: Codeunit "Document-Print";
}
