pageextension 50001 "Customer Sales Report" extends "Customer Ledger Entries"
{
    actions
    {
        addafter("&Navigate")
        {
            action(ShowCustomerSale)
            {
                Caption = 'Customer Sales Total';
                Image = Sales;
                ApplicationArea = All;
                RunObject = report 50003;
                // RunPageLink = "" = FIELD("No.");
                ToolTip = 'View Sales Total for Customer';
            }
        }
    }
}
