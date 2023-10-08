table 50004 "Employee Leave"
{
    Caption = 'Employee Leave';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Employee."No.";
        }
        field(2; Line_No; Integer)
        {
            Caption = 'Line No.';
            AutoIncrement = true;
        }
        field(3; "Leave Type"; Code[10])
        {
            Caption = 'Leave Type';
            TableRelation = "Cause of Absence".Code;
        }
        field(4; "Leave Quantity"; Integer)
        {
            Caption = 'Leave Quantity';
        }
        field(5; "Leave Remaining"; Integer)
        {
            Caption = 'Leave Remaining';

        }
        field(6; "Total Leave"; Date)
        {
            Caption = 'Leave Start Date';
        }
    }
    keys
    {
        key(PK; "Employee No.", Line_No)
        {
            Clustered = true;
        }
    }
}
