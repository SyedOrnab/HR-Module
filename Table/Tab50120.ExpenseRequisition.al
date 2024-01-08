table 50120 "Expense Requisition"
{
    Caption = 'Expense Requisition';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            Editable = false;
            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    ExpenseSetup.Get();
                    NoSeriesMgt.TestManual(ExpenseSetup."Requisition Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Expense Account"; Code[50])
        {
            Caption = 'Expense Account';
        }
        field(3; Remarks; Text[200])
        {
            Caption = 'Remarks';
        }
        field(4; "Total Amount"; Integer)
        {
            Caption = 'Total Amount';
        }
        field(5; "Date"; Date)
        {
            Caption = 'Date ';
        }
        field(6; "Credit Account"; Integer)
        {
            Caption = 'Credit Account';
        }
        field(7; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = "Open","Released","Pending Approval","Rejected";
        }
        field(8; "Journal Created"; Boolean)
        {
            Caption = 'Journal Created ';
        }
        field(9; Requiring; Boolean)
        {
            Caption = 'Requiring';
        }
        field(10; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    var
        ExpenseSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    trigger OnInsert()
    var
    begin
        if "No." = '' then begin
            ExpenseSetup.Get();
            ExpenseSetup.TestField("Expense Nos");
            NoSeriesMgt.InitSeries(ExpenseSetup."Expense Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        Date := WORKDATE;
    end;
}
