page 50011 "Batch Name"
{
    Caption = 'Batch Name';
    PageType = Card;
    SourceTable = "Batch Name ";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Payable Batch Name"; Rec."Payable Batch Name")
                {
                    ApplicationArea = All;
                }
                field("Payment Batch Name"; Rec."Payment Batch Name")
                {
                    ApplicationArea = All;
                }

            }
        }
    }
}
