page 50002 "Employee Training Page"
{
    Caption = 'Employee Training Page';
    PageType = List;
    SourceTable = "Employee Training";
    UsageCategory = Lists;
    AutoSplitKey = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the value of the Employee No. field.';
                    Visible = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the value of the Line No. field.';
                    Visible = false;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the value of the Employee Name field.';
                }
                field("Training Name"; Rec."Training Name")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the value of the Training Name field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Duration"; Rec."Duration")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the value of the Duration field.';
                }
                field("Planned Start Date"; Rec."Planned Start Date")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the value of the Planned Start Date field.';
                    trigger OnValidate()
                    begin
                        Rec."Planned End Date" := Rec."Planned Start Date" + Rec.Duration;
                    end;
                }
                field("Planned End Date"; Rec."Planned End Date")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the value of the Planned End Date field.';
                }
                field("Actual Start Date"; Rec."Actual Start Date")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the value of the Actual Start Date field.';
                }
                field("Actual End Date"; Rec."Actual End Date")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the value of the Actual End Date field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Certification No"; Rec."Certification No")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the value of the Certification No field.';
                }
                field(Certificate; Rec.Certificate)
                {
                    ApplicationArea = BasicHR;
                    // ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Certificate field.';
                }
                field("File Name"; Rec."File Name")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the value of the File Name field.';
                    // Visible = false;
                    Caption = 'Certificate File Name';
                    trigger OnDrillDown()
                    var
                        FileUploaded: Boolean;
                    begin
                        if Rec."File Name" = 'Attach File(s)...' then
                        begin
                            AttachFile();
                            // FileUploaded := true;
                        end
                        else
                        begin
                            DownloadFile();
                        end;
                    end;
                }
                field("File Extension"; Rec."File Extension")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the value of the File Extension field.';
                    Visible = false;
                }
                field("Attached By"; Rec."Attached By")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the value of the Attached By field.';
                    Visible = false;
                }
                field("Attached Date";Rec."Attached Date")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the value of the Attached Date field.';
                    Visible = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Attach Certificate")
            {
                ApplicationArea = All;
                Caption = 'Attach Certificate';
                Image = Attach;
                ToolTip = 'Import Blob File';
                trigger OnAction()
                begin
                    AttachFile()
                end;
                /*trigger OnAction()
                var
                    FileMng: Codeunit "File Management";
                    TempBlob: Codeunit "Temp Blob";
                    InStr: InStream;
                    OutStr: OutStream;
                    Filename: Text;
                    FilePath: Text;
                begin
                    if UploadIntoStream(SelectFileText1, '', '', FilePath, InStr) then
                        Rec.SaveAttachmentIntoBlobFromStream(InStr, FilePath);
                end;*/
            }
            action("Download")
            {
                ApplicationArea = ALL;
                Caption = 'Download';
                Image = Download;
                ToolTip = 'Download';

                trigger OnAction()
                begin
                    DownloadFile();
                end;
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."File Name" := SelectFileTxt;
    end;
    var
        myInt: Integer;
        DownloadEnabled: Boolean;
        // FileUploaded: Boolean;
        SelectFileText1: Label 'Select File..';
        SelectFileTxt: Label 'Attach File(s)...';

    local procedure InitiateUploadFile()
    var
        PathToFile: Text;
        OutStr: OutStream;
        InStr: InStream;

    begin
        File.UploadIntoStream('', '', '', PathToFile, InStr);
        Rec.Certificate.CreateOutStream(OutStr);
        CopyStream(OutStr, InStr);
        Rec.Modify();
    end;


    local procedure DownloadFile()
    var
        OutStr: OutStream;
        InStr: Instream;
        Filename: Text;
        FileMng: Codeunit "File Management";
        TempBlob: Codeunit "Temp Blob";
    begin
        Filename := (Rec."File Name"+'.'+Rec."File Extension");
        Rec.CalcFields(Certificate);
        Rec.Certificate.CreateInStream(InStr);
        TempBlob.CreateOutStream(OutStr);
        CopyStream(OutStr, InStr);
        FileMng.BLOBExport(TempBlob, Filename, true);
    end;
    local procedure AttachFile()
    var
        FileMng: Codeunit "File Management";
        TempBlob: Codeunit "Temp Blob";
        InStr: InStream;
        OutStr: OutStream;
        Filename: Text;
        FilePath: Text;
    begin
        if UploadIntoStream(SelectFileText1, '', '', FilePath, InStr) then
        Rec.SaveAttachmentIntoBlobFromStream(InStr, FilePath);
    end;

}
