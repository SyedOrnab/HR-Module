table 50003 "Training Master"
{
    Caption = 'Training Master';
    DrillDownPageId = "Training Master Page";
    LookupPageId = "Training Master Page";
    // DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Training Name"; Text[50])
        {
            Caption = 'Training Name';
            NotBlank = true;        // Mandatory field - without this fields, other fields will not be inserted
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(3; "Duration"; Integer)
        {
            Caption = 'Duration';
        }
    }
}
