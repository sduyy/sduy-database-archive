SELECT *
FROM employees
WHERE `reportsTo` is NULL

SELECT DISTINCT customerNumber
FROM payments

SELECT DISTINCT status
FROM orders

SELECT *
FROM orders
WHERE `requiredDate` = '2003-01-18'

SELECT *
FROM orders
WHERE `status` = 'Shipped'
  AND YEAR(`orderDate`) = 2005
  AND MONTH(`orderDate`) = 4;

SELECT *
FROM products
WHERE `productLine` = 'Classic Cars'

