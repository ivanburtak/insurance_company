CREATE VIEW ActivePolicies AS
SELECT
	PolicyID,
	PolicyNumber,
	StartDate, 
	EndDate,
	CustomerID,
	ProductID,
	IsActive
FROM Policies
WHERE EndDate >= GETDATE() AND IsActive = 1;
GO

CREATE VIEW CustomersWithActivePolicies AS
SELECT
	Customers.CustomerID,
	Customers.FirstName,
	Customers.LastName,
	Customers.DateOfBirth,
	Customers.Phone,
	Customers.Email,
	Customers.Address, 
    Policies.PolicyID,
	Policies.PolicyNumber,
	Policies.StartDate,
	Policies.EndDate,
	Policies.IsActive
FROM Customers
JOIN Policies ON Customers.CustomerID = Policies.CustomerID
WHERE Policies.EndDate >= GETDATE() AND Policies.IsActive = 1;
GO

CREATE VIEW ClaimsStatus AS
SELECT
	Claims.ClaimID,
	Claims.PolicyID,
	Claims.ClaimDate,
	Claims.ClaimAmount,
	Claims.Status,
	Claims.ProcessedByID,
    Policies.PolicyNumber,
	Policies.StartDate,
	Policies.EndDate
FROM Claims
JOIN Policies ON Claims.PolicyID = Policies.PolicyID
WHERE Claims.Status IN ('Розглядається', 'Очікує розгляду');
GO