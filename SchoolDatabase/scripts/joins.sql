--1 Students with their Department name using INNER JOIN
-- return students with their department
select s.FName + ' ' + s.LName As Student_Name , d.Name_ as Department_Name
from Student s Inner Join Department d 
on s.DepartmentID = d.ID


--2 Get Teacher who teaches more than 3 Courses using JOIN, GROUP BY, and HAVING.
-- display teachers that teach more than 3 courses (devide teachers into groups using id of each teacher) 
select t.ID , t.FName as TeacherName , count(c.Name) As 'Number of courses'
from Teacher t join Course c
on t.ID = c.TeacherId
group by t.ID , t.FName
Having Count(c.Name) > 3 


--3 Get every Student who has not received a Grade in any enrolled Course without using NOT IN.
-- return students' name who don't receive grades in any course
select s.FName + ' ' + s.LName As Student_Name 
from Student s join Enrollement e
on s.ID = e.StudentID
where e.Grade IS NULL


--4 Get every Department whose Lead Teacher supervises more than 5 Teachers using a Self JOIN and aggregation.
-- return no rows as there is no supervisors that supervise more than 5 teacher
select d.Name_ , count(t.ID) as 'Supervisee number'
from Teacher t  Join Teacher s
on t.SupervisorID = s.ID  -- parent with primary key
join Department d 
on s.DepartmentID = d.ID
group by d.Name_
having COUNT(t.ID) > 5


--5 Get students that enrolled in more than 1 course
select s.ID , s.FName As Student_Name , count(e.Code) as NumberOfCourses
from Student s join Enrollement e
on s.ID = e.StudentID
group by s.ID ,s.FName
Having COUNT(e.Code) > 1


--6 display average salary descending in each department 
select d.Name_ , AVG(t.Salary) As AverageSalary
from Department d join Teacher t
on d.ID = t.DepartmentID
group by d.Name_
order by AVG(t.Salary) DESC


--7 return number of student in each department with avg grades > 80
select d.Name_ , COUNT(distinct(s.ID)) As NumberOfStudents, AVG(e.Grade) As AverageGrades
from Department d  join Student s
on d.ID = s.DepartmentID 
join Enrollement e 
on s.ID = e.StudentID
group by d.Name_ 
having AVG(e.Grade) > 80


