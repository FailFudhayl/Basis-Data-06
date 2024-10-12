USE classicmodels;

SELECT DISTINCT products.productName AS NamaProduk, products.productDescription AS textDescription, customers.customerName AS NamaKustomer
FROM products
JOIN orderdetails ON products.productCode = orderdetails.productCode
JOIN orders ON orderdetails.orderNumber = orders.orderNumber
JOIN customers ON orders.customerNumber = customers.customerNumber
WHERE products.productName LIKE '%Titanic%'
ORDER BY customers.customerName ASC;


SELECT customers.customerName AS NamaPelanggan,        
products.productName AS NamaProduk,        
orders.status AS StatusPesanan,        
orders.shippedDate AS TanggalPengiriman
FROM customers
JOIN orders ON customers.customerNumber = orders.customerNumber
JOIN orderdetails ON orders.orderNumber = orderdetails.orderNumber
JOIN products ON orderdetails.productCode = products.productCode
WHERE products.productName LIKE '%Ferrari%' AND orders.status = 'Shipped'AND orders.shippedDate BETWEEN '2003-10-01' AND '2004-09-30'
ORDER BY orders.shippedDate DESC;

SELECT supervisor.firstName AS Supervisor, employees.firstName AS Karyawan
FROM employees
JOIN employees supervisor ON employees.reportsTo = supervisor.employeeNumber
WHERE supervisor.firstName = 'Gerard'
ORDER BY employees.lastName ASC, employees.firstName ASC;

SELECT customers.customerName AS customerName,    
payments.paymentDate AS paymentDate,    
employees.firstName AS employeeName,    
payments.amount AS amount
FROM payments
JOIN customers ON payments.customerNumber = customers.customerNumber
JOIN orders ON payments.customerNumber = orders.customerNumber
JOIN employees ON orders.customerNumber = employees.employeeNumber
WHERE payments.paymentDate LIKE '2003-11%' ORDER BY payments.paymentDate ASC;

SELECT customers.customerName, payments.paymentDate, employees.firstName, payments.amount
FROM payments
JOIN customers ON payments.customerNumber = customers.customerNumber
JOIN orders ON customers.customerNumber = orders.customerNumber
JOIN employees ON customers.salesRepEmployeeNumber = employees.employeeNumber
WHERE payments.paymentDate LIKE '%-11-%'
ORDER BY payments.amount DESC
LIMIT 1;

SELECT DISTINCT customers.customerName, payments.paymentDate, employees.firstName, payments.amount
FROM payments
JOIN customers ON payments.customerNumber = customers.customerNumber
JOIN orders ON customers.customerNumber = orders.customerNumber
JOIN employees ON customers.salesRepEmployeeNumber = employees.employeeNumber
WHERE payments.paymentDate LIKE '%-11-%'
ORDER BY payments.amount DESC;

SELECT customers.customerName AS NamaKustomer,
products.productName AS NamaProduk,
products.productDescription AS DeskripsiProduk,
payments.paymentDate
FROM customers
JOIN orders ON customers.customerNumber = orders.customerNumber
JOIN orderdetails ON orders.orderNumber = orderdetails.orderNumber
JOIN products ON orderdetails.productCode = products.productCode
JOIN payments ON customers.customerNumber = payments.customerNumber
WHERE customers.customerName LIKE 'Corporate%'
AND payments.paymentDate LIKE '%-11-%'
ORDER BY payments.paymentDate ASC;

SELECT 
e.firstName, 
e.lastName, 
m.firstName, 
m.lastName
FROM employees e
JOIN employees m ON e.reportsTo = m.employeeNumber;

