CREATE OR ALTER PROCEDURE dbo.sp_CreateClientPolicyAndPayment
    @FirstName NVARCHAR(50),
    @LastName NVARCHAR(50),
    @DateOfBirth DATE,
    @Phone NVARCHAR(15),
    @Email NVARCHAR(50),
    @Address NVARCHAR(100),
    @ProductID INT,
    @StartDate DATE = NULL,
    @EndDate DATE = NULL,
    @PaymentAmount DECIMAL(15, 2),
    @PaymentMethod NVARCHAR(50),
    @PaymentDate DATE = NULL
AS
BEGIN
    BEGIN TRY
        -- Крок 1: Створення клієнта
		DECLARE @CustomerID INT;
		EXEC sp_SetCustomer
			@CustomerID = @CustomerID OUTPUT,
			@FirstName = @FirstName,
			@LastName = @LastName,
			@DateOfBirth = @DateOfBirth,
			@Phone = @Phone,
			@Email = @Email,
			@Address = @Address;

        -- Крок 2: Створення полісу
		IF @StartDate IS NULL
			SET @StartDate = CAST(GETDATE() AS DATE);
		IF @EndDate IS NULL
			SET @EndDate = DATEADD(YEAR, 1, @StartDate);

		DECLARE @PolicyID INT;
		EXEC sp_SetPolicy
			@PolicyID = @PolicyID OUTPUT,
			@PolicyNumber = ' ',
			@CustomerID = @CustomerID,
			@ProductID = @ProductID,
			@StartDate = @StartDate,
			@EndDate = @EndDate,
			@IsActive = 1;

        -- Генерація унікального номера полісу
		DECLARE @PolicyNumber NVARCHAR(20) = 'POL-' + RIGHT('00000' + CAST(@PolicyID AS NVARCHAR(5)), 5);
		EXEC sp_SetPolicy
			@PolicyID = @PolicyID,
			@PolicyNumber = @PolicyNumber;

        -- Крок 3: Реєстрація оплати
		IF @PaymentDate IS NULL
			SET @PaymentDate = CAST(GETDATE() AS DATE);

		DECLARE @PaymentID INT;
		EXEC sp_SetPayment
			@PaymentID = @PaymentID OUTPUT,
			@PolicyID = @PolicyID,
			@PaymentAmount = @PaymentAmount,
			@PaymentMethod = @PaymentMethod;
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;


EXEC dbo.sp_CreateClientPolicyAndPayment
    @FirstName = 'Олена',
    @LastName = 'Шевченко',
    @DateOfBirth = '1990-05-20',
    @Phone = '0671234567',
    @Email = 'olena.shevchenko@example.com',
    @Address = 'вул. Центральна, 10',
    @ProductID = 2,               -- Ідентифікатор страхового продукту
    @StartDate = '2025-02-01',
    @EndDate = '2026-02-01',
    @PaymentAmount = 1000.00,     -- Сума оплати
    @PaymentMethod = 'Картка',    -- Метод оплати
    @PaymentDate = '2025-01-15';
GO


CREATE OR ALTER PROCEDURE dbo.sp_PaymentAndUpdateForPolicy
    @PolicyID INT,
    @PaymentAmount DECIMAL(15, 2),
    @PaymentMethod NVARCHAR(50),
    @PaymentDate DATE = NULL,
    @RenewalYears INT = 1
AS
BEGIN
    BEGIN TRY
        -- Реєстрація платежу
		IF @PaymentDate IS NULL
			SET @PaymentDate = CAST(GETDATE() AS DATE);

		DECLARE @PaymentID INT;
		EXEC sp_SetPayment
			@PaymentID = @PaymentID OUTPUT,
			@PolicyID = @PolicyID,
			@PaymentAmount = @PaymentAmount,
			@PaymentMethod = @PaymentMethod,
			@PaymentDate = @PaymentDate;

		-- Отримання статусу полісу
		DECLARE @IsPolicyActive BIT;
		DECLARE @EndDate DATE;

		SELECT @IsPolicyActive = IsActive
		FROM dbo.Policies
		WHERE PolicyID = @PolicyID;

		IF @IsPolicyActive = 1
		BEGIN
			DECLARE @CurrentEndDate DATE;
			SELECT @CurrentEndDate = EndDate
			FROM dbo.Policies
			WHERE PolicyID = @PolicyID;

			SET @EndDate = DATEADD(YEAR, @RenewalYears, @CurrentEndDate);
		END
		ELSE
			SET @EndDate = DATEADD(YEAR, @RenewalYears, @PaymentDate);

		-- Оновлення полісу
        EXEC sp_SetPolicy
            @PolicyID = @PolicyID,
            @StartDate = @PaymentDate,
            @EndDate = @EndDate,
            @IsActive = 1;
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;


EXEC dbo.sp_PaymentAndUpdateForPolicy
    @PolicyID = 5,
    @PaymentAmount = 1500.00,
    @PaymentMethod = 'Кредитна картка',
    @PaymentDate = '2025-12-15', -- Оплата та новий початок страховки
    @RenewalYears = 2;           -- Продовжуємо на 2 роки
GO