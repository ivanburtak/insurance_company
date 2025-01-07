SELECT 
    Policies.PolicyNumber, 
    Customers.FirstName + ' ' + Customers.LastName AS CustomerName,
    InsuranceProducts.ProductName,
    Policies.StartDate,
    Policies.EndDate
FROM Policies
JOIN Customers ON Policies.CustomerID = Customers.CustomerID
JOIN InsuranceProducts ON Policies.ProductID = InsuranceProducts.ProductID
WHERE Policies.IsActive = 1 AND InsuranceProducts.TypeID = 1; -- Автострахування


SELECT 
    Customers.FirstName + ' ' + Customers.LastName AS CustomerName,
    InsuranceProducts.ProductName,
    ProductDiscounts.DiscountAmount
FROM ProductDiscounts
JOIN InsuranceProducts ON ProductDiscounts.ProductID = InsuranceProducts.ProductID
JOIN Policies ON InsuranceProducts.ProductID = Policies.ProductID
JOIN Customers ON Policies.CustomerID = Customers.CustomerID
WHERE GETDATE() BETWEEN ProductDiscounts.ValidFrom AND ProductDiscounts.ValidUntil;


SELECT
	Customers.FirstName + ' ' + Customers.LastName AS CustomerName,
    Policies.PolicyNumber, 
    Claims.ClaimAmount, 
    Claims.ClaimDate
FROM Claims
JOIN Policies ON Claims.PolicyID = Policies.PolicyID
JOIN Customers ON Policies.CustomerID = Customers.CustomerID
WHERE Claims.Status = 'Очікує розгляду';


SELECT 
    Payments.PaymentMethod, 
    Payments.PaymentDate, 
    Payments.PaymentAmount
FROM Payments
JOIN Policies ON Payments.PolicyID = Policies.PolicyID
WHERE Policies.PolicyNumber = 'P001'; -- Вказати номер полісу


SELECT 
	Policies.PolicyNumber,
	Policies.StartDate,
	Policies.EndDate,
	Customers.FirstName + ' ' + Customers.LastName AS CustomerName
FROM Policies
JOIN Customers ON Policies.CustomerID = Customers.CustomerID
WHERE IsActive = 1 AND EndDate > GETDATE();