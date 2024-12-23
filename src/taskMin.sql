
--1. Owner_лердин аттарынын арасынан эн коп символ камтыган owner_ди жана анын уйун(House) чыгар.
select owners.first_name, h.house_type from owners  join houses h on owners.owner_id = h.owner_id
where length(first_name) = select (max(lenght(first_name)) FROM owners;
-- 2. Уйлордун баалары 1500, 2000 дин аралыгында бар болсо true чыгар, жок болсо false чыгар.
    select houses.price from houses where price between 1500 and 2000;
-- 3. id_лери 5, 6, 7, 8, 9, 10 го барабар болгон адресстерди жана ал адрессте кайсы уйлор бар экенин чыгар.
    select houses.house_id , houses.house_type from houses where house_id in (5,6,7,8,9,10);
-- 4. Бардык уйлорду, уйдун ээсинин атын, клиенттин атын, агенттин атын чыгар.
    select house_type, o.first_name, c.first_name ,name from houses left join rent_info ri on houses.house_id = ri.house_id
    left join owners o on houses.owner_id = o.owner_id left join customers c on ri.customer_id = c.customer_id
    left join agencies a on ri.agency_id = a.agency_id;
-- 5. Клиенттердин 10-катарынан баштап 1999-жылдан кийин туулган 15 клиентти чыгар.
    select * from customers where date_of_birth> '1999-12-31' offset 10 limit 15;
-- 6. Рейтинги боюнча уйлорду сорттоп, уйлордун тайптарын, рейтингин жана уйдун ээлерин чыгар. (asc and desc)
    select houses.house_type,houses.rating, o.first_name from houses join owners o on o.owner_id = houses.owner_id
    order by rating;
-- 7. Уйлордун арасынан квартиралардын (apartment) санын жана алардын баасынын суммасын чыгар.
    select houses.house_type, count(houses.house_type) , sum(houses.price) from houses where house_type='Apartment' group by houses.house_type ;
-- 8. Агентсволардын арасынан аты ‘My_House’ болгон агентсвоны, агентсвонын адресин жана анын бардык уйлорун, уйлордун
-- адрессин чыгар.
    select agencies.name, a.city , h.house_type , h.address_id from agencies join
    addresses a on agencies.address_id = a.address_id join houses h on a.address_id = h.address_id;
-- 9. Уйлордун арасынан мебели бар уйлорду, уйдун ээсин жана уйдун адрессин чыгар.
    select houses.house_type, houses.furniture , o.first_name, houses.address_id from houses join owners o on o.owner_id = houses.owner_id
    join addresses a on a.address_id = houses.address_id where furniture is  not null;
-- 10.Кленти жок уйлордун баарын жана анын адрессин жана ал уйлор кайсыл агентсвога тийешелуу экенин чыгар.
    select houses.house_type, houses.address_id, a2.name from houses join addresses a on a.address_id = houses.address_id
    join agencies a2 on a.address_id = a2.address_id join rent_info ri on houses.house_id = ri.house_id
    where customer_id is null;
-- 11.Клиенттердин улутуна карап, улутуну жана ал улуутта канча клиент жашайт санын чыгар.
    select customers.nationality , count(customers.customer_id) from customers group by nationality;
-- 12.Уйлордун арасынан рейтингтери чон, кичине, орточо болгон 3 уйду чыгар.
    select houses.house_type ,houses.rating from houses where rating = (select max(houses.rating) from houses)
    or rating=( select AVG(houses.rating) from houses ) or houses.rating = (select min(houses.rating) from houses);
-- 13.Уйлору жок киленттерди, клиенттери жок уйлорду чыгар.
    select c.first_name, houses.house_type from houses join rent_info ri on houses.house_id = ri.house_id
    join customers c on c.customer_id = ri.customer_id where ri.customer_id is null and ri.house_id is null;