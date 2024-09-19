USE classicmodels;

--1
SELECT productcode AS 'Kode Produk', productname AS 'Nama Produk', quantityinstock AS 'Jumlah Stok' 
FROM products WHERE quantityinstock >= 5000 AND quantityinstock <= 7000

--2
SELECT  ordernumber AS 'Nomor Pesanan', orderdate AS 'Tanggal Pesanan', STATUS, customernumber AS 'Nomor Pelanggan' 
FROM orders WHERE STATUS != 'shipped' ORDER BY customernumber ASC;

--3
SELECT employeenumber AS 'Nomor Karyawan', firstname , lastname, email, jobtitle AS Jabatan 
FROM employees WHERE jobtitle = 'sales rep' ORDER BY firstname ASC LIMIT 10;

--4
SELECT productcode AS 'Kode Produk', productname AS 'Nama Produk', productline AS 'Lini Product' , buyprice AS 'Harga Beli' 
FROM products ORDER BY buyprice DESC LIMIT 10 OFFSET 5;

--5
SELECT DISTINCT country, city FROM customers ORDER BY country ASC, city ASC;