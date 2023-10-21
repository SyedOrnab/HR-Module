tableextension 50000 "Employee Ext" extends Employee
{
    fields
    {
        field(951; "Time Sheet Owner User ID"; Code[50])
        {
            Caption = 'Time Sheet Owner User ID';
            DataClassification = EndUserIdentifiableInformation;
            TableRelation = "User Setup";

            trigger OnValidate()
            begin
                if "Time Sheet Owner User ID" <> xRec."Time Sheet Owner User ID" then
                    if ExistUnprocessedTimeSheets then
                        Error(Text005, FieldCaption("Time Sheet Owner User ID"));
            end;
        }
        field(952; "Time Sheet Approver User ID"; Code[50])
        {
            Caption = 'Time Sheet Approver User ID';
            DataClassification = EndUserIdentifiableInformation;
            TableRelation = "User Setup";

            trigger OnValidate()
            var
                IsHandled: Boolean;
            begin
                IsHandled := false;
                OnBeforeValidateTimeSheetApproverUserID(Rec, IsHandled);
                if IsHandled then
                    exit;

                if "Time Sheet Approver User ID" <> xRec."Time Sheet Approver User ID" then
                    if ExistUnprocessedTimeSheets then
                        Error(Text005, FieldCaption("Time Sheet Approver User ID"));
            end;
        }
    }
    var
        Text005: Label '%1 cannot be changed since unprocessed time sheet lines exist for this resource.';

    local procedure ExistUnprocessedTimeSheets(): Boolean
    var
        TimeSheetHeader: Record "Time Sheet Header";
        TimeSheetLine: Record "Time Sheet Line";
    begin
        TimeSheetHeader.SetCurrentKey("Resource No.");
        TimeSheetHeader.SetRange("Resource No.", "No.");
        if TimeSheetHeader.FindSet then
            repeat
                TimeSheetLine.SetRange("Time Sheet No.", TimeSheetHeader."No.");
                TimeSheetLine.SetRange(Posted, false);
                if not TimeSheetLine.IsEmpty() then
                    exit(true);
            until TimeSheetHeader.Next() = 0;

        exit(false);
    end;
    [IntegrationEvent(false, false)]
    local procedure OnBeforeValidateTimeSheetApproverUserID(var Employee: Record Employee; var IsHandled: Boolean)
    begin
    end;
}
