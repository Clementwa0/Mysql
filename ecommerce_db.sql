-- Create database
CREATE DATABASE IF NOT EXISTS ecommerce_db;
USE ecommerce_db;

-- Brand
CREATE TABLE brand (
    brand_id INT AUTO_INCREMENT PRIMARY KEY,
    brand_name VARCHAR(100) NOT NULL
);

-- Product Category
CREATE TABLE product_category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

-- Product
CREATE TABLE product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    brand_id INT,
    category_id INT,
    base_price DECIMAL(10, 2),
    description TEXT,
    FOREIGN KEY (brand_id) REFERENCES brand(brand_id),
    FOREIGN KEY (category_id) REFERENCES product_category(category_id)
);

-- Product Image
CREATE TABLE product_image (
    image_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    image_url VARCHAR(255) NOT NULL,
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

-- Product Item
CREATE TABLE product_item (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    sku VARCHAR(50) UNIQUE NOT NULL,
    price DECIMAL(10, 2),
    stock_quantity INT DEFAULT 0,
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

-- Color
CREATE TABLE color (
    color_id INT AUTO_INCREMENT PRIMARY KEY,
    color_name VARCHAR(50) NOT NULL
);

-- Size Category
CREATE TABLE size_category (
    size_category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

-- Size Option
CREATE TABLE size_option (
    size_id INT AUTO_INCREMENT PRIMARY KEY,
    size_category_id INT,
    size_value VARCHAR(20) NOT NULL,
    FOREIGN KEY (size_category_id) REFERENCES size_category(size_category_id)
);

-- Product Variation
CREATE TABLE product_variation (
    variation_id INT AUTO_INCREMENT PRIMARY KEY,
    item_id INT,
    color_id INT,
    size_id INT,
    FOREIGN KEY (item_id) REFERENCES product_item(item_id),
    FOREIGN KEY (color_id) REFERENCES color(color_id),
    FOREIGN KEY (size_id) REFERENCES size_option(size_id)
);

-- Attribute Type
CREATE TABLE attribute_type (
    type_id INT AUTO_INCREMENT PRIMARY KEY,
    type_name VARCHAR(50) NOT NULL
);

-- Attribute Category
CREATE TABLE attribute_category (
    attribute_category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

-- Product Attribute
CREATE TABLE product_attribute (
    attribute_id INT AUTO_INCREMENT PRIMARY KEY,
    item_id INT,
    attribute_category_id INT,
    type_id INT,
    attribute_name VARCHAR(100),
    attribute_value VARCHAR(255),
    FOREIGN KEY (item_id) REFERENCES product_item(item_id),
    FOREIGN KEY (attribute_category_id) REFERENCES attribute_category(attribute_category_id),
    FOREIGN KEY (type_id) REFERENCES attribute_type(type_id)
);


-- dump data

-- Brand
INSERT INTO brand (brand_name) VALUES 
('Apple'),
('Samsung'),
('Nike'),
('Adidas');

-- Product Category
INSERT INTO product_category (category_name) VALUES 
('Smartphones'),
('Shoes'),
('Clothing');

-- Product
INSERT INTO product (product_name, brand_id, category_id, base_price, description) VALUES 
('iPhone 14', 1, 1, 999.99, 'Latest iPhone with A15 chip'),
('Galaxy S22', 2, 1, 899.99, 'Samsung flagship phone'),
('Air Max 90', 3, 2, 129.99, 'Classic running shoes'),
('Adidas Hoodie', 4, 3, 59.99, 'Comfortable hoodie for casual wear');

-- Product Image
INSERT INTO product_image (product_id, image_url) VALUES 
(1, 'https://example.com/images/iphone14.jpg'),
(2, 'https://example.com/images/galaxys22.jpg'),
(3, 'https://example.com/images/airmax90.jpg'),
(4, 'https://example.com/images/hoodie.jpg');

-- Product Item
INSERT INTO product_item (product_id, sku, price, stock_quantity) VALUES 
(1, 'APL-IP14-128GB', 999.99, 10),
(2, 'SMS-S22-128GB', 899.99, 15),
(3, 'NK-AM90-BLK-42', 129.99, 20),
(4, 'AD-HOOD-M-BLK', 59.99, 25);

-- Color
INSERT INTO color (color_name) VALUES 
('Black'),
('White'),
('Blue'),
('Red');

-- Size Category
INSERT INTO size_category (category_name) VALUES 
('Clothing Sizes'),
('Shoe Sizes');

-- Size Option
INSERT INTO size_option (size_category_id, size_value) VALUES 
(1, 'S'),
(1, 'M'),
(1, 'L'),
(2, '42'),
(2, '44');

-- Product Variation
INSERT INTO product_variation (item_id, color_id, size_id) VALUES 
(3, 1, 4), -- Air Max 90 Black, Size 42
(4, 1, 2); -- Hoodie Black, Size M

-- Attribute Type
INSERT INTO attribute_type (type_name) VALUES 
('Text'),
('Number'),
('Boolean');

-- Attribute Category
INSERT INTO attribute_category (category_name) VALUES 
('Physical'),
('Technical');

-- Product Attribute
INSERT INTO product_attribute (item_id, attribute_category_id, type_id, attribute_name, attribute_value) VALUES 
(1, 2, 1, 'Chip', 'A15 Bionic'),
(2, 2, 1, 'Processor', 'Snapdragon 8'),
(3, 1, 1, 'Material', 'Leather'),
(4, 1, 1, 'Material', 'Cotton');
