page 50119 "Expense Requisition List"
{
    ApplicationArea = All;
    Caption = 'Expense Requisition List';
    PageType = List;
    SourceTable = "Expense Requisition";
    UsageCategory = Lists;
    Editable = false;
    CardPageId = "Expense Requistion Card";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Expense Account"; Rec."Expense Account")
                {
                    ToolTip = 'Specifies the value of the Expense Account field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.';
                    MultiLine = true;
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ToolTip = 'Specifies the value of the Total Amount field.';
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date  field.';
                }
                field("Credit Account"; Rec."Credit Account")
                {
                    ToolTip = 'Specifies the value of the Credit Account field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    Editable = false;
                }
                field("Journal Created"; Rec."Journal Created")
                {
                    ToolTip = 'Specifies the value of the Journal Created field.';
                }
                field(Requiring;Rec.Requiring)
                {
                    ToolTip = 'Specifies the value of the Requiring field.';
                }
            }
        }
    }
}
