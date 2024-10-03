USE classicmodels;

SELECT productCode, productName, quantityInStock FROM products WHERE  quantityInStock BETWEEN 5000 AND 6000;

SELECT productCode AS "Kode Produk", 
productName AS "Nama Produk", 
quantityInStock AS "Jumlah Stok" 
FROM products WHERE  quantityInStock BETWEEN 5000 AND 6000;



SELECT orderNumber AS "Nomor Pesanan", 
orderDate AS "Tanggal Pesanan", 
STATUS, 
customerNumber AS "NOMOR PELANGGAN" 
FROM orders 
WHERE STATUS <> "shipped"
ORDER BY customerNumber 

SELECT employeeNumber AS "Nomor Karyawan", 
firstName , 
lastName, 
email, 
jobtitle AS "Jabatan" 
FROM employees 
WHERE jobtitle = "Sales Rep" 
ORDER BY firstName 
LIMIT 10;

SELECT productCode AS "Kode Produk", 
productName AS "Nama Produk", 
productLine AS "Lini Produk", 
buyPrice AS "Harga Beli"
FROM products 
ORDER BY buyPrice DESC
LIMIT 10 OFFSET 5;

SELECT DISTINCT country, city FROM customers ORDER BY country, city;

SELECT  productName AS "Nama Produk", 
buyPrice AS "Harga Beli" 
FROM products 
WHERE  buyPrice BETWEEN 50 AND 100
ORDER BY buyPrice asc;