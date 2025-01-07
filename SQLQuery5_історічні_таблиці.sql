-- ������������ ������� Customers �� ���������
ALTER TABLE Customers ADD
    ValidFrom DATETIME2 GENERATED ALWAYS AS ROW START HIDDEN
        CONSTRAINT DF_Customers_ValidFrom DEFAULT SYSUTCDATETIME(),
    ValidTo DATETIME2 GENERATED ALWAYS AS ROW END HIDDEN
        CONSTRAINT DF_Customers_ValidTo DEFAULT CONVERT(DATETIME2, '9999-12-31 23:59:59.9999999'),
    PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo);

ALTER TABLE Customers
    SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.Customers_History));

-- ������������ ������� Policies �� ���������
ALTER TABLE Policies ADD
    ValidFrom DATETIME2 GENERATED ALWAYS AS ROW START HIDDEN
        CONSTRAINT DF_Policies_ValidFrom DEFAULT SYSUTCDATETIME(),
    ValidTo DATETIME2 GENERATED ALWAYS AS ROW END HIDDEN
        CONSTRAINT DF_Policies_ValidTo DEFAULT CONVERT(DATETIME2, '9999-12-31 23:59:59.9999999'),
    PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo);

ALTER TABLE Policies
    SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.Policies_History));

-- ������������ ������� Claims �� ���������
ALTER TABLE Claims ADD
    ValidFrom DATETIME2 GENERATED ALWAYS AS ROW START HIDDEN
        CONSTRAINT DF_Claims_ValidFrom DEFAULT SYSUTCDATETIME(),
    ValidTo DATETIME2 GENERATED ALWAYS AS ROW END HIDDEN
        CONSTRAINT DF_Claims_ValidTo DEFAULT CONVERT(DATETIME2, '9999-12-31 23:59:59.9999999'),
    PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo);

ALTER TABLE Claims
    SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.Claims_History));


-- �������� ��� ���
SELECT *
FROM Claims
FOR SYSTEM_TIME ALL;

-- �������� �� ������ ������ ����
SELECT * 
FROM Policies 
FOR SYSTEM_TIME AS OF '2024-01-01';

-- �������� �� ������ ����� ����
SELECT *
FROM Customers
FOR SYSTEM_TIME FROM '2023-01-01T00:00:00' TO '2023-12-31T23:59:59';