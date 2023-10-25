
-- Create the Users table for user authentication
-- Have added the status attribute for I to accomoate the fact of account activation hence once verified via email [FiRST TIME USER] then system becaume activated
-- Have also added Role due to the possibility of giving out the display [VIEWS] differently to the different system user

CREATE TABLE Users (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    Username VARCHAR(50) NOT NULL UNIQUE,
    PasswordHash CHAR(64) NOT NULL, -- Store hashed passwords
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Status ENUM('Unverified', 'Verified') DEFAULT 'Unverified',
    Role ENUM('Administration', 'Sales Rep', 'Customer') DEFAULT 'Customer'
);

-- Create the Categories table for categorizing products

CREATE TABLE Categories (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(50) NOT NULL
);

-- Create the Suppliers table to store supplier information
-- Hence tracking back the source if need be

CREATE TABLE Suppliers (
    SupplierID INT AUTO_INCREMENT PRIMARY KEY,
    SupplierName VARCHAR(100) NOT NULL,
    PhoneNumber VARCHAR(50),
    Email VARCHAR(50)
);

-- Create the Products table to store inventory items

CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Description TEXT,
    Quantity INT NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    Category VARCHAR(50),
    SupplierID INT,
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);

-- Create the Transactions table to record sales and purchases
-- The major table that would also implement the tracking of how many items of similar type are in stock

CREATE TABLE Transactions (
    TransactionID INT AUTO_INCREMENT PRIMARY KEY,
    ProductID INT,
    UserID INT,
    TransactionType ENUM('Sale', 'Purchase') NOT NULL,
    Quantity INT NOT NULL,
    TransactionDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Amount DECIMAL(10, 2) NOT NULL,
    Notes TEXT,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- Create a UserTransactions table to link users to their transactions
-- This table highly links the different users to the respective items that they have been working on
-- Operations that can be implemented on this table are very clear on the documentation

CREATE TABLE UserTransactions (
    UserTransactionID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT,
    TransactionID INT,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (TransactionID) REFERENCES Transactions(TransactionID)
);

