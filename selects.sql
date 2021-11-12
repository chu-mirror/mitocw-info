-- all instructors titled 'Dr.'
SELECT * FROM instructor
WHERE title = 'Dr.';

-- homepage of instructors titled 'Prof.'
SELECT homepage FROM instructor
WHERE title = 'Prof.';

-- all instructors who teaches 18.03
SELECT i.name
FROM instructor i
	INNER JOIN instruction ins ON i.instructor_id = ins.instructor_id
	INNER JOIN course c ON ins.course_id = c.course_id
WHERE c.major_no = 18 and c.minor_no = 03;

-- all instructors whose name beginning with 'A'
SELECT * FROM instructor
WHERE name REGEXP '^A.*';

-- the number of instructors titled 'Dr.'
SELECT count(*) FROM instructor
WHERE title = 'Dr.';

-- the numbers of courses grouped by its major_no
SELECT major_no, count(*) count FROM course
GROUP BY major_no;

-- the instructors' name
-- who instructs both 'Single Variable Calculus' and 'Multivariable Calculus'
SELECT i.name
FROM instructor i
	INNER JOIN instruction ins1 ON i.instructor_id = ins1.instructor_id
	INNER JOIN instruction ins2 ON i.instructor_id = ins2.instructor_id
	INNER JOIN course c1 ON ins1.course_id = c1.course_id
	INNER JOIN course c2 ON ins2.course_id = c2.course_id
WHERE c1.name = 'Single Variable Calculus' and c2.name = 'Multivariable Calculus';

-- the instructors' name who instructs 'Single Variable Calculus' or 'Multivariable Calculus'
SELECT i.name
FROM instructor i
	INNER JOIN instruction ins ON i.instructor_id = ins.instructor_id
	INNER JOIN course c ON ins.course_id = c.course_id 
WHERE c.name IN ('Single Variable Calculus', 'Multivariable Calculus')
GROUP BY i.name;

-- the instuctors' name who instructs course of 'Mathematics' department
SELECT i.name
FROM instructor i
	INNER JOIN instruction ins ON i.instructor_id = ins.instructor_id
	INNER JOIN course c ON ins.course_id = c.course_id
	INNER JOIN department d ON c.major_no = d.department_id
WHERE d.name = 'Mathematics'
GROUP BY i.name;
