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
            AutoIncrement = true;
        }
        field(3; "From Date"; Date)
        {
            Caption = 'From Date';
            trigger OnValidate()
            var
                LeaveApplicaiton: Record "Leave Application";
            begin
                LeaveApplicaiton.SetRange("Employee No.", Rec."Employee No.");
                LeaveApplicaiton.SetFilter("Entry No.", '<>%1', Rec."Entry No.");
                if LeaveApplicaiton.FindSet() then begin
                    repeat
                        if LeaveApplicaiton."From Date" = Rec."From Date" then
                            Error('Leave Application already exists for this date.');
                        if LeaveApplicaiton."To Date" = Rec."To Date" then
                            Error('Leave Application already exists for this date.');
                        if LeaveApplicaiton."To Date" = Rec."From Date" then
                            Error('Leave Application already exists for this date.');
                        if LeaveApplicaiton."From Date" < Rec."From Date" then begin
                            if LeaveApplicaiton."To Date" > Rec."From Date" then
                                Error('Leave Application already exists for this date.');
                        end;
                    until LeaveApplicaiton.Next() = 0;
                end;
                DateValidation();
            end;
        }
        field(4; "To Date"; Date)
        {
            Caption = 'To Date ';
            trigger OnValidate()
            var
                LeaveApplicaiton: Record "Leave Application";
            begin
                DateValidation();
                if "Leave Type" <> '' then
                    Rec.Validate("Leave Type", Rec."Leave Type");
            end;
        }
        field(5; "Leave Type"; Code[10])
        {
            Caption = 'Leave Type';
            TableRelation = "Cause of Absence";
            trigger OnValidate()
            var
                EmployeeLeave: Record "Employee Leave";
            begin
                CauseOfAbsence.Get("Leave Type");
                Description := CauseOfAbsence.Description;
                Validate("Unit of Measure Code", CauseOfAbsence."Unit of Measure Code");
                // Leave Remaining
                EmployeeLeave.SetRange("Employee No.", Rec."Employee No.");
                EmployeeLeave.SetRange("Leave Type", Rec."Leave Type");
                EmployeeLeave.FindFirst();

                Rec."Leave Remaining" := EmployeeLeave."Leave Remaining";
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

                if Rec."Leave Quantity" > Rec."Leave Remaining" then
                    Error('Only %1 leave remaining left. But the total quantity you enter %2.', Rec."Leave Remaining", Rec."Leave Quantity");                   
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
        field(13; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = ,Open,Pending,Approved,Released,Rejected;
            OptionCaption = ',Open,Pending,Approved,Released,Rejected';

            trigger OnValidate()
            var
                EmployeeAbsence: Record "Employee Absence";
                EmployeeLeave: Record "Employee Leave";
                LeaveApplication: Record "Leave Application";
                TotalQuantity: Decimal;
                LeaveRemaining: Integer;
            begin
                if Status = Status::Released then begin
                    EmployeeAbsence.INIT;
                    EmployeeAbsence."Employee No." := Rec."Employee No.";
                    EmployeeAbsence."Entry No." := Rec."Entry No.";
                    EmployeeAbsence."From Date" := Rec."From Date";
                    EmployeeAbsence."To Date" := Rec."To Date";
                    EmployeeAbsence."Cause of Absence Code" := Rec."Leave Type";
                    EmployeeAbsence.Description := Rec.Description;
                    EmployeeAbsence.Quantity := Rec."Leave Quantity";
                    EmployeeAbsence."Unit of Measure Code" := Rec."Unit of Measure Code";
                    EmployeeAbsence.INSERT(true);
                end;

                if Status = Status::Released then begin
                    EmployeeLeave.SetRange("Employee No.", Rec."Employee No.");
                    EmployeeLeave.SetRange("Leave Type", Rec."Leave Type");
                    EmployeeLeave.FindFirst();
                    EmployeeLeave."Leave Remaining" := EmployeeLeave."Leave Remaining" - EmployeeAbsence.Quantity;
                    EmployeeLeave.MODIFY(true);
                end;

                if Status = Status::Released then begin
                    Rec."Leave Remaining" := EmployeeLeave."Leave Remaining";
                    Rec.Modify(true);
                end;
            end;
        }
    }
    keys
    {
        key(PK; "Employee No.", "Entry No.")
        {
            Clustered = true;
        }
    }

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


    local procedure DateValidation()
    var
        Leaveappcard: Page "Leave Application Card";
        PreFromDate: Date;
        PreToDate: Date;
    begin
        if ("From Date" = 0D) or ("To Date" = 0D) then begin
            "Leave Quantity" := 0;
        end;
        if ("From Date" <> 0D) and ("To Date" <> 0D) then begin
            Rec.Validate("Leave Quantity", Rec."To Date" - Rec."From Date");
            if (Rec."From Date" = Rec."To Date") then begin
                Error('From Date and To Date cannot be same.');
            end;
            if (Rec."From Date" > Rec."To Date") then begin
                Error('From Date cannot be greater than To Date.');
            end;
        end;
    end;
}
