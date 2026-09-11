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




