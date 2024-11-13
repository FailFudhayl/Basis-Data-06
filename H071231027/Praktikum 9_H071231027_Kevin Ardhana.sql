-- Nomor 1
CREATE DATABASE manajemen_tim_sepakbola;

CREATE TABLE klub(
id INT(10) PRIMARY KEY AUTO_INCREMENT,
nama_klub VARCHAR(50) NOT NULL,
kota_asal VARCHAR(20) NOT NULL
);

CREATE TABLE pemain(
id INT(10) PRIMARY KEY AUTO_INCREMENT,
nama_pemain VARCHAR(50) NOT NULL,
posisi VARCHAR(20) NOT NULL,
id_klub INT(10),
FOREIGN KEY(id_klub) REFERENCES klub(id)
);

CREATE TABLE pertandingan(
id INT(10) PRIMARY KEY AUTO_INCREMENT,
id_klub_tuan_rumah INT(10),
FOREIGN KEY(id_klub_tuan_rumah) REFERENCES pemain(id_klub),
id_klub_tamu INT(10),
FOREIGN KEY(id_klub_tamu) REFERENCES klub(id),
tanggal_pertandingan DATE NOT NULL,
skor_tuan_rumah INT(10) DEFAULT 0,
skor_tamu INT(10) DEFAULT 0
);

ALTER TABLE pemain
ADD INDEX index_posisi(posisi);

ALTER TABLE klub
ADD INDEX index_kota_asal(kota_asal);

DESCRIBE klub;
DESCRIBE pemain;

DROP DATABASE manajemen_tim_sepakbola;

USE classicmodels

-- Nomor 2
SELECT 
	c.customerName, 
	c.country, 
	SUM(p.amount)*COUNT(p.amount) AS TotalPayment, 
	COUNT(p.amount)*COUNT(p.amount) AS orderCount, 
	MAX(p.paymentDate) AS LastPaymentDate,
case
when SUM(p.amount)*COUNT(p.amount) > 100000 then 'VIP'
when SUM(p.amount)*COUNT(p.amount >= 5000 AND SUM(p.amount)*COUNT(p.amount) <= 100000 then 'Loyal'
ELSE 'New'
END AS Status
FROM customers c
LEFT JOIN payments p
USING(customernumber)
GROUP BY c.customerName;

SELECT 
    customerName,
    country,
    FORMAT(SUM(amount), 2) AS totalPayment,
    COUNT(orderNumber) AS orderCount,
    MAX(paymentDate) AS LastPaymentDate,
    CASE 
        WHEN SUM(amount) > 100000 THEN 'VIP'
        WHEN SUM(amount) BETWEEN 5000 AND 100000 THEN 'Loyal'
        ELSE 'New'
    END AS Status
FROM customers
LEFT JOIN payments USING (customerNumber)
LEFT JOIN orders USING (customerNumber)
GROUP BY customerName, country;

-- Nomor 3
SELECT c.customerNumber, c.customerName, SUM(od.quantityOrdered) AS total_quantity,
case
when SUM(od.quantityOrdered) > (SELECT AVG(total_quantity) 
										 FROM (SELECT SUM(od.quantityOrdered) AS total_quantity 
										 FROM customers c
										 JOIN orders o
										 USING(customernumber)
										 JOIN orderdetails od
										 USING(ordernumber)
										 GROUP BY c.customerName)AS jumlah) then  'di atas rata-rata'
ELSE 'di bawah rata-rata'
END AS kategori_pembelian
FROM customers c
JOIN orders o
USING(customernumber)
JOIN orderdetails od
USING(ordernumber)
GROUP BY c.customerName
ORDER BY total_quantity DESC;


