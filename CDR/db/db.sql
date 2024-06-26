CREATE DATABASE cdr;

USE cdr;

-- STUDENTS
CREATE TABLE students (name VARCHAR(50), student_id VARCHAR(8));
INSERT INTO students VALUES
('Felix Stengele', '12345678'),
('Test 1234',''),
('Alex Garcia', ''),
('Jaqueline Khalioulline', ''),
('Arnau Sola', '60B69521');

CREATE TABLE tasks (date DATE NOT NULL,subject VARCHAR(10) NOT NULL,name VARCHAR(20) NOT NULL,student VARCHAR(8) NOT NULL);
INSERT INTO tasks VALUES
('2024-04-22', 'PBE', 'Puzzle 1', '60B69521'),
('2024-04-22', 'PBE', 'Puzzle 1', ''),
('2024-04-22', 'PBE', 'Puzzle 1', ''),
('2024-04-22', 'PBE', 'Puzzle 1', ''),
('2024-04-22', 'PBE', 'Puzzle 1', ''),
('2024-05-27', 'TD', 'Parcial', '60B69521'),
('2024-05-27', 'TD', 'Parcial', ''),
('2024-05-30', 'TD', 'Parcial', ''),
('2024-05-30', 'TD', 'Parcial', ''),
('2024-05-30', 'TD', 'Parcial', ''),
('2024-06-20', 'DSBM', 'Laboratori', '60B69521'),
('2024-06-28', 'DSBM', 'Laboratori', ''),
('2024-06-17', 'DSBM', 'Laboratori', ''),
('2024-06-15', 'DSBM', 'Laboratori', ''),
('2024-06-10', 'DSBM', 'Laboratori', ''),
('2024-06-23', 'PSVAC', 'Final', '60B69521'),
('2024-06-23', 'PSVAC', 'Final', ''),
('2024-06-23', 'PSVAC', 'Final', ''),
('2024-06-23', 'PSVAC', 'Final', ''),
('2024-06-23', 'PSVAC', 'Final', '');

CREATE TABLE timetables (day VARCHAR(3) NOT NULL, hour VARCHAR(8) NOT NULL, subject VARCHAR(10) NOT NULL, room VARCHAR(8) NOT NULL, student VARCHAR(8) NOT NULL);
INSERT INTO timetables VALUES
('1', '09:00:00', 'TD', 'A4001', '60B69521'),
('1', '09:00:00', 'TD', 'A4001', ''),
('3', '12:00:00', 'TD', 'A3102', ''),
('3', '12:00:00', 'TD', 'A3102', ''),
('5', '11:00:00', 'TD', 'A3102', ''),
('5', '11:00:00', 'TD', 'A3102', ''),
('1', '10:00:00', 'DSBM', 'D3001', '60B69521'),
('1', '10:00:00', 'DSBM', 'D3001', ''),
('2', '08:00:00', 'DSBM', 'A3101', '60B69521'),
('2', '08:00:00', 'DSBM', 'A3101', ''),
('4', '11:00:00', 'DSBM', 'D5001', '60B69521'),
('4', '11:00:00', 'DSBM', 'D5001', ''),
('3', '15:00:00', 'PBE', 'A3105', '60B69521'),
('3', '15:00:00', 'PBE', 'A3105', ''),
('3', '15:00:00', 'PBE', 'A3105', ''),
('3', '15:00:00', 'PBE', 'A3105', ''),
('3', '15:00:00', 'PBE', 'A3105', ''),
('5', '09:00:00', 'PBE', 'A1101', '60B69521'),
('5', '09:00:00', 'PBE', 'A1101', ''),
('5', '09:00:00', 'PBE', 'A1101', ''),
('5', '09:00:00', 'PBE', 'A1101', ''),
('5', '09:00:00', 'PBE', 'A1101', ''),
('1', '12:00:00', 'PSVAC', 'A2201', '60B69521'),
('1', '12:00:00', 'PSVAC', 'A2201', ''),
('2', '10:00:00', 'PSVAC', 'A5203', ''),
('2', '10:00:00', 'PSVAC', 'A5203', ''),
('4', '13:00:00', 'PSVAC', 'A1002', '60B69521'),
('4', '13:00:00', 'PSVAC', 'A1002', '');

CREATE TABLE marks (subject VARCHAR(10) NOT NULL, name VARCHAR(20) NOT NULL, mark FLOAT(4) NOT NULL, student VARCHAR(8) NOT NULL);
INSERT INTO marks VALUES
('PBE', 'Puzzle 1', 10, '60B69521'),
('PBE', 'Puzzle 1', 10,''),
('PBE', 'Puzzle 1', 10, ''),
('PBE', 'Puzzle 1', 10, ''),
('PBE', 'Puzzle 1', 10, ''),
('ICOM', 'Examen parcial', 2, '60B69521'),
('ICOM', 'Examen parcial', 2.5, ''),
('ICOM', 'Examen parcial', 7, ''),
('ICOM', 'Examen parcial', 2.3, ''),
('ICOM', 'Examen parcial', 5, ''),
('DSBM', 'Laboratori', 9.5, '60B69521'),
('DSBM', 'Laboratori', 9.9, ''),
('DSBM', 'Laboratori', 8, ''),
('DSBM', 'Laboratori', 6.1, ''),
('DSBM', 'Laboratori', 7, ''),
('PSVAC', 'Examen Final', 8, '60B69521'),
('PSVAC', 'Examen Final', 3.1, ''),
('PSVAC', 'Examen Final', 3, ''),
('PSVAC', 'Examen Final', 0, ''),
('PSVAC', 'Examen Final', 2.9, '');
