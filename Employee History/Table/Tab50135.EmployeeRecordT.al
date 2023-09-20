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
            // AutoIncrement = true;

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
        }
        field(7; "To Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,Active,"In Active";
            OptionCaption = ',Active,In Active';
            Editable = true;
            trigger OnValidate()
            var
                recEmployee: Record "Employee Record T";
                checkStatus: Boolean;
                Emp: Record Employee;
            begin
                if (Rec.Status = Rec.Status::"In Active") AND (xRec.Status = xRec.Status::Active) then begin
                    exit;
                end;

                checkStatus := false;
                recEmployee.SetRange("Emplyee No.", Rec."Emplyee No.");
                // recEmployee.SetRange(Status, recEmployee.Status::Active);
                // if recEmployee.FindSet() then begin
                //     Error('You can select "Active" status only once. Setting to "In Active."');
                // end;
                repeat
                    if recEmployee.Status = Status::Active then begin
                        // checkStatus := true;
                        // break;
                        Error('You can select "Active" status only once. Setting to "In Active."');
                    end;
                until recEmployee.Next() = 0;
                // if checkStatus then begin
                //     Message('You can select "Active" status only once. Setting to "In Active."');
                //     Status := Status::"In Active";
                // end;

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
