USE classicmodels

-- NOMOR 1
SELECT DISTINCT c.customerName, p.productName, pl.textDescription
FROM customers AS c
JOIN orders AS o
ON c.customerNumber = o.customerNumber
JOIN orderdetails AS od
ON o.orderNumber = od.orderNumber
JOIN products AS p
ON od.productCode = p.productCode
JOIN productlines AS pl
ON p.productLine = pl.productLine
WHERE productName LIKE '%Titanic%' 
ORDER BY customerName;

-- NOMOR 2
SELECT c.customerName, p.productName, o.status, o.shippedDate
FROM customers AS c
JOIN orders AS o
ON c.customerNumber = o.customerNumber
JOIN orderdetails AS od
ON o.orderNumber = od.orderNumber
JOIN products AS p
ON od.productCode = p.productCode
WHERE productName LIKE '%Ferrari%'
AND status = 'Shipped'
AND shippedDate BETWEEN '2003-10-01' AND '2004-10-01'
ORDER BY shippedDate DESC;

-- NOMOR 3
SELECT s.firstName AS Supervisor, k.firstName AS Karyawan
FROM employees AS s
JOIN employees AS k
ON s.employeeNumber = k.reportsTo
WHERE s.firstName = 'Gerard'
ORDER BY karyawan;

-- NOMOR 4 
-- 4A
SELECT c.customerName, pm.paymentDate, e.firstName, pm.amount
FROM customers AS c
JOIN payments AS pm
ON c.customerNumber = pm.customerNumber
JOIN employees AS e
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE paymentdate LIKE '_____11%';

-- 4B
SELECT c.customerName, pm.paymentDate, e.firstName, pm.amount
FROM customers AS c
JOIN payments AS pm
ON c.customerNumber = pm.customerNumber
JOIN employees AS e
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE paymentdate LIKE '_____11%'
ORDER BY amount DESC LIMIT 1;

-- 4C
SELECT c.customerName, p.productName
FROM customers AS c
JOIN orders AS o
ON c.customerNumber = o.customerNumber
JOIN orderdetails AS od
ON o.orderNumber = od.orderNumber
JOIN products AS p
ON od.productCode = p.productCode
JOIN payments AS pm
ON c.customerNumber = pm.customerNumber
WHERE customerName = 'Corporate Gift Ideas Co.'
AND pm.paymentdate LIKE '_____11%';

-- SOAL TAMBAHAN
SELECT e.firstName, c.customerName, o.country
FROM customers AS c
JOIN employees AS e
ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN offices AS o
ON e.officeCode = o.officeCode
WHERE o.country = c.country
AND o.city != c.city;
