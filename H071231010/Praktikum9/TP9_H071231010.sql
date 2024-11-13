-- no1
CREATE DATABASE sepakbola;

USE sepakbola;

CREATE TABLE klub (
	id INT PRIMARY KEY AUTO_INCREMENT,
	nama_klub VARCHAR(50) NOT NULL,
	kota_asal VARCHAR(20) NOT NULL 
)

CREATE TABLE pemain (
	id INT PRIMARY KEY AUTO_INCREMENT,
	nama_pemain VARCHAR(50) NOT NULL,
	posisi VARCHAR(20) NOT NULL,
	id_klub INT,
	FOREIGN KEY (id_klub) REFERENCES klub(id) 
)

CREATE TABLE pertandingan (
	id INT PRIMARY KEY AUTO_INCREMENT,
	id_klub_tuan_rumah INT,
	id_klub_tamu INT,
	tanggal_pertandingan DATE NOT NULL,
	skor_tuan_rumah INT DEFAULT 0,
	skor_tamu INT DEFAULT 0,
	FOREIGN KEY (id_klub_tuan_rumah) REFERENCES klub(id),
	FOREIGN KEY (id_klub_tamu) REFERENCES klub(id)
)

CREATE INDEX index_posisi ON pemain(posisi);
DESCRIBE pemain;

CREATE INDEX index_kotaAsal ON klub(kota_asal);
DESCRIBE klub;

-- no2
SELECT 
    c.customerName AS NamaPelanggan,
    c.country AS NegaraAsal,
    FORMAT(SUM(p.amount), 2) AS TotalPayment,
    COUNT(o.orderNumber) AS JumlahPesanan,
    MAX(p.paymentDate) AS TanggalPembayaranTerakhir,
    CASE 
        WHEN SUM(p.amount) > 100000 THEN 'VIP'
        WHEN SUM(p.amount) BETWEEN 5000 AND 10000 THEN 'Loyal'
        ELSE 'New'
    END AS StatusPelanggan
FROM customers c
LEFT JOIN payments p USING(customerNumber)
LEFT JOIN orders o USING(customerNumber)
GROUP BY c.customerName, c.country
ORDER BY c.customerName;

-- no3
SELECT 
    c.customerNumber,
    c.customerName,
    SUM(od.quantityOrdered) AS total_quantity,
    CASE 
        WHEN SUM(od.quantityOrdered) > (
            SELECT AVG(quantityOrdered) 
            FROM orderdetails
        ) THEN 'di atas rata-rata'
        ELSE 'di bawah rata-rata'
    END AS kategori_pembelian
FROM customers c
JOIN orders o USING(customerNumber)
JOIN orderdetails od USING(orderNumber)
GROUP BY c.customerNumber, c.customerName
ORDER BY total_quantity DESC;
  


