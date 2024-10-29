USE classicmodels;
SELECT * FROM customers;
SELECT * FROM employees;
SELECT * FROM offices;
SELECT * FROM orderdetails;
SELECT * from orders;
SELECT * FROM payments;
SELECT * FROM productlines;
SELECT * FROM products;

SELECT customers.customerName, CONCAT(employees.firstName, ' ', employees.lastName) AS salesRepName, 
customers.creditLimit - SUM(payments.amount) AS remainingCredit
FROM customers
JOIN employees ON customers.salesRepEmployeeNumber = employees.employeeNumber
JOIN payments ON customers.customerNumber = payments.customerNumber
GROUP BY customers.customerName, salesRepName, customers.creditLimit
HAVING remainingCredit >= 0
ORDER BY customers.customerName;

SELECT products.productName AS 'Nama Produk',
GROUP_CONCAT(customers.customerName SEPARATOR ' | ') AS 'Nama Kostumer',
COUNT(DISTINCT customers.customerName) AS 'Total Kostumer',
SUM(orderdetails.quantityOrdered) AS 'Total Kuantitas'FROM products
JOIN orderdetails ON orderdetails.productCode = products.productCode
JOIN orders ON orders.orderNumber = orderdetails.orderNumber
JOIN customers ON customers.customerNumber = orders.customerNumber
GROUP BY products.productNameORDER BY products.productName ASC;

SELECT CONCAT(employees.firstName, ' ', employees.lastName) AS employeeName, 
COUNT(customers.customerName) AS totalCustomersFROM employees
JOIN customers ON employees.employeeNumber = customers.salesRepEmployeeNumber
GROUP BY employeeNameORDER BY totalCustomers DESC;

SELECT CONCAT(employees.firstName, ' ', employees.lastName) AS `Nama Karyawan`,
products.productName AS `Nama Produk`,SUM(orderdetails.quantityOrdered) AS `Jumlah Pesanan`
FROM employees
LEFT JOIN customers ON employees.employeeNumber = customers.salesRepEmployeeNumber
LEFT JOIN orders USING(customerNumber)
LEFT JOIN orderdetails USING(orderNumber)
LEFT JOIN products USING(productCode)
WHERE employees.officeCode = '6'
GROUP BY employees.firstName, employees.lastName, products.productNameORDER BY `Jumlah Pesanan` DESC;

SELECT customers.customerName, products.productName AS `Nama Produk`, 
COUNT(DISTINCT products.productCode) AS `Banyak Jenis Produk`FROM customers
JOIN orders USING (customerNumber)
JOIN orderdetails USING(orderNumber)
JOIN products USING(productCode)WHERE orders.shippedDate IS NULL
GROUP BY customers.customerName