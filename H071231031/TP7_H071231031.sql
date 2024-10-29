USE classicmodels;

-- no 1

SELECT productCode, productName, buyPrice
FROM products
WHERE buyPrice > (
    SELECT AVG(buyPrice)
    FROM products);


SELECT e.employeeNumber, e.firstName, o.officeCode, o.city, o.country
FROM employees e
JOIN offices o ON e.officeCode = o.officeCode
WHERE o.city = 'Tokyo';

-- no 2
SELECT orders.orderNumber, orders.orderDate
FROM orders
WHERE orders.customerNumber IN (
    SELECT customers.customerNumber
    FROM customers
    WHERE customers.salesRepEmployeeNumber IN (
        SELECT employees.employeeNumber
        FROM employees
        WHERE employees.officeCode = '5' ));


-- no 3
SELECT 
customers.customerName AS customerName,
orders.orderNumber AS orderNumber,
orders.shippedDate AS shippedDate,
orders.requiredDate AS requiredDate,
orderDetails.products AS products,  
orderDetails.total_quantity_ordered AS totalQuantityOrdered,
CONCAT(employees.firstName, ' ', employees.lastName) AS employeeName
FROM orders
JOIN customers ON orders.customerNumber = customers.customerNumber
JOIN (SELECT 
         orderdetails.orderNumber AS orderNumber,
         GROUP_CONCAT(products.productName, ', ', products.productDescription) AS products,
         SUM(orderdetails.quantityOrdered) AS total_quantity_ordered
     FROM orderdetails
     JOIN products ON orderdetails.productCode = products.productCode
     GROUP BY orderdetails.orderNumber) AS orderDetails ON orders.orderNumber = orderDetails.orderNumber
JOIN employees ON customers.salesRepEmployeeNumber = employees.employeeNumber
WHERE orders.shippedDate > orders.requiredDate
ORDER BY orders.requiredDate;


-- no 4
SELECT products.productName,
productlines.productLine AS categoryName,
SUM(orderdetails.quantityOrdered) AS totalOrdered
FROM orderdetails
JOIN products ON orderdetails.productCode = products.productCode
JOIN productlines ON products.productLine = productlines.productLine
GROUP BY products.productName, productlines.productLine
HAVING productlines.productLine IN ( SELECT productLine
        FROM (SELECT productlines.productLine
            FROM productlines
            JOIN products ON productlines.productLine = products.productLine
            JOIN orderdetails ON products.productCode = orderdetails.productCode
            GROUP BY productlines.productLine
            ORDER BY SUM(orderdetails.quantityOrdered) DESC
            LIMIT 3) AS TopCategories)
ORDER BY productlines.productLine, totalOrdered DESC;


-- no5
SELECT productCode, avg_quantity_ordered
FROM(SELECT products.productCode, AVG(orderdetails.quantityOrdered) AS avg_quantity_ordered
		FROM orderdetails
		JOIN products ON orderdetails.productCode = products.productCode
		GROUP BY products.productCode) AS PP
		ORDER BY avg_quantity_ordered DESC LIMIT 10;