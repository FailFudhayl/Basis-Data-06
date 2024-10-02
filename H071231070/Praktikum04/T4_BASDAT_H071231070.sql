USE classicmodels

-- Nomor 1
SELECT 
	customerNumber,
	customerName,
	country,
	creditLimit 
FROM customers 
WHERE (country = 'USA' AND creditLimit > 50000 AND creditLimit < 100000) OR (country != 'USA' AND creditLimit BETWEEN 100000 AND 200000)
ORDER BY creditLimit DESC;


-- Nomor 2
SELECT 
	productCode,
	productName,
	quantityinstock,
	buyprice
FROM products
WHERE quantityinstock BETWEEN 1000 AND 2000
AND buyprice < 50 OR  buyprice > 150
AND productline NOT LIKE  'vintage%';

-- Nomor 3
SELECT 
	productCode,
	productName,
	MSRP
FROM products
WHERE productline LIKE '%Classic%' 
AND buyprice > 50;

-- Nomor 4
SELECT 
	orderNumber,
	orderDate,
	STATUS,
	customerNumber
FROM orders
WHERE orderNumber > 10250
AND status NOT IN  ('Shipped', 'Cancelled')
AND orderDate BETWEEN '2003-12-31' AND '2006-01-01';

-- Nomor 5
SELECT 
	orderNumber,
	orderlineNumber,
	productcode,
	quantityordered,
	priceEach,(quantityordered * priceEach * 0.95)
	discountedTotalprice
FROM orderdetails 
WHERE quantityordered > 50 AND priceEach > 100
AND productcode NOT LIKE 'S18%'
ORDER BY discountedTotalprice DESC;
	

SELECT*FROM customers	
SELECT*FROM products