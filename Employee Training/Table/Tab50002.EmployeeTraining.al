table 50002 "Employee Training"
{
    Caption = 'Employee Training';
    DataCaptionFields = "Training Name";
    DrillDownPageId = "Employee Training Page";
    LookupPageId = "Employee Training Page";
    // DataClassification = ToBeClassified;
    
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
            AutoIncrement = true;

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
            // FieldClass = FlowFilter;
            // TableRelation = "Training Master"."Training ID";
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
/*         field(14; ID; Integer)
        {
            DataClassification = CustomerContent;
            // AutoIncrement = true;
            Editable = false;
        } */
        field(15; "File Name"; Text[250])
        {
            DataClassification = CustomerContent;
            Editable = false;
            Caption = 'Attachment';
        }
        field(16; "File Extension"; Text[30])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(17; "Attached By"; Code[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
            Caption = 'Attached By';
        }
        field(18; "Attached Date"; DateTime)
        {
            DataClassification = CustomerContent;
            Editable = false;
            Caption = 'Attached Date';
        }
        field(19; "Media Storage"; Media)
        {
            DataClassification = CustomerContent;
            Editable = false;
            Caption = 'Media Storage';
        }
        field(20; "Total Training Target"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            // FieldClass = FlowField;
            // CalcFormula = sum("Employee Training".Duration where( "Employee No."= field("Training Name"),=field("Item Filter")));
        }
        field(21; "Total Training Completed"; Integer)
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
    trigger OnInsert()
    begin
        Validate("Attached By",UserId);
        Validate("Attached Date",CurrentDateTime);
        // if "Training Name".Contains('T1') or "Training Name".Contains('T2')then
        // Message('First Attach Certificate then fillup other information');
    end;
    procedure SaveAttachmentIntoBlobFromStream(DocStream: InStream;FileName: Text)
    var
        OStream: OutStream;
        Filemgmt: Codeunit "File Management";
    begin
        Validate("File Extension",Filemgmt.GetExtension(FileName));
        Validate("File Name",CopyStr(Filemgmt.GetFileNameWithoutExtension(FileName),1,MaxStrLen("File Name")));
        Rec.Certificate.CreateOutStream(OStream);
        CopyStream(OStream, DocStream);
        Insert(true);
    end;
}
