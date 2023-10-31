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
        field(2; "Employee No."; Code[30])
        {
            Caption = 'Transaction Name';
            DataClassification = CustomerContent;
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(4; "Date"; Date)
        {
            Caption = 'Date';
            DataClassification = CustomerContent;
        }
        field(5; "Entry Time"; Time)
        {
            Caption = 'Entry Time';
            DataClassification = CustomerContent;
        }
        field(6; "Exit Time"; Time)
        {
            Caption = 'Exit Time';
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
