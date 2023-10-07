table 50001 "Employee Record T"
{
    Caption = 'Employee Record T';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Emplyee No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";
            trigger OnValidate()
            var
                recEmployeeName: Record Employee;
                recEmployeeDept: Record Employee;
            begin
                recEmployeeName.Get("Emplyee No.");
                "Emplyee Name" := recEmployeeName.FullName();
            end;
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(3; "Emplyee Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Designation; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(5; Department; Code[30])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,1,1';
            Caption = 'Department';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

        }
        field(6; "From Date"; Date)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                recEmployee: Record "Employee Record T";
            begin
                recEmployee.SetRange("Emplyee No.", Rec."Emplyee No.");
                if recEmployee.FindSet() then begin
                    repeat
                        if Rec."From Date" = recEmployee."From Date" then begin
                            Error('From Date cannot be same.');
                        end;
                        if (Rec."From Date" < recEmployee."From Date") then begin
                            Error('From Date must be not be less than previous record.');
                        end;
                    until recEmployee.Next() = 0;
                end;
            end;
        }
        field(7; "To Date"; Date)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                recEmployee: Record "Employee Record T";
            begin
                if (Rec."From Date" = Rec."To Date") then begin
                    Error('From Date and To Date cannot be same.');
                end;
                if (Rec."From Date" > Rec."To Date") then begin
                    Error('From Date cannot be greater than To Date.');
                end;
            end;
        }
        field(8; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,Active,Inactive;
            OptionCaption = ',Active,Inactive';
            Editable = true;
            trigger OnValidate()
            var
                recEmployee: Record "Employee Record T";
                checkStatus: Boolean;
                Emp: Record Employee;
            begin
                if (Rec.Status = Rec.Status::Inactive) AND (xRec.Status = xRec.Status::Active) then begin
                    exit;
                end;

                checkStatus := false;
                recEmployee.SetRange("Emplyee No.", Rec."Emplyee No.");
                repeat
                    if recEmployee.Status = Status::Active then begin
                        recEmployee.Status := Status::Inactive;
                        recEmployee.Modify(true);
                    end;
                until recEmployee.Next() = 0;

                recEmployee.Get("Emplyee No.", "Line No.");
                if Emp.GET("Emplyee No.") then begin
                    Emp."Job Title" := Designation;
                    Emp.Modify(true);
                end;
            end;

        }

    }
    keys
    {
        key(PK; "Emplyee No.", "Line No.")
        {
            Clustered = true;
        }
    }
    var

}
