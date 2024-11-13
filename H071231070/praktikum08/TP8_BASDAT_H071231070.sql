-- NOMOR 1 : Mengambil produk dengan pendapatan tertinggi dan terendah di bulan September
USE classicmodels;

(SELECT productName, 
SUM(priceEach * quantityOrdered) AS TotalRevenue, 
'Pendapatan Tinggi' AS Pendapatan
FROM products 
JOIN orderdetails USING(productCode)
JOIN orders USING(orderNumber)
WHERE MONTH(orderDate) = 09
GROUP BY productName
ORDER BY TotalRevenue DESC LIMIT 5)
UNION 
(SELECT productName, 
SUM(priceEach * quantityOrdered) AS TotalRevenue, 
'Pendapatan Pendek (kayak kamu)' AS Pendapatan
FROM products 
JOIN orderdetails USING(productCode)
JOIN orders USING(orderNumber)
WHERE MONTH(orderDate) = 09
GROUP BY productName
ORDER BY TotalRevenue ASC LIMIT 5);



-- NOMOR 2 : Produk yang tidak dibeli lebih dari 10 pesanan
SELECT productName FROM products 
EXCEPT 
SELECT DISTINCT p.productName FROM products p
JOIN orderdetails od USING(productCode)
JOIN orders o USING(orderNumber)
JOIN customers c USING(customerNumber)
WHERE c.customerNumber IN(
	SELECT c2.customerNumber FROM customers c2
	JOIN orders o2 USING(customerNumber)	
	JOIN orderdetails od2 USING(orderNumber)
	WHERE od2.priceEach > (
		SELECT AVG(priceeach) FROM orderdetails
	)
	GROUP BY c2.customerNumber
	HAVING COUNT(DISTINCT o2.orderNumber) > 10
);



-- NOMOR 3 : Pelanggan dengan pembelian produk bertipe "Planes" atau "Trains" dengan nilai transaksi tinggi
SELECT c.customerName FROM customers c
JOIN payments py USING(customerNumber)
JOIN orders o USING(customerNumber)
JOIN orderdetails od USING(orderNumber)
JOIN products pr USING(productCode) 
WHERE pr.productLine LIKE '%Planes%'
GROUP BY c.customerNumber
HAVING SUM(py.amount) > (
	SELECT AVG(amount) * 2 FROM payments -- total amount lebih dari 2 kli rata2
) 
AND SUM(od.priceEach) > 20000
UNION 
SELECT c.customerName FROM customers c
JOIN payments py USING(customerNumber)
JOIN orders o USING(customerNumber)
JOIN orderdetails od USING(orderNumber)
JOIN products pr USING(productCode) 
WHERE pr.productLine LIKE '%Trains%'
GROUP BY c.customerNumber
HAVING SUM(py.amount) > (
	SELECT AVG(amount) * 2 FROM payments 
) 
AND SUM(od.priceEach) > 20000;



-- NOMOR 4 : Riwayat transaksi pelanggan di bulan September 2003
(SELECT DISTINCT o.orderdate AS Tanggal, c.customerNumber, 
'Membayar Pesanan dan Memesan Barang' AS riwayat  
FROM customers c 
JOIN orders o USING(customerNumber)
JOIN payments p ON o.orderDate = p.paymentDate 
WHERE o.orderdate LIKE '%2003-09%'
UNION 
SELECT orderDate AS Tanggal, customerNumber,
'Memesan Barang' AS riwayat
FROM orders 
WHERE orderDate LIKE '%2003-09%'
AND orderdate NOT IN (
	SELECT paymentdate FROM payments 
)
UNION 
SELECT paymentDate AS Tanggal, customerNumber,
'Membayar Barang' AS riwayat
FROM payments 
WHERE paymentdate LIKE '%2003-09%' 
AND paymentDate NOT IN (
	SELECT orderdate FROM orders 
))
ORDER BY Tanggal;



-- NOMOR 5 : Produk dengan harga beli di atas rata-rata dan kuantitas pemesanan tinggi, kecuali yang dijual di Jepang, Jerman, atau Italia
(SELECT pr.productCode FROM products pr
JOIN orderdetails od USING(productCode)
JOIN orders o USING(orderNumber)
WHERE pr.buyPrice > (
	SELECT AVG(pr.buyprice) FROM products pr
	JOIN orderdetails od USING(productCode)
	JOIN orders o USING(orderNumber)
	WHERE orderdate BETWEEN '2001-01-01' AND '2004-03-31'
)
AND od.quantityOrdered > 48
AND LEFT (pr.productVendor, 1) IN ('a', 'i', 'u', 'e', 'o')
EXCEPT 
SELECT pr.productCode FROM products pr
JOIN orderdetails od USING(productCode)
JOIN orders o USING(orderNumber)
JOIN customers c USING(customerNumber)
WHERE c.country IN ('Japan', 'Germany', 'Italy'))
ORDER BY productcode;