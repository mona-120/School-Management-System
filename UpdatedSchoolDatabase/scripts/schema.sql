Create Database SchoolSystem
Go

use SchoolSystem
Go

Create table Department
(
   ID Int Primary Key Identity(1,1),   -- Create ID as primary key and generated automatically when adding new department 
   Name_ NVarchar(50) Unique,       -- create Department Name unique (There is no more than one department with the same name)
   Location_ NVarChar(200) 
)
Go

Create Table Teacher
(
   ID Int Primary Key Identity (1,1),
   FName NVarchar(30) Not Null,     -- At least Teacher First name is not null
   LName NVarchar(30),
   Email NVarChar(50) Unique,
   Salary Decimal(10,2) check (Salary >= 5000), -- avoid negative enteries and ensure that all salaries >= 5000
   HireDate DateTime2 Default SYSDATETIME(),   
   DepartmentID Int Not Null ,   -- create DepartmentID as not null (because each teacher name must be stored in specific department) --> Total Participation
   SupervisorID Int Null,   -- allow null

   -- Teacher-Teacher relationship allow nulls in SupervisorID as it's not necessary that teacher have a supervisor
   -- and SupervisorID accept duplication as one supervisor can supervise many teachers

   Constraint FK_Teacher_DepartmentID Foreign Key (DepartmentID) References Department (ID) on delete no action,  -- prevent department deleting when it still has teachers
   Constraint Fk_Teacher_SupervisorID Foreign key (SupervisorID) References Teacher (ID) on delete no action,   -- Can't make it (on delete cascade or on delete set null) as it cause multiple cascade paths 
   Constraint Check_Not_TheSame Check (ID <> SupervisorID) -- create constraint as [Table_Level] to compare column with another column
)
Go


create table TeacherPhone
(
    TeacherId Int,
    Phone varchar(20),

    Primary key(TeacherId,Phone),
    Constraint Fk_TeacherPhone_Teacher Foreign Key (TeacherId) References Teacher (ID) on delete cascade -- remove record if id removed
)
Go


create table Student
( 
   ID Int Primary Key Identity (1,1),
   FName NVarchar(30) Not Null,     
   LName NVarchar(30),
   Email NVarChar(50) Unique,
   Gender char(1) check (Gender IN ('M','F')),
   BirthDate Date ,
   DepartmentID Int Not Null,

   Constraint Fk_Student_DepartmentID foreign key (DepartmentID) References Department (ID) on delete no action   -- can't delete department that contain students
)
Go


create table Course
(
   Code Int Primary Key Identity(1,1),
   Name NvarChar(100),
   Hours_ decimal(5,2) ,
   DepartmentID Int Not Null,
   TeacherId Int Not Null,

   Constraint Fk_Course_DepartmentID Foreign Key (DepartmentID) References Department (ID) on delete no action ,
   Constraint Fk_Course_Teacher Foreign Key (TeacherId) References Teacher (ID) on delete no action
)
Alter table Course Add Constraint Unique_Name Unique(Name)
Go


-- Enrollment table is required as relation between course and student is many-to-many that means one student can enroll 
-- in many courses and one course can contain many students ,and that cause duplication in course and student tables
Create table Enrollement
(
   Code Int ,
   StudentID Int ,
   Grade decimal(5,2) Null check (Grade Between 0 and 100) , 
   EnrollmentDate DateTime2 Default SysDateTime(),

   Primary key (Code,StudentID),
   constraint Fk_Enrollement_Code Foreign Key (Code) References Course (Code) on delete cascade,
   constraint Fk_Enrollement_StudentID Foreign Key (StudentID) References Student (ID) on delete cascade
)
Go


-- Add a computed column in student table thhat compute full name
Alter table Student Add FullName AS (FName + ' ' + LName)
Go

-- Add a Computed Column IsPassed on Enrollment, where NULL Grade returns NULL
Alter Table Enrollement Add IsPassed As(case when Grade >= 50 Then 'Passed'
                                             when Grade < 50 Then 'Failed'
                                             Else Null 
                                             End)
Go