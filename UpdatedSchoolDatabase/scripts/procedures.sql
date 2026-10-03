--1 Create sp_GetStudentsByDepartment(@DepartmentId)
CREATE OR ALTER Procedure sp_GetStudentsByDepartment @DepartmentId Int
with encryption 
AS
BEGIN
     If Not Exists(select 1 from Department where ID = @DepartmentId)
     Begin
        Throw 50001,'Department not exist',1;
     End
      select s.ID , s.FName + ' ' + s.LName As 'Full Name' 
      from Student s join Department d
      on s.DepartmentID = d.ID 
      where d.ID = @DepartmentId;
END
Go

Exec sp_GetStudentsByDepartment 8
Go


--2 Create sp_EnrollStudent(@StudentId, @CourseId) to add new enrollment row with verification (prevent dublication ,
--     make sure that course and student in the same department)
CREATE OR ALTER Procedure sp_EnrollStudent @StudentId Int , @CourseId Int
with Encryption
AS 
BEGIN
     IF Not Exists(select 1 from Student where Id = @StudentId)   -- check if student id exist
     BEGIN
        Throw 50002,'Student not Exist',1;
     END
     IF Not Exists(select 1 from Course where Code =  @CourseId)    -- check if course is exist
     Begin 
        Throw 50003,'Course not exist',1;
     End
     IF (Select DepartmentID from Course where Code = @CourseId) 
         !=  (Select DepartmentID from Student where ID = @StudentId)
     BEGIN
        throw 50004, 'Course not exist in student department',1;
     END
     IF Exists (select 1 from Enrollement
                       where Code = @CourseId AND StudentID = @StudentId)
      BEGIN 
         throw 50005, 'Student Enrollement already exist',1
      END
      Insert Into Enrollement (Code,StudentID,Grade) 
            Values (@CourseId,@StudentId,Null);
END
Go

EXEC sp_EnrollStudent 15,2   -- Student and course arn't in the same department
Go
EXEC sp_EnrollStudent 15,17  --Enrollment Already exist
Go
EXEC sp_EnrollStudent 1,3 
Go
select * from Enrollement where StudentID = 1
Go
-- Delete row that added after apply rule that student and course must be in the same department
Delete from Enrollement Where StudentID = 15 AND Code = 2
Go




--3 Create sp_TransferStudent(@StudentId, @NewDepartmentId). 
-- Rollback the complete transfer if an existing Enrollment conflicts with the new Department.
CREATE OR ALTER Procedure sp_TransferStudent @StudentId INT, @NewDepartmentId INT
WITH ENCRYPTION
AS
BEGIN
      If Not Exists(select 1 from Student where ID = @StudentId)
      Begin
         throw 50006,'Student not exist',1;
      End
      IF NOT Exists (select 1 from Department where ID = @NewDepartmentId)
      Begin
             throw 50007,'Department not exist',1;
      End

      BEGIN Transaction
      Update Student
      Set DepartmentID = @NewDepartmentId
      where ID = @StudentId

      if Exists (select 1 from Enrollement e join Course c on e.Code = c.Code 
                   where e.StudentID = @StudentId AND c.DepartmentID != @NewDepartmentId)
        Begin 
          RollBack;
          throw 50008,'Transfer Failed, there is a conflict',1;
        End
        commit transaction;
END
Go

EXEC sp_TransferStudent 8,2
Go




-- create procedure to add new course with try-catch to check it's valid or not to add course
CREATE OR ALTER Procedure sp_AddCourse @Name NvarChar(100), @DepartmentId Int ,@TeacherID Int
with encryption
AS
Begin
      Begin Try
         Insert into Course(Name,DepartmentID,TeacherId) 
            Values(@Name,@DepartmentId,@TeacherID)
      End Try
      Begin Catch
         throw 50009,'Invalid Process',1;
      End Catch
End
Go

Exec sp_AddCourse 'C#', 2,2   --courseName already exist and it's unique
Go
Exec sp_AddCourse 'Soft_Skills',50,2   -- invalid department id
Go
Exec sp_AddCourse 'Soft_Skills',2,25   -- invalid teacher id
Go
Exec sp_AddCourse 'Soft_Skills',2,2     -- Valid Process
Go