table 50005 "Leave Application"
{
    Caption = 'Leave Application';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
        }
        field(2; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(3; "From Date"; Date)
        {
            Caption = 'From Date';
        }
        field(4; "To Date"; Date)
        {
            Caption = 'To Date ';
        }
        field(5; "Leave Type"; Code[10])
        {
            Caption = 'Leave Type';
        }
        field(6; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(7; "Leave Quantity"; Integer)
        {
            Caption = 'Leave Quantity';
        }
        field(8; "Leave Remaining"; Integer)
        {
            Caption = 'Leave Remaining';
        }
        field(9; "Unit of Measurement Code"; Code[10])
        {
            Caption = 'Unit of Measurement Code';
        }
        field(10; Comment; Boolean)
        {
            Caption = 'Comment';
        }
    }
    keys
    {
        key(PK; "Employee No.","Entry No.")
        {
            Clustered = true;
        }
    }
}
