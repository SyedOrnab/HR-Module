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
        field(2; "Employee ID"; Code[30])
        {
            Caption = 'Transaction Name';
            DataClassification = CustomerContent;
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(4; "Attendance Time"; DateTime)
        {
            Caption = 'Attendance Time';
            DataClassification = CustomerContent;
        }
        
        field(5; "Terminal ID"; Code[10])
        {
            Caption = 'Terminal ID';
            DataClassification = CustomerContent;
        }

    }
    keys
    {
        key(PK; "Transaction Name", "Line No.")
        {
            Clustered = true;
        }
    }
}
