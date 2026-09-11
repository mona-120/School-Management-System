--------- Create fn_CalculateAge(@DateOfBirth DATE) as a Scalar Function.
Create Function fn_CalculateAge (@DateOfBirth DATE)
returns int
AS
Begin
     declare @age int
     set @age = DATEDIFF(Year,@DateOfBirth,GetDate())
     return @age
End

select dbo.fn_CalculateAge((select Cast(BirthDate As Date) from Student where id = 3)) As Age



--------Create fn_GetCoursesByStudent(@StudentId INT) as a Table-Valued Function.
Create Function fn_GetCoursesByStudent (@StudentId INT)
returns Table
As
return
(
   select c.Name AS [Course Name]
   from Enrollement e join Course c 
   on e.Code = c.Code
   where e.StudentID = @StudentId
)

select * from fn_GetCoursesByStudent(1)



------------Create fn_GetTopStudentsByCourse(@CourseId INT, @TopN INT) using a Window Function as a Table-Valued function
Create Function fn_GetTopStudentsByCourse (@CourseId int, @TopN int)
returns table
AS
return(
     select Top(@TopN)
     ROW_NUMBER() Over(Order by e.Grade DESC) AS Rank_ , 
     s.FName+' '+ s.LName AS FullName , e.Grade
     from Student s join Enrollement e
     on s.ID = e.StudentID
     where e.Code = @CourseId
     )

select * from fn_GetTopStudentsByCourse(1,5)



---------------Create fn_IsPassed(@Grade DECIMAL) as a Scalar Function.
Create Function fn_IsPassed(@Grade Decimal)
returns VarChar(10)
AS
Begin
     declare @Status VarChar(10)
     Set @Status = Case 
       when @Grade >= 50  then 'Passed'
       when @Grade < 50 then 'Failed'
       Else 'Pending'
       End
     return @Status
End

select dbo.fn_IsPassed((Select Grade from Enrollement where studentId = 5))