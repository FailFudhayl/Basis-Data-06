USE classicmodels;

/* Nomor 1 */
SELECT customerName, country, creditLimit
FROM customers
WHERE (country = 'USA' AND creditLimit > 50000 AND creditLimit < 100000)
   OR (country != 'USA' AND creditLimit BETWEEN 100000 AND 200000)
ORDER BY creditLimit DESC;

/* Nomor 2 */
SELECT productName, quantityInStock, buyPrice, productLine
FROM products
WHERE quantityInStock BETWEEN 1000 AND 2000
  AND (buyPrice < 50 OR buyPrice > 150)
  AND productLine != 'Vintage Cars';

/* Nomor 3 */
SELECT productName, productLine, MSRP
FROM products
WHERE productLine LIKE '%Classic%'
  AND buyPrice > 50;

/* Nomor 4 */
SELECT orderNumber, orderDate, status
FROM orders
WHERE orderNumber > 10250
  AND status NOT IN ('Shipped', 'Cancelled')
  AND YEAR(orderDate) BETWEEN 2004 AND 2005;
  
/* Nomor 5 */
SELECT orderNumber, productCode, quantityOrdered, priceEach, 
       (quantityOrdered * priceEach * 0.95) AS discountedTotalPrice
FROM orderdetails
WHERE quantityOrdered > 50
  AND priceEach > 100
  AND productCode NOT LIKE 'S18%'
ORDER BY discountedTotalPrice DESC;



