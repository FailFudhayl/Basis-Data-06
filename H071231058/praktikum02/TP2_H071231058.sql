-- Nama: Destin Kendenan
-- NIM : H071231058

-- nomor 1
SELECT productCode AS 'Kode Produk', productName AS 'Nama Produk', quantityInStock AS 'Jumlah Stok' FROM products
WHERE quantityInStock >= 5000 AND quantityInStock <= 6000;

-- nomor 2
SELECT orderNumber AS 'Nomor Pesanan', orderDate AS 'Tanggal Pesanan', status, customerNumber AS 'Nomor Pelanggan' FROM orders
WHERE STATUS != 'Shipped'
ORDER BY customerNumber;

-- nomor 3
SELECT employeeNumber AS 'Nomor Karyawan', firstName, lastName, email, jobTitle AS Jabatan FROM employees
WHERE jobTitle = 'Sales Rep'
ORDER BY firstName 
LIMIT 10;

-- nomor 4
SELECT productCode AS 'Kode Produk', productName AS 'Nama Produk', productLine AS 'Lini Produk', buyPrice AS 'Harga Beli' FROM products
ORDER BY buyPrice DESC
LIMIT 10 OFFSET 5;

-- nomor 5
SELECT distinct country, city FROM customers
ORDER BY country, city;

