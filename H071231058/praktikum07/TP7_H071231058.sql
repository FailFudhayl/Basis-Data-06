-- nama: Destin Kendenan
-- NIM: H071231058


## NOMOR 1
SELECT
	productCode,
	productName,
	buyPrice
FROM products 
WHERE buyPrice > 
	(SELECT AVG(p.buyprice) FROM products p);
	
## NOMOR 2
SELECT
	o.orderNumber,
	o.orderDate
FROM orders o
JOIN customers c
USING(customerNumber)
WHERE c.salesRepEmployeeNumber IN 
(
	SELECT e.employeeNumber
	FROM employees e
	JOIN offices ofc
	USING(officeCode)
	WHERE ofc.city = 'Tokyo'
);

## NOMOR 3
SELECT 
	c.customerName,
	o.orderNumber,
	o.shippedDate,
	o.requiredDate,
 	GROUP_CONCAT(p.productName) AS products,
	SUM(od.quantityOrdered) AS total_quantity_ordered,
	CONCAT(e.firstName, " ", e.lastName) AS employeeName
FROM customers c
JOIN orders o
USING(customerNumber)
JOIN orderdetails od
USING(orderNumber)
JOIN products p
USING(productCode)
JOIN employees e
ON e.employeeNumber = c.salesRepEmployeeNumber
WHERE o.orderNumber IN 
(
	SELECT orderNumber
	FROM orders
	WHERE requiredDate < shippeddate
);

## NOMOR 4
SELECT 
	p.productName,
	p.productLine,
	SUM(od.quantityOrdered) AS total_quantity_ordered
FROM products p
JOIN orderdetails od
USING(productCode)
WHERE p.productLine IN 
(
	SELECT productline
	FROM (
		SELECT p2.productline FROM products  p2
		JOIN orderdetails od2
		USING(productCode)
		GROUP BY p2.productline
		ORDER BY SUM(od2.quantityOrdered) DESC 
		LIMIT 3
	) AS product 
)
GROUP BY productName
ORDER BY productline, total_quantity_ordered DESC 



-- SOAL TAMBAHAN: Buatlah sebuah query SQL yang Menampilkan nama karyawan yang melayani pelanggan yang pernah membeli produk dengan stok tertinggi
SELECT
	CONCAT(e.firstName, " ", e.lastName) AS 'nama karyawan'
FROM employees e
JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders o
USING(customerNumber)
JOIN orderdetails od
USING(orderNumber)
JOIN products p
USING(productCode)
WHERE p.productCode IN
(SELECT productCode FROM 
	(SELECT p2.productCode FROM products p2
	 GROUP BY p2.productCode
	 ORDER BY SUM(p2.quantityInStock) DESC 
	 LIMIT 1
	) AS product
);



