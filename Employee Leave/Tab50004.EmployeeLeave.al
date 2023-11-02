table 50004 "Employee Leave Setup"
{
    Caption = 'Employee Leave Setup';
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
            // FieldClass = FlowFilter;
            Caption = 'Leave Type';
            TableRelation = "Cause of Absence".Code;
        }
        field(4; "Leave Quantity"; Integer)
        {
            Caption = 'Leave Quantity';
        }
        field(5; "Leave Taken"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Employee Absence".Quantity where("Employee No."= field("Employee No."),"Cause of Absence Code"=field("Leave Type")));
            Caption = 'Leave Taken';
        }
        field(6; "Leave Remaining"; Integer)
        {
            Caption = 'Leave Remaining';

        }
        field(7; "Total Leave"; Date)
        {
            Caption = 'Leave Start Date';
        }
        field(8; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Human Resource Unit of Measure".Code;
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
