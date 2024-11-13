USE classicmodels;

SELECT * FROM customers;
SELECT * FROM employees;
SELECT * FROM offices;
SELECT * FROM orderdetails;
SELECT * FROM orders;
SELECT * FROM payments;
SELECT * FROM products;
SELECT * FROM productlines;

#1
(SELECT 
	productName, 
	SUM(priceEach * quantityOrdered) AS Revenue, 
	'Pendapatan Tertinggi' AS Pendapatan
FROM products
JOIN orderdetails USING (productCode)
JOIN orders USING (orderNumber)
WHERE month(orderDate) = 9
GROUP by productName
ORDER BY Revenue desc
LIMIT 5)

UNION

(SELECT 
	productName, 
	SUM(priceEach * quantityOrdered) AS Revenue, 
	'Pendapatan Terendah (kayak kamu)' AS Pendapatan
FROM products
JOIN orderdetails USING (productCode)
JOIN orders USING (orderNumber)
WHERE month(orderDate) = 9
GROUP by productName
ORDER BY Revenue asc
LIMIT 5);

#2
SELECT productName FROM products
WHERE productCode NOT in(
	select productCode from orderdetails 
	JOIN orders USING (orderNumber)
	WHERE customerNumber in
	(SELECT customerNumber FROM customers
	JOIN orders USING (customerNumber)
	GROUP BY customerName
	having COUNT(orderNumber) > 10
	
	intersect
	
	SELECT customerNumber FROM customers
	JOIN orders USING (customerNumber)
	JOIN orderdetails USING (orderNumber)
	JOIN products USING (productCode)
	WHERE buyPrice > (SELECT AVG(buyPrice) FROM products)));
	
#3
SELECT customerName
FROM customers
JOIN payments USING (customerNumber)
GROUP BY customerName
HAVING SUM(amount) > 2 * (
    SELECT AVG(totalAverage)
    FROM (
        SELECT DISTINCT SUM(amount) AS totalAverage
        FROM payments
        GROUP BY customerNumber
    ) AS hasil
)

INTERSECT

SELECT customerName
FROM customers
JOIN orders USING (customerNumber)
JOIN orderdetails USING (orderNumber)
JOIN products USING (productCode)
WHERE productLine IN('Planes', 'Trains')
GROUP BY customerName
HAVING SUM(quantityOrdered * priceEach) > 20000


#4
SELECT 
    o.orderDate AS 'Tanggal',
    c.customerNumber AS 'CustomerNumber',
    'Membayar Pesanan dan Memesan Barang' AS 'riwayat'
FROM orders o
JOIN customers c USING (customerNumber)
JOIN payments p ON o.orderDate = p.paymentDate
HAVING MONTH(Tanggal) = 09 AND YEAR(Tanggal) = 2003

UNION

SELECT 
    orderDate, 
    customerNumber,
    'Memesan Barang' 
FROM orders
WHERE MONTH(orderDate) = 09 AND YEAR(orderDate) = 2003
AND orderDate NOT IN (  
	SELECT o.orderDate AS 'Tanggal'
	FROM orders o
	JOIN customers c USING (customerNumber)
	JOIN payments p ON o.orderDate = p.paymentDate
	HAVING MONTH(Tanggal) = 09 AND YEAR(Tanggal) = 2003
)

UNION

SELECT 
    paymentDate, 
    customerNumber, 
    'Membayar Pesanan'  FROM payments
WHERE MONTH(paymentDate) = 09 AND YEAR(paymentDate) = 2003
AND paymentDate NOT IN (  
	SELECT p.paymentDate AS 'Tanggal'
	FROM orders o
	JOIN customers c USING (customerNumber)
	JOIN payments p ON o.orderDate = p.paymentDate
	HAVING MONTH(Tanggal) = 09 AND YEAR(Tanggal) = 2003
)
ORDER BY Tanggal;


#5
SELECT DISTINCT productCode FROM products
JOIN orderdetails USING(productCode)
WHERE priceEach > (
    SELECT AVG(priceEach) FROM orderdetails
    join orders USING(orderNumber)
    where orderDate BETWEEN '2001-01-01' and '2004-03-31'
)
AND quantityOrdered > 48
AND left(productVendor, 1) IN ('A', 'I', 'U','E','O')

except

SELECT DISTINCT productCode FROM products
JOIN orderdetails USING(productCode)
JOIN orders USING(orderNumber)
JOIN customers using(customerNumber)
WHERE country in ("Japan", "Germany", "Italy");