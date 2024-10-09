USE models;

-- no1
SELECT DISTINCT c.customername AS 'namaKustomer', p.productname AS 'namaProduk', pl.textdescription 
FROM customers  c
JOIN orders o
ON c.customerNumber = o.customerNumber
JOIN orderdetails od
ON o.orderNumber = od.orderNumber
JOIN products p 
ON od.productCode = p.productCode
JOIN productlines pl 
ON p.productLine = pl.productLine
WHERE p.productName LIKE '%Titanic%'
ORDER BY c.customerName ASC;

-- no2
SELECT DISTINCT c.customerName, p.productName, o.`status`, o.shippedDate
FROM customers c
JOIN orders o
USING (customerNumber)
JOIN orderdetails od 
USING (orderNumber)
JOIN products p 
USING (productCode)
WHERE p.productName LIKE '%Ferrari%'
		AND o.`status` = 'Shipped'
		AND o.shippedDate BETWEEN '2003-10-01' AND '2004-10-01'
ORDER BY o.shippedDate DESC;

-- no3
SELECT s.firstName AS Supervisor, e.firstName AS Karyawan
FROM employees e
JOIN employees s 
ON e.reportsTo = s.employeeNumber
WHERE s.firstName = 'Gerard'
ORDER BY e.firstName ASC ;

SELECT firstName FROM employees;

SELECT firstName, reportsTo, employeeNumber FROM employees;

-- no4
-- A
SELECT c.customername, p.paymentdate, e.firstname AS employeeName, p.amount 
FROM payments p
JOIN customers c 
ON p.customerNumber = c.customerNumber
JOIN employees e 
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE p.paymentDate LIKE '%-11-%';

-- B
SELECT c.customername, p.paymentdate, e.firstname AS employeeName, p.amount 
FROM payments p
JOIN customers c 
ON p.customerNumber = c.customerNumber
JOIN employees e 
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE p.paymentDate LIKE '_____11%'
ORDER BY p.amount DESC
LIMIT 1;

-- C
SELECT c.customername, p.productname 
FROM customers c
JOIN orders 
ON c.customerNumber = orders.customerNumber
JOIN orderdetails 
ON orders.orderNumber = orderdetails.orderNumber
JOIN products p 
ON orderdetails.productCode = p.productCode
JOIN payments pay 
ON c.customerNumber = pay.customerNumber
WHERE c.customerName = 'Corporate Gift Ideas Co.'
AND pay.paymentDate LIKE '_____11%';

-- soal tambahan
SELECT c.customerName, p.productName, od.quantityOrdered
FROM customers c
JOIN orders o
ON c.customerNumber = o.customerNumber 
JOIN orderdetails od
ON o.orderNumber = od.orderNumber
JOIN products p
ON od.productCode = p.productCode
WHERE c.country IN ('Singapore', 'Japan', 'Hong Kong',  'China', 'India')
ORDER BY od.quantityOrdered DESC ;




