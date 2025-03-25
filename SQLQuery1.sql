-- T?o Database
CREATE DATABASE BookShop;
GO

USE BookShop;
GO

-- B?ng Users: L?u thông tin ng??i dùng
CREATE TABLE Users (
    UserID          INT PRIMARY KEY IDENTITY(1,1),
    Username        VARCHAR(50) NOT NULL UNIQUE,
    Password        VARCHAR(255) NOT NULL,
    FullName        VARCHAR(100) NOT NULL,
    Email           VARCHAR(100) NOT NULL UNIQUE,
    Phone           VARCHAR(20),
    Address         VARCHAR(255),
    DateOfBirth     DATE,
    RegistrationDate DATETIME DEFAULT GETDATE(),
    IsAdmin         BIT NOT NULL DEFAULT 0 CHECK (IsAdmin IN (0,1)),
    Money           DECIMAL(10,2) DEFAULT 0.00
);
GO

-- B?ng DepositHistory: L?ch s? n?p ti?n
CREATE TABLE DepositHistory (
    DepositID   INT IDENTITY(1,1) PRIMARY KEY,
    UserID      INT NOT NULL,
    BankName    NVARCHAR(100) NOT NULL,
    Value       DECIMAL(18,2) NOT NULL CHECK (Value > 0),
    DepositDate DATETIME DEFAULT GETDATE(),
    Status      NVARCHAR(10) NOT NULL DEFAULT 'Waiting' CHECK (Status IN ('Waiting', 'Completed')),
    CONSTRAINT  FK_DepositHistory_Users FOREIGN KEY (UserID) REFERENCES Users(UserID)
);
GO

-- B?ng Books: L?u thông tin sách
CREATE TABLE Books (
    BookID          INT PRIMARY KEY IDENTITY(1,1),
    Title           VARCHAR(255) NOT NULL,
    Author          VARCHAR(100) NOT NULL,
    Genre           VARCHAR(50),
    PublishedYear   INT,
    Publisher       VARCHAR(100),
    Description     TEXT,
    TotalCopies     INT NOT NULL,
    AvailableCopies INT NOT NULL CHECK (AvailableCopies >= 0),
    Price           DECIMAL(10,2) NOT NULL,
    ImagePath       CHAR(50),
    PageCount       INT,
    Language        VARCHAR(50),
    AddedDate       DATETIME DEFAULT GETDATE()
);
GO

-- B?ng Sales: L?u thông tin ??n hàng
CREATE TABLE Sales (
    SaleID      INT PRIMARY KEY IDENTITY(1,1),
    UserID      INT NOT NULL,
    BookID      INT NOT NULL,
    SaleDate    DATETIME DEFAULT GETDATE(),
    Quantity    INT NOT NULL CHECK (Quantity > 0),
    TotalPrice  DECIMAL(10,2) NOT NULL,
    Status      VARCHAR(20) DEFAULT 'Pending' CHECK (Status IN ('Pending', 'Completed', 'Cancelled', 'Refunded', 'Pending Refund')),
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID) ON DELETE CASCADE
);
GO

-- B?ng Revenue: L?u thông tin doanh thu hàng ngày
CREATE TABLE Revenue (
    RevenueID    INT PRIMARY KEY IDENTITY(1,1),
    RevenueDate  DATE NOT NULL UNIQUE,
    TotalSales   INT DEFAULT 0,
    TotalRevenue DECIMAL(10,2) DEFAULT 0.00
);
GO

-- B?ng Feedbacks: L?u thông tin ?ánh giá sách
CREATE TABLE Feedbacks (
    UserID       INT NOT NULL,
    BookID       INT NOT NULL,
    Rating       INT NOT NULL CHECK (Rating BETWEEN 1 AND 5),
    Comment      TEXT,
    FeedbackDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);
GO

-- Thêm d? li?u vào b?ng Users
INSERT INTO Users (Username, Password, FullName, Email, Phone, Address, DateOfBirth, IsAdmin, Money)
VALUES 
    ('admin',     'admin123',   'Admin User',    'admin@bookshop.com', '0123456789', 'FPT Da Nang',      '1990-01-01', 1, 10000.00),
    ('alice123',  'password123','Alice Johnson', 'alice@example.com',  '123456789',  '123 Main St',      '1995-05-10', 0, 500.00),
    ('bob456',    'securepass', 'Bob Smith',     'bob@example.com',    '987654321',  '456 Elm St',       '1990-08-22', 0, 300.00),
    ('charlie789','pass789',    'Charlie Brown', 'charlie@example.com','555666777',  '789 Oak St',       '1985-12-01', 0, 800.00);
GO

-- Thêm d? li?u vào b?ng Books v?i nhi?u sách n?i ti?ng c?a Vi?t Nam và n??c ngoài
INSERT INTO Books (Title, Author, Genre, PublishedYear, Publisher, Description, TotalCopies, AvailableCopies, Price, ImagePath, PageCount, Language)
VALUES
-- Sách l?p trình & khoa h?c máy tính
('Clean Code', 'Robert C. Martin', 'Programming', 2008, 'Prentice Hall', 'A guide to writing clean and maintainable code.', 10, 10, 150.00, '/images/CleanCode.png', 464, 'English'),
('The Pragmatic Programmer', 'Andrew Hunt', 'Software Development', 1999, 'Addison-Wesley', 'Tips and techniques for software craftsmanship.', 8, 8, 120.00, '/images/ThePragmaticProgrammer.png', 352, 'English'),
('Introduction to Algorithms', 'Thomas H. Cormen', 'Computer Science', 2009, 'MIT Press', 'A comprehensive book on algorithms.', 5, 5, 200.00, '/images/IntroductionToAlgorithms.png', 1312, 'English'),
('Design Patterns', 'Erich Gamma', 'Software Engineering', 1994, 'Addison-Wesley', 'A classic book on software design patterns.', 7, 7, 180.00, '/images/DesignPatterns.png', 395, 'English'),

-- Sách v?n h?c qu?c t?
('1984', 'George Orwell', 'Dystopian', 1949, 'Secker & Warburg', 'A dystopian novel about totalitarianism.', 15, 15, 100.00, '/images/1984.jpg', 328, 'English'),
('To Kill a Mockingbird', 'Harper Lee', 'Classic', 1960, 'J.B. Lippincott & Co.', 'A novel about racial injustice in the American South.', 10, 10, 110.00, '/images/ToKillAMockingbird.jpg', 281, 'English'),
('The Great Gatsby', 'F. Scott Fitzgerald', 'Classic', 1925, 'Charles Scribner’s Sons', 'A critique of the American Dream.', 12, 12, 90.00, '/images/TheGreatGatsby.png', 180, 'English'),
('Pride and Prejudice', 'Jane Austen', 'Romance', 1813, 'T. Egerton', 'A classic romantic novel.', 14, 14, 85.00, '/images/PrideAndPrejudice.jpg', 279, 'English'),

-- Sách v?n h?c Vi?t Nam
('Nhat ky Dang Thuy Tram', 'Dang Thuy Tram', 'Memoir', 2005, 'Nha xuat ban Tre', 'Nhat ky cua nu bac si tre trong chien tranh.', 10, 10, 80.00, '/images/NhatKyDangThuyTram.jpg', 320, 'Vietnamese');

GO

-- Thêm d? li?u vào b?ng Sales
INSERT INTO Sales (UserID, BookID, Quantity, TotalPrice, Status)
VALUES 
    (2, 1, 2, 300.00, 'Completed'),  -- Alice mua 2 quy?n "Clean Code"
    (3, 2, 1, 120.00, 'Completed'),  -- Bob mua 1 quy?n "The Pragmatic Programmer"
    (4, 3, 1, 200.00, 'Pending'),   -- Charlie ??t mua "Introduction to Algorithms"
    (2, 4, 1, 180.00, 'Completed');  -- Alice mua 1 quy?n "Design Patterns"
GO