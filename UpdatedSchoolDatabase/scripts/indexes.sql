-- Remove elements from plan cache
DBCC FREEPROCCACHE
-- Flush the plan cache
DBCC FREEPROCCACHE

-- Get Execution time
Set Statistics time, IO on


-- Add an Index on Enrollment(StudentId)
Create Index Enrollement_StudentID_IX
on Enrollement(StudentID)
Go

-- Retrive student's enrollements  and display execution time in microsec
DECLARE @Start DATETIME2 = SYSDATETIME();
select StudentID , code
from Enrollement
where StudentID = 15 
select CAST(DATEDIFF(MICROSECOND, @Start, SYSDATETIME()) AS VARCHAR) 
Go
-- before creating index takes: 16299 Micro ,  After creating index takes: 3338 Micro

---------------------------------------------------------------------------------------


-- Create a composite non-clustered index on Enrollement(StudentID,CourseCode)
Create index Enrollement_StudentID_CourseCode_IX
on Enrollement(StudentID,Code)
Go

-- This composite index optimizes queries filtering by StudentID or covering both (StudentID, Code).
-- Note: Duplication is prevented by the table's composite PRIMARY KEY constraint, not this non-unique index. 

--drop index Enrollement_StudentID_CourseCode_IX on Enrollement
--drop index Enrollement_StudentID_IX on Enrollement

---------------------------------------------------------------------------------------

-- Design a Composite Index for finding Students in a Course ordered by Grade descending.

select StudentID , Grade
from Enrollement
where code = 5
order by Grade DESC 
Go

create index Enrollement_Code_Grade   
on Enrollement(Code,Grade)      -- select code and grade as composite indexes as they are in where and order by and have the priority
Go

-- From Execution plan ,before adding index it depends on clustered index and take much time to order rows by grade ,
-- but after using non clustered index it avoid sortting time 

---------------------------------------------------------------------------------------
-- Explain when an Index on Course.TeacherId could be less useful because of Low Selectivity:
-- Low selectivity occurs when a column has very few distinct values relative to the total number of rows 
-- (e.g., a few teachers teaching hundreds of courses). 
-- When filtering by TeacherId, the query matches a large percentage of table rows.
-- In this case, the Query Optimizer reasonably chooses a Clustered Index Scan (or Table Scan) 
-- instead of using the non-clustered index, because an Index Seek combined with many Key Lookups becomes more expensive.