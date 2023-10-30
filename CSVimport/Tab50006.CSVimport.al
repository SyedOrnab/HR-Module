table 50006 CSVimport
{
    Caption = 'CSV IMPORT';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Transaction Name"; Code[10])
        {
            Caption = 'Transaction Name';
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Employee No."; Code[30])
        {
            Caption = 'Employee No.';
            DataClassification = CustomerContent;
        }
        field(4; "Production No."; Code[10])
        {
            Caption = 'Production No.';
            DataClassification = CustomerContent;
        }
        field(5; "Date"; Date)
        {
            Caption = 'Date';
            DataClassification = CustomerContent;
        }
        field(6; "Payment Method"; Text[10])
        {
            Caption = 'Payment Method';
            DataClassification = CustomerContent;
        }
        field(7; Quantity; Integer)
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;
        }
        field(8; "Unit Price"; Integer)
        {
            Caption = 'Unit Price';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Transaction Name","Line No.")
        {
            Clustered = true;
        }
    }
}
