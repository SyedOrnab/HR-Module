tableextension 50000 "Employee Ext" extends Employee
{
    fields
    {
        field(50000; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
        }
    }
}
