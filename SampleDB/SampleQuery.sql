CREATE DATABASE OnlineBookstore;
USE OnlineBookstore;

-- Drop tables if they exist in the right order to avoid foreign key constraints
DROP TABLE IF EXISTS CartItems;
DROP TABLE IF EXISTS ShoppingCart;
DROP TABLE IF EXISTS Notifications;
DROP TABLE IF EXISTS Promotions;
DROP TABLE IF EXISTS Reviews;
DROP TABLE IF EXISTS Payment;
DROP TABLE IF EXISTS OrderItem;
DROP TABLE IF EXISTS [Order];
DROP TABLE IF EXISTS LoyaltyProgram; -- Added to ensure it is dropped before Customer
DROP TABLE IF EXISTS Book;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS [User];

|-- Create User Table (Admin and Staff)
CREATE TABLE [User] (
    user_id INT IDENTITY(1,1) PRIMARY KEY,
    username NVARCHAR(50) UNIQUE NOT NULL,
    password_hash NVARCHAR(255) NOT NULL,
    role NVARCHAR(20) DEFAULT 'Staff', -- 'Admin' or 'Staff'
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE()
);

-- Create Customer Table
CREATE TABLE Customer (
    customer_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT UNIQUE, -- Foreign key to User
    name NVARCHAR(255) NOT NULL,
    email NVARCHAR(255) UNIQUE NOT NULL,
    phone NVARCHAR(20),
    address NVARCHAR(MAX),
    loyalty_points INT DEFAULT 0,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES [User](user_id) ON DELETE SET NULL
);

-- Create Book Table
CREATE TABLE Book (
    ISBN NVARCHAR(14) PRIMARY KEY,
    title NVARCHAR(255) NOT NULL,
    author NVARCHAR(255) NOT NULL,
    publisher NVARCHAR(255),
    genre NVARCHAR(50),
    stock_quantity INT DEFAULT 0,
    price DECIMAL(10, 2) NOT NULL,
    online_price DECIMAL(10, 2),
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE()
);

-- Create Order Table
CREATE TABLE [Order] (
    order_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATETIME DEFAULT GETDATE(),
    total_amount DECIMAL(10, 2),
    status NVARCHAR(20) DEFAULT 'Pending',
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id) ON DELETE CASCADE
);

-- Create OrderItem Table
CREATE TABLE OrderItem (
    order_item_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT NOT NULL,
    ISBN NVARCHAR(14) NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    status NVARCHAR(20) DEFAULT 'Pending',  -- Set default status
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (order_id) REFERENCES [Order](order_id) ON DELETE CASCADE,
    FOREIGN KEY (ISBN) REFERENCES Book(ISBN) ON DELETE CASCADE
);

-- Create Payment Table
CREATE TABLE Payment (
    payment_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_method NVARCHAR(20) DEFAULT 'Credit Card',
    status NVARCHAR(20) DEFAULT 'Pending',
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (order_id) REFERENCES [Order](order_id) ON DELETE CASCADE
);

-- Create LoyaltyProgram Table
CREATE TABLE LoyaltyProgram (
    loyalty_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT NOT NULL,
    points_accumulated INT DEFAULT 0,
    reward_threshold INT DEFAULT 100,
    reward_eligible BIT DEFAULT 0 CHECK (reward_eligible IN (0, 1)),
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id) ON DELETE CASCADE
);

-- Create Reviews Table
CREATE TABLE Reviews (
    review_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT NOT NULL,
    ISBN NVARCHAR(14) NOT NULL,
    rating INT CHECK (rating >= 1 AND rating <= 5),
    comment NVARCHAR(MAX),
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (ISBN) REFERENCES Book(ISBN)
);

-- Create Promotions Table
CREATE TABLE Promotions (
    promo_id INT IDENTITY(1,1) PRIMARY KEY,
    description NVARCHAR(255),
    discount_percentage DECIMAL(5, 2),
    start_date DATETIME,
    end_date DATETIME,
    status NVARCHAR(20) DEFAULT 'Active'  -- Optional: track promotion status
);

-- Create ShoppingCart Table
CREATE TABLE ShoppingCart (
    cart_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id) ON DELETE CASCADE
);

-- Create CartItems Table
CREATE TABLE CartItems (
    cart_item_id INT IDENTITY(1,1) PRIMARY KEY,
    cart_id INT NOT NULL,
    ISBN NVARCHAR(14) NOT NULL,
    quantity INT NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (cart_id) REFERENCES ShoppingCart(cart_id) ON DELETE CASCADE,
    FOREIGN KEY (ISBN) REFERENCES Book(ISBN)
);

-- Create Notifications Table
CREATE TABLE Notifications (
    notification_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT NOT NULL,
    message NVARCHAR(MAX),
    is_read BIT DEFAULT 0,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id) ON DELETE CASCADE
);

