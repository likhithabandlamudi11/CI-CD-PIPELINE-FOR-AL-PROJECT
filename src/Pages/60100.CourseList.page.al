page 60100 "Course List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Documents;
    SourceTable = "Course List";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Course ID"; Rec."Course ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Course ID';
                }
                field("Course Name"; Rec."Course Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Course Name';
                }
                field("Course Fee"; Rec."Course Fee")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Course Fee';
                }
            }
        }
        area(Factboxes)
        {
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;
                ToolTip = 'Executes the action';
            }
        }
    }
}
