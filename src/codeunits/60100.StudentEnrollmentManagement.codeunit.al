codeunit 60100 "Student Enrollment Management"
{

    procedure UpdateStudentInfo(var StudentRec: Record "Student List")
    begin
        UpdateFullNameInRecord(StudentRec);
        UpdateAgeInRecord(StudentRec);
    end;

    procedure SetDefaultJoiningDate(var StudentRec: Record "Student List")
    begin
        StudentRec."Date of Joining" := Today();
    end;

    local procedure UpdateFullNameInRecord(var StudentRec: Record "Student List")
    begin
        StudentRec."Full Name" := StudentRec."First Name" + ' ' + StudentRec."Last Name";
    end;

    local procedure UpdateAgeInRecord(var StudentRec: Record "Student List")
    var
        Age: Integer;
        Today_Date: Date;
        BirthYear: Integer;
        CurrentYear: Integer;
        BirthDay: Integer;
        BirthMonth: Integer;
        TodayDay: Integer;
        TodayMonth: Integer;
    begin
        Today_Date := Today();
        if StudentRec."Date of Birth" <> 0D then begin
            CurrentYear := System.Date2DMY(Today_Date, 3);
            BirthYear := System.Date2DMY(StudentRec."Date of Birth", 3);
            Age := CurrentYear - BirthYear;
            BirthMonth := System.Date2DMY(StudentRec."Date of Birth", 2);
            BirthDay := System.Date2DMY(StudentRec."Date of Birth", 1);
            TodayMonth := System.Date2DMY(Today_Date, 2);
            TodayDay := System.Date2DMY(Today_Date, 1);
            if (BirthMonth > TodayMonth) or ((BirthMonth = TodayMonth) and (BirthDay > TodayDay)) then
                Age := Age - 1;
        end;
        StudentRec.Age := Age;
    end;

    procedure UpdateStudentFullNameByID(StudentID: Code[20])
    var
        StudentRec: Record "Student List";
    begin
        if StudentRec.Get(StudentID) then begin
            StudentRec."Full Name" := StudentRec."First Name" + ' ' + StudentRec."Last Name";
            StudentRec.Modify();
        end;
    end;

    procedure CalculateStudentAge(DateOfBirth: Date): Integer
    var
        Age: Integer;
        Today_Date: Date;
        BirthYear: Integer;
        CurrentYear: Integer;
        BirthDay: Integer;
        BirthMonth: Integer;
        TodayDay: Integer;
        TodayMonth: Integer;
    begin
        Today_Date := Today();
        if DateOfBirth <> 0D then begin
            CurrentYear := System.Date2DMY(Today_Date, 3);
            BirthYear := System.Date2DMY(DateOfBirth, 3);
            Age := CurrentYear - BirthYear;
            BirthMonth := System.Date2DMY(DateOfBirth, 2);
            BirthDay := System.Date2DMY(DateOfBirth, 1);
            TodayMonth := System.Date2DMY(Today_Date, 2);
            TodayDay := System.Date2DMY(Today_Date, 1);
            if (BirthMonth > TodayMonth) or ((BirthMonth = TodayMonth) and (BirthDay > TodayDay)) then
                Age := Age - 1;
        end;
        exit(Age);
    end;

    procedure ValidateEnrollment(StudentID: Code[20]; CourseID: Code[20]): Boolean
    var
        StudentRec: Record "Student List";
        EnrollmentRec: Record "Course Enrollment";
    begin
        // Get Student Information
        if not StudentRec.Get(StudentID) then begin
            Error('Student not found.');
            exit(false);
        end;

        // Check if Fee is Paid
        if not StudentRec."Fee Paid" then begin
            Error('Please pay the course fee first to complete enrollment.');
            exit(false);
        end;

        // Check Age Validation (minimum 16 years)
        if StudentRec.Age < 16 then begin
            Error('Student must be at least 16 years old to enroll in a course.');
            exit(false);
        end;

        // Check for Duplicate Enrollment
        EnrollmentRec.SetRange("Student ID", StudentID);
        EnrollmentRec.SetRange("Course ID", CourseID);
        if EnrollmentRec.FindFirst() then begin
            Error('Student is already enrolled in this course.');
            exit(false);
        end;

        exit(true);
    end;

    procedure PopulateEnrollmentFields(var EnrollmentRec: Record "Course Enrollment"; StudentID: Code[20]; CourseID: Code[20])
    var
        StudentRec: Record "Student List";
        CourseRec: Record "Course List";
    begin
        if StudentRec.Get(StudentID) then begin
            EnrollmentRec."Student ID" := StudentID;
            EnrollmentRec."Course Name" := StudentRec."Course Selected";

            if CourseRec.Get(CourseID) then begin
                EnrollmentRec."Course Fee" := CourseRec."Course Fee";
                EnrollmentRec."Course ID" := CourseID;
                EnrollmentRec."Course Name" := CourseRec."Course Name";
            end;

            if StudentRec."Fee Paid" then
                EnrollmentRec."Fee Payment Status" := 'Fee paid. Enrollment allowed.'
            else
                EnrollmentRec."Fee Payment Status" := 'Fee not paid. Enrollment blocked.';

            EnrollmentRec."Enrollment Date" := Today();
        end;
    end;

    procedure GetCourseDetails(CourseID: Code[20]): Decimal
    var
        CourseRec: Record "Course List";
    begin
        if CourseRec.Get(CourseID) then
            exit(CourseRec."Course Fee")
        else
            exit(0);
    end;

    procedure CheckDuplicateEnrollment(StudentID: Code[20]; CourseID: Code[20]): Boolean
    var
        EnrollmentRec: Record "Course Enrollment";
    begin
        EnrollmentRec.SetRange("Student ID", StudentID);
        EnrollmentRec.SetRange("Course ID", CourseID);
        exit(EnrollmentRec.FindFirst());
    end;

    procedure ValidateAgeForEnrollment(StudentID: Code[20]): Boolean
    var
        StudentRec: Record "Student List";
    begin
        if StudentRec.Get(StudentID) then begin
            if StudentRec.Age < 16 then begin
                Error('Student must be at least 16 years old to enroll in a course.');
                exit(false);
            end;
            exit(true);
        end;
        exit(false);
    end;

    procedure DisplayEnrollmentMessage(FeePaid: Boolean): Text
    begin
        if FeePaid then
            exit('Student enrolled successfully.')
        else
            exit('Please pay the course fee first to complete enrollment.');
    end;

    procedure PopulateEnrollmentByStudentID(var EnrollmentRec: Record "Course Enrollment"; StudentID: Code[20])
    var
        StudentRec: Record "Student List";
        CourseRec: Record "Course List";
    begin
        if StudentID <> '' then begin
            if StudentRec.Get(StudentID) then begin
                // Set Course ID from Student's Course Selected
                EnrollmentRec."Course ID" := StudentRec."Course Selected";

                // Get course name and fee from Course List using the selected course
                if StudentRec."Course Selected" <> '' then begin
                    if CourseRec.Get(StudentRec."Course Selected") then begin
                        EnrollmentRec."Course Name" := CourseRec."Course Name";
                        EnrollmentRec."Course Fee" := CourseRec."Course Fee";
                    end;
                end;

                UpdateEnrollmentFeeStatus(EnrollmentRec, StudentRec."Fee Paid");
            end;
        end;
    end;

    procedure PopulateEnrollmentByCourseID(var EnrollmentRec: Record "Course Enrollment"; CourseID: Code[20])
    var
        CourseRec: Record "Course List";
    begin
        if CourseID <> '' then begin
            if CourseRec.Get(CourseID) then begin
                EnrollmentRec."Course Name" := CourseRec."Course Name";
                EnrollmentRec."Course Fee" := CourseRec."Course Fee";
            end;
        end;
    end;

    procedure UpdateEnrollmentFeeStatus(var EnrollmentRec: Record "Course Enrollment"; FeePaid: Boolean)
    begin
        if FeePaid then
            EnrollmentRec."Fee Payment Status" := 'Fee paid. Enrollment allowed.'
        else
            EnrollmentRec."Fee Payment Status" := 'Fee not paid. Enrollment blocked.';
    end;

    procedure GenerateEnrollmentID(var EnrollmentRec: Record "Course Enrollment")
    var
        LastEnrollmentRec: Record "Course Enrollment";
        NewEnrollmentID: Code[20];
        NextNumber: Integer;
        EnrollmentIDText: Text;
        NumericPart: Text;
        FormattedNumber: Text;
    begin
        LastEnrollmentRec.SetCurrentKey("Enrollment ID");
        if LastEnrollmentRec.FindLast() then begin
            EnrollmentIDText := LastEnrollmentRec."Enrollment ID";
            // Extract the numeric part from the last Enrollment ID (ENR followed by number)
            if StrPos(EnrollmentIDText, 'ENR') = 1 then begin
                NumericPart := DelStr(EnrollmentIDText, 1, 3);
                NumericPart := DelChr(NumericPart, '=', ' ');
                if NumericPart <> '' then begin
                    Evaluate(NextNumber, NumericPart);
                    NextNumber := NextNumber + 1;
                end else begin
                    NextNumber := 1;
                end;
            end else begin
                NextNumber := 1;
            end;
        end else begin
            NextNumber := 1;
        end;

        // Format with leading zeros: ENR0000001, ENR0000002, etc.
        FormattedNumber := Format(NextNumber);
        while StrLen(FormattedNumber) < 7 do
            FormattedNumber := '0' + FormattedNumber;

        NewEnrollmentID := 'ENR' + FormattedNumber;
        EnrollmentRec."Enrollment ID" := NewEnrollmentID;
    end;
}
