USE classicmodels;

-- NO 1
SELECT 
   c.customerName,
   CONCAT(e.firstName, ' ', e.lastName) AS salesRep,
   (c.creditLimit - SUM(p.amount)) AS remainingCredit
FROM customers AS c
JOIN employees AS e
   ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments AS p
   ON p.customerNumber = c.customerNumber
GROUP BY c.customerName
HAVING remainingCredit > 0;

-- No 2
SELECT
    productName AS 'Nama Produk',
    GROUP_CONCAT(DISTINCT customerName) AS 'Nama Customer',
    COUNT(DISTINCT customerName) AS 'Jumlah Customer',
    SUM(quantityOrdered) AS 'Total Quantitas'
FROM products
JOIN orderdetails
    ON products.productCode = orderdetails.productCode
JOIN orders
    ON orders.orderNumber = orderdetails.orderNumber
JOIN customers
    ON customers.customerNumber = orders.customerNumber
GROUP BY productName;

-- No 3
SELECT
	CONCAT(e.firstName,' ',e.lastName) AS employeeName,
	COUNT(c.customerName) AS totalCustomers
FROM employees AS e 
JOIN customers AS c
ON e.employeeNumber = c.salesRepEmployeeNumber
GROUP BY employeeName
ORDER BY totalCustomers DESC;

-- No 4
SELECT
	CONCAT(employees.firstName,' ',employees.lastName) AS 'Nama Karyawan',
	productName AS 'Nama Produk',
	SUM(quantityOrdered) AS 'Jumlah Pesanan'
FROM products
JOIN orderdetails
ON products.productCode = orderdetails.productCode
JOIN orders
ON orders.orderNumber = orderdetails.orderNumber
JOIN customers
ON customers.customerNumber = orders.customerNumber
RIGHT JOIN employees
ON employees.employeeNumber = customers.salesRepEmployeeNumber
JOIN offices
ON offices.officeCode = employees.officeCode
WHERE offices.country = 'Australia'
GROUP BY products.productCode, employees.employeeNumber
ORDER BY SUM(quantityOrdered) DESC;

-- No 5
SELECT DISTINCT 
	customerName AS 'Nama Pelanggan',
	GROUP_CONCAT(DISTINCT productName) AS 'Nama Produk',
	COUNT(DISTINCT p.productCode) AS 'Banyak Jenis Produk'
FROM customers AS c
JOIN orders AS o
ON o.customerNumber = c.customerNumber
JOIN orderdetails AS od
ON od.orderNumber = o.orderNumber
JOIN products AS p
ON p.productCode = od.productCode
WHERE o.shippedDate IS NULL
GROUP BY c.customerNumber
ORDER BY customerName;
