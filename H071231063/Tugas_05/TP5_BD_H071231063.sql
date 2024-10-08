SELECT classicmodels;

--1
SELECT DISTINCT c.customerName AS namaKustomer, 
p.productName AS namaProduk,  pl.textDescription
FROM customers AS c
JOIN orders AS o
ON o.customerNumber = c.customerNumber
JOIN orderdetails AS od
ON od.orderNumber = o.orderNumber
JOIN products AS p
ON p.productCode = od.productCode
JOIN productlines AS pl
ON pl.productLine = p.productLine
WHERE p.productName LIKE '%Titanic'
ORDER BY c.customerName;

--2
SELECT c.customerName, p.productName ,o.`status`,o.shippedDate 
FROM customers AS c
JOIN orders AS o
ON o.customerNumber = c.customerNumber
JOIN orderdetails AS od
ON od.orderNumber = o.orderNumber
JOIN products AS p
ON p.productCode = od.productCode
WHERE p.productName LIKE '%Ferrari%' 
AND o.`status` = 'Shipped' 
AND (o.shippedDate BETWEEN '2003-10-01' AND '2004-10-1')
ORDER BY o.shippedDate DESC;

--3
SELECT 
DISTINCT s.firstName AS supervisor, 
e.firstName AS karyawan
FROM 
employees AS  e
JOIN  employees AS s 
ON e.reportsTo = s.employeeNumber
WHERE 
e.reportsTo = 1102 ORDER BY e.firstName ASC;

--4
a--
SELECT c.customerName, p.paymentDate, 
CONCAT(e.firstName, ' ', e.lastName) AS employeeName, p.amount
FROM customers AS c
JOIN payments AS p
ON p.customerNumber = c.customerNumber
JOIN employees AS e
ON e.employeeNumber = c.salesRepEmployeeNumber
WHERE p.paymentDate LIKE '%-11-%' ORDER BY amount;

b--
SELECT c.customerName, p.paymentDate, CONCAT(e.firstName, ' ', e.lastName) AS employeeName, p.amount
FROM customers AS c
JOIN payments AS p
ON p.customerNumber = c.customerNumber
JOIN employees AS e
ON e.employeeNumber = c.salesRepEmployeeNumber
WHERE p.paymentDate LIKE '%-11-%' ORDER BY amount DESC LIMIT 1;

c--
SELECT c.customerName, p.productName
FROM customers AS c
JOIN payments AS ps
ON ps.customerNumber = c.customerNumber
JOIN orders AS o 
ON o.customerNumber = c.customerNumber
JOIN orderdetails AS od 
ON od.orderNumber = o.orderNumber
JOIN products AS p
ON p.productCode = od.productCode 
WHERE c.customerName LIKE 'Corporate%' AND ps.paymentDate LIKE '%-11-%';