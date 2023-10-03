page 50004 "Training Master Page"
{
    Caption = 'Training Master Page';
    PageType = List;
    DataCaptionFields = "Training Name";
    SourceTable = "Training Master";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                    
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
            }
        }
        // area(factboxes)
        // {
        //     systempart(Control1900383207; Links)
        //     {
        //         ApplicationArea = RecordLinks;
        //         Visible = false;
        //     }
        //     systempart(Control1905767507; Notes)
        //     {
        //         ApplicationArea = Notes;
        //         Visible = false;
        //     }
        // }
    }
}
