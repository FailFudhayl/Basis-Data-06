--  No 1
(SELECT 
    p.productCode,
    p.productName,
    SUM(od.quantityOrdered * od.priceEach) AS TotalRevenue,
    'Pendapatan Tinggi' AS Pendapatan
FROM 
    products p
JOIN 
    orderdetails od ON p.productCode = od.productCode
JOIN 
    orders o ON od.orderNumber = o.orderNumber
WHERE 
    MONTH(o.orderDate) = 9 
GROUP BY 
    p.productCode, p.productName
ORDER BY 
    TotalRevenue DESC
LIMIT 5)

UNION 

(SELECT 
    p.productCode,
    p.productName,
    SUM(od.quantityOrdered * od.priceEach) AS TotalRevenue,
    'Pendapatan Rendah' AS Pendapatan
FROM 
    products p
JOIN 
    orderdetails od ON p.productCode = od.productCode
JOIN 
    orders o ON od.orderNumber = o.orderNumber
WHERE 
    MONTH(o.orderDate) = 9 
GROUP BY 
    p.productCode, p.productName
ORDER BY 
    TotalRevenue ASC
LIMIT 5);

-- No 2
SELECT productName 
FROM products
WHERE productCode NOT IN (
    SELECT od.productCode 
    FROM orderdetails od
    JOIN orders o ON od.orderNumber = o.orderNumber
    WHERE o.customerNumber IN (
        SELECT c.customerNumber 
        FROM customers c
        JOIN orders o ON c.customerNumber = o.customerNumber
        GROUP BY c.customerNumber
        HAVING COUNT(o.orderNumber) > 10
        
        INTERSECT 
        
        SELECT c.customerNumber 
        FROM customers c
        JOIN orders o ON c.customerNumber = o.customerNumber
        JOIN orderdetails od ON o.orderNumber = od.orderNumber
        JOIN products p ON od.productCode = p.productCode
        WHERE p.buyPrice > (SELECT AVG(buyPrice) FROM products)
    )
);


-- No 3
SELECT 
	customerName
FROM customers

INTERSECT

SELECT
	customerName
FROM 
	(select
	customerName, sum(amount) AS totalPembayaran, productLine, SUM(buyprice) AS totalPembelian
FROM customers
JOIN payments
ON payments.customerNumber = customers.customerNumber
JOIN orders
ON orders.customerNumber = customers.customerNumber
JOIN orderdetails
ON orderdetails.orderNumber = orders.orderNumber
JOIN products
ON products.productCode = orderdetails.productCode
WHERE productLine = "Planes" OR productline = "Trains"
GROUP BY customerName
HAVING totalPembayaran > (
	SELECT 
		2*(AVG(amount))
	FROM payments) AND totalPembelian > 20000) AS a;



-- No 4

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
    'Membayar Pesanan' FROM payments
WHERE MONTH(paymentDate) = 09 AND YEAR(paymentDate) = 2003
AND paymentDate NOT IN (  
	SELECT p.paymentDate AS 'Tanggal'
	FROM orders o
	JOIN customers c USING (customerNumber)
	JOIN payments p ON o.orderDate = p.paymentDate
	HAVING MONTH(Tanggal) = 09 AND YEAR(Tanggal) = 2003
)
ORDER BY Tanggal;


-- No 5
SELECT p.productCode
FROM products p
JOIN orderdetails od
USING(productCode)
WHERE od.priceEach > (
    SELECT AVG(od2.priceEach) 
    FROM orderdetails od2
    JOIN orders o2 
    USING(orderNumber)
    WHERE o2.orderDate BETWEEN '2001-01-01' AND '2004-03-31'
) 
AND od.quantityOrdered > 48
AND LEFT(p.productVendor,1)  IN ('A', 'I', 'U', 'E', 'O')

EXCEPT

SELECT p.productCode 
FROM products p
JOIN orderdetails od
USING(productCode)
JOIN orders o 
USING(orderNumber)
JOIN customers c
USING(customerNumber)
WHERE c.country IN ('Japan', 'germany', 'Italy');	





	
	
	
	



