-- 1
SELECT 
	c.customerName,  
	CONCAT(e.firstName, ' ', e.lastName) AS salesRep,
	(c.creditLimit-sum(p.amount)) AS remainingCredit
FROM customers AS c
	JOIN employees AS e 
	ON e.employeeNumber = c.salesRepEmployeeNumber
	JOIN payments AS p USING (customerNumber)
GROUP BY
	c.customerName
HAVING 
	remainingCredit > 0;

-- 2
SELECT 
   p.productName AS `Nama Produk`,
   GROUP_CONCAT(DISTINCT c.customerName) AS `Nama Customer`,
   COUNT(DISTINCT o.customerNumber ) AS `Jumlah Customer`,
   SUM(od.quantityOrdered) AS `Total Quantitas`
FROM
	products AS p
JOIN 
   orderdetails AS od USING (productCode)
JOIN
	orders AS o USING (orderNumber)
JOIN
   customers AS c USING (customerNumber)
GROUP BY
   p.productName;
   
-- 3
SELECT
   CONCAT(e.firstName, ' ', e.lastName) AS employeeName,
   COUNT(DISTINCT c.customerNumber) AS `Jumlah Customer`
FROM
   employees AS e
JOIN 
   customers AS c 
ON 
   c.salesRepEmployeeNumber = e.employeeNumber
GROUP BY
   e.firstName, e.lastName
ORDER BY
   `Jumlah Customer` DESC;

-- 4
SELECT 
   CONCAT(e.firstName, ' ', e.lastName) AS `Nama Karyawan`,
   p.productName AS `Nama Produk`,
   SUM(od.quantityOrdered) AS `Jumlah Pesanan`
FROM 
   employees AS e
LEFT JOIN
   customers AS c
	ON e.employeeNumber = c.salesRepEmployeeNumber
LEFT JOIN 
   orders AS o USING(customerNumber)
LEFT JOIN 
   orderdetails AS od USING(orderNumber)
LEFT JOIN                    
   products AS p USING(productCode)
WHERE 
   e.officeCode = '6'
GROUP BY 
   e.firstName, e.lastName, p.productName
ORDER BY 
   `Jumlah Pesanan` DESC;

-- 5
SELECT 
	c.customerName, 
	p.productName AS `Nama Produk`, 
	COUNT(DISTINCT p.productCode) AS `Banyak Jenis Produk`
FROM 
	customers AS c
JOIN 
	orders AS o USING (customerNumber)
JOIN 
   orderdetails AS od USING(orderNumber)
JOIN 
	products AS p USING(productCode)
WHERE o.shippedDate IS NULL
GROUP BY 
	c.customerName