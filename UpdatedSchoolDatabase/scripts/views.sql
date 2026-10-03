--1 Create vw_DepartmentSummary showing each Department with Student Count and Teacher Count.
Alter view vw_DepartmentSummary (DapartmentName , StudentCount , TeacherCount)
with encryption
as 
select d.Name_ , COUNT(Distinct(s.ID)) , COUNT(Distinct(t.ID))
from Department d Left join Student s
on d.ID = s.DepartmentID
Left join Teacher t
on d.ID = t.DepartmentID
group by d.Name_
Go

-- sp_helptext 'vw_DepartmentSummary' can't get query as it's encrypted
select * from vw_DepartmentSummary;
Go


--2 Create vw_TeacherCourseLoad showing each Teacher and the number of Courses they teach.
create view vw_TeacherCourseLoad
as
select t.ID , t.FName , COUNT(c.Code) As CoursesCount
from Teacher t left join Course c
on t.ID = c.TeacherId
group by t.ID , t.FName
Go

select FName , CoursesCount from vw_TeacherCourseLoad
Go


--3 Create vw_StudentFullReport combining Student information, enrolled Courses, Grades, and a computed Status.
create view vw_StudentFullReport 
with encryption
as 
Select s.ID , s.FName + ' ' + s.LName As FullName , c.Name , e.Grade , 
   case 
     when e.Grade >= 50 Then 'Passed'
     when e.Grade < 50 then  'Failled'
     else 'Pending'
     END As Status
from Student s join Enrollement e
on s.ID = e.StudentID
join Course c
on c.Code = e.Code
Go

select * from vw_StudentFullReport
Go

--4 Create vw_DepartmentTopStudent using RANK() or ROW_NUMBER() to identify the top Student by average Grade.
-- using Rank() as it give the rank to the same grade. 
create view vw_DepartmentTopStudent 
with encryption 
as
select d.ID as DepartmentID, s.FName , AVG(e.Grade) as AverageGrade ,
      Rank() over (PARTITION BY d.ID order by Avg(e.grade) DESC) AS Rank_
from Student s join Enrollement e
on s.ID = e.StudentID
join Department d
on s.DepartmentID = d.ID
group by d.ID , s.FName
Go

select * from vw_DepartmentTopStudent
Go