
-- NOMOR 1
CREATE DATABASE db_sepakbola;
USE db_sepakbola;

CREATE TABLE klub (
	id INT PRIMARY KEY AUTO_INCREMENT,
	nama_klub VARCHAR(50) NOT NULL,
	kota_asal VARCHAR(20) NOT NULL,
	INDEX index_kota_asal(kota_asal)
);

CREATE TABLE pemain (
	id INT PRIMARY KEY AUTO_INCREMENT,
	nama_pemain VARCHAR(50) NOT NULL,
	posisi VARCHAR(20) NOT NULL,
	id_klub INT, 
	FOREIGN KEY(id_klub) REFERENCES klub(id),
	INDEX index_posisi(posisi)
);

CREATE TABLE pertandingan (
	id INT PRIMARY KEY AUTO_INCREMENT,
	id_klub_tuan_rumah INT,
	FOREIGN KEY(id_klub_tuan_rumah) REFERENCES pemain(id_klub),
	id_klub_tamu INT,
	FOREIGN KEY(id_klub_tamu) REFERENCES klub(id),
	tanggal_pertandingan DATE NOT NULL,
	skor_tuan_rumah INT DEFAULT 0,
	skor_tamu INT DEFAULT 0
);

DESCRIBE klub;
DESCRIBE pertandingan;
DESCRIBE pemain;



USE classicmodels;
-- NOMOR 2
SELECT 
    c.customerName, 
    c.country, 
    ROUND(SUM(p.amount), 2) AS TotalPaymet, -- dihitung lalu dibulatkan ke 2 desimal
    COALESCE(COUNT(o.orderNumber), 0) AS orderCount, -- coalesce untuk mengembalkikan nilai null diganti sama 0
		MAX(p.paymentDate) AS LastPaymentDate,
    CASE 
        WHEN SUM(p.amount) > 100000 THEN 'VIP'
        WHEN SUM(p.amount) BETWEEN 5000 AND 100000 THEN 'Loyal'
        ELSE 'New'
    END AS Status
FROM customers c
LEFT JOIN payments p USING(customerNumber)
LEFT JOIN orders o USING(customerNumber)
GROUP BY c.customerNumber
ORDER BY c.customerName;


-- NOMOR 3
SELECT 
	c.customerNumber,
	c.customerName,
	SUM(od.quantityOrdered) AS total_quantity,
	case
	when SUM(od.quantityOrdered) > AVG(od.quantityOrdered) then 'di atas rata-rata'
	ELSE 'di bawah rata-rata'
	END AS kategori_pembelian
FROM customers c
JOIN orders o USING(customerNumber)
JOIN orderdetails od USING(orderNumber)
GROUP BY c.customerNumber
ORDER BY total_quantity DESC 


-- TUGAS TAMBAHAN
START TRANSACTION
SET autocommit = OFF

INSERT INTO klub(id, nama_klub, kota_asal) VALUES (1, 'timnas', 'wamena');

DELETE FROM klub WHERE  nama_klub = 'timnas';

ROLLBACK;

SELECT*FROM klub;
