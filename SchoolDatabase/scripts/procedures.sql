--1 Create sp_GetStudentsByDepartment(@DepartmentId)
create Procedure sp_GetStudentsByDepartment @DepartmentId Int
with encryption 
AS
BEGIN
     If Not Exists(select 1 from Department where ID = @DepartmentId)
     Begin
        select'Department not exist'
        return
     End
      select s.ID , s.FName + ' ' + s.LName As 'Full Name' 
      from Student s join Department d
      on s.DepartmentID = d.ID 
      where d.ID = @DepartmentId
END
Exec sp_GetStudentsByDepartment 8


--2 Create sp_EnrollStudent(@StudentId, @CourseId) to add new enrollment row with verification (prevent dublication ,
--     make sure that course and student in the same department)
Alter Procedure sp_EnrollStudent @StudentId Int , @CourseId Int
with Encryption
AS 
BEGIN
     IF Not Exists(select 1 from Student where Id = @StudentId)   -- check if student id exist
     BEGIN
        Select'Student not Exist'
        return
     END
     IF Not Exists(select 1 from Course where Code =  @CourseId)    -- check if course is exist
     Begin 
        select'Course not exist'
        return
     End
     IF (Select DepartmentID from Course where Code = @CourseId) 
         !=  (Select DepartmentID from Student where ID = @StudentId)
     BEGIN
        Select 'Course not exist in student department'
        Return
     END
     IF Exists (select 1 from Enrollement
                       where Code = @CourseId AND StudentID = @StudentId)
      BEGIN 
         Select 'Student Enrollement already exist'
         RETURN
      END
      Insert Into Enrollement (Code,StudentID,Grade) 
            Values (@CourseId,@StudentId,Null)
END

EXEC sp_EnrollStudent 15,2   -- Student and course arn't in the same department 
EXEC sp_EnrollStudent 15,17  --Enrollment Already exist
EXEC sp_EnrollStudent 1,3  
select * from Enrollement where StudentID = 1
-- Delete row that added after apply rule that student and course must be in the same department
Delete from Enrollement Where StudentID = 15 AND Code = 2 



--3 Create sp_TransferStudent(@StudentId, @NewDepartmentId). 
-- Rollback the complete transfer if an existing Enrollment conflicts with the new Department.
create Procedure sp_TransferStudent @StudentId INT, @NewDepartmentId INT
WITH ENCRYPTION
AS
BEGIN
      If Not Exists(select 1 from Student where ID = @StudentId)
      Begin
         select'Student not exist'
         Return
      End
      IF NOT Exists (select 1 from Department where ID = @NewDepartmentId)
      Begin
             select'Department not exist'
             return
      End

      BEGIN Transaction
      Update Student
      Set DepartmentID = @NewDepartmentId
      where ID = @StudentId

      if Exists (select 1 from Enrollement e join Course c on e.Code = c.Code 
                   where e.StudentID = @StudentId AND c.DepartmentID != @NewDepartmentId)
        Begin 
          RollBack
          select'Transfer Failed, there is a conflict'
          return
        End
        commit transaction
END

EXEC sp_TransferStudent 8,2




-- create procedure to add new course with try-catch to check it's valid or not to add course
create Procedure sp_AddCourse @Name NvarChar(100), @DepartmentId Int ,@TeacherID Int
with encryption
AS
Begin
      Begin Try
         Insert into Course(Name,DepartmentID,TeacherId) 
            Values(@Name,@DepartmentId,@TeacherID)
      End Try
      Begin Catch
         select'Invalid Process'
      End Catch
End

Exec sp_AddCourse C#, 2,2   --courseName already exist and it's unique
Exec sp_AddCourse Soft_Skills,50,2   -- invalid department id
Exec sp_AddCourse Soft_Skills,2,25   -- invalid teacher id  
Exec sp_AddCourse Soft_Skills,2,2     -- Valid Process