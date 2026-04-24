table 60102 "Course Enrollment"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Enrollment ID"; Code[20])
        {
            Caption = 'Enrollment ID';
            DataClassification = ToBeClassified;
        }
        field(2; "Student ID"; Code[20])
        {
            Caption = 'Student ID';
            TableRelation = "Student List"."Student ID";
            DataClassification = ToBeClassified;
        }
        field(3; "Course Name"; Text[100])
        {
            Caption = 'Course Name';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(4; "Course Fee"; Decimal)
        {
            Caption = 'Course Fee';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(5; "Fee Payment Status"; Text[200])
        {
            Caption = 'Fee Payment Status';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(6; "Enrollment Date"; Date)
        {
            Caption = 'Enrollment Date';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(7; "Course ID"; Code[20])
        {
            Caption = 'Course ID';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Enrollment ID")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        EnrollmentMgmt: Codeunit "Student Enrollment Management";
    begin
        if "Enrollment ID" = '' then begin
            EnrollmentMgmt.GenerateEnrollmentID(Rec);
        end;
        "Enrollment Date" := Today();
    end;
}
