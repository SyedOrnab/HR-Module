page 50004 "Training Master Page"
{
    ApplicationArea = All;
    Caption = 'Training Master Page';
    PageType = List;
    SourceTable = "Training Master";
    UsageCategory = Lists;
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
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
            }
        }
    }
}
