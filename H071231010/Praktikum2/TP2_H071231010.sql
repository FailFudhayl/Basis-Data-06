-- no 1
SELECT 
	productcode AS "Kode Produk" , 
	productname AS "Nama Produk", 
	quantityinstock AS "Jumlah Stok" 
	FROM products
WHERE quantityinstock >= 5000 AND quantityinstock <= 6000;

-- no 2
SELECT 
	ordernumber AS "Nomor Pesanan", 
	orderdate AS "Tanggal Pesanan", 
	STATUS, 
	customernumber 
	FROM orders 
WHERE STATUS != 'shipped'
ORDER BY customernumber; 

-- no 3
SELECT 
	employeenumber AS "Nomor Karyawan",
	firstname, 
	lastname, 
	email, 
	jobtitle AS Jabatan 
	FROM employees
WHERE jobtitle = 'Sales Rep'
ORDER BY firstname ASC
LIMIT 10;

-- no 4
SELECT 
	productcode AS "Kode Produk", 
	productname AS "Nama Produk", 
	productline AS "Lini Produk", 
	buyprice AS "Harga Beli" 
	FROM products
ORDER BY buyprice DESC
LIMIT 5,10;

-- no 5
SELECT distinct country, city FROM customers
ORDER BY country, city;
