USE MobileOperator_by_DmitryBalabanov
GO

/* SIMPLE */

-- View subscribers table
SELECT *
FROM Subscriber
GO


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
WHERE sub_phone_number = '+79123456789';

INSERT INTO Traffic (trf_subscriber, trf_datetime, trf_type, trf_description, trf_amount, trf_pay) 
VALUES ('+79123456789', '24/04/2023', 'SMS', '+71234567890', 2, 0);

SELECT *
FROM Subscriber
JOIN Package ON sub_phone_number = Package.pck_subscriber
WHERE sub_phone_number = '+79123456789';


-- Procedures
EXECUTE CreateDetailing '+79123456778', '01/01/2020', '31/12/2021', 0;
EXECUTE CreateSellingsSummary '01/02/2020', '01/05/2020';
EXECUTE UpdateTariffGrid;