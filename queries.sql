USE MobileOperator_by_DmitryBalabanov
GO

/* SIMPLE */

-- View subscribers table
SELECT *
FROM Subscriber
GO


-- View all tariffs ready to be sold
SELECT *
FROM Tariff
WHERE tar_archived = 0


-- View address
OPEN SYMMETRIC KEY SymKey_Encr_Address
DECRYPTION BY PASSWORD = 'AddressSymmetricKeyPassword123';
SELECT adr_id, 
CONVERT(NVARCHAR(64), DECRYPTBYKEY(adr_region)) AS adr_region, 
CONVERT(NVARCHAR(64), DECRYPTBYKEY(adr_city)) AS adr_city,
CONVERT(NVARCHAR(64), DECRYPTBYKEY(adr_locality)) AS adr_locality,
CONVERT(NVARCHAR(64), DECRYPTBYKEY(adr_street)) AS adr_street,
CONVERT(NVARCHAR(10), DECRYPTBYKEY(adr_home)) AS adr_home,
CONVERT(NVARCHAR(5), DECRYPTBYKEY(adr_apartment)) AS adr_apartment
FROM HomeAddress;
CLOSE SYMMETRIC KEY SymKey_Encr_Address;


-- Sorting tariffs according to popularity
SELECT sub_tariff AS [Tariff Name], COUNT(sub_tariff) AS [Number of subscribers],
	(COUNT(sub_tariff) * 100 / (SELECT COUNT(*) FROM Subscriber)) AS [Percentage]
FROM Subscriber
GROUP BY sub_tariff
ORDER BY [Number of subscribers] DESC


-- View subscribers’ passport data
SELECT sub_phone_number, sub_name, ppt_series_number, ppt_issued_by, ppt_issued_date, ppt_division_code
FROM Subscriber
JOIN Passport ON Subscriber.sub_passport = Passport.ppt_series_number


-- View subscribers’ address information
SELECT sub_phone_number, sub_name, adr_city
FROM Subscriber
JOIN Passport ON Subscriber.sub_passport = Passport.ppt_series_number
JOIN HomeAddress ON Passport.ppt_address = HomeAddress.adr_id;


-- Test trigger
SELECT *
FROM Subscriber
JOIN Package ON sub_phone_number = Package.pck_subscriber
WHERE sub_phone_number = '+79123456788';

INSERT INTO Traffic (trf_subscriber, trf_datetime, trf_type, trf_description, trf_amount, trf_pay) 
VALUES ('+79123456788', '24/04/2023', 'Internet', 'telegram.org', 2, 0);

SELECT *
FROM Subscriber
JOIN Package ON sub_phone_number = Package.pck_subscriber
WHERE sub_phone_number = '+79123456788';


-- Procedures
EXECUTE CreateDetailing '+79123456778', '01/01/2020', '31/12/2021', 0;
EXECUTE CreateSellingsSummary '01/02/2020', '01/05/2020';
EXECUTE UpdateTariffGrid;
EXECUTE ChooseTariff 1000, 500, 5, 101;
EXEC SalesReportByCohorts '01/01/2019', '31/12/2023', 30;

SELECT
    r.name AS RoleName,
    u.name AS UserName
FROM
    sys.database_role_members AS m
    JOIN sys.database_principals AS r ON m.role_principal_id = r.principal_id
    JOIN sys.database_principals AS u ON m.member_principal_id = u.principal_id
WHERE
    r.type = 'R'
ORDER BY
    r.name, u.name;