SELECT
    UPPER(SUBSTRING(productDescription, 1, 50)) AS "Title of products"
FROM products

SELECT
    CONCAT(`firstName`, ' ', `lastName`, ', ', `jobTitle`) AS "Description"
FROM employees
    
UPDATE productlines
    SET `productLine` = REPLACE(`productLine`, 'Cars', 'Automobiles')
    WHERE `productLine` LIKE '%Cars%'

SELECT *,
       DATEDIFF(requiredDate, shippedDate) AS days_early
FROM orders
ORDER BY days_early DESC
LIMIT 5;

SELECT *
FROM orders
WHERE shippedDate IS NULL
  AND MONTH(orderDate) = 5
  AND YEAR(orderDate) = 2005;

SELECT *,
    IF(creditLimit > 100000, 'VIP', 'Regular') AS customerType
FROM customers;

