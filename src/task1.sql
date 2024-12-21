create table publishers (
                            publisher_id serial primary key,
                            publisher_name varchar
);
create table languages(
                          language_id serial primary key,
                          language_name varchar
);

create type gender as enum (
    'Male', 'Female'
    );

create table authors (
                         author_id serial primary key,
                         author_firstName varchar,
                         author_lastName varchar,
                         author_email varchar,
                         author_dateOfBirth date,
                         author_country varchar,
                         gender gender
);

create type genre as enum (
    'DETECTIVE','DRAMA','HISTORY','ROMANCE','BIOGRAPHY','FANTASY'
    );

create table books (
                       book_id serial primary key,
                       book_name varchar,
                       book_country varchar,
                       book_publishedYear date,
                       book_price int,
                       genre genre
);

alter table languages
    alter column language_name set not null;

alter table authors
    add constraint unique_author_email unique(author_email);

alter table books add column language_id int;
alter table books add constraint fk_language foreign key (language_id) references languages(language_id);

alter table books add column publisher_id int;
alter table books add constraint fk_publisher_id foreign key (publisher_id) references publishers(publisher_id);

alter table books add column author_id int;
alter table books add constraint fk_author_id foreign key (author_id) references authors(author_id);
--1.Китептердин атын, чыккан жылын, жанрын чыгарыныз.
select book_name, book_publishedYear, genre from books;
--2.Авторлордун мамлекеттери уникалдуу чыксын.
select distinct author_country from authors;
--3.2020-2023 жылдардын арасындагы китептер чыксын.
select * from books where  book_publishedYear between '2020-01-01' and '2023-12-31';
--4.Детектив китептер жана алардын аттары чыксын.
select book_name , genre from books where genre = 'DETECTIVE';
--5.Автордун аты-жону author деген бир колонкага чыксын.
select concat(author_firstName,' ',author_lastName) as author from authors;
--6.Германия жана Франциядан болгон авторлорду толук аты-жону менен сорттоп чыгарыныз.
select concat(author_firstName,' ',author_lastName) as fullName, author_country from authors where author_country in ('Germany','France')
order by fullName;
--7.Романдан башка жана баасы 500 дон кичине болгон китептердин аты, олкосу, чыккан жылы, баасы жанры чыксын..
select book_name, book_country, book_publishedYear, book_price, genre from books where genre!= 'ROMANCE' and book_price>500;
--8.Бардык кыз авторлордун биринчи 3 ну чыгарыныз.
select * from authors where gender= 'Female' limit 3;
--9.Почтасы .com мн буткон, аты 4 тамгадан турган, кыз авторлорду чыгарыныз.
select * from authors where gender= 'Female' and author_email like '%.com' and  length(author_firstName)=4;
--10.Бардык олколорду жана ар бир олкодо канчадан автор бар экенин чыгаргыла.
select author_country , count(author_id) from authors group by author_country;
--11.Уч автор бар болгон олколорду аты мн сорттоп чыгарыныз.
select author_country , count(author_id) from authors group by author_country having count(author_id)=3 ;
--12. Ар бир жанрдагы китептердин жалпы суммасын чыгарыныз
select genre, sum(book_price) from books group by genre;
--13. Роман жана Детектив китептеринин эн арзан бааларын чыгарыныз
select genre, min(book_price) from books where genre in ('ROMANCE','DETECTIVE') group by genre;
--14.История жана Биографиялык китептердин сандарын чыгарыныз
select genre , count(genre) from books where genre in ('BIOGRAPHY','HISTORY') group by genre;
--15.Китептердин , издательстволордун аттары жана тили чыксын
select book_name, publisher_name from books join publishers on books.publisher_id= publishers.publisher_id;
--16.Авторлордун бардык маалыматтары жана издательстволору чыксын, издательство болбосо null чыксын
select author_firstName ,author_lastName, author_email,author_dateOfBirth, author_country, gender, publisher_name
from authors left join books on authors.author_id = books.author_id left join publishers on books.publisher_id = publishers.publisher_id;
--17.Авторлордун толук аты-жону жана китептери чыксын, китеби жок болсо null чыксын.
select author_firstName ,author_lastName, book_name from authors left join books on authors.author_id= books.author_id;
--18.Кайсы тилде канча китеп бар экендиги ылдыйдан ойлдого сорттолуп чыксын.
select language_name, count(book_id) from languages join books on languages.language_id= books.language_id group by language_name
order by language_name desc;
--19.Издательствонун аттары жана алардын тапкан акчасынын оточо суммасы тегеректелип чыгарылсын.
select publisher_name, round(avg(book_price)) from publishers join books on publishers.publisher_id = books.publisher_id
group by publisher_name order by publisher_name desc;
--20.2010-2015 жылдардын арасындагы китептер жана автордун аты-фамилиясы чыксын.
select author_firstName, author_lastName, book_name from authors join books on authors.author_id = books.author_id where
    book_publishedYear between '2010-01-01' and '2015-12-31';
--21.2010-2015 жылдардын арасындагы китептердин авторлорунун толук аты-жону жана алардын тапкан акчаларынын жалпы суммасы чыксын.
select concat(author_firstName,' ',author_lastName) as fullName, sum(book_price) from authors join books on authors.author_id = books.author_id where
    book_publishedYear between '2010-01-01' and '2015-12-31' group by fullName;
