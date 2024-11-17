USE OnlineBookstore;

-- Select queries using declared variables

DECLARE @order_id INT = 1;   -- Example value
DECLARE @ISBN NVARCHAR(14) = '978-1234567890';  -- Example value
DECLARE @customer_id INT = 1;  -- Example value

-- Select all users
SELECT user_id, username, role, created_at 
FROM [User];

-- Select all customers
SELECT customer_id, name, email, phone, address, loyalty_points 
FROM Customer;

-- Select all books
SELECT ISBN, title, author, publisher, genre, stock_quantity, price, online_price 
FROM Book;

-- Select all orders
SELECT order_id, customer_id, order_date, total_amount, status 
FROM [Order];

-- Select all items in a specific order
SELECT oi.order_item_id, oi.ISBN, oi.quantity, oi.price
FROM OrderItem oi
JOIN [Order] o ON oi.order_id = o.order_id
WHERE o.order_id = @order_id;  -- Using the declared variable

-- Select payments for a specific order
SELECT payment_id, amount, payment_method, status, created_at
FROM Payment
WHERE order_id = @order_id;  -- Using the declared variable

-- Select all reviews for a specific book
SELECT r.review_id, r.customer_id, r.rating, r.comment
FROM Reviews r
WHERE r.ISBN = @ISBN;  -- Using the declared variable

-- Select all promotions
SELECT promotion_id, description, discount_percentage, start_date, end_date 
FROM Promotions;

-- Select all items in a customer's shopping cart
SELECT ci.cart_item_id, ci.ISBN, ci.quantity
FROM CartItems ci
JOIN ShoppingCart sc ON ci.cart_id = sc.cart_id
WHERE sc.customer_id = @customer_id;  -- Using the declared variable

-- Select all notifications for a specific customer
SELECT notification_id, message, notification_date
FROM Notifications
WHERE customer_id = @customer_id;  -- Using the declared variable
