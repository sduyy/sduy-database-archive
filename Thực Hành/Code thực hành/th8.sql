SELECT
    productCode,
    productName
FROM products
WHERE `productCode` in (
    SELECT DISTINCT od.`productCode`
    FROM orderdetails od
    JOIN orders o on od.`orderNumber` = o.`orderNumber`
    WHERE MONTH(o.`orderDate`) = 3 AND YEAR(o.`orderDate`) = 2003
);

SELECT *
FROM orders
WHERE MONTH(orderDate) = (
    SELECT MONTH(MAX(orderDate)) FROM orders
)
AND YEAR(orderDate) = (
    SELECT YEAR(MAX(orderDate)) FROM orders
);

SELECT 
    o.orderNumber,
    o.orderDate,
    o.status,
    (
        SELECT SUM(od.quantityOrdered * od.priceEach)
        FROM orderdetails od
        WHERE od.orderNumber = o.orderNumber
    ) AS totalAmount
FROM orders o;

SELECT 
    e.employeeNumber,
    CONCAT(e.firstName, ' ', e.lastName) AS employeeName,
    COUNT(c.customerNumber) AS totalCustomers
FROM employees e
JOIN customers c 
    ON e.employeeNumber = c.salesRepEmployeeNumber
GROUP BY e.employeeNumber, employeeName
ORDER BY totalCustomers DESC
LIMIT 1;

SELECT 
    c.customerNumber,
    c.customerName,
    SUM(p.amount) AS totalPayment
FROM customers c
JOIN payments p 
    ON c.customerNumber = p.customerNumber
GROUP BY c.customerNumber, c.customerName
HAVING SUM(p.amount) > (
    SELECT AVG(totalPerCustomer)
    FROM (
        SELECT SUM(amount) AS totalPerCustomer
        FROM payments
        GROUP BY customerNumber
    ) AS avg_table
);

SELECT 
    c.customerName,
    IFNULL(orderTotals.totalOrder, 0) AS totalOrder,
    IFNULL(paymentTotals.totalPaid, 0) AS totalPaid,
    (IFNULL(orderTotals.totalOrder, 0) - IFNULL(paymentTotals.totalPaid, 0)) AS amountDue
FROM customers c
LEFT JOIN (
    SELECT 
        o.customerNumber,
        SUM(od.quantityOrdered * od.priceEach) AS totalOrder
    FROM orders o
    JOIN orderdetails od ON o.orderNumber = od.orderNumber
    GROUP BY o.customerNumber
) AS orderTotals
    ON c.customerNumber = orderTotals.customerNumber
LEFT JOIN (
    SELECT 
        p.customerNumber,
        SUM(p.amount) AS totalPaid
    FROM payments p
    GROUP BY p.customerNumber
) AS paymentTotals
    ON c.customerNumber = paymentTotals.customerNumber;
