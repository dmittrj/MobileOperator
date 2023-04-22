USE MobileOperator_by_DmitryBalabanov
GO

/* SIMPLE */

-- View subscribers table
SELECT *
FROM Subscriber
GO


-- View subscribers’ passport data
SELECT sub_phone_number, sub_name, ppt_series_number, ppt_issued_by, ppt_issued_date, ppt_division_code
FROM Subscriber
JOIN Passport ON Subscriber.sub_passport = Passport.ppt_series_number