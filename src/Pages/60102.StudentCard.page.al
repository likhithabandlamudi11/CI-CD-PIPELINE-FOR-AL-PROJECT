page 60102 "Student Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Documents;
    SourceTable = "Student List";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Student ID"; Rec."Student ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Student ID';
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the First Name';
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Last Name';
                }
            }
            group("Personal Information")
            {
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Date of Birth';
                }
                field("Age"; Rec."Age")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Age (auto-calculated)';
                }
            }
            group("Enrollment Information")
            {
                field("Course Selected"; Rec."Course Selected")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Course Selected from Course List';
                }
                field("Date of Joining"; Rec."Date of Joining")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Date of Joining (default: today)';
                }
                field("Fee Paid"; Rec."Fee Paid")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the Fee has been Paid';
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
