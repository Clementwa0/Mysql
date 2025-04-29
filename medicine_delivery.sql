-- --------------------------------------------------------
-- SCHEMA: Online Medicine Delivery System
-- --------------------------------------------------------

-- DROP existing tables if needed
DROP TABLE IF EXISTS emergency_orders, order_items, orders, payments, prescriptions, medicines, categories, addresses, users;

-- 1. USERS TABLE
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. ADDRESSES TABLE (1-M: user → addresses)
CREATE TABLE addresses (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    location_description TEXT NOT NULL,
    city VARCHAR(50),
    postal_code VARCHAR(10),
    is_primary BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- 3. CATEGORIES TABLE
CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL
);

-- 4. MEDICINES TABLE
CREATE TABLE medicines (
    medicine_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    stock INT DEFAULT 0,
    requires_prescription BOOLEAN DEFAULT FALSE,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES categories(category_id) ON DELETE SET NULL
);

-- 5. PRESCRIPTIONS TABLE
CREATE TABLE prescriptions (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    file_path VARCHAR(255) NOT NULL,
    uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- 6. ORDERS TABLE
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    address_id INT,
    prescription_id INT DEFAULT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    order_status ENUM('pending', 'confirmed', 'delivered', 'cancelled') DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (address_id) REFERENCES addresses(address_id),
    FOREIGN KEY (prescription_id) REFERENCES prescriptions(prescription_id)
);

-- 7. ORDER ITEMS TABLE (M-M: orders ↔ medicines)
CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    medicine_id INT,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (medicine_id) REFERENCES medicines(medicine_id)
);

-- 8. PAYMENTS TABLE
CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    amount_paid DECIMAL(10,2),
    payment_method ENUM('mpesa', 'card', 'cash') DEFAULT 'mpesa',
    paid_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- 9. EMERGENCY ORDERS TABLE (1-1 with orders, special flag)
CREATE TABLE emergency_orders (
    emergency_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT UNIQUE,
    emergency_fee DECIMAL(10,2) DEFAULT 150.00,
    responded_by_operator BOOLEAN DEFAULT FALSE,
    emergency_time TIME NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE
);

-- --------------------------------------------------------
-- 📥 Sample Data
-- --------------------------------------------------------

-- USERS
INSERT INTO users (full_name, email, phone, password) VALUES
('Mary Wambui', 'mary@example.com', '0700111222', 'hashedpassword'),
('John Otieno', 'john@example.com', '0712345678', 'hashedpassword');

-- ADDRESSES
INSERT INTO addresses (user_id, location_description, city, postal_code, is_primary) VALUES
(1, 'Thika Town, Behind Naivas', 'Thika', '01000', TRUE),
(2, 'Kasarani, Mwiki Road', 'Nairobi', '00618', TRUE);

-- CATEGORIES
INSERT INTO categories (name) VALUES
('Pain Relief'), ('Cold & Flu'), ('Allergy'), ('Baby Health'), ('Supplements');

-- MEDICINES
INSERT INTO medicines (name, description, price, stock, requires_prescription, category_id) VALUES
('Paracetamol 500mg', 'Pain and fever relief', 10.00, 100, FALSE, 1),
('Amoxicillin 250mg', 'Antibiotic', 25.00, 50, TRUE, 1),
('Vitamin C Tablets', 'Boosts immunity', 20.00, 200, FALSE, 5);

-- PRESCRIPTIONS
INSERT INTO prescriptions (user_id, file_path) VALUES
(1, 'uploads/prescription1.pdf');

-- ORDERS
INSERT INTO orders (user_id, address_id, prescription_id, total_amount, order_status) VALUES
(1, 1, 1, 55.00, 'confirmed'),
(2, 2, NULL, 20.00, 'pending');

-- ORDER ITEMS
INSERT INTO order_items (order_id, medicine_id, quantity, unit_price) VALUES
(1, 1, 2, 10.00),
(1, 2, 1, 25.00),
(2, 3, 1, 20.00);

-- PAYMENTS
INSERT INTO payments (order_id, amount_paid, payment_method) VALUES
(1, 55.00, 'mpesa');

-- EMERGENCY ORDERS
INSERT INTO emergency_orders (order_id, emergency_fee, responded_by_operator, emergency_time) VALUES
(1, 150.00, TRUE, '00:45:00');

