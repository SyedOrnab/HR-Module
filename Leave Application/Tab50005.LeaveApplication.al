table 50005 "Leave Application"
{
    Caption = 'Leave Application';
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            NotBlank = true;
            TableRelation = Employee;
            trigger OnValidate()
            begin
                Employee.Get("Employee No.");
                if Employee."Privacy Blocked" then
                    Error(BlockedErr);
            end;
        }
        field(2; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            // AutoIncrement = true;
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
            TableRelation = "Cause of Absence";

            trigger OnValidate()
            var
                EmployeeLeave : Record "Employee Leave";
            begin
                CauseOfAbsence.Get("Leave Type");
                Description := CauseOfAbsence.Description;
                Validate("Unit of Measure Code", CauseOfAbsence."Unit of Measure Code");
            end;
        }
        field(6; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(7; "Leave Quantity"; Decimal)
        {
            Caption = 'Leave Quantity';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                "Quantity (Base)" := UOMMgt.CalcBaseQty("Leave Quantity", "Qty. per Unit of Measure");
            end;
        }
        field(8; "Leave Remaining"; Integer)
        {
            Caption = 'Leave Remaining';
        }
        field(9; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Human Resource Unit of Measure".Code;
        }
        field(10; Comment; Boolean)
        {
            CalcFormula = Exist("Human Resource Comment Line" WHERE("Table Name" = CONST("Employee Absence"),
                                                                     "Table Line No." = FIELD("Entry No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(11; "Quantity (Base)"; Decimal)
        {
            Caption = 'Quantity (Base)';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                TestField("Qty. per Unit of Measure", 1);
                Validate("Leave Quantity", "Quantity (Base)");
            end;
        }
        field(12; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            Editable = false;
            InitValue = 1;
        }
    }
    keys
    {
        key(PK; "Employee No.", "Entry No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        EmployeeAbsence.SetCurrentKey("Entry No.");
        if EmployeeAbsence.FindLast() then
            "Entry No." := EmployeeAbsence."Entry No." + 1
        else begin
            CheckBaseUOM();
            "Entry No." := 1;
        end;
    end;

    var
        CauseOfAbsence: Record "Cause of Absence";
        Employee: Record Employee;
        EmployeeAbsence: Record "Employee Absence";
        HumanResUnitOfMeasure: Record "Human Resource Unit of Measure";
        UOMMgt: Codeunit "Unit of Measure Management";

        BlockedErr: Label 'You cannot register absence because the employee is blocked due to privacy.';

    local procedure CheckBaseUOM()
    var
        HumanResourcesSetup: Record "Human Resources Setup";
    begin
        HumanResourcesSetup.Get();
        HumanResourcesSetup.TestField("Base Unit of Measure");
    end;
}
