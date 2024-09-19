SELECT * FROM products
ORDER BY msrp ASC;
SELECT * FROM customers;
SELECT * FROM employees;
SELECT * FROM products;

 
-- Nomor 1
SELECT productCode AS 'Kode produk', productName AS 'Nama Produk', quantityinstock AS 'Jumlah Stok'
FROM products
WHERE quantityinstock >= 5000 AND quantityinstock <= 6000;

-- Nomor 2
SELECT ordernumber AS 'Nomor pesanan', orderdate AS 'Tanggal pesanan', STATUS, customernumber 'Nomor pelanggan' 
FROM orders
WHERE STATUS != 'shipped'
ORDER BY customernumber;

-- Nomor 3
SELECT employeenumber AS 'Nomor karyawan', firstname, lastname, email, jobtitle 'jabatan'
FROM employees
WHERE jobtitle ='sales rep'
ORDER BY firstname 
LIMIT 10;

-- Nomor 4
SELECT productCode AS 'Kode produk', productName AS 'Nama Produk', productline AS 'Lini produk', buyprice AS 'Harga beli'
FROM products
ORDER BY buyprice DESC 
LIMIT 10 OFFSET 5;

-- Nomor 5
SELECT DISTINCT  country, city
FROM customers
ORDER  BY country, city;

SELECT orderdate, ordernumber
FROM orders 
ORDER BY orderdate DESC 
LIMIT 5 OFFSET 5;
