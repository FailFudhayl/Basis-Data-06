USE classicmodels;
--1
SELECT customernumber, customername, country FROM customers 
WHERE (country='usa' AND creditlimit > 50000 AND creditlimit < 100000)
OR (country !='usa' AND  creditlimit >= 100000 AND creditlimit <= 200000)
ORDER BY creditlimit DESC;

--2
SELECT productcode, productname, quantityinstock, buyprice FROM products
WHERE (quantityinstock BETWEEN 1000 AND 2000) AND (buyprice < 50 OR buyprice > 150) 
AND (productname NOT LIKE 'Vintage%');

--3
SELECT productcode, productname, msrp FROM products
WHERE productline LIKE 'Classic%' AND buyprice > 50;

--4 
SELECT ordernumber, orderdate, STATUS, customernumber FROM orders
WHERE ordernumber > 10250 AND STATUS NOT IN ('shipped', 'cancelled')
AND orderdate BETWEEN '2004-01-01' AND '2005-12-31';

--5
SELECT ordernumber, orderlinenumber, productcode, quantityordered, priceeach, 
(priceeach*0.05) AS discountedTotalprice FROM orderdetails
WHERE quantityordered > 50 AND priceeach > 100 AND productcode NOT LIKE 'S18%'
ORDER BY discountedTotalprice DESC;