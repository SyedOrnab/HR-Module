table 50002 "Employee Training"
{
    Caption = 'Employee Training';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Employee No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";
            trigger OnValidate()
            var
                recEmployeeName: Record Employee;
                recEmployeeDept: Record Employee;
            begin
                recEmployeeName.Get("Employee No.");
                "Employee Name" := recEmployeeName.FullName();
            end;
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            // AutoIncrement = true;

        }
        field(3; "Employee Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Training Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Training Master";
            trigger OnValidate()
            var
                TrainingMaster: Record "Training Master";
            begin
                TrainingMaster.Get("Training Name");
                Description := TrainingMaster.Description;
                Duration := TrainingMaster.Duration;
            end;
        }

        field(5; Description; Text[100])
        {
            DataClassification = ToBeClassified;

        }
        field(6; Duration; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Planned Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Planned End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Actual Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Actual End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(11; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,Pending,Started,Completed;
            OptionCaption = ',Pending,Started,Completed';
        }
        field(12;"Certification No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Certificate"; Blob)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Employee No.","Line No.")
        {
            Clustered = true;
        }
    }
}
