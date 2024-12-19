CREATE TABLE users (
                       id SERIAL PRIMARY KEY,
                       email VARCHAR(50) NOT NULL UNIQUE,
                       phone_number VARCHAR(50),
                       first_name VARCHAR(50) NOT NULL,
                       address VARCHAR(100)
);
CREATE TABLE car (
                     id SERIAL PRIMARY KEY,
                     make VARCHAR(100) NOT NULL,
                     model VARCHAR(100) NOT NULL,
                     year_of_manufacture DATE NOT NULL,
                     mileage VARCHAR(100),
                     condition VARCHAR(50),
                     price VARCHAR(50),
                     user_id INTEGER,
                     CONSTRAINT car_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id));
-- Inserting data into the users table
INSERT INTO users (email, phone_number, first_name, address)
VALUES
    ('john.doe@example.com', '123-456-7890', 'John', '123 Main St, Springfield'),
    ('jane.smith@example.com', '987-654-3210', 'Jane', '456 Elm St, Shelbyville'),
    ('michael.brown@example.com', NULL, 'Michael', '789 Oak St, Capital City'),
    ('emily.davis@example.com', '555-555-5555', 'Emily', NULL),
    ('alex.jones@example.com', NULL, 'Alex', '101 Pine St, Metropolis');
-- Inserting data into the car table
INSERT INTO car (make, model, year_of_manufacture, mileage, condition, price, user_id)
VALUES
    ('Toyota', 'Corolla', '2018-05-20', '50000', 'Used', '15000', 1),
    ('Honda', 'Civic', '2020-03-15', '30000', 'New', '20000', 2),
    ('Ford', 'Focus', '2015-07-10', '80000', 'Used', '10000', 3),
    ('BMW', 'X5', '2022-09-01', '10000', 'New', '50000', 4),
    ('Tesla', 'Model 3', '2021-01-20', '15000', 'New', '45000', NULL); -- Car without an owner
-- Inserting extended data into the users table
INSERT INTO users (email, phone_number, first_name, address)
VALUES
    ('charles.miller@example.com', '111-222-3333', 'Charles', '221B Baker St, London'),
    ('sarah.connor@example.com', NULL, 'Sarah', 'Cyberdyne Blvd, Los Angeles'),
    ('bruce.wayne@example.com', '000-000-0000', 'Bruce', 'Wayne Manor, Gotham'),
    ('clark.kent@example.com', '123-987-6543', 'Clark', 'Smallville, Kansas'),
    ('diana.prince@example.com', NULL, 'Diana', 'Themyscira, Paradise Island');
-- Insert additional cars into the car table
INSERT INTO car (make, model, year_of_manufacture, mileage, condition, price, user_id)
VALUES
    ('Mercedes-Benz', 'C-Class', '2017-03-10', '45000', 'Used', '22000', 2),
    ('Hyundai', 'Elantra', '2019-08-15', '30000', 'Used', '18000', 3),
    ('Audi', 'A4', '2021-11-25', '15000', 'New', '35000', 4),
    ('Kia', 'Sorento', '2020-05-05', '20000', 'Used', '25000', 5),
    ('Chevrolet', 'Malibu', '2018-06-20', '60000', 'Used', '17000', 1),
    ('Volkswagen', 'Passat', '2020-01-10', '25000', 'Used', '27000', 2),
    ('Subaru', 'Outback', '2022-04-01', '5000', 'New', '34000', 3),
    ('Nissan', 'Altima', '2016-02-18', '75000', 'Used', '13000', NULL), -- Unowned car
    ('Toyota', 'Camry', '2021-09-30', '12000', 'New', '28000', NULL), -- Unowned car
    ('Ford', 'Explorer', '2015-12-12', '80000', 'Used', '20000', 5);

SELECT * FROM users, car;
SELECT * FROM car  INNER JOIN users  on users.id = user_id;
SELECT  car.make,car.mileage , users.email from car inner join users on users.id = car.user_id;

SELECT * FROM car left join users u on u.id = car.user_id;

SELECT * FROM car FULL JOIN users u on u.id = car.user_id;

SELECT users.email, car.make , car.year_of_manufacture from car join users on car.user_id = users.id where car.make= 'Toyota';
SELECT u.first_name , car.make, car.condition from car join users u on u.id = car.user_id where first_name = 'John';
SELECT * FROM users u left join car c on u.id = c.user_id where user_id is null;


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