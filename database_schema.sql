-- Users Table
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('customer', 'admin') DEFAULT 'customer',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Sample User Inserts
INSERT INTO users (username, email, password, role) 
VALUES 
('john_doe', 'john@example.com', 'password123', 'customer'),
('alice_smith', 'alice@example.com', 'password456', 'customer'),
('bob_jones', 'bob@example.com', 'password789', 'customer'),
('admin_user', 'admin@example.com', 'adminpass', 'admin'),
('mary_johnson', 'mary@example.com', 'passwordabc', 'customer');

-- Products Table
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL,
    image_url VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Sample Product Inserts
INSERT INTO products (name, description, price, stock, image_url) 
VALUES 
('Apple', 'Fresh red apple', 1.99, 100, 'http://example.com/apple.jpg'),
('Banana', 'Fresh yellow banana', 0.99, 150, 'http://example.com/banana.jpg'),
('Carrot', 'Crunchy orange carrot', 2.49, 80, 'http://example.com/carrot.jpg'),
('Tomato', 'Ripe red tomato', 3.29, 120, 'http://example.com/tomato.jpg'),
('Lettuce', 'Fresh green lettuce', 2.79, 200, 'http://example.com/lettuce.jpg');

-- Cart Items Table
CREATE TABLE cart (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

-- Sample Cart Items Inserts
INSERT INTO cart (user_id, product_id, quantity) 
VALUES 
(1, 1, 3),
(2, 2, 5),
(3, 3, 2),
(1, 4, 1),
(4, 5, 4);

-- Orders Table
CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status ENUM('pending', 'completed', 'cancelled') DEFAULT 'pending',
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Sample Orders Inserts
INSERT INTO orders (user_id, total_price, status) 
VALUES 
(1, 11.97, 'pending'),
(2, 9.95, 'completed'),
(3, 14.96, 'pending'),
(4, 10.58, 'completed'),
(5, 7.89, 'pending');

-- Order Items Table
CREATE TABLE order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

-- Sample Order Items Inserts
INSERT INTO order_items (order_id, product_id, quantity, price) 
VALUES 
(1, 1, 3, 1.99),
(2, 2, 5, 0.99),
(3, 3, 2, 2.49),
(4, 4, 1, 3.29),
(5, 5, 4, 2.79);

-- Product Categories Table (Optional)
CREATE TABLE product_categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Sample Product Categories Inserts (Optional)
INSERT INTO product_categories (name) 
VALUES 
('Fruits'),
('Vegetables');

-- Product Category Relationship Table (Optional)
CREATE TABLE product_category_rel (
    product_id INT NOT NULL,
    category_id INT NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES product_categories(id) ON DELETE CASCADE,
    PRIMARY KEY (product_id, category_id)
);

-- Sample Product-Category Relationship Inserts (Optional)
INSERT INTO product_category_rel (product_id, category_id) 
VALUES 
(1, 1),
(2, 1),
(3, 2),
(4, 2),
(5, 2);
