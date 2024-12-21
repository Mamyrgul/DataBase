SELECT DISTINCT City FROM Customers;
SELECT * FROM Employees
WHERE BirthDate BETWEEN '1950-01-01' AND '1960-12-31';
select SupplierName, Country from suppliers where City = 'France';
select CustomerName , Address , Country from customers where Country != 'Spain' and CustomerName like 'A%';
select * from customers where PostalCode is null;
select * from customers where Country= 'London' limit 2;
select FirstName , BirthDate from employees where  length(LastName) = 4;
select Country , count(*) from suppliers group by Country;
select Country from suppliers group by Country having count(*)=1 order by Country;
select sum(Price) from Products;
select CategoryID , ProductName , Price as min_price from Products where
    (CategoryID, Price) in (select CategoryID , min(Price) from Products where CategoryID between 6 and 8 group by CategoryID)
order by CategoryID;
select ProductName , SupplierName from Products join Suppliers on Products.SupplierID = Suppliers.SupplierID order by ProductName;
select SupplierName , count(ProductID) from  Suppliers join Products on Suppliers.SupplierID = Products.SupplierID GROUP BY
SupplierName order by SupplierName desc;
select CustomerName , FirstName, ShipperName from Customers join Orders on Customers.CustomerID = Orders.CustomerID
join Employees on Orders.EmployeeID = Employees.EmployeeID join Shippers on Orders.ShipperID = Shippers.ShipperID
order by CustomerName;
select FirstName , count(CustomerID) from Employees join Orders on Employees.EmployeeID = Orders.EmployeeID group by FirstName;
