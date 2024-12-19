CREATE TABLE students(
                         id SERIAL PRIMARY KEY ,
                         name VARCHAR NOT NULL ,
                         date_of_birth DATE NOT NULL ,
                         gender VARCHAR CHECK ( gender IN ('Male', 'Female')),
                         email VARCHAR UNIQUE NOT NULL CHECK ( email like '%@%'),
                         phone_number VARCHAR ,
                         registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
ALTER TABLE students
    RENAME COLUMN name to students_name;

CREATE TABLE courses(
                        id SERIAL PRIMARY KEY ,
                        course_name  VARCHAR NOT NULL ,
                        student_id INT REFERENCES Students(id),
                        teacher_name VARCHAR NOT NULL,
                        course_duration_weeks INT NOT NULL CHECK (course_duration_weeks > 0),
                        start_date DATE NOT NULL ,
                        end_date DATE GENERATED ALWAYS AS ( start_date+ (course_duration_weeks*7)) STORED
);

INSERT INTO Students (name, date_of_birth, gender, email, phone_number)
VALUES
    ('Alice', '2000-01-15', 'Female', 'alice@example.com', '123-456-7890'),
    ('Bob', '1998-06-20', 'Male', 'bob@example.com', '234-567-8901'),
    ('Charlie', '1999-12-05', 'Male', 'charlie@example.com', '345-678-9012'),
    ('David', '2001-03-10', 'Male', 'david@example.com', '456-789-0123'),
    ('Emma', '2002-07-22', 'Female', 'emma@example.com', '567-890-1234'),
    ('Sophia', '1997-09-14', 'Female', 'sophia@example.com', '678-901-2345');


INSERT INTO courses (course_name, student_id, teacher_name, course_duration_weeks, start_date)
VALUES
    ('Math', 1, 'Dr. Smith', 12, '2024-01-10'),
    ('Science', 2, 'Dr. Brown', 8, '2024-02-15'),
    ('Literature', 1, 'Ms. Green', 10, '2024-01-25'),
    ('Math', 2, 'Dr. Smith', 12, '2024-01-10'),
    ('History', 3, 'Dr. White', 6, '2024-03-01'),
    ('Math', 3, 'Dr. Smith', 12, '2024-01-10'),
    ('Physics', 4, 'Dr. Black', 16, '2024-01-15'),
    ('Art', 5, 'Ms. Blue', 8, '2024-02-01'),
    ('Biology', 1, 'Dr. Yellow', 10, '2024-02-20'),
    ('Chemistry', NULL, 'Dr. Purple', 14, '2024-03-15');

/*
Найти всех студентов, которые моложе 25 лет, и их курсы.
Вывести студентов, которые обучаются у "Dr. Smith", включая информацию о курсе.
Посчитать общее количество курсов для каждого преподавателя.
Найти всех студентов, зарегистрировавшихся в течение последних 6 месяцев.
Вывести имена студентов и названия курсов, которые заканчиваются позже "2024-05-01".
Вывести количество студентов по полу (Male/Female).
Найти студентов, не записанных ни на один курс.
Найти курсы с продолжительностью более 10 недель.
Вывести средний возраст студентов, обучающихся на каждом курсе.
Вывести полный список студентов и курсов (даже если студент не записан ни на один курс), включая преподавателя.
 */

SELECT students.students_name , courses.course_name FROM students LEFT JOIN courses ON students.id = courses.student_id
WHERE age(current_date, date_of_birth)< interval '25 years';

SELECT students.students_name, courses.course_name from students inner join courses on students.id = courses.student_id
where teacher_name = 'Dr. Smith';

SELECT courses.teacher_name, COUNT(*) as teacher_count from courses group by teacher_name;

SELECT students.students_name , students.registration_date from students where registration_date >= current_date- interval '6 month';

SELECT  students.students_name, courses.course_name from courses left join students on courses.student_id= student_id
where end_date > '2024-05-01';

SELECT gender ,count(*)  from students group by gender;

SELECT students.students_name from students left join courses on students.id = courses.student_id
where student_id is null;

SELECT courses.course_name from courses  where course_duration_weeks > 10 group by courses.course_name;

SELECT course_name,avg(age(current_date, students.date_of_birth)) as average_age from students inner join courses on students.id = courses.student_id
group by course_name;

SELECT students.students_name, courses.course_name, courses.teacher_name  from students full outer join courses on students.id = courses.student_id
order by students_name, course_name;

