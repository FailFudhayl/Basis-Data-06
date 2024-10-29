USE classicmodels

-- NOMOR 1
SELECT productCode, productName, buyPrice
FROM products
WHERE buyPrice >(SELECT AVG(buyPrice) FROM products)

-- NOMOR 2
SELECT o.orderNumber, o.orderDate
FROM orders AS o
JOIN customers c
ON o.customerNumber = c.customerNumber
WHERE c.salesRepEmployeeNumber IN (SELECT e.employeeNumber
FROM employees AS e
JOIN offices AS os
ON e.officeCode = os.officeCode
WHERE os.city = 'Tokyo')

-- NOMOR 3
SELECT c.customerName, o.orderNumber, o.shippedDate, o.requiredDate,
GROUP_CONCAT(p.productName) AS products,
SUM(od.quantityOrdered) AS total_quantity_ordered,
CONCAT(e.firstName, ' ', e.lastName) AS employeeName
FROM customers AS c
JOIN orders AS o
ON c.customerNumber = o.customerNumber
JOIN orderdetails AS od
ON o.orderNumber = od.orderNumber
JOIN products AS p
ON od.productCode = p.productCode
JOIN employees AS e
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE o.orderNumber IN (SELECT orderNumber FROM orders WHERE shippedDate > requiredDate)



-- NOMOR 4 
SELECT p.productName, p.productLine,
SUM(od.quantityOrdered) AS total_quantity_ordered
FROM products p
JOIN orderdetails od
ON p.productCode = od.productCode
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
	) AS zzzz 
)
GROUP BY productName, productline
ORDER BY productline, total_quantity_ordered DESC

-- TUGAS TAMBAHAN
SELECT c.customerNumber, c.customerName, py.amount
FROM customers AS c
JOIN payments AS py
ON c.customerNumber = py.customerNumber
WHERE amount > (SELECT AVG(amount) FROM payments)
ORDER BY amount DESC;
