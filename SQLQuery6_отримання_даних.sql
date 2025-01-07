CREATE OR ALTER PROCEDURE dbo.sp_GetCustomer
	@CustomerID INT = NULL,
	@Name NVARCHAR(50) = NULL,
	@DateOfBirth DATE = NULL,
	@PageSize INT = 20,
	@PageNumber INT = 1,
	@SortColumn VARCHAR(128) = 'CustomerID',
	@SortDirection BIT = 0        -- 0-ASC, 1-DESC
AS
	IF @CustomerID IS NOT NULL AND 
	NOT EXISTS(
		SELECT *
		FROM Customers
		WHERE CustomerID = @CustomerID
	)
	BEGIN
		PRINT 'Incorrect value of @CustomerID'
		RETURN
	END

	SELECT *
	FROM Customers
	WHERE
		(@CustomerID IS NULL OR CustomerID = @CustomerID) AND
		(@Name IS NULL OR LastName LIKE @Name +'%' OR FirstName LIKE @Name + '%') AND
		(@DateOfBirth IS NULL OR DateOfBirth = @DateOfBirth)
	ORDER BY
		CASE
		WHEN @SortDirection = 0 THEN
			CASE @SortColumn
				WHEN 'CustomerID'  THEN RIGHT('          '+CAST(CustomerID AS NVARCHAR(50)), 10)
				WHEN 'LastName'    THEN LastName
				WHEN 'FirstName'   THEN FirstName    
				WHEN 'DateOfBirth' THEN CONVERT(NVARCHAR, DateOfBirth, 112)
			END
		END ASC,
		CASE
		WHEN @SortDirection = 1 THEN
			CASE @SortColumn
				WHEN 'CustomerID'  THEN RIGHT('          '+CAST(CustomerID AS NVARCHAR(50)), 10)
				WHEN 'LastName'    THEN LastName
				WHEN 'FirstName'   THEN FirstName    
				WHEN 'DateOfBirth' THEN CONVERT(NVARCHAR, DateOfBirth, 112)
			END
		END DESC
	OFFSET (@PageNumber - 1) * @PageSize ROWS  
	FETCH NEXT @PageSize ROWS ONLY
GO


EXEC sp_GetCustomer
	@SortColumn = 'DateOfBirth',
	@SortDirection = 1
GO


CREATE OR ALTER PROCEDURE dbo.sp_GetInsuranceType
    @TypeID INT = NULL,
    @TypeName NVARCHAR(50) = NULL,
    @PageSize INT = 20,
    @PageNumber INT = 1,
    @SortColumn VARCHAR(128) = 'TypeID',
    @SortDirection BIT = 0
AS
    IF @TypeID IS NOT NULL AND 
    NOT EXISTS(
        SELECT *
        FROM InsuranceTypes
        WHERE TypeID = @TypeID
    )
    BEGIN
        PRINT 'Incorrect value of @TypeID'
        RETURN
    END

    SELECT *
    FROM InsuranceTypes
    WHERE
        (@TypeID IS NULL OR TypeID = @TypeID) AND
        (@TypeName IS NULL OR TypeName LIKE @TypeName + '%')
    ORDER BY
        CASE
        WHEN @SortDirection = 0 THEN
            CASE @SortColumn
                WHEN 'TypeID' THEN RIGHT('          '+CAST(TypeID AS NVARCHAR(50)), 10)
                WHEN 'TypeName' THEN TypeName
            END
        END ASC,
        CASE
        WHEN @SortDirection = 1 THEN
            CASE @SortColumn
                WHEN 'TypeID' THEN RIGHT('          '+CAST(TypeID AS NVARCHAR(50)), 10)
                WHEN 'TypeName' THEN TypeName
            END
        END DESC
    OFFSET (@PageNumber - 1) * @PageSize ROWS  
    FETCH NEXT @PageSize ROWS ONLY
GO


CREATE OR ALTER PROCEDURE dbo.sp_GetInsuranceProduct
    @ProductID INT = NULL,
    @ProductName NVARCHAR(50) = NULL,
    @TypeID INT = NULL,
    @PageSize INT = 20,
    @PageNumber INT = 1,
    @SortColumn VARCHAR(128) = 'ProductID',
    @SortDirection BIT = 0
AS
    IF @ProductID IS NOT NULL AND 
    NOT EXISTS(
        SELECT *
        FROM InsuranceProducts
        WHERE ProductID = @ProductID
    )
    BEGIN
        PRINT 'Incorrect value of @ProductID'
        RETURN
    END

    SELECT *
    FROM InsuranceProducts
    WHERE
        (@ProductID IS NULL OR ProductID = @ProductID) AND
        (@ProductName IS NULL OR ProductName LIKE @ProductName + '%') AND
        (@TypeID IS NULL OR TypeID = @TypeID)
    ORDER BY
        CASE
        WHEN @SortDirection = 0 THEN
            CASE @SortColumn
                WHEN 'ProductID' THEN RIGHT('          '+CAST(ProductID AS NVARCHAR(50)), 10)
                WHEN 'ProductName' THEN ProductName
                WHEN 'TypeID' THEN RIGHT('          '+CAST(TypeID AS NVARCHAR(50)), 10)
            END
        END ASC,
        CASE
        WHEN @SortDirection = 1 THEN
            CASE @SortColumn
                WHEN 'ProductID' THEN RIGHT('          '+CAST(ProductID AS NVARCHAR(50)), 10)
                WHEN 'ProductName' THEN ProductName
                WHEN 'TypeID' THEN RIGHT('          '+CAST(TypeID AS NVARCHAR(50)), 10)
            END
        END DESC
    OFFSET (@PageNumber - 1) * @PageSize ROWS  
    FETCH NEXT @PageSize ROWS ONLY
GO


CREATE OR ALTER PROCEDURE dbo.sp_GetPolicy
    @PolicyID INT = NULL,
    @PolicyNumber NVARCHAR(20) = NULL,
    @CustomerID INT = NULL,
    @ProductID INT = NULL,
    @PageSize INT = 20,
    @PageNumber INT = 1,
    @SortColumn VARCHAR(128) = 'PolicyID',
    @SortDirection BIT = 0
AS
    IF @PolicyID IS NOT NULL AND 
    NOT EXISTS(
        SELECT *
        FROM Policies
        WHERE PolicyID = @PolicyID
    )
    BEGIN
        PRINT 'Incorrect value of @PolicyID'
        RETURN
    END

    SELECT *
    FROM Policies
    WHERE
        (@PolicyID IS NULL OR PolicyID = @PolicyID) AND
        (@PolicyNumber IS NULL OR PolicyNumber LIKE @PolicyNumber + '%') AND
        (@CustomerID IS NULL OR CustomerID = @CustomerID) AND
        (@ProductID IS NULL OR ProductID = @ProductID)
    ORDER BY
        CASE
        WHEN @SortDirection = 0 THEN
            CASE @SortColumn
                WHEN 'PolicyID' THEN RIGHT('          '+CAST(PolicyID AS NVARCHAR(50)), 10)
                WHEN 'PolicyNumber' THEN PolicyNumber
                WHEN 'CustomerID' THEN RIGHT('          '+CAST(CustomerID AS NVARCHAR(50)), 10)
                WHEN 'ProductID' THEN RIGHT('          '+CAST(ProductID AS NVARCHAR(50)), 10)
            END
        END ASC,
        CASE
        WHEN @SortDirection = 1 THEN
            CASE @SortColumn
                WHEN 'PolicyID' THEN RIGHT('          '+CAST(PolicyID AS NVARCHAR(50)), 10)
                WHEN 'PolicyNumber' THEN PolicyNumber
                WHEN 'CustomerID' THEN RIGHT('          '+CAST(CustomerID AS NVARCHAR(50)), 10)
                WHEN 'ProductID' THEN RIGHT('          '+CAST(ProductID AS NVARCHAR(50)), 10)
            END
        END DESC
    OFFSET (@PageNumber - 1) * @PageSize ROWS  
    FETCH NEXT @PageSize ROWS ONLY
GO


CREATE OR ALTER PROCEDURE dbo.sp_GetEmployee
    @EmployeeID INT = NULL,
	@Name NVARCHAR(50) = NULL,
    @Position NVARCHAR(50) = NULL,
	@Salary DECIMAL(15, 2) = NULL,
    @PageSize INT = 20,
    @PageNumber INT = 1,
    @SortColumn VARCHAR(128) = 'EmployeeID',
    @SortDirection BIT = 0
AS
    IF @EmployeeID IS NOT NULL AND 
    NOT EXISTS(
        SELECT *
        FROM Employees
        WHERE EmployeeID = @EmployeeID
    )
    BEGIN
        PRINT 'Incorrect value of @EmployeeID'
        RETURN
    END

    SELECT *
    FROM Employees
    WHERE
        (@EmployeeID IS NULL OR EmployeeID = @EmployeeID) AND
        (@Name IS NULL OR LastName LIKE @Name +'%' OR FirstName LIKE @Name + '%') AND
        (@Position IS NULL OR Position LIKE @Position + '%') AND
		(@Salary IS NULL OR Salary = @Salary)
    ORDER BY
        CASE
        WHEN @SortDirection = 0 THEN
            CASE @SortColumn
                WHEN 'EmployeeID' THEN RIGHT('          '+CAST(EmployeeID AS NVARCHAR(50)), 10)
                WHEN 'FirstName' THEN FirstName
                WHEN 'LastName' THEN LastName
                WHEN 'Position' THEN Position
				WHEN 'Salary' THEN Salary
            END
        END ASC,
        CASE
        WHEN @SortDirection = 1 THEN
            CASE @SortColumn
                WHEN 'EmployeeID' THEN RIGHT('          '+CAST(EmployeeID AS NVARCHAR(50)), 10)
                WHEN 'FirstName' THEN FirstName
                WHEN 'LastName' THEN LastName
                WHEN 'Position' THEN Position
				WHEN 'Salary' THEN Salary
            END
        END DESC
    OFFSET (@PageNumber - 1) * @PageSize ROWS  
    FETCH NEXT @PageSize ROWS ONLY
GO

EXEC sp_GetEmployee
	@SortColumn = 'Salary'
GO

-- Procedure for Claims
CREATE OR ALTER PROCEDURE dbo.sp_GetClaim
    @ClaimID INT = NULL,
    @PolicyID INT = NULL,
    @ClaimDate DATE = NULL,
    @ProcessedByID INT = NULL,
    @PageSize INT = 20,
    @PageNumber INT = 1,
    @SortColumn VARCHAR(128) = 'ClaimID',
    @SortDirection BIT = 0
AS
    IF @ClaimID IS NOT NULL AND 
    NOT EXISTS(
        SELECT *
        FROM Claims
        WHERE ClaimID = @ClaimID
    )
    BEGIN
        PRINT 'Incorrect value of @ClaimID'
        RETURN
    END

    SELECT *
    FROM Claims
    WHERE
        (@ClaimID IS NULL OR ClaimID = @ClaimID) AND
        (@PolicyID IS NULL OR PolicyID = @PolicyID) AND
        (@ClaimDate IS NULL OR ClaimDate = @ClaimDate) AND
        (@ProcessedByID IS NULL OR ProcessedByID = @ProcessedByID)
    ORDER BY
        CASE
        WHEN @SortDirection = 0 THEN
            CASE @SortColumn
                WHEN 'ClaimID' THEN RIGHT('          '+CAST(ClaimID AS NVARCHAR(50)), 10)
                WHEN 'PolicyID' THEN RIGHT('          '+CAST(PolicyID AS NVARCHAR(50)), 10)
                WHEN 'ClaimDate' THEN CONVERT(NVARCHAR, ClaimDate, 112)
                WHEN 'ProcessedByID' THEN RIGHT('          '+CAST(ProcessedByID AS NVARCHAR(50)), 10)
            END
        END ASC,
        CASE
        WHEN @SortDirection = 1 THEN
            CASE @SortColumn
                WHEN 'ClaimID' THEN RIGHT('          '+CAST(ClaimID AS NVARCHAR(50)), 10)
                WHEN 'PolicyID' THEN RIGHT('          '+CAST(PolicyID AS NVARCHAR(50)), 10)
                WHEN 'ClaimDate' THEN CONVERT(NVARCHAR, ClaimDate, 112)
                WHEN 'ProcessedByID' THEN RIGHT('          '+CAST(ProcessedByID AS NVARCHAR(50)), 10)
            END
        END DESC
    OFFSET (@PageNumber - 1) * @PageSize ROWS  
    FETCH NEXT @PageSize ROWS ONLY
GO

-- Procedure for CustomerDiscounts
CREATE OR ALTER PROCEDURE dbo.sp_GetCustomerDiscount
    @DiscountID INT = NULL,
    @CustomerID INT = NULL,
    @ValidFrom DATE = NULL,
    @ValidUntil DATE = NULL,
    @PageSize INT = 20,
    @PageNumber INT = 1,
    @SortColumn VARCHAR(128) = 'DiscountID',
    @SortDirection BIT = 0
AS
    IF @DiscountID IS NOT NULL AND 
    NOT EXISTS(
        SELECT *
        FROM CustomerDiscounts
        WHERE DiscountID = @DiscountID
    )
    BEGIN
        PRINT 'Incorrect value of @DiscountID'
        RETURN
    END

    SELECT *
    FROM CustomerDiscounts
    WHERE
        (@DiscountID IS NULL OR DiscountID = @DiscountID) AND
        (@CustomerID IS NULL OR CustomerID = @CustomerID) AND
        (@ValidFrom IS NULL OR ValidFrom = @ValidFrom) AND
        (@ValidUntil IS NULL OR ValidUntil = @ValidUntil)
    ORDER BY
        CASE
        WHEN @SortDirection = 0 THEN
            CASE @SortColumn
                WHEN 'DiscountID' THEN RIGHT('          '+CAST(DiscountID AS NVARCHAR(50)), 10)
                WHEN 'CustomerID' THEN RIGHT('          '+CAST(CustomerID AS NVARCHAR(50)), 10)
                WHEN 'ValidFrom' THEN CONVERT(NVARCHAR, ValidFrom, 112)
                WHEN 'ValidUntil' THEN CONVERT(NVARCHAR, ValidUntil, 112)
            END
        END ASC,
        CASE
        WHEN @SortDirection = 1 THEN
            CASE @SortColumn
                WHEN 'DiscountID' THEN RIGHT('          '+CAST(DiscountID AS NVARCHAR(50)), 10)
                WHEN 'CustomerID' THEN RIGHT('          '+CAST(CustomerID AS NVARCHAR(50)), 10)
                WHEN 'ValidFrom' THEN CONVERT(NVARCHAR, ValidFrom, 112)
                WHEN 'ValidUntil' THEN CONVERT(NVARCHAR, ValidUntil, 112)
            END
        END DESC
    OFFSET (@PageNumber - 1) * @PageSize ROWS  
    FETCH NEXT @PageSize ROWS ONLY
GO


CREATE OR ALTER PROCEDURE dbo.sp_GetPayments
    @PaymentID INT = NULL,
    @PolicyID INT = NULL,
    @PaymentMethod NVARCHAR(50) = NULL,
    @PaymentDate DATE = NULL,
	@PaymentAmount DECIMAL(15, 2) = NULL,
    @PageSize INT = 20,
    @PageNumber INT = 1,
    @SortColumn VARCHAR(128) = 'PaymentID',
    @SortDirection BIT = 0        -- 0-ASC, 1-DESC
AS
    IF @PaymentID IS NOT NULL AND 
    NOT EXISTS(
        SELECT *
        FROM Payments
        WHERE PaymentID = @PaymentID
    )
    BEGIN
        PRINT 'Incorrect value of @PaymentID'
        RETURN
    END

    SELECT *
    FROM Payments
    WHERE
        (@PaymentID IS NULL OR PaymentID = @PaymentID) AND
        (@PolicyID IS NULL OR PolicyID = @PolicyID) AND
        (@PaymentMethod IS NULL OR PaymentMethod LIKE @PaymentMethod + '%') AND
        (@PaymentDate IS NULL OR PaymentDate = @PaymentDate) AND
		(@PaymentAmount IS NULL OR PaymentAmount = @PaymentAmount)
    ORDER BY
        CASE
            WHEN @SortDirection = 0 THEN
                CASE @SortColumn
                    WHEN 'PaymentID'    THEN RIGHT('          '+CAST(PaymentID AS NVARCHAR(50)), 10)
                    WHEN 'PolicyID'     THEN RIGHT('          '+CAST(PolicyID AS NVARCHAR(50)), 10)
                    WHEN 'PaymentMethod' THEN PaymentMethod
                    WHEN 'PaymentDate'   THEN CONVERT(NVARCHAR, PaymentDate, 112)
                    WHEN 'PaymentAmount' THEN PaymentAmount
                END
        END ASC,
        CASE
            WHEN @SortDirection = 1 THEN
                CASE @SortColumn
                    WHEN 'PaymentID'    THEN RIGHT('          '+CAST(PaymentID AS NVARCHAR(50)), 10)
                    WHEN 'PolicyID'     THEN RIGHT('          '+CAST(PolicyID AS NVARCHAR(50)), 10)
                    WHEN 'PaymentMethod' THEN PaymentMethod
                    WHEN 'PaymentDate'   THEN CONVERT(NVARCHAR, PaymentDate, 112)
                    WHEN 'PaymentAmount' THEN PaymentAmount
                END
        END DESC
    OFFSET (@PageNumber - 1) * @PageSize ROWS  
    FETCH NEXT @PageSize ROWS ONLY
GO

EXEC sp_GetPayments
	@SortColumn = 'PaymentMethod'
GO