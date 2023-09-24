table 50003 "Training Master"
{
    Caption = 'Training Master';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Training Name"; Text[50])
        {
            Caption = 'Training Name';
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(3; "Duration"; Integer)
        {
            Caption = 'Duration';
        }
        // field(4; "Training ID"; Code[20])
        // {
        //     Caption = 'Training ID';
        //     DataClassification = ToBeClassified;
        // }
    }
    // keys
    // {
    //     key(PK; "Training ID")
    //     {
    //         Clustered = true;
    //     }
    // }
}
