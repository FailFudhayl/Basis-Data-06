classicmodelsUSE classicmodels;

-- NO 1
SELECT 
	customerNumber,
	customerName,
	country
FROM customers
WHERE 
	(country = 'USA' AND 
	creditLimit BETWEEN 50000 AND 100000) OR 
	(country != 'USA' AND creditLimit BETWEEN 100000 AND 200000)
ORDER BY creditLimit DESC;

-- No 2
SELECT
	productCode,
	productName,
	quantityInStock,
	buyPrice
FROM products
WHERE 
	(quantityInStock BETWEEN 1000 AND 2000 ) AND
	buyPrice < 50 OR buyprice > 150 AND 
	productLine NOT LIKE '%vintage%';

-- NO 3
SELECT
	productCode,
	productName,
	MSRP
FROM products
WHERE
	productLine LIKE '%Classic%' AND 
	buyPrice > 50;

-- No 4
SELECT 
	orderNumber,
	orderDate,
	STATUS,
	customerNumber
FROM orders
WHERE 
	(orderNumber > 10250) and
	(STATUS != 'Shipped' AND  STATUS != 'Cancelled') and
	(orderDate LIKE '2004' OR '2005');

-- No 5
SELECT
	orderNumber, 
	orderLineNumber,
	productCode,
	quantityOrdered,
	priceEach,
	(priceEach * quantityOrdered) * 0.95 AS discountedTotalPrice
FROM orderdetails
WHERE 
	quantityOrdered > 50 and
	priceEach > 100 and
	productCode NOT LIKE 'S18%'
ORDER BY discountedTotalPrice;