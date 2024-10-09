USE classicmodels;

-- No 1 
SELECT DISTINCT 
	customerName AS "namaKustomer",
	products.productName AS "namaProduk",
	textDescription
FROM customers
JOIN orders
ON customers.customerNumber = orders.customerNumber
JOIN orderdetails
ON orderdetails.orderNumber = orders.orderNumber
JOIN products 
ON products.productCode = orderdetails.productCode
JOIN productlines
ON productlines.productLine = products.productLine
WHERE 
	products.productName LIKE "%Titanic%" 
ORDER BY customerName;

-- No 2
SELECT 
	customers.customerName,
	products.productName,
	STATUS,
	shippedDate
FROM customers
JOIN orders
ON customers.customerNumber = orders.customerNumber
JOIN orderdetails
ON orders.orderNumber = orderdetails.orderNumber
JOIN products
ON orderdetails.productCode = products.productCode
WHERE 
	productName LIKE "%Ferrari%" and
	STATUS LIKE "Shipped" AND 
	shippedDate BETWEEN "2003-10-01" AND "2004-10-01";
	
-- No 3
SELECT 
	s.firstName AS Supervisor, 
	k.firstName AS Karyawan
FROM employees AS s
JOIN employees AS k
ON s.employeeNumber = k.reportsTo
WHERE 
	s.firstName LIKE "%Gerard%"
ORDER BY k.firstName;

-- nomor 4
-- -- bagian a
SELECT c.customerName, p.paymentDate, e.firstname, p.amount
FROM customers c
INNER JOIN  employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
INNER JOIN payments p
ON c.customerNumber = p.customerNumber
WHERE paymentdate LIKE '%-11-%'

-- -- bagian b
ORDER BY amount DESC
LIMIT 1;

-- -- bagian c
SELECT c.customerName, p.productName
FROM customers c
INNER JOIN orders o
ON c.customerNumber = o.customerNumber
INNER JOIN orderdetails od
ON o.orderNumber = od.orderNumber
INNER JOIN products p
ON od.productCode = p.productCode
INNER JOIN payments 
ON c.customerNumber = payments.customerNumber
WHERE customername = 'corporate gift ideas co.' AND 
		paymentDate LIKE "%-11-%";	
	
-- Soal Tambahan
SELECT 
	customerName,
	STATUS,
	comments
FROM customers
JOIN orders
ON customers.customerNumber = orders.customerNumber
WHERE STATUS LIKE "%hold%";


