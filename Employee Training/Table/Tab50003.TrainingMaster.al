table 50003 "Training Master"
{
    Caption = 'Training Master';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Training ID"; Code[20])
        {
            Caption = 'Training Code';
            DataClassification = ToBeClassified;
        }
        field(2; "Training Name"; Text[50])
        {
            Caption = 'Training Name';
        }
        field(3; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(4; "Duration"; Integer)
        {
            Caption = 'Duration';
        }
    }
    keys
    {
        key(PK; "Training ID")
        {
            Clustered = true;
        }
    }
}
