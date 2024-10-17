USE models;

-- no1
SELECT c.customerName, 
		 CONCAT(e.firstName, ' ', e.lastName) AS salesRep, 
		 (c.creditLimit - SUM(p.amount)) AS remainingCredit
FROM customers c
JOIN employees e 
ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN payments p
USING (customerNumber)
GROUP BY c.customerName
HAVING remainingCredit > 0;

-- no2
SELECT p.productName AS 'Nama Produk', 
		 GROUP_CONCAT(DISTINCT c.customerName SEPARATOR ',') AS 'Nama Customer', 
		 COUNT(DISTINCT c.customerNumber) AS 'Jumlah Customer', 
		 SUM(od.quantityOrdered) AS 'Total Quantitas'
FROM products p
JOIN orderdetails od 
USING (productCode)
JOIN orders o 
USING (orderNumber)
JOIN customers c 
USING (customerNumber)
GROUP BY p.productName;

-- no3
SELECT CONCAT(e.firstName, ' ', e.lastName) AS employeeName, 
       COUNT(c.customerNumber) AS totalCustomers
FROM employees e
JOIN customers c 
ON e.employeeNumber = c.salesRepEmployeeNumber
GROUP BY e.employeeNumber
ORDER BY totalCustomers DESC;

-- no4
SELECT CONCAT(e.firstName, ' ', e.lastName) AS NamaKaryawan, 
       p.productName AS NamaProduk, 
       SUM(od.quantityOrdered) AS JumlahPesanan
FROM employees e
LEFT JOIN offices o 
USING (officeCode)
LEFT JOIN customers c 
ON e.employeeNumber = c.salesRepEmployeeNumber
LEFT JOIN orders os 
USING (customerNumber)
LEFT JOIN orderdetails od 
USING (orderNumber)
LEFT JOIN products p 
USING (productCode)
WHERE o.country = 'Australia'
GROUP BY e.employeeNumber, p.productName
ORDER BY JumlahPesanan DESC;

-- no5
SELECT c.customerName AS 'Nama Pelanggan', 
		 p.productName AS 'Nama Produk',
		 COUNT(p.productLine) AS 'Banyak Jenis Produk',
FROM customers c
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products p
USING (productCode)
WHERE o.shippedDate IS NULL
GROUP BY c.customerName;










