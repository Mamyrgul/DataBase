//TIP To <b>Run</b> code, press <shortcut actionId="Run"/> or
// click the <icon src="AllIcons.Actions.Execute"/> icon in the gutter.
public class Main {
    public static void main(String[] args) {

        SELECT brand,model,price FROM cars;
        SELECT count(*) AS total_cars FROM cars;
        SELECT * from cars where brand='Hyundai';
        SELECT * from cars where color in ('Red','Blue');
        SELECT *from cars where year_of_issue between 2000 and 2010;
        SELECT count(*) AS chevorlet_count FROM cars where brand='Chevrolet';
        SELECT AVG(cars.year_of_issue) AS year_issue from cars;
        SELECT  * from cars where brand in ('Audi','Toyota','Kia','Ford');
        SELECT * from  cars where model like 'T%';
        SELECT  * from cars where  model like '%e';
        SELECT DISTINCT cars.brand from cars where length(brand) = 5;
        SELECT  SUM(cars.price) AS total_price from cars;
        SELECT * FROM cars ORDER BY price DESC LIMIT 1;
        SELECT * FROM cars ORDER BY price LIMIT 1;
        SELECT  * from cars where brand != 'Toyota';
        SELECT * FROM cars ORDER BY price DESC LIMIT 10;
        SELECT * FROM cars ORDER BY year_of_issue DESC OFFSET 4 LIMIT 10;
        SELECT * FROM cars WHERE year_of_issue NOT BETWEEN 1995 AND 2005;
        SELECT color, COUNT(*) AS color_count FROM cars GROUP BY color ORDER BY color_count DESC LIMIT 1;


    }
}