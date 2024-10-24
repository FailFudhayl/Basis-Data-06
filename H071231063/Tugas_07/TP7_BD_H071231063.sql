-- 1
SELECT p.productCode, p.productName, p.buyPrice
FROM products AS p
WHERE p.buyPrice > (SELECT AVG(p.buyPrice) FROM products AS p);

-- 2
SELECT o.orderNumber, o.orderDate
FROM orders AS o
JOIN customers AS c USING(customerNumber)
WHERE c.salesRepEmployeeNumber IN (
   SELECT e.employeeNumber
   FROM employees AS e
   WHERE e.officeCode = (SELECT officeCode FROM offices WHERE city = 'Tokyo')
);

-- 3
SELECT  
   c.customerName,
   o.orderNumber,
   o.shippedDate,
   o.requiredDate,
   GROUP_CONCAT(p.productName) AS `psroducts`,
   SUM(od.quantityOrdered) AS `total_quantity_ordered`,
   CONCAT(e.firstName, " ", e.lastName) AS `employeeName`
FROM customers AS c
JOIN  orders AS o ON o.customerNumber = c.customerNumber
JOIN orderdetails AS od ON o.orderNumber = od.orderNumber
JOIN products AS p ON p.productCode = od.productCode
JOIN employees AS e ON e.employeeNumber = c.salesRepEmployeeNumber
WHERE o.orderNumber IN (
	SELECT o.orderNumber FROM orders AS o 	
	WHERE o.shippedDate > o.requiredDate);

-- 4
SELECT 
   p.productName,
   p.productLine AS productCategory,
   SUM(od.quantityOrdered) AS totalQuantityOrdered
FROM products AS p
JOIN orderdetails AS od USING(productCode)
JOIN orders AS o USING(orderNumber)
GROUP BY p.productName, p.productLine
HAVING p.productLine IN (
   SELECT productLine
   FROM (
      SELECT p2.productLine
      FROM products AS p2
      JOIN orderdetails AS od2 USING(productCode)
      JOIN orders AS o2 USING(orderNumber)
      GROUP BY p2.productLine
      ORDER BY SUM(od2.quantityOrdered) DESC
      LIMIT 3
   ) AS topCategories
)
ORDER BY p.productLine, totalQuantityOrdered DESC;

SELECT p.productCode, 
AVG(od.quantityOrdered) AS avg_quantity_ordered
FROM products AS p 
JOIN orderdetails AS od USING(productCode)
JOIN orders AS o USING(orderNumber)
GROUP BY p.productCode
HAVING p.productCode IN (
	SELECT productCode 
	FROM (
		SELECT p2.productCode
		FROM products AS p2
		 JOIN orderdetails AS od2 USING(productCode)
      JOIN orders AS o2 USING(orderNumber)
      GROUP BY p2.productName
      ORDER BY AVG(od2.quantityOrdered) DESC
      LIMIT 10
	) AS topAvg
)ORDER BY avg_quantity_ordered DESC;