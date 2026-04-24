page 60103 "Course Enrollment"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Documents;
    SourceTable = "Course Enrollment";
    CardPageId = "Course Enrollment Card";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                Editable = false;
                field("Enrollment ID"; Rec."Enrollment ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Enrollment ID';
                }
                field("Student ID"; Rec."Student ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Student ID';
                }
                field("Course Name"; Rec."Course Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Course Name';
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
        }
    }
}
