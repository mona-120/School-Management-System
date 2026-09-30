# School Management System Database

## About
This project is a complete SQL Server database built from scratch. The main focus was to practice the full database lifecycle, starting from drawing the ERD and mapping it to tables, to writing complex queries and optimizing execution time. 
It applies various relational database concepts to ensure data integrity and improve query performance.

## Core Concepts Applied

### 1. Schema Design & Data Integrity
* Designed a normalized relational schema with proper mapping (One-to-Many, Many-to-Many, Self-Referencing).
* Enforced data integrity using `PRIMARY KEY`, `FOREIGN KEY`, `UNIQUE`, `CHECK`, and `DEFAULT` constraints.
* Utilized **Computed Columns** for dynamic data generation (e.g., Full Name, Pass/Fail status).

### 2. Advanced Queries & Views
* Used `INNER`, `LEFT`, and Self Joins combined with aggregations (`GROUP BY`, `HAVING`) for complex data retrieval.
* Applied **Window Functions** (`RANK() OVER PARTITION BY`) to rank top students per department dynamically.
* Created **Views** to encapsulate complex reporting queries safely and cleanly.

### 3. Programmability & Transactions
* **Functions:** Created Scalar and Table-Valued Functions (UDFs) to encapsulate reusable business logic.
* **Stored Procedures:** Handled complex DML operations using `TRY...CATCH` for error handling.
* **Transactions:** Used `BEGIN TRANSACTION`, `COMMIT`, and `ROLLBACK` to ensure ACID compliance during sensitive operations, like transferring a student between departments without enrollment conflicts.

### 4. Auditing with Triggers
* Implemented `AFTER INSERT`, `UPDATE`, and `DELETE` Triggers on the Enrollment table.
* Automatically records the action type, username, modification date, and grade changes into the `AuditTable`, while enforcing cross-table business rules before allowing inserts.

### 5. Performance Tuning & Indexing
* Monitored query performance using `STATISTICS TIME, IO` and **Execution Plans**.
* Identified performance bottlenecks (e.g., expensive in-memory `Sort` operations).
* Designed and applied a **Composite Non-Clustered Index**.

## Getting Started & Execution Order

To set up and run the database locally without dependency conflicts, follow the steps below using SQL Server Management Studio (SSMS) or Azure Data Studio.

### Prerequisites
* Microsoft SQL Server (2019 or later)
* SQL Server Management Studio (SSMS)

### Run Order
Execute the SQL scripts strictly in the following sequential order:

1. **`schema.sql`**
   * Creates the `SchoolSystem` database, core tables (`Department`, `Teacher`, `TeacherPhone`, `Student`, `Course`, `Enrollement`), and defines primary/foreign keys and computed columns.

2. **`functions.sql`**
   * Creates custom scalar and table-valued functions (`fn_CalculateAge`, `fn_GetCoursesByStudent`, etc.).

3. **`views.sql`**
   * Creates analytical views (`vw_DepartmentSummary`, `vw_TeacherCourseLoad`, `vw_StudentFullReport`, `vw_DepartmentTopStudent`).

4. **`procedures.sql`**
   * Creates stored procedures for business transactions and student enrollment (`sp_GetStudentsByDepartment`, `sp_EnrollStudent`, `sp_TransferStudent`, `sp_AddCourse`).

5. **`triggers.sql`**
   * Creates the `AuditTable` and attaches automated audit/validation triggers (`trg_AddEnrollment`, `trg_UpdateEnrollement`, `trg_DeleteEnrollement`).

6. **`indexes.sql`**
   * Implements non-clustered and composite indexes for query optimization.

7. **`seed.sql`**
   * Seeds testing records and lookup data into the database.

8. **`joins.sql`**
   * Contains verification queries, complex JOINs, and reporting aggregations to test business requirements.




