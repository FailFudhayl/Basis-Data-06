-- nama: Destin Kendenan
-- NIM: H071231058

-- nomor 1
SELECT DISTINCT c.customername AS namaKustomer, p.productname AS namaProduk, pl.textDescription 
FROM customers c
INNER JOIN orders o
ON c.customerNumber = o.customerNumber
INNER JOIN orderdetails od
ON o.orderNumber = od.orderNumber
INNER JOIN products p
ON od.productCode = p.productCode
INNER JOIN productlines pl
ON p.productline = pl.productLine
WHERE productname LIKE '%titanic%' 
ORDER BY customername;


-- nomor 2
SELECT c.customerName, p.productName, o.status, o.shippedDate
FROM customers c
INNER JOIN orders o
USING (customerNumber)
INNER JOIN orderdetails od
ON o.orderNumber = od.orderNumber
INNER JOIN products p
ON od.productCode = p.productCode
WHERE productName LIKE '%ferrari%'
		AND STATUS = 'shipped'
		AND shippeddate BETWEEN '2003-10-01' AND '2004-10-01'
ORDER BY shippeddate DESC;


-- nomor 3
SELECT s.firstName AS 'Supervisor', 
       e.firstName AS 'Karyawan'
FROM employees e
JOIN employees s 
ON e.reportsTo = s.employeeNumber
WHERE s.firstName = 'Gerard'
ORDER BY e.firstname;


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
INNER JOIN payments pm
USING (customerNumber)
INNER JOIN orders o
ON c.customerNumber = o.customerNumber
INNER JOIN orderdetails od
ON o.orderNumber = od.orderNumber
INNER JOIN products p
ON od.productCode = p.productCode
WHERE customername = 'corporate gift ideas co.' AND paymentdate LIKE '%-11-%';


-- SOAL TAMBAHAN
SELECT o.ordernumber, o.orderdate, c.customername, p.amount
FROM orders o
INNER JOIN customers c
ON o.customerNumber = c.customerNumber
INNER JOIN payments p
ON c.customerNumber = p.customerNumber
WHERE STATUS = 'shipped'