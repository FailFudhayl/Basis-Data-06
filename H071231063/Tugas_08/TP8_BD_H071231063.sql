-- Nomor 1
(SELECT p.productName, 
SUM(od.priceEach*(od.quantityOrdered)) AS TotalRevenue, 
'Pendapatan Tinggi' AS Pendapatan
 FROM products p 
JOIN orderdetails od USING (productCode)
 JOIN orders o USING(orderNumber)
 WHERE   MONTH(o.orderDate) = 9
 GROUP BY p.productName
 ORDER BY TotalRevenue DESC
 LIMIT 5)
 
UNION

(SELECT p.productName, 
(od.priceEach * SUM(od.quantityOrdered)) AS TotalRevenue, 
'Pendapatan Pendek' AS Pendapatan
FROM products p
JOIN orderdetails od USING (productCode)
JOIN orders o USING (orderNumber)
WHERE MONTH(o.orderDate) = 9 
GROUP BY p.productName
ORDER BY TotalRevenue ASC
LIMIT 5);

-- Nomor 2
SELECT productName FROM products

EXCEPT

SELECT productName FROM products
JOIN orderdetails USING(productCode)
JOIN orders USING(orderNumber)
JOIN customers c USING(customerNumber)
WHERE c.customerNumber IN(
SELECT customerNumber
FROM customers
JOIN orders USING(customerNumber)
JOIN orderdetails USING(orderNumber)
JOIN products USING(productCode)
WHERE buyPrice < (SELECT AVG(buyPrice) FROM products)
GROUP BY customerNumber
HAVING COUNT(DISTINCT orderNumber) > 10);

-- Nomor 3
SELECT c.customerName
FROM customers c
JOIN payments pa USING(customerNumber)
JOIN orders o USING(customerNumber)
JOIN orderdetails od USING(orderNumber)
JOIN products p USING(productCode)
WHERE p.productLine ='Planes'
GROUP BY c.customerName
HAVING SUM(pa.amount) > (2 * AVG(pa.amount)) 
AND SUM(od.quantityOrdered * od.priceEach) > 20000

INTERSECT

SELECT c.customerName
FROM customers c
JOIN payments pa USING(customerNumber)
JOIN orders o USING(customerNumber)
JOIN orderdetails od USING(orderNumber)
JOIN products p USING(productCode)
WHERE p.productLine ='Trains'
GROUP BY c.customerName
HAVING SUM(pa.amount) > (2 * AVG(pa.amount)) 
and SUM(od.quantityOrdered * od.priceEach) > 20000;

-- Nomor 4
SELECT o.orderDate AS 'Tanggal',
c.customerNumber AS 'CustomerNumber',
'Membayar Pesanan dan Memesan Barang' AS 'riwayat'
FROM orders o
JOIN customers c USING (customerNumber)
JOIN payments p ON o.orderDate = p.paymentDate
WHERE o.orderDate LIKE '2003-09%'

UNION

SELECT orderDate, 
customerNumber,
'Memesan Barang' 
FROM orders
WHERE orderDate LIKE '2003-09%'
AND orderDate NOT IN(  
SELECT o.orderDate AS 'Tanggal'
FROM orders o
JOIN customers c USING (customerNumber)
JOIN payments p ON o.orderDate = p.paymentDate
WHERE o.orderDate LIKE '2003-09%'
)

UNION

SELECT paymentDate, 
customerNumber, 
'Membayar Pesanan' 
FROM payments 
WHERE paymentDate LIKE '2003-09%'
AND paymentDate NOT IN (  
SELECT p.paymentDate AS 'Tanggal'
FROM orders o
JOIN customers c USING (customerNumber)
JOIN payments p ON o.orderDate = p.paymentDate
WHERE o.orderDate LIKE '2003-09%'
)
ORDER BY Tanggal;

-- Nomor 5
SELECT p.productCode
FROM products p
JOIN orderdetails od USING(productCode)
JOIN orders o USING(orderNumber)  
WHERE od.priceEach > (SELECT AVG(od.priceEach) FROM orderdetails od 
WHERE o.orderDate BETWEEN '2001-01-01' AND '2004-03-31') 
AND od.quantityOrdered > 48 
AND LEFT(p.productVendor , 1) IN ('A', 'I', 'U', 'E', 'O')

EXCEPT

SELECT p.productCode
FROM products p
JOIN orderdetails od USING(productCode)
JOIN orders o USING(orderNumber)  
JOIN customers c USING(customerNumber)
WHERE c.country IN ('Japan', 'Germany', 'Italy')
ORDER BY productCode ASC;
