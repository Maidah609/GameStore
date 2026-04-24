CREATE DATABASE Game_Store

USE Game_Store

CREATE TABLE Users (
    user_id INT IDENTITY(1,1) PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role VARCHAR(50) CHECK (role IN ('customer', 'admin')) NOT NULL
);

CREATE TABLE Games (
    game_id INT IDENTITY(1,1) PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2),
    genre VARCHAR(100),
    platform VARCHAR(100)
);

CREATE TABLE Orders (
    order_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT,
    order_date DATETIME,
    total_amount DECIMAL(10, 2),
    order_status VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE Payments (
    payment_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT,
    payment_date DATETIME,
    payment_status VARCHAR(50),
    payment_method VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

CREATE TABLE Inventory (
    game_id INT,
    stock_quantity INT,
    FOREIGN KEY (game_id) REFERENCES Games(game_id)
);


CREATE TABLE Order_Items (
    order_item_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT,
    game_id INT,
    quantity INT,
    price DECIMAL(10, 2),  -- This could store the price of the game at the time of the order (in case prices change)
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (game_id) REFERENCES Games(game_id)
);


SELECT * 
FROM Orders 
WHERE user_id = 1 AND order_status = 'Active';


SELECT g.title, oi.quantity, oi.price 
FROM Order_Items oi
JOIN Games g ON oi.game_id = g.game_id
WHERE oi.order_id = 1;


UPDATE Inventory 
SET stock_quantity = stock_quantity - oi.quantity
FROM Order_Items oi
WHERE Inventory.game_id = oi.game_id AND oi.order_id = 1;


SELECT SUM(o.total_amount) AS TotalRevenue
FROM Orders o
WHERE o.order_status = 'Completed';


CREATE VIEW ActiveOrderss AS
SELECT o.order_id, u.username, o.order_date, o.total_amount, o.order_status
FROM Orders o
JOIN Users u ON o.user_id = u.user_id
WHERE o.order_status = 'Active';


CREATE TRIGGER UpdateInventoryAfterOrderr
ON Order_Items
AFTER INSERT
AS
BEGIN
    -- Update inventory when an order item is inserted
    UPDATE Inventory
    SET stock_quantity = stock_quantity - i.quantity
    FROM Inventory inv
    INNER JOIN inserted i ON inv.game_id = i.game_id;
END;

CREATE INDEX idx_game_title ON Games(title);
CREATE INDEX idx_user_email ON Users(email);


INSERT INTO Users (username, email, password_hash, role)
VALUES
('Ali_ahmed', 'ali.ahmed@example.com', 'hashedpassword123', 'customer'),
('Fatima_siddiqui', 'fatima.siddiqui@example.com', 'hashedpassword123', 'customer'),
('Adeel_malik', 'adeel.malik@example.com', 'hashedpassword123', 'admin'),
('Sana_bashir', 'sana.bashir@example.com', 'hashedpassword123', 'customer'),
('Omar_ali', 'omar.ali@example.com', 'hashedpassword123', 'admin'),
('Hina_razzaq', 'hina.razzaq@example.com', 'hashedpassword123', 'customer'),
('Bilal_yousaf', 'bilal.yousaf@example.com', 'hashedpassword123', 'customer'),
('Nida_javed', 'nida.javed@example.com', 'hashedpassword123', 'customer'),
('Imran_khan', 'imran.khan@example.com', 'hashedpassword123', 'admin'),
('Kiran_akhter', 'kiran.akhter@example.com', 'hashedpassword123', 'customer');


INSERT INTO Games (title, description, price, genre, platform)
VALUES
('PUBG Mobile', 'Battle Royale game', 10.00, 'Action', 'Mobile'),
('Call of Duty', 'First-person shooter game', 50.00, 'Action', 'PC'),
('FIFA 21', 'Football simulation game', 60.00, 'Sports', 'PlayStation'),
('Minecraft', 'Sandbox game', 20.00, 'Adventure', 'PC'),
('Grand Theft Auto V', 'Open world action-adventure', 30.00, 'Action', 'Xbox');


INSERT INTO Orders (user_id, order_date, total_amount, order_status)
VALUES
(1, '2025-05-08 10:00:00', 40.00, 'Active'),
(2, '2025-05-08 12:30:00', 50.00, 'Completed'),
(3, '2025-05-08 13:00:00', 60.00, 'Completed'),
(4, '2025-05-09 15:00:00', 80.00, 'Active'),
(5, '2025-05-07 16:00:00', 100.00, 'Shipped');


INSERT INTO Inventory (game_id, stock_quantity)
VALUES
(1, 100), -- PUBG Mobile
(2, 50),  -- Call of Duty
(3, 75),  -- FIFA 21
(4, 120), -- Minecraft
(5, 60);  -- Grand Theft Auto V


INSERT INTO Order_Items (order_id, game_id, quantity, price)
VALUES
(1, 1, 2, 10.00),  -- Ali Ahmed orders 2 PUBG Mobile games
(2, 2, 1, 50.00),  -- Fatima Siddiqui orders 1 Call of Duty
(3, 3, 1, 60.00),  -- Adeel Malik orders 1 FIFA 21
(4, 4, 3, 20.00),  -- Sana Bashir orders 3 Minecraft games
(5, 5, 2, 30.00);  -- Omar Ali orders 2 Grand Theft Auto V


INSERT INTO Payments (order_id, payment_date, payment_status, payment_method)
VALUES
(1, '2025-05-08 10:30:00', 'Completed', 'Credit Card'),
(2, '2025-05-08 13:00:00', 'Completed', 'PayPal'),
(3, '2025-05-08 13:15:00', 'Completed', 'PayPal'),
(4, '2025-05-09 15:30:00', 'Completed', 'Credit Card'),
(5, '2025-05-07 16:30:00', 'Completed', 'Bank Transfer');
