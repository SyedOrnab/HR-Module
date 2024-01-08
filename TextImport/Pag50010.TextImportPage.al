page 50010 TextImportPage
{
    PageType = Worksheet;
    ApplicationArea = All;
    UsageCategory = Tasks;
    SourceTable = TextImport;
    AutoSplitKey = true;
    Caption = 'Attendance Data Import';
    DelayedInsert = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    SaveValues = true;
    SourceTableView = sorting("Transaction Name", "Line No.");


    layout
    {
        area(Content)
        {
            field(TransName; TransName)
            {
                Caption = 'Transaction Name';
                ApplicationArea = All;
            }
            repeater(Group)
            {
                Editable = false;
                field("Transaction Name"; Rec."Transaction Name")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Employee No."; Rec."Employee ID")
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Date; Rec."Attendance Time")
                {
                    ApplicationArea = All;
                }
                field("Terminal ID"; Rec."Terminal ID")
                {
                    ApplicationArea = All;
                }
            }

        }
    }
    actions
    {
        area(Processing)
        {
            action("&Import")
            {
                ApplicationArea = All;
                Caption = '&Import';
                Image = ImportDatabase;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Import data from Attendance Data';

                trigger OnAction()
                begin
                    if TransName = '' then
                        Error(BatchIsblankmsg);
                    ReadTextdata();
                    ImportTextData();

                end;
            }
        }
    }
    var
        TransName: Code[10];
        FileName: Text[100];  //filepath
        TempTextBuffer: Record "CSV Buffer" temporary;
        UploadMsg: Label 'Please choose the Text file';
        NoFileMsg: Label 'No Text file found';
        BatchIsblankmsg: Label 'Trasaction name is blank';
        TextImportSuccess: Label 'Text imported successfully';




    local procedure ReadTextdata()
    var
        FileManagent: Codeunit "File Management";
        Istream: InStream;
        FromFile: Text[100];
    begin
        UploadIntoStream(UploadMsg, '', '', FromFile, Istream);
        if FromFile <> '' then begin
            FileName := FileManagent.GetFileName(FromFile);
        end else
            Error(NoFileMsg);
        TempTextBuffer.Reset();
        TempTextBuffer.DeleteAll();
        TempTextBuffer.LoadDataFromStream(Istream, ',');
        TempTextBuffer.GetNumberOfLines();
    end;

    local procedure GetValueAtCell(RowNo: Integer; ColNo: Integer): Text

    begin
        TempTextBuffer.Reset();
        if TempTextBuffer.Get(RowNo, ColNo) then
            exit(TempTextBuffer.Value)
        else
            exit('');
    end;


    local procedure ImportTextData()
    var
        ImportBuffer: Record CSVimport;
        RowNo: Integer;
        ColNo: Integer;
        LineNO: Integer;
        MaxRow: Integer;
    begin
        RowNo := 0;
        ColNo := 0;
        MaxRow := 0;
        LineNO := 0;
        ImportBuffer.Reset();
        if ImportBuffer.FindLast() then
            LineNO := ImportBuffer."Line No.";
        TempTextBuffer.Reset();
        if TempTextBuffer.FindLast() then begin
            MaxRow := TempTextBuffer."Line No.";
        end;
        for RowNo := 2 to MaxRow do begin
            LineNO := LineNO + 10000;
            ImportBuffer.Init();
            Evaluate(ImportBuffer."Transaction Name", TransName);
            ImportBuffer."Line No." := LineNO;
            Evaluate(ImportBuffer."Employee ID", GetValueAtCell(RowNo, 1));
            Evaluate(ImportBuffer."Attendance Time", GetValueAtCell(RowNo, 2));
            Evaluate(ImportBuffer."Terminal ID", GetValueAtCell(RowNo, 3));
            ImportBuffer.Insert();
        end;
        Message(TextImportSuccess);
    end;
}
