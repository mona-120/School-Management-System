-- create AuditTable to store changes on Enrollment table
Create Table AuditTable
(
  ActionType Varchar(10) Not Null,
  User_ NVarchar(50) Not Null,
  StudentId Int Not Null,
  CourseCode Int Not Null,
  OldGrade decimal(5,2) Default Null,
  NewGrade decimal(5,2),
  AuditDate DateTime2 Default SYSDATETIME()
)
Go



------ Trigger if Insert an Enrollement-------
Create Trigger trg_AddEnrollment
ON Enrollement
After Insert
AS
BEGIN 
      IF Not Exists(select 1 from Student s join inserted i
                     on s.ID = i.StudentID join Course c
                     on c.Code = i.Code
                     where s.DepartmentID = c.DepartmentID)
      Begin 
           RollBack Transaction;
           Throw 50001,'Error: Course does not belong to student department',1;  -- display the written error
      End

      Insert Into AuditTable (ActionType,User_,StudentId,CourseCode,OldGrade,NewGrade)
      Select 
         'Insert',
         SUSER_NAME(),
         i.StudentID,
         i.Code,
         Null,
         Null
         from inserted i;
END
Go

Insert into Enrollement(Code,StudentID,Grade)   -- student and course arn't in the same department, then process will not applied
Values (3,8,Null)
Go
-- if insert a student or course that aren't exist it will cause error because foreign key

-- get student and courses that in the same department
--select s.ID , s.DepartmentID , c.Code,c.DepartmentID
--from Student s join course c
--on s.DepartmentID = c.DepartmentID

Insert into Enrollement(Code,StudentID,Grade)    -- Insert new enrollment and store the process in Audit table successfully
Values (21,1,Null)
Go




-------- Trigger if Update an Enrollement ---------
Create Trigger trg_UpdateEnrollement
ON Enrollement
After Update
AS
Begin
       IF (Update(Grade))
       Begin
            Insert into AuditTable (ActionType,User_,StudentId,CourseCode,OldGrade,NewGrade)
            select 
              'Update',
              SUSER_NAME(),
              i.StudentID,
              i.Code,
              d.Grade,
              i.Grade
              from inserted i join deleted d
              on i.Code = d.Code And i.StudentID = d.StudentID
              where d.Grade != i.Grade
       End
       Else
       Begin
            RollBack Transaction
       End
End
Go

Update Enrollement
Set Grade = 90
where StudentID = 15
Go


-------- Trigger if Delete an Enrollement------
create Trigger trg_DeleteEnrollement
ON Enrollement
After Delete
AS
BEGIN
    Begin
       insert into AuditTable (ActionType,User_,StudentId,CourseCode,OldGrade)
       select
        'Delete',
        SUSER_NAME(),
        StudentID,
        Code,
        Grade
        from deleted 
    End    
END
Go

Delete from Enrollement where StudentID = 1 And Code = 21


select * from AuditTable


