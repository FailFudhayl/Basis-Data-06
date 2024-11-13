-- nomor 1
(SELECT 
	productName, 
	SUM(priceEach * quantityOrdered) AS Revenue, 
	'Pendapatan Tinggi' AS Pendapatan
FROM products
JOIN orderdetails USING (productCode)
JOIN orders USING (orderNumber)
WHERE month(orderDate) = 9
GROUP BY productName
ORDER BY Revenue DESC 
LIMIT 5)

UNION

(SELECT 
	productName, 
	SUM(priceEach * quantityOrdered) AS Revenue, 
	'Pendapatan Pendek (kayak kamu)' AS Pendapatan
FROM products
JOIN orderdetails USING (productCode)
JOIN orders USING (orderNumber)
WHERE month(orderDate) = 9
GROUP by productName
ORDER BY Revenue
LIMIT 5);

-- nomor 2
SELECT productName FROM products

EXCEPT 

(SELECT productName FROM products
JOIN orderdetails USING (productCode)
JOIN orders USING (orderNumber)
JOIN customers c USING (customerNumber)
WHERE c.customerNumber IN (
	SELECT customerNumber FROM customers
	JOIN orders USING (customerNumber)
	JOIN orderdetails USING (orderNumber)
	JOIN products USING (productCode)
	where buyPrice > (SELECT AVG(buyPrice) FROM products)
	GROUP BY customerNumber
	having COUNT(DISTINCT orderNumber) > 10));

-- nomor 3
SELECT customerName
FROM customers
JOIN payments USING (customerNumber)
GROUP BY customerName
HAVING SUM(amount) > 2 * (
    SELECT AVG(totalAverage)
    FROM (
        SELECT SUM(amount) AS totalAverage
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
WHERE productLine ='Planes' OR productLine = 'Trains'
GROUP BY customerName
HAVING SUM(quantityOrdered * priceEach) > 20000

-- nomor 4
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

-- nomor 5
SELECT DISTINCT productCode FROM products
JOIN orderdetails USING(productCode)
WHERE priceEach > (
    SELECT AVG(priceEach) FROM orderdetails
    JOIN orders USING(orderNumber)
    WHERE orderDate BETWEEN '2001-01-01' and '2004-03-31'
)
AND quantityOrdered > 48
AND LEFT(productVendor, 1) IN ('A', 'I', 'U','E','O')

EXCEPT

SELECT DISTINCT productCode FROM products
JOIN orderdetails USING(productCode)
JOIN orders USING(orderNumber)
JOIN customers USING (customerNumber)
WHERE country IN ("Japan", "Germany", "Italy");

