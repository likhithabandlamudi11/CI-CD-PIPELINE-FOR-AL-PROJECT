page 60104 "Course Enrollment Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Documents;
    SourceTable = "Course Enrollment";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Enrollment ID"; Rec."Enrollment ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Enrollment ID (auto-generated)';
                    Editable = false;
                }
                field("Student ID"; Rec."Student ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Student ID';
                    trigger OnValidate()
                    var
                        EnrollmentMgmt: Codeunit "Student Enrollment Management";
                        EnrollmentRec: Record "Course Enrollment";
                    begin
                        if Rec."Student ID" <> '' then begin
                            EnrollmentMgmt.PopulateEnrollmentByStudentID(Rec, Rec."Student ID");
                            // Auto-save the record to generate Enrollment ID
                            if Rec."Enrollment ID" = '' then begin
                                Rec.Insert(true);
                                CurrPage.Update(false);
                            end;
                        end;
                    end;
                }
                field("Course ID"; Rec."Course ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Course ID (auto-populated from Student selection)';
                    Editable = false;
                }
            }
            group("Enrollment Details")
            {
                field("Course Name"; Rec."Course Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Course Name (auto-populated)';
                    Editable = false;
                }
                field("Course Fee"; Rec."Course Fee")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Course Fee (auto-populated)';
                    Editable = false;
                }
                field("Enrollment Date"; Rec."Enrollment Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Enrollment Date';
                    Editable = false;
                }
                field("Fee Payment Status"; Rec."Fee Payment Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Fee Payment Status';
                    Editable = false;
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
            action("Validate Enrollment")
            {
                ApplicationArea = All;
                ToolTip = 'Validate if the student can be enrolled in the course';
                Image = Process;

                trigger OnAction()
                var
                    EnrollmentMgmt: Codeunit "Student Enrollment Management";
                begin
                    if EnrollmentMgmt.ValidateEnrollment(Rec."Student ID", Rec."Course ID") then
                        Message('Student enrolled successfully.')
                    else
                        Message('Enrollment validation failed.');
                end;
            }
        }
    }


}
