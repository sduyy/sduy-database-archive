CREATE TABLE temp_orderdetails LIKE orderdetails;
SELECT MAX(orderDate) FROM orders;
INSERT INTO temp_orderdetails
SELECT od.*
FROM orderdetails od
JOIN orders o ON od.orderNumber = o.orderNumber
WHERE o.orderDate = (SELECT MAX(orderDate) FROM orders);

UPDATE employees
SET jobTitle = 'Sales Representative'
WHERE jobTitle = 'Sales Rep';

UPDATE customers c
SET creditLimit = 10000 + (
    SELECT SUM(od.quantityOrdered * od.priceEach)
    FROM orders o
    JOIN orderdetails od ON o.orderNumber = od.orderNumber
    WHERE o.customerNumber = c.customerNumber
);

UPDATE products
SET buyPrice =
    CASE 
        WHEN quantityInStock > 1000 THEN buyPrice * 0.9
        ELSE buyPrice * 1.05                             
    END;
