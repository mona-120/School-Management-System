-- Remove elements from plan cache
DBCC FREEPROCCACHE
-- Flush the plan cache
DBCC FREEPROCCACHE

-- Get Execution time
Set Statistics time, IO on


-- Add an Index on Enrollment(StudentId)
Create Index Enrollement_StudentID_IX
on Enrollement(StudentID)


-- Retrive student's enrollements  and display execution time in microsec
DECLARE @Start DATETIME2 = SYSDATETIME();
select StudentID , code
from Enrollement
where StudentID = 15 
select CAST(DATEDIFF(MICROSECOND, @Start, SYSDATETIME()) AS VARCHAR) 
-- before creating index takes: 16299 Micro ,  After creating index takes: 3338 Micro

---------------------------------------------------------------------------------------


-- Create a composite index on Enrollement(StudentID,CourseCode)
Create index Enrollement_StudentID_CourseCode_IX
on Enrollement(StudentID,Code)

-- composite index behave as primary key and prevent dublication and it's faster than check all values in table
-- before creating composite index takes: 9023 Micro ,  After creating composite index takes: 3355 Micro and get Course code
-- if required columns in query are indexes, it's faster than get values from origin table 

--drop index Enrollement_StudentID_CourseCode_IX on Enrollement
--drop index Enrollement_StudentID_IX on Enrollement

---------------------------------------------------------------------------------------

-- Design a Composite Index for finding Students in a Course ordered by Grade descending.

select StudentID , Grade
from Enrollement
where code = 5
order by Grade DESC 

create index Enrollement_Code_Grade   
on Enrollement(Code,Grade)      -- select code and grade as composite indexes as they are in where and order by and have the priority

-- From Execution plan ,before adding index it depends on clustered index and take much time to order rows by grade ,
-- but after using non clustered index it avoid sortting time 

---------------------------------------------------------------------------------------
-- Explain when an Index on Course.TeacherId could be less useful because of Low Selectivity.
-- if used table course for (insert, delete, update) operations more than select , then index whill be not usefull 
-- as it will waste much time to insert,delete or update to find specific place