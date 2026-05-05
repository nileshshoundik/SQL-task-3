-- TASK-3
use StudentManagement;
-- Querry 1.Top student per course.

select c.name as course, s.name as student, e.grade
from enrollments e
join students s on e.student_id = s.StudentID
join courses c on e.course_id = c.id
where e.grade = (
select MAX(e2.grade)
from enrollments e2
where e2.course_id = e.course_id
);

-- querry 2. Pass rate per course (grade ≥ 40)

select c.name AS course,
SUM(case when e.grade >= 40 then 1 else 0 end) * 100.0 / COUNT(*) as pass_rate
from enrollments e
join courses c on e.course_id = c.id
group by c.name;

-- querry 3. Overall topper across all courses.

select s.name as student, e.grade
from enrollments e
join students s on e.student_id = s.StudentID
where e.grade = (select max(grade) from enrollments);

-- querry 4. Students enrolled in multiple courses.

select student_id, count(course_id) as total_courses
from enrollments
group by student_id
having count(course_id) >1;