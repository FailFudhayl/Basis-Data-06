-- No 1
SELECT 
	productCode,
	productName,
	buyPrice
FROM products
WHERE buyPrice > (SELECT AVG(buyPrice) FROM products);
 
--  No 2
SELECT 
	orderNumber,
	orderDate
FROM orders
JOIN customers
ON customers.customerNumber = orders.customerNumber
JOIN employees
ON customers.salesRepEmployeeNumber = employees.employeeNumber
JOIN offices
ON employees.officeCode = offices.officeCode
WHERE offices.city IN 
(SELECT 
	city
FROM offices 
WHERE city = 'Tokyo');

-- No 3
SELECT distinct
	customerName,
	orders.orderNumber,
	shippedDate,
	requiredDate,
	group_concat(productName)AS 'products',
	SUM(quantityOrdered) AS total_quantity_ordered,
	CONCAT(firstName, ' ', lastName) AS employeeName
FROM customers 
JOIN employees
ON employees.employeeNumber = customers.salesRepEmployeeNumber
JOIN orders
ON orders.customerNumber = customers.customerNumber
JOIN orderdetails
on orderdetails.orderNumber = orders.orderNumber
JOIN products
ON products.productCode = orderdetails.productCode
WHERE orders.orderNumber IN (SELECT orderNumber FROM orders WHERE requiredDate < shippedDate);

-- No 4
SELECT 
   p.productName,
   p.productLine, 
   SUM(od.quantityOrdered) AS total_quantity_ordered
FROM products p
JOIN orderdetails od 
ON od.productCode = p.productCode
JOIN (
   SELECT 
      p2.productLine,
      SUM(od2.quantityOrdered) AS total_quantity_ordered
   FROM products p2
   JOIN orderdetails od2 
	ON od2.productCode = p2.productCode
   GROUP BY p2.productLine
   ORDER BY total_quantity_ordered DESC
   LIMIT 3
) AS top_categories 
ON p.productLine = top_categories.productLine
GROUP BY p.productName, p.productLine
ORDER BY p.productLine, total_quantity_ordered DESC;






 



