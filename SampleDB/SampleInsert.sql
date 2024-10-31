USE OnlineBookstore;

-- Insert sample data into User Table
INSERT INTO [User] (username, password_hash, role)
VALUES 
    ('admin', 'hashed_password_here', 'Admin'),
    ('staff1', 'hashed_password_here_2', 'Staff'),
    ('staff2', 'hashed_password_here_3', 'Staff');

-- Insert sample data into Customer Table
INSERT INTO Customer (user_id, name, email, phone, address, loyalty_points)
VALUES 
    (1, 'Nguyen Van A', 'nguyenvana@example.com', '0912345678', '123 Main St', 100),  -- Assuming user_id 1 exists
    (2, 'Tran Thi B', 'tranthib@example.com', '0987654321', '456 Second St', 50),  -- Assuming user_id 2 exists
    (NULL, 'Le Van C', 'levanc@example.com', '0908765432', '789 Third St', 30);  -- This should not conflict with the unique constraint

-- Insert sample data into Book Table
INSERT INTO Book (ISBN, title, author, publisher, genre, stock_quantity, price, online_price)
VALUES 
    ('978-1234567890', 'Learn SQL', 'John Doe', 'TechPress', 'Education', 50, 20.00, 18.00),
    ('978-0987654321', 'Mastering Python', 'Jane Smith', 'CodeBooks', 'Programming', 100, 25.00, 22.50),
    ('978-5432109876', 'Java for Beginners', 'Alan Brown', 'LearningPub', 'Programming', 75, 30.00, 27.00);

-- Insert sample data into Order Table
INSERT INTO [Order] (customer_id, total_amount, status)
VALUES 
    (1, 100.00, 'Completed'),  -- Ensure customer_id 1 exists
    (2, 50.00, 'Pending');      -- Ensure customer_id 2 exists

-- Insert sample data into OrderItem Table
INSERT INTO OrderItem (order_id, ISBN, quantity, price)
VALUES 
    (1, '978-1234567890', 2, 20.00),  -- Ensure order_id 1 exists
    (1, '978-0987654321', 1, 25.00),  -- Ensure order_id 1 exists
    (2, '978-5432109876', 1, 30.00);  -- Ensure order_id 2 exists

-- Insert sample data into Payment Table
INSERT INTO Payment (order_id, amount, payment_method, status)
VALUES 
    (1, 100.00, 'Credit Card', 'Completed'),  -- Ensure order_id 1 exists
    (2, 50.00, 'PayPal', 'Pending');           -- Ensure order_id 2 exists

-- Insert sample data into Reviews Table
INSERT INTO Reviews (customer_id, ISBN, rating, comment)
VALUES 
    (1, '978-1234567890', 5, 'Excellent book! Highly recommend.'),  -- Ensure customer_id 1 exists
    (2, '978-0987654321', 4, 'Very informative, but a bit advanced.'); -- Ensure customer_id 2 exists

-- Insert sample data into Promotions Table
INSERT INTO Promotions (description, discount_percentage, start_date, end_date)
VALUES 
    ('Black Friday Sale', 20.00, '2024-11-01', '2024-11-30');

-- Insert sample data into ShoppingCart Table
INSERT INTO ShoppingCart (customer_id)
VALUES 
    (1),  -- Ensure customer_id 1 exists
    (2);  -- Ensure customer_id 2 exists

-- Insert sample data into CartItems Table
INSERT INTO CartItems (cart_id, ISBN, quantity)
VALUES 
    (1, '978-1234567890', 1),  -- Ensure cart_id 1 exists
    (2, '978-0987654321', 2);  -- Ensure cart_id 2 exists

-- Insert sample data into Notifications Table
INSERT INTO Notifications (customer_id, message)
VALUES 
    (1, 'Your order has been shipped!'),  -- Ensure customer_id 1 exists
    (2, 'Your shopping cart has been updated.');  -- Ensure customer_id 2 exists

