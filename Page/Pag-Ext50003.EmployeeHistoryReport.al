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
                    ToolTip = 'Print an order confirmation. A report request window opens where you can specify what to include on the print-out.';

                    trigger OnAction()
                    var
                        Employee: Record "Employee";
                    begin
                        Employee.Get();
                        
                    end;
                }
        }
    }
    var
    DocPrint: Codeunit "Document-Print";
}
