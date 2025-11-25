SELECT * FROM customers
WHERE city IN ('Nantes', 'Lyon')


SELECT * FROM orders
WHERE `shippedDate` BETWEEN '2003-01-10' AND '2003-03-10';
SELECT * FROM orders
WHERE `shippedDate` >= '2003-01-10' AND `shippedDate` <= '2003-03-10'


SELECT * FROM products
WHERE `productLine` LIKE '%CARS%'


SELECT * FROM products
ORDER BY `quantityInStock` DESC
LIMIT 10


SELECT * FROM employees
ORDER BY `lastName` ASC, `firstName` ASC


SELECT 
    *,
    (quantityInStock * buyPrice) AS tienHangTon
FROM products;
