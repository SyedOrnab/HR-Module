report 50003 "CustomerSales"
{
    ApplicationArea = All;
    Caption = 'CustomerSales';
    DefaultLayout = Word;
    WordLayout = 'CustomerSales.docx';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
        {
            column(Posting_Date; "Posting Date") { }
            column(Customer_No_; "Customer No.") { }
            column(Customer_Name; "Customer Name") { }
            column(Sales__LCY_; "Sales (LCY)") { }
            column(TotalSales; TotalSales) { }

            trigger OnAfterGetRecord()
                var
                    CustSales: Record "Cust. Ledger Entry";
                begin
                    TotalSales := 0;
                    CustSales.SetRange("Customer No.","Cust. Ledger Entry"."Customer No.");
                    if CustSales.FindSet() then
                    repeat begin
                        TotalSales += CustSales."Sales (LCY)";
                    end until CustSales.Next() = 0;
                    CustSales.FindFirst();
                end;

            trigger OnPreDataItem()
            begin
                if StartingDate <> 0D then
                    "Cust. Ledger Entry".SetRange("Posting Date", StartingDate, EndingDate);
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(FilterbyDate)
                {
                    field(StartingDate; StartingDate)
                    {
                        Caption = 'Starting Date';
                    }
                    field(EndingDate; EndingDate)
                    {
                        Caption = 'Ending Date';
                    }
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var
        CustLedger: Record "Cust. Ledger Entry";
        StartingDate: Date;
        EndingDate: Date;
        TotalSales: Decimal;
}
