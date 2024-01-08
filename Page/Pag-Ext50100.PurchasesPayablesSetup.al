pageextension 50100 "Ext Purchases & Payables Setup" extends "Purchases & Payables Setup"
{
    layout
    {
        addafter("Posted Credit Memo Nos.")
        {
            field("Requisition Nos."; Rec."Requisition Nos")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the code for the number series that will be used to assign numbers to requisitions.';
            }
            field("Expense Nos."; Rec."Expense Nos")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the code for the number series that will be used to assign numbers to requisitions.';
            }
        }
    }
}
