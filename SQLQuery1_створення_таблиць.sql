CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    DateOfBirth DATE,
    Phone NVARCHAR(15),
    Email NVARCHAR(50),
    Address NVARCHAR(100)
);

CREATE TABLE InsuranceTypes (
    TypeID INT PRIMARY KEY,
    TypeName NVARCHAR(50) NOT NULL,
    Description NVARCHAR(255)
);

CREATE TABLE InsuranceProducts (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(50) NOT NULL,
	TypeID INT,
	FOREIGN KEY (TypeID) REFERENCES InsuranceTypes(TypeID),
    Description NVARCHAR(255),
	PremiumAmount DECIMAL(15, 2) NOT NULL,
    CoverageAmount DECIMAL(15, 2) NOT NULL
);

CREATE TABLE Policies (
    PolicyID INT PRIMARY KEY,
    PolicyNumber NVARCHAR(20) NOT NULL UNIQUE,
	CustomerID INT NOT NULL,
	FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    ProductID INT NOT NULL,
	FOREIGN KEY (ProductID) REFERENCES InsuranceProducts(ProductID),
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    IsActive BIT
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Position NVARCHAR(50) NOT NULL,
    HireDate DATE,
    Salary DECIMAL(15, 2)
);

CREATE TABLE Claims (
    ClaimID INT PRIMARY KEY,
    PolicyID INT NOT NULL,
	FOREIGN KEY (PolicyID) REFERENCES Policies(PolicyID),
    ClaimDate DATE,
    ClaimAmount DECIMAL(15, 2),
    Status NVARCHAR(50),
	ProcessedByID INT NULL,
	FOREIGN KEY (ProcessedByID) REFERENCES Employees(EmployeeID)
);

CREATE TABLE CustomerDiscounts (
	DiscountID INT PRIMARY KEY,
    DiscountAmount DECIMAL(15, 2) NOT NULL,
    ValidFrom DATE,
    ValidUntil DATE NOT NULL,
    CustomerID INT UNIQUE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE ProductDiscounts (
	DiscountID INT PRIMARY KEY,
    DiscountAmount DECIMAL(15, 2) NOT NULL,
    ValidFrom DATE,
    ValidUntil DATE NOT NULL,
    ProductID INT UNIQUE,
    FOREIGN KEY (ProductID) REFERENCES InsuranceProducts(ProductID)
);

CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    PolicyID INT,
	FOREIGN KEY (PolicyID) REFERENCES Policies(PolicyID),
	PaymentMethod NVARCHAR(50),
    PaymentDate DATE,
    PaymentAmount DECIMAL(15, 2)
);
