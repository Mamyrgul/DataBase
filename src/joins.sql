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

CREATE TABLE groups (
                        id SERIAL PRIMARY KEY ,
                        group_name VARCHAR NOT NULL
);


CREATE TABLE course(
                       id SERIAL PRIMARY KEY ,
                       course_name VARCHAR,
                       start_date date,
                       group_id int references groups(id)
);

CREATE TABLE student(
                        id serial primary key ,
                        first_name varchar,
                        last_name varchar,
                        gender varchar,
                        email varchar,
                        date_of_birth date,
                        group_id int references groups(id)
);

CREATE TABLE mentors(
                        id serial primary key ,
                        first_name varchar,
                        last_name varchar,
                        gender varchar,
                        email varchar,
                        specialization varchar,
                        experience int,
                        course_id int references course(id)
);
create table lessons(
                        id serial primary key ,
                        lesson_name varchar,
                        course_id int references course(id)
);

insert into groups(group_name)
values ('Java 9'),
       ('JS 9'),
       ('Java 12'),
       ('JS 12'),
       ('Java 13'),
       ('JS 13');

insert into course (course_name, start_date, group_id)
values ('Java 9 core', '2023-01-03', 1),
       ('JS 9 core', '2023-01-03', 2),
       ('Java 12 core', '2023-10-03', 3),
       ('JS 12 core', '2023-10-03', 4),
       ('Java 13 core', '2024-01-08', 5),
       ('JS 13 core', '2024-01-08', 6),
       ('Technical English','2024-01-08', 1),
       ('Python','2024-01-08', 6);
insert into lessons(lesson_name, course_id)
values ('Loops', 1),
       ('HTML', 2),
       ('Methods', 3),
       ('CSS', 4),
       ('Collections', 5),
       ('React', 6);


insert into mentors (first_name, last_name, gender, email, specialization, experience, course_id)
values ('Datka', 'Mamatzhanova', 'Female', 'datka@gmail.com', 'java', 2, 1),
       ('Ulan', 'Kubanychbekov', 'Male', 'ulan@gmail.com', 'java', 3, 3),
       ('Aizat', 'Duisheeva', 'Female', 'aizat@gmail.com', 'java', 1, 5),
       ('Elizar', 'Aitbek uulu', 'Male', 'elizar@gmail.com', 'js', 1, 2),
       ('Aziat', 'Abdimalikov', 'Male', 'aziat@gmail.com', 'js', 1, 4),
       ('Alisher', 'Jumanov', 'Male', 'alisher@gmail.com', 'js', 1, 6);

insert into student (id, first_name, last_name, email, gender, date_of_birth, group_id) values (1, 'Knox', 'Jacquot', 'kjacquot0@addthis.com', 'Male', '2004-04-12', 1);
insert into student (id, first_name, last_name, email, gender, date_of_birth, group_id) values (2, 'Dewain', 'Hunt', 'dhunt1@trellian.com', 'Male', '2003-04-13', 2);
insert into student (id, first_name, last_name, email, gender, date_of_birth, group_id) values (3, 'Jarrett', 'Iianon', 'jiianon2@chronoengine.com', 'Male', '2005-05-05', 3);
insert into student (id, first_name, last_name, email, gender, date_of_birth, group_id) values (4, 'Merry', 'Niezen', 'mniezen3@canalblog.com', 'Male', '1999-04-03', 4);
insert into student (id, first_name, last_name, email, gender, date_of_birth, group_id) values (5, 'Nollie', 'Pellingar', 'npellingar4@usgs.gov', 'Female', '2003-05-06', 5);
insert into student (id, first_name, last_name, email, gender, date_of_birth, group_id) values (6, 'Eveleen', 'Moukes', 'emoukes5@amazon.co.uk', 'Female', '1996-03-03', 6);
insert into student (id, first_name, last_name, email, gender, date_of_birth, group_id) values (7, 'Nollie', 'Becker', 'nbecker6@is.gd', 'Male', '1994-02-04', 1);
insert into student (id, first_name, last_name, email, gender, date_of_birth, group_id) values (8, 'Nadine', 'Robilart', 'nrobilart7@walmart.com', 'Female', '2000-06-06', 2);
insert into student (id, first_name, last_name, email, gender, date_of_birth, group_id) values (9, 'Dex', 'Prugel', 'dprugel8@arizona.edu', 'Male', '2001-03-04', 3);
insert into student (id, first_name, last_name, email, gender, date_of_birth, group_id) values (10, 'Phyllis', 'Baroche', 'pbaroche9@state.gov', 'Female', '2004-04-04', 4);
insert into student (id, first_name, last_name, email, gender, date_of_birth, group_id) values (11, 'Bernadette', 'Dulson', 'bdulsona@altervista.org', 'Female', '2004-04-04', 5);
insert into student (id, first_name, last_name, email, gender, date_of_birth, group_id) values (12, 'Earlie', 'Pledge', 'epledgeb@jimdo.com', 'Male', '1993-12-04', 6);
insert into student (id, first_name, last_name, email, gender, date_of_birth, group_id) values (13, 'Luigi', 'Standish', 'lstandishc@army.mil', 'Male', '1998-11-13', 1);
insert into student (id, first_name, last_name, email, gender, date_of_birth, group_id) values (14, 'Cody', 'McLeoid', 'cmcleoidd@yahoo.com', 'Male', '2000-10-10', 2);
insert into student (id, first_name, last_name, email, gender, date_of_birth, group_id) values (15, 'Heall', 'Dolligon', 'hdolligone@squidoo.com', 'Male', '2003-09-09', 3);
insert into student (id, first_name, last_name, email, gender, date_of_birth, group_id) values (16, 'Isiahi', 'Somerscales', 'isomerscalesf@eepurl.com', 'Male', '1995-05-03', 4);
insert into student (id, first_name, last_name, email, gender, date_of_birth, group_id) values (17, 'Matthieu', 'Spolton', 'mspoltong@so-net.ne.jp', 'Male', '1995-03-30', 5);
insert into student (id, first_name, last_name, email, gender, date_of_birth, group_id) values (18, 'Esme', 'Brockway', 'ebrockwayh@hexun.com', 'Female', '1997-08-08', 6);
insert into student (id, first_name, last_name, email, gender, date_of_birth, group_id) values (19, 'Erroll', 'Cutforth', 'ecutforthi@wisc.edu', 'Male', '2002-03-30', 1);
insert into student (id, first_name, last_name, email, gender, date_of_birth, group_id) values (20, 'Gordon', 'Thieme', 'gthiemej@japanpost.jp', 'Male', '1994-04-04', 2);
insert into student (id, first_name, last_name, email, gender, date_of_birth, group_id) values (21, 'Dom', 'Arnecke', 'darneckek@google.fr', 'Male', '2000-03-03', 3);
insert into student (id, first_name, last_name, email, gender, date_of_birth, group_id) values (22, 'Raven', 'Yarrall', 'ryarralll@vimeo.com', 'Female', '2009-05-05', 4);
insert into student (id, first_name, last_name, email, gender, date_of_birth, group_id) values (23, 'Emery', 'McSporon', 'emcsporonm@reverbnation.com', 'Male', '1990-12-20', 5);
insert into student (id, first_name, last_name, email, gender, date_of_birth, group_id) values (24, 'Der', 'Caville', 'dcavillen@csmonitor.com', 'Male',  '2003-03-20',6);
insert into student (id, first_name, last_name, email, gender, date_of_birth, group_id) values (25, 'Erich', 'Lorroway', 'elorrowayo@bizjournals.com', 'Male', '2000-08-07', 1);
insert into student (id, first_name, last_name, email, gender, date_of_birth, group_id) values (26, 'Edan', 'Brayne', 'ebraynep@prweb.com', 'Male', '2008-12-23', 2);
insert into student (id, first_name, last_name, email, gender, date_of_birth, group_id) values (27, 'Garald', 'Puddle', 'gpuddleq@taobao.com', 'Male', '1990-03-03', 3);
insert into student (id, first_name, last_name, email, gender, date_of_birth, group_id) values (28, 'Orelee', 'Hoggan', 'ohogganr@e-recht24.de', 'Female', '1999-03-29', 4);
insert into student (id, first_name, last_name, email, gender, date_of_birth, group_id) values (29, 'Dion', 'Kepp', 'dkepps@boston.com', 'Female', '2000-12-13', 5);
insert into student (id, first_name, last_name, email, gender, date_of_birth, group_id) values (30, 'Winna', 'Ganders', 'wganderst@artisteer.com', 'Female', '2001-11-11', 6);


-- 1. Получите все записи таблицы groups;
SELECT  * FROM groups;
-- 2. Получите общее количество записей таблицы groups
SELECT COUNT(*) AS total_groups from groups;
-- 3. Выведите группы их курсы
SELECT * from groups left join course c on groups.id = c.group_id;
-- 4. Выведите курсы групп у которых курс начался с 202011 по 202333
SELECT * FROM course where start_date between '2020-01-01' and '2023-03-03';
SELECT  c.course_name,g.group_name, c.start_date
FROM course c  JOIN  groups g   ON  c.id = g.id
WHERE c.start_date BETWEEN '2020-01-01' AND '2023-03-03';
-- 5. Выведите имена, дату рождения студентов , которые родились с 198011 по 20041212, и названиегруппы
SELECT first_name, student.date_of_birth,  g.group_name from student  join groups g on student.group_id = g.id
where date_of_birth between '1980-12-12' and '2004-12-12';
-- 6. Вывести полное имя, возраст, почту студентов и название группы, где айди группы равен 3
SELECT concat(student.first_name,' ',student.last_name) as full_name , age(current_date, student.date_of_birth) , student.email , g.group_name
from student join groups g on student.group_id = g.id where g.id = 3;
-- 7. Вывести все курсы одной группы, где название группы 'Java-13'
SELECT course.course_name, groups.group_name from  course join groups on course.group_id = group_id where group_name='Java 13';
select * from course join groups g on g.id = course.group_id where group_name= 'Java 13';
-- 8. Вывести название всех групп и количество студентов в группе
select groups.group_name , count(student.id) from groups join student on  groups.id = student.group_id group by groups.group_name;
-- 9.Вывести название всех групп и количество студентов в группе, если в группе больше 4 студентов
select groups.group_name, count(student.id) from student join groups on groups.id = student.group_id group by
    groups.group_name having count(student.id) >4;
-- 10. Отсортируйте имена студентов группы по убыванию, где айди группы равна 4 и выведите айдистудента, имя, пол и название группы
select student.id, student.first_name, student.last_name, groups.group_name from student join groups on student.group_id=groups.id
where groups.id=4 order by first_name desc ;





