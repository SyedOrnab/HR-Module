page 50009 "CSV Import"
{
    PageType = Worksheet;
    ApplicationArea = All;
    UsageCategory = Tasks;
    SourceTable = CSVimport;
    AutoSplitKey = true;
    Caption = 'CSV Import';
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
                //terminal
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
                ToolTip = 'Import data from CSV';

                trigger OnAction()
                begin
                    if TransName = '' then
                        Error(BatchIsblankmsg);
                    ReadCSVdata();
                    ImportCSVData();

                end;
            }
        }
    }
    var
        TransName: Code[10];
        FileName: Text[100];  //filepath
        TempCSVBuffer: Record "CSV Buffer" temporary;
        UploadMsg: Label 'Please choose the CSV file';
        NoFileMsg: Label 'No CSV file found';
        BatchIsblankmsg: Label 'Trasaction name is blank';
        CSVImportSuccess: Label 'CSV imported successfully';




    local procedure ReadCSVdata()
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
        TempCSVBuffer.Reset();
        TempCSVBuffer.DeleteAll();
        TempCSVBuffer.LoadDataFromStream(Istream, ',');
        TempCSVBuffer.GetNumberOfLines();
    end;

    local procedure GetValueAtCell(RowNo: Integer; ColNo: Integer): Text

    begin
        TempCSVBuffer.Reset();
        if TempCSVBuffer.Get(RowNo, ColNo) then
            exit(TempCSVBuffer.Value)
        else
            exit('');
    end;


    local procedure ImportCSVData()
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
        TempCSVBuffer.Reset();
        if TempCSVBuffer.FindLast() then begin
            MaxRow := TempCSVBuffer."Line No.";
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
        Message(CSVImportSuccess);
    end;
}


