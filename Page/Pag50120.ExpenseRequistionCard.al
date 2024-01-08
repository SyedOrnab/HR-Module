page 50120 "Expense Requistion Card"
{
    // ApplicationArea = All;
    Caption = 'Expense Requistion Card';
    PageType = Card;
    SourceTable = "Expense Requisition";
    
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No.";Rec."No."){}
                field("Expense Account";Rec."Expense Account"){}
                field(Remarks;Rec.Remarks){}
                field("Total Amount";Rec."Total Amount"){}
                field(Date;Rec.Date){}
                field("Credit Account";Rec."Credit Account"){}
                field(Status;Rec.Status){}
                field("Journal Created";Rec."Journal Created"){}
                field(Requiring;Rec.Requiring){}
            }
            part(ExpenseReqLine; "Expense Requisition Subform")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Document No." = FIELD("No.");
                UpdatePropagation = Both;
            }
        }
    }
}
