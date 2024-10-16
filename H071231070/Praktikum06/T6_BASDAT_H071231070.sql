USE classicmodels 

-- NOMOR 1
SELECT c.customerName, 
CONCAT (e.firstName, " ", e.lastName) AS SalesRep, 
c.creditLimit -SUM(py.amount) AS remainingCredit
FROM customers AS c
JOIN employees AS e
ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN payments AS py
ON c.customerNumber = py.customerNumber
GROUP BY c.customerName
HAVING remainingCredit > 0
ORDER BY c.customerName;

-- NOMOR 2
SELECT p.productname AS 'Nama Produk',
GROUP_CONCAT(DISTINCT c.customername ORDER BY c.customername SEPARATOR ', ') AS 'Nama Customer',
COUNT(DISTINCT c.customername) AS 'Jumlah Customer',
SUM(od.quantityordered) AS 'Total Quantitas'
FROM products p
JOIN orderdetails od 
USING(productcode)
JOIN orders 
USING(ordernumber)
JOIN customers c 
USING(customernumber)
GROUP BY p.productname;

-- NOMOR 3
SELECT CONCAT(e.firstName, ' ', e.lastName) AS employeeName,
COUNT(c.customerNumber) AS Totalcustomers
FROM employees AS e
JOIN customers AS c
ON e.employeeNumber = c.salesRepEmployeeNumber
GROUP BY employeeName
ORDER BY Totalcustomers DESC;

-- NOMOR 4
SELECT CONCAT(e.firstName, ' ', e.lastName) AS 'Nama Karyawan',
p.productName AS 'Nama Produk', SUM(od.quantityordered) AS 'Jumlah Pesanan'
FROM employees AS e
LEFT JOIN customers AS c
ON e.employeeNumber = c.salesRepEmployeeNumber
LEFT JOIN orders AS o
ON c.customerNumber = o.customerNumber
LEFT JOIN orderdetails AS od
ON o.orderNumber = od.orderNumber
LEFT JOIN products AS p
ON od.productCode = p.productCode
LEFT JOIN offices AS os
ON e.officeCode = os.officeCode
WHERE os.country = 'Australia'
GROUP BY CONCAT(e.firstName, ' ', e.lastName), p.productName
ORDER BY SUM(od.quantityordered) DESC;

-- NOMOR 5
SELECT c.customerName AS 'Nama Pelanggan', GROUP_CONCAT( p.productName) AS 'Nama Produk', 
COUNT(p.productLine) AS 'Banyak Jenis Produk'
FROM customers AS c
JOIN orders AS o
ON c.customerNumber = o.customerNumber
JOIN orderdetails AS od
ON o.orderNumber = od.orderNumber
JOIN products AS p
ON od.productCode = p.productCode
WHERE o.shippeddate IS NULL 
GROUP BY c.customerName;
