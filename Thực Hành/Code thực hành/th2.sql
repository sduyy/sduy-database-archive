CREATE TABLE productlines(  
    productLine VARCHAR(50) NOT NULL PRIMARY KEY,
    textDescription VARCHAR(4000),
    htmlDescription MEDIUMTEXT,
    image MEDIUMBLOB
) ENGINE=InnoDB;

CREATE TABLE products(  
    productCode VARCHAR(15) NOT NULL PRIMARY KEY,
    productName VARCHAR(70) NOT NULL,
    productLine VARCHAR(50) NOT NULL,
    productScale VARCHAR(10) NOT NULL,
    productVendor VARCHAR(50) NOT NULL,
    productDescription TEXT NOT NULL,
    quantityInStock SMALLINT(6) NOT NULL,
    buyPrice DOUBLE NOT NULL,

    CONSTRAINT fk_products_productlines FOREIGN KEY (productLine) REFERENCES productlines (productLine) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE orderdetails(
    orderNumber INT(11) NOT NULL,
    productCode VARCHAR(15) NOT NULL,
    quantityOrdered INT(11) NOT NULL,
    priceEach DOUBLE NOT NULL,
    orderLineNumber SMALLINT(6) NOT NULL,

    PRIMARY KEY (orderNumber, productCode),

    CONSTRAINT fk_orderdetails_products FOREIGN KEY (productCode) REFERENCES products (productCode) ON DELETE RESTRICT ON UPDATE CASCADE,

    CONSTRAINT fk_orderdetails_orders FOREIGN KEY (orderNumber) REFERENCES orders (orderNumber) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE orders(
    orderNumber INT(11) NOT NULL PRIMARY KEY,
    orderDate DATETIME NOT NULL,
    requiredDate DATETIME NOT NULL,
    shippedDate DATETIME,
    status VARCHAR(15) NOT NULL,
    comments TEXT,
    customerNumber INT(11) NOT NULL
) ENGINE=InnoDB;
