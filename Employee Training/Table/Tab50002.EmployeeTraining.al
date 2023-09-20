table 50002 "Employee Training"
{
    Caption = 'Employee Training';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Employee No."; Integer)
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
        field(13; "Certificate"; Text[250])
        {
            DataClassification = ToBeClassified;
            // SubType = 'File';
            NotBlank = true;

            trigger OnValidate()
            var
                DocumentAttachmentMgmt: Codeunit "Document Attachment Mgmt";
            begin
                if Certificate = '' then
                    Error(EmptyFileNameErr);

                if DocumentAttachmentMgmt.IsDuplicateFile(
                    "Table ID", "Employee No.", "Document Type".AsInteger(), "Line No.",Certificate, "File Extension")
                then
                    Error(DuplicateErr);
            end;
        }
        field(14; "Document Type"; Enum "Attachment Document Type")
        {
            Caption = 'Document Type';
        }
        field(15; "Table ID"; Integer)
        {
            Caption = 'Table ID';
            NotBlank = true;
            TableRelation = AllObjWithCaption."Object ID" WHERE("Object Type" = CONST(Table));
        }
        field(16; "File Type"; Enum "Document Attachment File Type")
        {
            Caption = 'File Type';
        }
        field(17; "File Extension"; Text[30])
        {
            Caption = 'File Extension';

            trigger OnValidate()
            begin
                case LowerCase("File Extension") of
                    'jpg', 'jpeg', 'bmp', 'png', 'tiff', 'tif', 'gif':
                        "File Type" := "File Type"::Image;
                    'pdf':
                        "File Type" := "File Type"::PDF;
                    'docx', 'doc':
                        "File Type" := "File Type"::Word;
                    'xlsx', 'xls':
                        "File Type" := "File Type"::Excel;
                    'pptx', 'ppt':
                        "File Type" := "File Type"::PowerPoint;
                    'msg':
                        "File Type" := "File Type"::Email;
                    'xml':
                        "File Type" := "File Type"::XML;
                    else
                        "File Type" := "File Type"::Other;
                end;
            end;
        }
        field(18; "Document Reference ID"; Media)
        {
            Caption = 'Document Reference ID';
        }
    }
    keys
    {
        key(PK; "Employee No.","Line No.")
        {
            Clustered = true;
        }
    }
    var
    EmptyFileNameErr: Label 'Please choose a file to attach.';
    DuplicateErr: Label 'This file is already attached to the document. Please choose another file.';
    procedure Export(ShowFileDialog: Boolean) Result: Text
    var
        TempBlob: Codeunit "Temp Blob";
        FileManagement: Codeunit "File Management";
        DocumentStream: OutStream;
        FullFileName: Text;
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeExport(Rec, IsHandled);
        if IsHandled then
            exit;

        if "Employee No." = 0 then
            exit;
            
        if not "Document Reference ID".HasValue() then
            exit;

        OnBeforeExportAttachment(Rec);
        FullFileName := "File Name" + '.' + "File Extension";
        TempBlob.CreateOutStream(DocumentStream);
        "Document Reference ID".ExportStream(DocumentStream);
        exit(FileManagement.BLOBExport(TempBlob, FullFileName, ShowFileDialog));
    end;
    local procedure OnBeforeExport(var DocumentAttachment: Record "Document Attachment"; var IsHandled: Boolean)
    begin
    end;

}
