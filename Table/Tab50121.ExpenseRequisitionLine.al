table 50121 "Expense Requisition Line"
{
    Caption = 'Expense Requisition Line';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
        }
        field(4; "Employee Name"; Text[50])
        {
            Caption = 'Employee Name';
        }
        field(5; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(6; Amount; Integer)
        {
            Caption = 'Amount';
        }
    }
    keys
    {
        key(PK; "Document No.","Line No.")
        {
            Clustered = true;
        }
    }
}
