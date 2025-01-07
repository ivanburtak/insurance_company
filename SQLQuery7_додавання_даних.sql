CREATE OR ALTER PROCEDURE dbo.sp_SetCustomer
    @CustomerID INT = NULL OUTPUT,
    @FirstName NVARCHAR(50) = NULL,
    @LastName NVARCHAR(50) = NULL,
    @DateOfBirth DATE = NULL,
    @Phone NVARCHAR(15) = NULL,
    @Email NVARCHAR(50) = NULL,
    @Address NVARCHAR(100) = NULL
AS
BEGIN
	BEGIN TRY
		IF @CustomerID IS NULL
		BEGIN
			SET @CustomerID = 1 + ISNULL((SELECT TOP(1) CustomerID FROM dbo.Customers ORDER BY CustomerID DESC), 0)
			INSERT dbo.Customers (CustomerID, FirstName, LastName, DateOfBirth, Phone, Email, Address)
			VALUES (@CustomerID, @FirstName, @LastName, @DateOfBirth, @Phone, @Email, @Address);
		END
		ELSE
			UPDATE TOP(1) dbo.Customers
			SET FirstName = ISNULL(@FirstName, FirstName),
				LastName = ISNULL(@LastName, LastName),
				DateOfBirth = ISNULL(@DateOfBirth, DateOfBirth),
				Phone = ISNULL(@Phone, Phone),
				Email = ISNULL(@Email, Email),
				Address = ISNULL(@Address, Address)
			WHERE CustomerID = @CustomerID;
	END TRY

	BEGIN CATCH
		PRINT ERROR_MESSAGE()
	END CATCH
END;
GO

CREATE OR ALTER PROCEDURE dbo.sp_SetInsuranceType
    @TypeID INT = NULL OUTPUT,
    @TypeName NVARCHAR(50) = NULL,
    @Description NVARCHAR(255) = NULL
AS
BEGIN
    BEGIN TRY
        IF @TypeID IS NULL
        BEGIN
            SET @TypeID = 1 + ISNULL((SELECT TOP(1) TypeID FROM dbo.InsuranceTypes ORDER BY TypeID DESC), 0)
            INSERT INTO dbo.InsuranceTypes (TypeID, TypeName, Description)
            VALUES (@TypeID, @TypeName, @Description);
        END
        ELSE
        BEGIN
            UPDATE dbo.InsuranceTypes
            SET TypeName = ISNULL(@TypeName, TypeName),
                Description = ISNULL(@Description, Description)
            WHERE TypeID = @TypeID;
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;
GO

EXEC dbo.sp_SetCustomer
    @FirstName = 'Андрій', 
    @LastName = 'Шевченко', 
    @DateOfBirth = '1980-12-15', 
    @Phone = '0991234567', 
    @Email = 'andriy.shevchenko@example.com', 
    @Address = 'вул. Шевченка, 12';
GO

EXEC dbo.sp_SetCustomer
    @CustomerID = 1,      
    @FirstName = 'Іван',
	@Email = NULL;
GO

CREATE OR ALTER PROCEDURE dbo.sp_SetInsuranceProduct
    @ProductID INT = NULL OUTPUT,
    @ProductName NVARCHAR(50) = NULL,
    @TypeID INT = NULL,
    @Description NVARCHAR(255) = NULL,
    @PremiumAmount DECIMAL(15, 2) = NULL,
    @CoverageAmount DECIMAL(15, 2) = NULL
AS
BEGIN
    BEGIN TRY
        IF @ProductID IS NULL
        BEGIN
            SET @ProductID = 1 + ISNULL((SELECT TOP(1) ProductID FROM dbo.InsuranceProducts ORDER BY ProductID DESC), 0)
            INSERT INTO dbo.InsuranceProducts (ProductID, ProductName, TypeID, Description, PremiumAmount, CoverageAmount)
            VALUES (@ProductID, @ProductName, @TypeID, @Description, @PremiumAmount, @CoverageAmount);
        END
        ELSE
        BEGIN
            UPDATE dbo.InsuranceProducts
            SET ProductName = ISNULL(@ProductName, ProductName),
                TypeID = ISNULL(@TypeID, TypeID),
                Description = ISNULL(@Description, Description),
                PremiumAmount = ISNULL(@PremiumAmount, PremiumAmount),
                CoverageAmount = ISNULL(@CoverageAmount, CoverageAmount)
            WHERE ProductID = @ProductID;
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;
GO

CREATE OR ALTER PROCEDURE dbo.sp_SetPolicy
    @PolicyID INT = NULL OUTPUT,
    @PolicyNumber NVARCHAR(20) = NULL,
    @CustomerID INT = NULL,
    @ProductID INT = NULL,
    @StartDate DATE = NULL,
    @EndDate DATE = NULL,
    @IsActive BIT = NULL
AS
BEGIN
    BEGIN TRY
        IF @PolicyID IS NULL
        BEGIN
            SET @PolicyID = 1 + ISNULL((SELECT TOP(1) PolicyID FROM dbo.Policies ORDER BY PolicyID DESC), 0)
            INSERT INTO dbo.Policies (PolicyID, PolicyNumber, CustomerID, ProductID, StartDate, EndDate, IsActive)
            VALUES (@PolicyID, @PolicyNumber, @CustomerID, @ProductID, @StartDate, @EndDate, @IsActive);
        END
        ELSE
        BEGIN
            UPDATE dbo.Policies
            SET PolicyNumber = ISNULL(@PolicyNumber, PolicyNumber),
                CustomerID = ISNULL(@CustomerID, CustomerID),
                ProductID = ISNULL(@ProductID, ProductID),
                StartDate = ISNULL(@StartDate, StartDate),
                EndDate = ISNULL(@EndDate, EndDate),
                IsActive = ISNULL(@IsActive, IsActive)
            WHERE PolicyID = @PolicyID;
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;
GO

CREATE OR ALTER PROCEDURE dbo.sp_SetEmployee
    @EmployeeID INT = NULL OUTPUT,
    @FirstName NVARCHAR(50) = NULL,
    @LastName NVARCHAR(50) = NULL,
    @Position NVARCHAR(50) = NULL,
    @HireDate DATE = NULL,
    @Salary DECIMAL(15, 2) = NULL
AS
BEGIN
    BEGIN TRY
        IF @EmployeeID IS NULL
        BEGIN
            SET @EmployeeID = 1 + ISNULL((SELECT TOP(1) EmployeeID FROM dbo.Employees ORDER BY EmployeeID DESC), 0)
            INSERT INTO dbo.Employees (EmployeeID, FirstName, LastName, Position, HireDate, Salary)
            VALUES (@EmployeeID, @FirstName, @LastName, @Position, @HireDate, @Salary);
        END
        ELSE
        BEGIN
            UPDATE dbo.Employees
            SET FirstName = ISNULL(@FirstName, FirstName),
                LastName = ISNULL(@LastName, LastName),
                Position = ISNULL(@Position, Position),
                HireDate = ISNULL(@HireDate, HireDate),
                Salary = ISNULL(@Salary, Salary)
            WHERE EmployeeID = @EmployeeID;
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;
GO

CREATE OR ALTER PROCEDURE dbo.sp_SetClaim
    @ClaimID INT = NULL OUTPUT,
    @PolicyID INT = NULL,
    @ClaimDate DATE = NULL,
    @ClaimAmount DECIMAL(15, 2) = NULL,
    @Status NVARCHAR(50) = NULL,
    @ProcessedByID INT = NULL
AS
BEGIN
    BEGIN TRY
        IF @ClaimID IS NULL
        BEGIN
            SET @ClaimID = 1 + ISNULL((SELECT TOP(1) ClaimID FROM dbo.Claims ORDER BY ClaimID DESC), 0)
            INSERT INTO dbo.Claims (ClaimID, PolicyID, ClaimDate, ClaimAmount, Status, ProcessedByID)
            VALUES (@ClaimID, @PolicyID, @ClaimDate, @ClaimAmount, @Status, @ProcessedByID);
        END
        ELSE
        BEGIN
            UPDATE dbo.Claims
            SET PolicyID = ISNULL(@PolicyID, PolicyID),
                ClaimDate = ISNULL(@ClaimDate, ClaimDate),
                ClaimAmount = ISNULL(@ClaimAmount, ClaimAmount),
                Status = ISNULL(@Status, Status),
                ProcessedByID = ISNULL(@ProcessedByID, ProcessedByID)
            WHERE ClaimID = @ClaimID;
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;
GO

CREATE OR ALTER PROCEDURE dbo.sp_SetCustomerDiscount
    @DiscountID INT = NULL OUTPUT,
    @DiscountAmount DECIMAL(15, 2) = NULL,
    @ValidFrom DATE = NULL,
    @ValidUntil DATE = NULL,
    @CustomerID INT = NULL
AS
BEGIN
    BEGIN TRY
        IF @DiscountID IS NULL
        BEGIN
            SET @DiscountID = 1 + ISNULL((SELECT TOP(1) DiscountID FROM dbo.CustomerDiscounts ORDER BY DiscountID DESC), 0)
            INSERT INTO dbo.CustomerDiscounts (DiscountID, DiscountAmount, ValidFrom, ValidUntil, CustomerID)
            VALUES (@DiscountID, @DiscountAmount, @ValidFrom, @ValidUntil, @CustomerID);
        END
        ELSE
        BEGIN
            UPDATE dbo.CustomerDiscounts
            SET DiscountAmount = ISNULL(@DiscountAmount, DiscountAmount),
                ValidFrom = ISNULL(@ValidFrom, ValidFrom),
                ValidUntil = ISNULL(@ValidUntil, ValidUntil),
                CustomerID = ISNULL(@CustomerID, CustomerID)
            WHERE DiscountID = @DiscountID;
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;
GO

CREATE OR ALTER PROCEDURE dbo.sp_SetProductDiscount
    @DiscountID INT = NULL OUTPUT,
    @DiscountAmount DECIMAL(15, 2) = NULL,
    @ValidFrom DATE = NULL,
    @ValidUntil DATE = NULL,
    @ProductID INT = NULL
AS
BEGIN
    BEGIN TRY
        IF @DiscountID IS NULL
        BEGIN
            SET @DiscountID = 1 + ISNULL((SELECT TOP(1) DiscountID FROM dbo.ProductDiscounts ORDER BY DiscountID DESC), 0)
            INSERT INTO dbo.ProductDiscounts (DiscountID, DiscountAmount, ValidFrom, ValidUntil, ProductID)
            VALUES (@DiscountID, @DiscountAmount, @ValidFrom, @ValidUntil, @ProductID);
        END
        ELSE
        BEGIN
            UPDATE dbo.ProductDiscounts
            SET DiscountAmount = ISNULL(@DiscountAmount, DiscountAmount),
                ValidFrom = ISNULL(@ValidFrom, ValidFrom),
                ValidUntil = ISNULL(@ValidUntil, ValidUntil),
                ProductID = ISNULL(@ProductID, ProductID)
            WHERE DiscountID = @DiscountID;
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;
GO

CREATE OR ALTER PROCEDURE dbo.sp_SetPayment
    @PaymentID INT = NULL OUTPUT,
    @PolicyID INT = NULL,
    @PaymentMethod NVARCHAR(50) = NULL,
    @PaymentDate DATE = NULL,
    @PaymentAmount DECIMAL(15, 2) = NULL
AS
BEGIN
    BEGIN TRY
        IF @PaymentID IS NULL
        BEGIN
            SET @PaymentID = 1 + ISNULL((SELECT TOP(1) PaymentID FROM dbo.Payments ORDER BY PaymentID DESC), 0)
            INSERT INTO dbo.Payments (PaymentID, PolicyID, PaymentMethod, PaymentDate, PaymentAmount)
            VALUES (@PaymentID, @PolicyID, @PaymentMethod, @PaymentDate, @PaymentAmount);
        END
        ELSE
        BEGIN
            UPDATE dbo.Payments
            SET PolicyID = ISNULL(@PolicyID, PolicyID),
                PaymentMethod = ISNULL(@PaymentMethod, PaymentMethod),
                PaymentDate = ISNULL(@PaymentDate, PaymentDate),
                PaymentAmount = ISNULL(@PaymentAmount, PaymentAmount)
            WHERE PaymentID = @PaymentID;
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;
GO
