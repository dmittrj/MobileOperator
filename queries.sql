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


-- Procedures
EXECUTE CreateDetailing '+79123456789', '01/02/2020', '31/12/2020', 1;
EXECUTE CreateSellingsSummary '01/02/2020', '01/05/2020';