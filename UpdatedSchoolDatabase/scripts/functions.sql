--------- Create fn_CalculateAge(@DateOfBirth DATE) as a Scalar Function.
CREATE OR ALTER FUNCTION fn_CalculateAge (@DateOfBirth DATE)
RETURNS INT
AS
BEGIN
    DECLARE @Age INT;
    DECLARE @Today DATE = CAST(GETDATE() AS DATE);

    SET @Age = DATEDIFF(YEAR, @DateOfBirth, @Today);

    IF (DATEADD(YEAR, @Age, @DateOfBirth) > @Today)
    BEGIN
        SET @Age = @Age - 1;
    END

    RETURN @Age;
END;
GO

select dbo.fn_CalculateAge((select Cast(BirthDate As Date) from Student where id = 3)) As Age
Go


--------Create fn_GetCoursesByStudent(@StudentId INT) as a Table-Valued Function.
CREATE OR ALTER Function fn_GetCoursesByStudent (@StudentId INT)
returns Table
As
return
(
   select c.Name AS [Course Name]
   from Enrollement e join Course c 
   on e.Code = c.Code
   where e.StudentID = @StudentId
)
Go

select * from fn_GetCoursesByStudent(1)
Go


------------Create fn_GetTopStudentsByCourse(@CourseId INT, @TopN INT) using a Window Function as a Table-Valued function
CREATE OR ALTER Function fn_GetTopStudentsByCourse (@CourseId int, @TopN int)
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
Go

select * from fn_GetTopStudentsByCourse(1,5)
Go


---------------Create fn_IsPassed(@Grade DECIMAL) as a Scalar Function.
CREATE OR ALTER Function fn_IsPassed(@Grade Decimal)
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
Go

select dbo.fn_IsPassed((Select Grade from Enrollement where studentId = 5))
Go