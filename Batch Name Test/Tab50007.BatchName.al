table 50007 "Batch Name "
{
    Caption = 'Batch Name ';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; "Payment Batch Name"; Code[20])
        {
            Caption = 'Payment Batch Name';
        }
        field(3; "Payable Batch Name"; Code[20])
        {
            Caption = 'Payable Batch Name';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Journal Template Name"));

            trigger OnValidate()
            begin
                UpdateJournalBatchID;
            end;
        }
        field(4; "Journal Template Name"; Code[20])
        {
            Caption = 'Journal Template Name';
            TableRelation = "Gen. Journal Line";
        }
        field(8006; "Journal Batch Id"; Guid)
        {
            Caption = 'Journal Batch Id';
            TableRelation = "Gen. Journal Batch".SystemId;

            trigger OnValidate()
            begin
                UpdateJournalBatchName();
            end;
        }
        field(51; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Journal Template Name"));

            trigger OnValidate()
            begin
                UpdateJournalBatchID;
            end;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    procedure UpdateJournalBatchID()
    var
        GenJournalBatch: Record "Gen. Journal Batch";
    begin
        if not GenJournalBatch.Get("Journal Template Name", "Journal Batch Name") then
            exit;

        "Journal Batch Id" := GenJournalBatch.SystemId;
    end;

    local procedure UpdateJournalBatchName()
    var
        GenJournalBatch: Record "Gen. Journal Batch";
    begin
        if not GenJournalBatch.GetBySystemId("Journal Batch Id") then
            exit;

        "Journal Batch Name" := GenJournalBatch.Name;
    end;
}
