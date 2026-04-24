table 60101 "Student List"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Student ID"; Code[20])
        {
            Caption = 'Student ID';
            DataClassification = ToBeClassified;
        }
        field(2; "First Name"; Text[50])
        {
            Caption = 'First Name';
            DataClassification = ToBeClassified;
        }
        field(3; "Last Name"; Text[50])
        {
            Caption = 'Last Name';
            DataClassification = ToBeClassified;
        }
        field(4; "Full Name"; Text[100])
        {
            Caption = 'Full Name';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(5; "Date of Birth"; Date)
        {
            Caption = 'Date of Birth';
            DataClassification = ToBeClassified;
        }
        field(6; "Age"; Integer)
        {
            Caption = 'Age';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(7; "Course Selected"; Code[20])
        {
            Caption = 'Course Selected';
            TableRelation = "Course List"."Course ID";
            DataClassification = ToBeClassified;
        }
        field(8; "Date of Joining"; Date)
        {
            Caption = 'Date of Joining';
            DataClassification = ToBeClassified;
        }
        field(9; "Fee Paid"; Boolean)
        {
            Caption = 'Fee Paid';
            DataClassification = ToBeClassified;
        }
        field(10; Email; Text[100])
        {
            Caption = 'Email';
        }
    }

    keys
    {
        key(PK; "Student ID")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        EnrollmentMgmt: Codeunit "Student Enrollment Management";
    begin
        EnrollmentMgmt.SetDefaultJoiningDate(Rec);
        EnrollmentMgmt.UpdateStudentInfo(Rec);
    end;

    trigger OnModify()
    var
        EnrollmentMgmt: Codeunit "Student Enrollment Management";
    begin
        EnrollmentMgmt.UpdateStudentInfo(Rec);
    end;
}
