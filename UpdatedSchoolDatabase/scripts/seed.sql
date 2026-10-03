INSERT INTO Department (Name_, Location_) VALUES
('Computer Science', 'Building A - Floor 1'),
('Information Systems', 'Building A - Floor 2'),
('Software Engineering', 'Building A - Floor 3'),
('Mathematics', 'Building B - Floor 1'),
('Physics', 'Building B - Floor 2'),
('Artificial Intelligence', 'Building C - Floor 1'),
('Data Science', 'Building C - Floor 2'),
('Cyber Security', 'Building C - Floor 3'),
('Bioinformatics', 'Building D - Floor 1'),
('Information Technology', 'Building D - Floor 2'),
('Statistics', 'Building B - Floor 3'),
('Networks', 'Building A - Floor 4'),
('Electronics', 'Building E - Floor 1'),
('Civil Engineering', 'Building F - Floor 1'),
('Mechanical Engineering', 'Building F - Floor 2'),
('Electrical Engineering', 'Building E - Floor 2'),
('Architecture', 'Building G - Floor 1'),
('Business Analytics', 'Building H - Floor 1'),
('Digital Media', 'Building H - Floor 2'),
('Robotics', 'Building C - Floor 4');
Go

INSERT INTO Teacher (FName, LName, Email, Salary, DepartmentID, SupervisorID) VALUES
('Ahmed', 'Hassan', 'ahmed.hassan@school.edu', 12000.00, 1, NULL),
('Mohamed', 'Ali', 'mohamed.ali@school.edu', 11500.00, 2, NULL),
('Mahmoud', 'Ibrahim', 'mahmoud.ibrahim@school.edu', 13000.00, 3, NULL),
('Khaled', 'Omar', 'khaled.omar@school.edu', 11000.00, 4, NULL),
('Tarek', 'Youssef', 'tarek.youssef@school.edu', 10500.00, 5, NULL),
('Mona', 'Sami', 'mona.sami@school.edu', 7500.00, 1, 1),
('Sara', 'Adel', 'sara.adel@school.edu', 8000.00, 1, 1),
('Noha', 'Ezzat', 'noha.ezzat@school.edu', 7000.00, 2, 2),
('Yasser', 'Khaled', 'yasser.khaled@school.edu', 8500.00, 2, 2),
('Hisham', 'Tawfik', 'hisham.tawfik@school.edu', 9000.00, 3, 3),
('Amr', 'Diab', 'amr.diab@school.edu', 6500.00, 3, 3),
('Rania', 'Youssef', 'rania.youssef@school.edu', 7200.00, 4, 4),
('Dina', 'ElSawy', 'dina.elsawy@school.edu', 6800.00, 5, 5),
('Sherif', 'Mounir', 'sherif.mounir@school.edu', 9500.00, 1, 1),
('Hany', 'Ramzy', 'hany.ramzy@school.edu', 6000.00, 2, 2),
('Eman', 'Badr', 'eman.badr@school.edu', 8200.00, 3, 3),
('Karim', 'Fouad', 'karim.fouad@school.edu', 7700.00, 4, 4),
('Samy', 'Naguib', 'samy.naguib@school.edu', 8800.00, 5, 5),
('Hala', 'Shiha', 'hala.shiha@school.edu', 5400.00, 4, 4),
('Mostafa', 'Kamar', 'mostafa.kamar@school.edu', 9100.00, 1, 1);
Go

INSERT INTO TeacherPhone (TeacherId, Phone) VALUES
(1, '01000000001'), (1, '01100000001'),
(2, '01000000002'), (3, '01000000003'),
(4, '01000000004'), (4, '01200000004'),
(5, '01000000005'), (6, '01000000006'),
(7, '01000000007'), (8, '01000000008'),
(9, '01000000009'), (10, '01000000010'),
(11, '01000000011'), (12, '01000000012'),
(13, '01000000013'), (14, '01000000014'),
(15, '01000000015'), (16, '01000000016'),
(17, '01000000017'), (18, '01000000018');
Go

INSERT INTO Student (FName, LName, Email, Gender, BirthDate, DepartmentID) VALUES
('Omar', 'Hassan', 'omar.hassan@student.edu', 'M', '2002-05-15', 1),
('Mariam', 'Ali', 'mariam.ali@student.edu', 'F', '2003-01-20', 1),
('Youssef', 'Ahmed', 'youssef.ahmed@student.edu', 'M', '2001-11-10', 2),
('Aya', 'Ibrahim', 'aya.ibrahim@student.edu', 'F', '2002-08-05', 2),
('Kareem', 'Mahmoud', 'kareem.mahmoud@student.edu', 'M', '2003-03-30', 3),
('Nour', 'ElDin', 'nour.eldin@student.edu', 'F', '2002-12-12', 3),
('Ali', 'Mostafa', 'ali.mostafa@student.edu', 'M', '2001-07-22', 4),
('Fatma', 'Samy', 'fatma.samy@student.edu', 'F', '2003-09-18', 5),
('Hassan', 'Khaled', 'hassan.khaled@student.edu', 'M', '2002-04-14', 6),
('Salma', 'Tarek', 'salma.tarek@student.edu', 'F', '2003-06-25', 7),
('Ziad', 'Sherif', 'ziad.sherif@student.edu', 'M', '2001-02-17', 8),
('Hana', 'Hisham', 'hana.hisham@student.edu', 'F', '2002-10-08', 9),
('Hussein', 'Amr','hussein.amr@student.edu', 'M', '2003-05-01', 10),
('Habiba', 'Ezz', 'habiba.ezz@student.edu', 'F', '2002-07-19', 11),
('Seif', 'Adel', 'seif.adel@student.edu', 'M', '2001-09-09', 12),
('Laila', 'Mounir', 'laila.mounir@student.edu', 'F', '2003-11-30', 13),
('Mostafa', 'Nabil', 'mostafa.nabil@student.edu', 'M', '2002-03-11', 14),
('Nada', 'Fouad', 'nada.fouad@student.edu', 'F', '2001-08-23', 15),
('Marwan', 'Hamdy', 'marwan.hamdy@student.edu', 'M', '2003-04-02', 16),
('Reem', 'Khaled', 'reem.khaled@student.edu', 'F', '2002-01-28', 17);
Go

INSERT INTO Course (Name, Hours_, DepartmentID, TeacherId) VALUES
('Database Systems', 3.0, 1, 1),
('Data Structures', 4.0, 1, 6),
('OOP with C#', 3.0, 1, 7),
('System Analysis', 3.0, 2, 2),
('Management Information Systems', 2.0, 2, 8),
('Software Architecture', 3.0, 3, 3),
('Agile Development', 2.0, 3, 10),
('Calculus I', 4.0, 4, 4),
('Linear Algebra', 3.0, 4, 12),
('General Physics', 4.0, 5, 5),
('Machine Learning', 3.0, 6, 14),
('Data Mining', 3.0, 7, 15),
('Network Security', 3.0, 8, 16),
('Genomics', 2.0, 9, 17),
('Web Development', 3.0, 10, 18),
('Probability Theory', 3.0, 11, 19),
('Routing & Switching', 3.0, 12, 20),
('Digital Circuits', 4.0, 13, 13),
('Fluid Mechanics', 3.0, 15, 12),
('Robotics Kinematics', 3.0, 20, 14);
Go

INSERT INTO Course (Name, Hours_, DepartmentID, TeacherId) VALUES
('C#', 3.0 , 1,1),
('OOP', 3.0 , 1,1),
('Solid', 3.0 , 1,1);
Go

INSERT INTO Enrollement (Code, StudentID, Grade) VALUES
(1, 1, 95.50),
(2, 1, 88.00),
(1, 2, 72.25),
(3, 2, 85.00),
(4, 3, 90.00),
(5, 4, NULL), 
(6, 5, 65.50),
(7, 6, 78.00),
(8, 7, 82.50),
(9, 7, 91.00),
(10, 8, 55.00),
(11, 9, 98.00),
(12, 10, 84.00),
(13, 11, NULL),
(14, 12, 79.50),
(15, 13, 89.00),
(16, 14, 60.00),
(17, 15, 93.00),
(18, 16, 87.50),
(19, 17, 74.00);
GO








-- Additional rows to notice difference with index
INSERT INTO Enrollement (Code, StudentID, Grade) VALUES
(7, 1, 91.00),
(4, 1, 84.50),
(21, 1, 99.00),

(5, 2, 60.00),
(6, 2, 77.50),
(22, 2, 88.00),

(1, 3, 82.00),
(2, 3, 79.00),
(7, 3, 93.50),

(1, 4, 88.50),
(2, 4, 91.00),
(8, 4, 70.00),

(3, 5, 58.00),
(4, 5, 62.50),
(9, 5, 80.00),

(1, 6, 85.00),
(5, 6, 90.00),
(10, 6, 73.00),

(2, 7, 67.00),
(3, 7, 74.50),
(23, 7, 95.00),

(1, 8, 89.00),
(4, 8, 92.00),
(12, 8, 81.50),

(5, 9, 64.00),
(6, 9, 71.00),
(13, 9, 83.00),

(7, 10, 96.00),
(8, 10, 88.50),
(14, 10, 75.00),

(1, 11, 55.00),
(9, 11, 68.00),
(15, 11, 86.50),

(2, 12, 94.00),
(10, 12, 89.00),
(16, 12, 78.00),

(3, 13, 61.50),
(11, 13, 73.00),
(17, 13, 85.00),

(4, 14, 90.50),
(12, 14, 82.00),
(18, 14, 69.00),

(5, 15, 77.00),
(13, 15, 84.00),
(19, 15, 91.50),

(6, 16, 93.00),
(14, 16, 88.00),
(20, 16, 76.50),

(7, 17, 80.00),
(15, 17, 65.00),
(21, 17, 87.00),

(1, 18, 92.00),
(8, 18, 85.50),
(16, 18, 74.00),
(22, 18, 98.00),

(2, 19, 66.00),
(9, 19, 79.50),
(17, 19, 83.00),
(23, 19, 89.00),

(1, 20, 95.00),
(3, 20, 91.00),
(10, 20, 87.00),
(18, 20, 93.50);
Go