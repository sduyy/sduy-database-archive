SELECT
    e.employeeNumber,
    e.lastName,
    e.firstName,
    o.city AS officeCity
FROM employees e
JOIN offices o ON e.`officeCode` = o.`officeCode`

SELECT 
    p.productCode,
    p.productName
FROM products p
LEFT JOIN orderdetails od ON p.productCode = od.productCode
WHERE od.productCode IS NULL;

SELECT 
    o.orderNumber,
    o.orderDate,
    o.requiredDate,
    o.status,
    SUM(od.quantityOrdered * od.priceEach) AS totalAmount
FROM orders o
JOIN orderdetails od ON o.orderNumber = od.orderNumber
WHERE MONTH(o.orderDate) = 3 AND YEAR(o.orderDate) = 2003
GROUP BY o.orderNumber, o.orderDate, o.requiredDate, o.status;

SELECT 
    p.productLine,
    COUNT(p.productCode) AS totalProducts
FROM products p
GROUP BY p.productLine
ORDER BY totalProducts DESC;

SELECT 
    c.customerNumber,
    c.customerName,
    SUM(od.quantityOrdered * od.priceEach) AS totalSpent
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY c.customerNumber, c.customerName
ORDER BY totalSpent DESC;

SELECT 
    e.employeeNumber,
    CONCAT(e.firstName, ' ', e.lastName) AS employeeName,
    SUM(od.quantityOrdered * od.priceEach) AS totalSales2003
FROM employees e
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
WHERE YEAR(o.orderDate) = 2003
GROUP BY e.employeeNumber, employeeName
ORDER BY totalSales2003 DESC;
