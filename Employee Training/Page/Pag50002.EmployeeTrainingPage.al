page 50002 "Employee Training Page"
{
    ApplicationArea = All;
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
                    ToolTip = 'Specifies the value of the Employee No. field.';
                    Visible = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
                    Visible = false;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field.';
                }
                field("Training Name"; Rec."Training Name")
                {
                    ToolTip = 'Specifies the value of the Training Name field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Duration"; Rec."Duration")
                {
                    ToolTip = 'Specifies the value of the Duration field.';
                }
                field("Planned Start Date"; Rec."Planned Start Date")
                {
                    ToolTip = 'Specifies the value of the Planned Start Date field.';
                    trigger OnValidate()
                    begin
                        Rec."Planned End Date" := Rec."Planned Start Date" + Rec.Duration;
                    end;
                }
                field("Planned End Date"; Rec."Planned End Date")
                {
                    ToolTip = 'Specifies the value of the Planned End Date field.';
                }
                field("Actual Start Date"; Rec."Actual Start Date")
                {
                    ToolTip = 'Specifies the value of the Actual Start Date field.';
                }
                field("Actual End Date"; Rec."Actual End Date")
                {
                    ToolTip = 'Specifies the value of the Actual End Date field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Certification No"; Rec."Certification No")
                {
                    ToolTip = 'Specifies the value of the Certification No field.';
                }
                field(Certificate; Rec.Certificate)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Certificate field.';

                    trigger OnDrillDown()
                    var
                        Selection: Integer;
                    begin
                        if Rec."Document Reference ID".HasValue() then
                            Export(true);
                    end;
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
                Caption = 'Attachments';
                Image = Attach;
                ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                trigger OnAction()
                var
                    DocumentAttachmentDetails: Page "Document Attachment Details";
                    RecRef: RecordRef;
                begin
                    RecRef.GetTable(Rec);
                    DocumentAttachmentDetails.OpenForRecRef(RecRef);
                    DocumentAttachmentDetails.RunModal();
                end;
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Certificate := SelectFileTxt;
    end;
    var
        myInt: Integer;
        DownloadEnabled: Boolean;
        SelectFileTxt: Label 'Attach File(s)...';
}
