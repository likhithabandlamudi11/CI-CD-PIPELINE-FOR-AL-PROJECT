table 60100 "Course List"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Course ID"; Code[20])
        {
            Caption = 'Course ID';
            DataClassification = ToBeClassified;
        }
        field(2; "Course Name"; Text[100])
        {
            Caption = 'Course Name';
            DataClassification = ToBeClassified;
        }
        field(3; "Course Fee"; Decimal)
        {
            Caption = 'Course Fee';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Course ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Course ID", "Course Name", "Course Fee")
        {
        }
    }
}
