BEGIN {
	FS = " *\t+ *"
	get_course_id_sql = "(SELECT course_id FROM course WHERE major_no = \"%s\" and minor_no = \"%s\")"
	get_instructor_id_sql = "(SELECT instructor_id FROM instructor WHERE name = \"%s\")"
}

{
	if ( FILENAME == "instructor" ) {
		printf("INSERT INTO instructor (name, title, homepage)\n")
		printf("VALUE (\"%s\", \"%s\", \"%s\");\n", $1, $2, $3)
	} else if ( FILENAME == "course" ) {
		n = split($1, no, ".")
		printf("INSERT INTO course (major_no, minor_no, name, homepage)\n")
		printf("VALUE (\"%s\", \"%s\", \"%s\", \"%s\");\n", no[1], no[2], $2, $3)
	} else if ( FILENAME == "instruction" ) {
		n = split($2, no, ".")
		printf("INSERT INTO instruction (instructor_id, course_id)\n")
		printf("VALUE (")
		printf(get_instructor_id_sql ",", $1)
		printf(get_course_id_sql ");\n", no[1], no[2])
	} else if ( FILENAME == "prerequisite" ) {
		n = split($1, no1, ".")
		n = split($2, no2, ".")
		printf("INSERT INTO prerequisite (course_id, required_course)\n")
		printf("VALUE(")
		printf(get_course_id_sql ",", no1[1], no1[2])
		printf(get_course_id_sql ");\n", no2[1], no2[2])
	}
}
