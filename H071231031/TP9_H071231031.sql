#1
CREATE DATABASE sepakBola;

USE sepakBola;

CREATE TABLE klub(
	id INT AUTO_INCREMENT PRIMARY KEY,
	nama_klub VARCHAR(50) NOT NULL,
	kota_asal VARCHAR(20) NOT NULL
);

CREATE TABLE pemain (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nama_pemain VARCHAR(50) NOT NULL,
    posisi VARCHAR(20) NOT NULL,
    id_klub INT,
    FOREIGN KEY (id_klub) REFERENCES klub(id)
);

CREATE TABLE pertandingan(
	id INT AUTO_INCREMENT PRIMARY KEY,
	id_klub_tuan_rumah INT,
	id_klub_tamu INT,
	tanggal_pertandingan DATE NOT NULL,
	skor_tuan_rumah INT DEFAULT(0),
	skor_tamu INT DEFAULT(0),
	FOREIGN KEY(id_klub_tuan_rumah) REFERENCES pemain(id_klub),
	FOREIGN KEY(id_klub_tamu) REFERENCES klub(id)
);

ALTER TABLE pemain
ADD INDEX posisi (posisi);

ALTER TABLE klub
ADD INDEX kota_asal (kota_asal);

DESCRIBE klub;
DESCRIBE pemain;
DESCRIBE pertandingan;


INSERT INTO klub (nama_klub, kota_asal) VALUES ('Klub Pare', 'Kota Parepare');
INSERT INTO klub (nama_klub, kota_asal) VALUES ('Klub PSM', 'Kota Makassar');

INSERT INTO pemain (nama_pemain, posisi, id_klub) VALUES ('Ragilnata san', 'Striker', 1);
INSERT INTO pemain (nama_pemain, posisi, id_klub) VALUES ('Dulex Brutal', 'Penjaga Gawang', 2);

START TRANSACTION;
SET autocommit = 1;

UPDATE pemain SET posisi = 'Mid' WHERE nama_pemain = 'Dulex Brutal';

UPDATE pemain SET posisi = 'Penjaga Gawang' WHERE nama_pemain = 'Ragilnata san';

COMMIT;

ROLLBACK;
SELECT * FROM pemain;


###########

USE classicmodels;
SELECT * FROM customers;
SELECT * FROM employees;
SELECT * FROM offices;
SELECT * FROM orderdetails;
SELECT * FROM orders;
SELECT * FROM payments;
SELECT * FROM products;
SELECT * FROM productlines;

###########

#2
SELECT
    customerName,
    country,
    SUM(amount) AS totalPayment,
    COUNT(orderNumber) AS orderCount,
    MAX(paymentDate) AS LastPaymentDate,
    CASE
        WHEN SUM(amount) > 100000 THEN 'VIP'
        WHEN SUM(amount) > 5000  THEN 'Loyal'
        WHEN SUM(amount) < 5000 THEN 'New'
        ELSE 'New'
    END AS status
FROM customers
LEFT JOIN orders USING (customerNumber)
LEFT JOIN payments USING (customerNumber)
GROUP BY customerName, country;


#3
SELECT
	customerNumber,
	customerName,
	SUM(quantityOrdered) AS total_quantity,
	case
		when SUM(quantityOrdered)  > (SELECT AVG(quantityOrdered) FROM orderdetails) then 'di atas rata-rata'
		ELSE 'di bawah rata-rata'
	END AS kategori_pembelian
FROM customers
JOIN orders USING (customerNumber)
JOIN orderdetails USING (orderNumber)
GROUP by customerNumber
ORDER BY total_quantity DESC;