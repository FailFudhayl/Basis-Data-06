USE classicmodels;
-- No 1
SELECT 
	productCode AS "Kode Produk",
	productName AS "Nama Produk",
	quantityInStock AS "Jumlah Stok"
FROM products
WHERE quantityInStock >= 5000 AND quantityInStock<= 6000;

-- No 2
SELECT 
	orderNumber AS "Nomor Pesanan",
	orderDate AS "Tanggal Pesanan",
	status,
	customerNumber AS "Nomor Pelanggan"
FROM orders
WHERE STATUS <> "shipped"
ORDER BY customerNumber;

-- No 3
SELECT 
	employeeNumber AS "Nomor Karyawan",
	firstName,
	lastName,
	email,
	jobTitle AS "Jabatan"
FROM employees
WHERE jobTitle = "Sales Rep"
ORDER BY firstName
LIMIT 10;

-- No 4
SELECT
	productCode AS "Kode Produk",
	productName AS "Nama Produk",
	productLine AS "Lini Produk",
	buyPrice AS "Harga Beli"
FROM products
ORDER BY buyPrice DESC
LIMIT 10 OFFSET 5;

-- No 5
SELECT DISTINCT 
	country,
	city
FROM customers
ORDER BY country, city;

-- soal tambahan
-- no 1
SELECT 
	officeCode,
	firstName,
	lastName
FROM employees
WHERE officeCode = "1"
ORDER BY firstName;

-- No 2
SELECT 
	productCode,
	productName
	buyPrice 
FROM products
WHERE buyPrice BETWEEN 30 AND 60 
ORDER BY buyPrice;
