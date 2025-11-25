-- Câu 1
CREATE TABLE customer_logins (
    loginID INT(11) AUTO_INCREMENT PRIMARY KEY,
    customerNumber INT(11) NOT NULL,
    username VARCHAR(255) NOT NULL UNIQUE,
    passwordHash VARCHAR(128) NOT NULL,
    createdAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (customerNumber) REFERENCES customers (customerNumber) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Câu 2
SELECT productCode, quantityOrdered, priceEach,
        (quantityOrdered * priceEach) AS lineTotal
FROM orderdetails
WHERE `orderNumber` = 10100
ORDER BY lineTotal DESC

-- Câu 3
SELECT e.employeeNumber, e.lastName, e.firstName,
        COUNT(r.employeeNumber) as soNhanVienQuanLy
FROM employees e
LEFT JOIN employees r on e.employeeNumber = r.reportsTo
GROUP BY e.employeeNumber, e.lastName, e.firstName
ORDER BY soNhanVienQuanLy DESC
LIMIT 1

-- Câu 4
SELECT c.customerNumber, c.customerName, c.contactLastName, c.contactFirstName
FROM customers c
LEFT JOIN payments p ON p.customerNumber = c.customerNumber
WHERE p.customerNumber IS NULL

-- Câu 5
SELECT p.productLine,
       SUM(od.quantityOrdered * od.priceEach) AS total
FROM orderdetails od
JOIN products p ON p.productCode = od.productCode
GROUP BY p.productLine
ORDER BY total DESC
LIMIT 2, 1

-- Câu 6
SELECT c.salesRepEmployeeNumber as employeeNumber,
       SUM(od.quantityOrdered * od.priceEach) AS total
FROM customers c
JOIN orders o ON o.customerNumber = c.customerNumber
JOIN orderdetails od ON od.orderNumber = o.orderNumber
WHERE YEAR(o.orderDate) = 2005
    AND c.country = 'USA'
    AND c.salesRepEmployeeNumber IS NOT NULL
GROUP BY c.salesRepEmployeeNumber
ORDER BY total DESC
LIMIT 1

-- Câu 7
-- Câu này tool chứ ko hiểu :))
SELECT c.customerNumber, c.customerName,
       SUM(od.quantityOrdered) as tiemNang
FROM customers c
CROSS JOIN (SELECT MAX(orderDate) as maxDate FROM orders) latest
LEFT JOIN orders o ON o.customerNumber = c.customerNumber
    AND o.orderDate BETWEEN DATE_SUB(latest.maxDate, INTERVAL 3 MONTH) AND latest.maxDate
LEFT JOIN orderdetails od ON od.orderNumber = o.orderNumber
GROUP BY c.customerNumber, c.customerName
ORDER BY tiemNang DESC

-- Câu 8
-- Câu này chạy vẫn lỗi nhưng mà hết giờ phải nộp
UPDATE orders
SET comments = 'First order'
WHERE MONTH(orderDate) = (SELECT MONTH(MIN(orderDate)) FROM orders)
  AND YEAR(orderDate) = (SELECT YEAR(MIN(orderDate)) FROM orders);
