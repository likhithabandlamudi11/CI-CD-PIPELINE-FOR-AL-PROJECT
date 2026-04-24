permissionset 60101 MyPermissionSet
{
    Assignable = true;

    Permissions =
        tabledata "Course List" = RIMD,
        tabledata "Student List" = RIMD,
        tabledata "Course Enrollment" = RIMD,
        page "Course List" = x,
        page "Student List" = x,
        page "Student Card" = x,
        page "Course Enrollment" = x,
        page "Course Enrollment Card" = x;
}