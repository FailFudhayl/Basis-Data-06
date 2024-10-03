USE models;

-- no1
SELECT customerNumber, customerName, country
FROM customers
WHERE 
  (country = 'USA' AND creditLimit > 50000 AND creditLimit < 100000)
  OR (country != 'USA' AND creditLimit >= 100000 AND creditLimit <= 200000)
ORDER BY creditLimit DESC;

-- no2
SELECT productCode, productName, quantityInStock, buyPrice
FROM products
WHERE 
  quantityInStock BETWEEN 1000 AND 2000
  AND (buyPrice < 50 OR buyPrice > 150)
  AND productLine NOT LIKE '%Vintage%';

-- no3
SELECT productCode, productName, MSRP
FROM products
WHERE 
	productLine LIKE '%Classic%' 
	AND buyPrice > 50;

-- no4
SELECT orderNumber, orderDate, STATUS, customerNumber
FROM orders
WHERE 
	orderNumber > 10250
	AND STATUS != 'Shipped' AND  STATUS !='Cancelled'
	AND (
		(orderDate BETWEEN  '2002-01-01' AND '2002-12-31')
		OR (orderDate BETWEEN '2004-01-01' AND '2004-12-31'));

-- no5
SELECT orderNumber, orderLineNumber, productCode, quantityOrdered, priceEach,  (quantityOrdered * priceEach * (1 - 0.05)) AS discountedTotalPrice
FROM orderdetails
WHERE 
	quantityOrdered > 50
	AND priceEach > 100
	AND productCode NOT LIKE 'S18%'
ORDER BY discountedTotalPrice DESC;


