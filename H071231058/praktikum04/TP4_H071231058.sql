-- Nama: Destin Kendenan
-- NIM: H071231058

-- nomor 1
SELECT customerNumber, customerName, country 
FROM customers
WHERE country = 'USA' 
		AND creditlimit > 50000 
		AND creditlimit < 100000
		OR 
		country NOT IN ('usa') 
		AND creditlimit >= 100000 
		AND creditlimit <= 200000
ORDER BY creditlimit DESC;

-- nomor 2
SELECT productCode, productName, quantityInStock, buyPrice 
FROM products 
WHERE quantityinstock >= 1000 
		AND quantityinstock <= 2000
		AND buyprice < 50 
		OR  buyprice > 150
		AND productline NOT LIKE 'vintage%';

-- nomor 3
SELECT productCode, productName, MSRP 
FROM products 
WHERE productline LIKE 'classic%' 
		AND buyprice > 50;
		
-- nomor 4
SELECT orderNumber, orderDate, status, customerNumber
FROM orders
WHERE ordernumber > 10250
		AND STATUS NOT IN ('shipped', 'cancelled')
		AND ((orderdate BETWEEN '2002-01-01' AND '2002-12-31') 
		OR (orderdate BETWEEN '2004-01-01' AND '2004-12-31'));

-- nomor 5
SELECT orderNumber, orderLineNumber, productCode, quantityOrdered, priceEach, 
((priceeach*quantityordered) - (5/100 * priceeach*quantityordered)) AS discountedTotalPrice 
FROM orderdetails
WHERE quantityordered > 50
		AND priceeach > 100
		AND productcode NOT LIKE 's18%'
ORDER BY discountedtotalprice DESC;
		