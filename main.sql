/* Creating db */
USE master;
IF DB_ID (N'MobileOperator_by_DmitryBalabanov') IS NOT NULL
	DROP DATABASE [MobileOperator_by_DmitryBalabanov];

CREATE DATABASE [MobileOperator_by_DmitryBalabanov]
GO


USE MobileOperator_by_DmitryBalabanov;

DROP TABLE IF EXISTS [Subscriber];
DROP TABLE IF EXISTS [Passport];
DROP TABLE IF EXISTS [HomeAddress];
DROP TABLE IF EXISTS [Sellings];
DROP TABLE IF EXISTS [Tariff];
DROP TABLE IF EXISTS [Billings];
DROP TABLE IF EXISTS [Package];
DROP TABLE IF EXISTS [Traffic];
DROP TABLE IF EXISTS [UnlimitedServices];
GO

DROP VIEW IF EXISTS [SubscribersInfo];
DROP VIEW IF EXISTS [AvaliableTariffs];
GO

DROP PROCEDURE IF EXISTS CreateDetailing;
DROP FUNCTION IF EXISTS getTariff;

/* Own types */
DROP TYPE IF EXISTS PHONE
DROP TYPE IF EXISTS PASSPORTDATA
DROP TYPE IF EXISTS STRING
DROP TYPE IF EXISTS SMALLSTRING
DROP TYPE IF EXISTS BIGSTRING
DROP TYPE IF EXISTS ENCRYPTEDSTRING

CREATE TYPE PHONE FROM VARCHAR(16) NOT NULL;
CREATE TYPE PASSPORTDATA FROM CHAR(11) NOT NULL;
CREATE TYPE STRING FROM NVARCHAR(64);
CREATE TYPE SMALLSTRING FROM NVARCHAR(32);
CREATE TYPE BIGSTRING FROM NVARCHAR(100);
CREATE TYPE ENCRYPTEDSTRING FROM VARBINARY(160);

GO


/* Subscriber entity */
CREATE TABLE Subscriber (
	[sub_phone_number] PHONE PRIMARY KEY,

	[sub_name] STRING NOT NULL,
	[sub_passport] PASSPORTDATA NOT NULL,
	
	[sub_joining_date] DATE NULL DEFAULT NULL,

	[sub_tariff] SMALLSTRING NULL DEFAULT NULL,
	[sub_balance] SMALLMONEY NOT NULL DEFAULT 0,

	[sub_email] BIGSTRING NULL DEFAULT NULL CONSTRAINT ch_email CHECK ([sub_email] LIKE '%_@__%.__%'),
);



/* Passport entity */
CREATE TABLE Passport (
	[ppt_series_number] PASSPORTDATA PRIMARY KEY CONSTRAINT ch_sernum CHECK ([ppt_series_number] LIKE '[0-9][0-9][0-9][0-9] [0-9][0-9][0-9][0-9][0-9][0-9]'),
	[ppt_issued_by] STRING NOT NULL,
	[ppt_issued_date] DATE NOT NULL,
	[ppt_division_code] CHAR(7) NOT NULL,
	[ppt_date_of_birth] DATE NOT NULL,
	[ppt_address] INT NULL DEFAULT NULL,

	[ppt_gender] CHAR NOT NULL CONSTRAINT ch_gen CHECK([ppt_gender] IN ('M', 'F'))
);
ALTER TABLE [Subscriber] ADD CONSTRAINT fk_sub_pptHolds 
	FOREIGN KEY ([sub_passport]) REFERENCES Passport([ppt_series_number])
	ON DELETE CASCADE
	ON UPDATE CASCADE;



/* Address entity */
CREATE TABLE HomeAddress (
	[adr_id] INT PRIMARY KEY,

	[adr_region] ENCRYPTEDSTRING NOT NULL,
	[adr_city] ENCRYPTEDSTRING NOT NULL,
	[adr_locality] ENCRYPTEDSTRING NOT NULL,
	[adr_street] ENCRYPTEDSTRING NOT NULL,
	[adr_home] ENCRYPTEDSTRING NOT NULL,
	[adr_apartment] ENCRYPTEDSTRING NULL
);
ALTER TABLE [Passport] ADD CONSTRAINT fk_ppt_adrLives 
	FOREIGN KEY ([ppt_address]) REFERENCES HomeAddress([adr_id])
	ON DELETE CASCADE
	ON UPDATE CASCADE;



/* Tariff entity */
CREATE TABLE Tariff (
	[tar_name] SMALLSTRING PRIMARY KEY,
	[tar_description] BIGSTRING NULL DEFAULT NULL,
	[tar_restrictions] BIGSTRING NULL DEFAULT NULL,
	[tar_creating_date] DATE NOT NULL,

	[tar_minutes] INT NULL,
	[tar_minute_cost] SMALLMONEY NULL,
	[tar_sms] INT NULL,
	[tar_sms_cost] SMALLMONEY NULL,
	[tar_internet] REAL NULL,
	[tar_mb_cost] SMALLMONEY NULL,
	
	[tar_internet_speed] INT NULL DEFAULT NULL,

	[tar_cost] SMALLMONEY NOT NULL DEFAULT 0,
	
	[tar_archived] BIT NOT NULL DEFAULT 0
);
ALTER TABLE [Subscriber] ADD CONSTRAINT fk_sub_tarUse 
	FOREIGN KEY ([sub_tariff]) REFERENCES Tariff([tar_name])
	ON DELETE CASCADE
	ON UPDATE CASCADE;
	
	

/* Unlimited services entity */	
CREATE TABLE UnlimitedServices (
	[unl_id] INT IDENTITY(1,1) PRIMARY KEY,
	[unl_tariff] SMALLSTRING NOT NULL,
	[unl_service] STRING NOT NULL
)
ALTER TABLE [UnlimitedServices] ADD CONSTRAINT fk_unl_tarIncluded 
	FOREIGN KEY ([unl_tariff]) REFERENCES Tariff([tar_name])
	ON DELETE CASCADE
	ON UPDATE CASCADE;


/* Package entity */
CREATE TABLE Package (
	[pck_id] INT IDENTITY(1,1) PRIMARY KEY,
	[pck_subscriber] PHONE,

	[pck_minutes] INT NULL,
	[pck_sms] INT NULL,
	[pck_internet] REAL NULL,

	[pck_billing_date] INT NULL DEFAULT NULL CONSTRAINT ch_billDay CHECK([pck_billing_date] >= 1 AND [pck_billing_date] <= 31)
);
ALTER TABLE [Package] ADD CONSTRAINT fk_pck_subOwn 
	FOREIGN KEY ([pck_subscriber]) REFERENCES Subscriber([sub_phone_number])
	ON DELETE CASCADE
	ON UPDATE CASCADE;



/* Sellings entity */
CREATE TABLE Sellings (
	[sll_id] INT IDENTITY(1,1) PRIMARY KEY,

	[sll_subscriber] PHONE,
	[sll_tariff] SMALLSTRING NOT NULL,
	
	[sll_date] DATETIME NULL,
);
ALTER TABLE [Sellings] ADD CONSTRAINT fk_sll_subBought 
	FOREIGN KEY ([sll_subscriber]) REFERENCES Subscriber([sub_phone_number])
	ON DELETE NO ACTION
	ON UPDATE CASCADE;
ALTER TABLE [Sellings] ADD CONSTRAINT fk_sll_tarSold 
	FOREIGN KEY ([sll_tariff]) REFERENCES Tariff([tar_name])
	ON DELETE NO ACTION
	ON UPDATE NO ACTION;
	

/* Traffic entity */
CREATE TABLE Traffic (
	[trf_id] INT IDENTITY(1,1) PRIMARY KEY,
	[trf_subscriber] PHONE NOT NULL,
	[trf_datetime] DATETIME NOT NULL,
	[trf_type] VARCHAR(15) NOT NULL CONSTRAINT ch_traffic CHECK ([trf_type] IN ('Internet', 'SMS', 'Outgoing call', 'Incoming call')),
	[trf_description] SMALLSTRING NOT NULL,
	[trf_amount] DECIMAL NOT NULL,
	[trf_pay] SMALLMONEY NOT NULL
)
ALTER TABLE [Traffic] ADD CONSTRAINT fk_trf_subDrain 
	FOREIGN KEY ([trf_subscriber]) REFERENCES Subscriber([sub_phone_number])
	ON DELETE CASCADE
	ON UPDATE CASCADE;


/* Billings entity */
CREATE TABLE Billings (
	[bll_id] INT IDENTITY(1,1) PRIMARY KEY,
	 
	[bll_subscriber] PHONE,
	[bll_money] SMALLMONEY NOT NULL DEFAULT 0,
	 
	[bll_date] DATETIME NOT NULL
);
ALTER TABLE [Billings] ADD CONSTRAINT fk_bll_subReplenished 
	FOREIGN KEY ([bll_subscriber]) REFERENCES Subscriber([sub_phone_number])
	ON DELETE NO ACTION
	ON UPDATE CASCADE;

GO


/* Index */
CREATE INDEX inx_sub_pass ON [Subscriber] (sub_passport);
CREATE INDEX inx_sub_join ON [Subscriber] (sub_joining_date);
CREATE INDEX inx_sub_tariff ON [Subscriber] (sub_tariff);
CREATE INDEX inx_pass_address ON [Passport] (ppt_address);
CREATE INDEX inx_tariff_date ON [Tariff] (tar_creating_date);
CREATE INDEX inx_tariff_minutes ON [Tariff] (tar_minutes);
CREATE INDEX inx_tariff_sms ON [Tariff] (tar_sms);
CREATE INDEX inx_tariff_gb ON [Tariff] (tar_internet);
CREATE INDEX inx_tariff_cost ON [Tariff] (tar_cost);
CREATE INDEX inx_tariff_arch ON [Tariff] (tar_archived);
CREATE INDEX inx_unlim_tariff ON [UnlimitedServices] (unl_tariff);
CREATE INDEX inx_pack_sub ON [Package] (pck_subscriber);
CREATE INDEX inx_sell_sub ON [Sellings] (sll_subscriber);
CREATE INDEX inx_sell_tariff ON [Sellings] (sll_tariff);
CREATE INDEX inx_traffic_sub ON [Traffic] (trf_subscriber);
CREATE INDEX inx_traffic_date ON [Traffic] (trf_datetime);
CREATE INDEX inx_bill_sub ON [Billings] (bll_subscriber);
GO


/* Checking balance */
CREATE OR ALTER PROCEDURE CreateDetailing (@sub PHONE, @date_from DATE, @date_to DATE, @brief BIT)
AS
BEGIN
	IF (@brief = 0)
		SELECT
			trf_datetime AS [Date & Time],
			trf_type AS [Type],
			trf_description AS [Description],
			trf_amount AS [Amount of Usage],
			trf_pay AS [To Pay]
		FROM [Traffic]
		WHERE trf_subscriber = @sub
		AND trf_datetime BETWEEN @date_from AND @date_to;
	ELSE
		SELECT
			trf_type AS [Type],
			COUNT(trf_pay) AS [Number],
			SUM(trf_pay) AS [To Pay]
		FROM [Traffic]
		WHERE trf_subscriber = @sub
		AND trf_datetime BETWEEN @date_from AND @date_to
		GROUP BY trf_type;

	SELECT SUM(trf_pay) AS [Total to Pay], (SELECT sub_tariff FROM [Subscriber] WHERE sub_phone_number = @sub) AS [Current Tariff]
	FROM [Traffic]
	WHERE trf_subscriber = @sub
	AND trf_datetime BETWEEN @date_from AND @date_to
END;
GO

/* Checking balance */
CREATE OR ALTER PROCEDURE CreateSellingsSummary (@date_from DATE, @date_to DATE)
AS
BEGIN
	SELECT tar_name, SUM(trf_pay) AS [Additional Utilities], ((SELECT COUNT(*) FROM Subscriber WHERE sub_tariff = tar_name) * (SELECT tar_cost FROM Tariff WHERE t.tar_name = tar_name)) AS [Income]
	FROM [Tariff] AS t
	JOIN [Subscriber] ON Subscriber.sub_tariff = t.tar_name
	JOIN [Traffic] ON Traffic.trf_subscriber = Subscriber.sub_phone_number
	GROUP BY tar_name;
END;

GO

CREATE OR ALTER PROCEDURE UpdateTariffGrid
AS
BEGIN
	CREATE TABLE #traffic_tariff (
		t_tariff NVARCHAR(32), 
		t_mon INT,
		t_year INT,
		t_type VARCHAR(15), 
		t_amount INT, 
		t_pay SMALLMONEY,
		t_mins INT NULL,
		t_sms INT NULL,
		t_internet REAL NULL,
		t_cost SMALLMONEY
	);
	INSERT INTO #traffic_tariff
	SELECT sub_tariff, trf_mon, trf_year, trf_type, amount, pay, tar_minutes, tar_sms, tar_internet, tar_cost FROM
	(SELECT sub_tariff, trf_mon, trf_year, trf_type, SUM(trf_amount) AS amount, SUM(trf_pay) AS pay FROM
	(SELECT sub_tariff, trf_datetime, trf_type, trf_amount, trf_pay, MONTH(trf_datetime) AS trf_mon, YEAR(trf_datetime) AS trf_year FROM
	(SELECT *,
		(SELECT TOP(1) sll_date FROM Sellings WHERE Subscriber.sub_phone_number = Sellings.sll_subscriber ORDER BY sll_date DESC) AS last_tariff_update
	FROM Subscriber) AS q1
	JOIN Traffic ON last_tariff_update <= trf_datetime AND sub_phone_number = trf_subscriber) AS q2
	GROUP BY sub_tariff, trf_mon, trf_year, trf_type) AS q3
	JOIN Tariff ON sub_tariff = tar_name;

	SELECT t_tariff AS Tariff, 'Reduce minutes amount' AS Advice
	FROM #traffic_tariff
	WHERE t_type = 'Outgoing call' AND t_mins IS NOT NULL
	GROUP BY t_tariff
	HAVING AVG(t_mins - t_amount) > (SELECT tar_minutes FROM Tariff WHERE tar_name = t_tariff) * 0.5
	UNION

	SELECT t_tariff AS Tariff, 'Reduce SMS amount' AS Advice
	FROM #traffic_tariff
	WHERE t_type = 'SMS' AND t_sms IS NOT NULL
	GROUP BY t_tariff
	HAVING AVG(t_sms - t_amount) > (SELECT tar_sms FROM Tariff WHERE tar_name = t_tariff) * 0.5
	UNION

	SELECT t_tariff AS Tariff, 'Reduce GB amount' AS Advice
	FROM #traffic_tariff
	WHERE t_type = 'Internet' AND t_internet IS NOT NULL
	GROUP BY t_tariff
	HAVING AVG(t_internet * 1024 - t_amount) > (SELECT tar_internet FROM Tariff WHERE tar_name = t_tariff) * 0.5
	UNION

	SELECT t_tariff AS Tariff, 'Increase minutes amount' AS Advice
	FROM #traffic_tariff
	WHERE t_type = 'Outgoing call' AND t_mins IS NOT NULL
	GROUP BY t_tariff
	HAVING AVG(t_amount - t_mins) > (SELECT tar_minutes FROM Tariff WHERE tar_name = t_tariff) * 0.5
	UNION

	SELECT t_tariff AS Tariff, 'Increase SMS amount' AS Advice
	FROM #traffic_tariff
	WHERE t_type = 'SMS' AND t_sms IS NOT NULL
	GROUP BY t_tariff
	HAVING AVG(t_amount - t_sms) > (SELECT tar_sms FROM Tariff WHERE tar_name = t_tariff) * 0.5
	UNION

	SELECT t_tariff AS Tariff, 'Increase GB amount' AS Advice
	FROM #traffic_tariff
	WHERE t_type = 'Internet' AND t_internet IS NOT NULL
	GROUP BY t_tariff
	HAVING AVG(t_amount - t_internet * 1024) > (SELECT tar_internet FROM Tariff WHERE tar_name = t_tariff) * 0.5;
END;
GO

CREATE OR ALTER PROCEDURE ChooseTariff (@w_minutes INT, @w_sms INT, @w_gb REAL, @w_speed INT)
AS
BEGIN
	CREATE TABLE #temp_tariffs (
		t_name NVARCHAR(32),
		t_description NVARCHAR(100),
		t_restrictions NVARCHAR(100),
		t_minutes INT,
		t_sms INT,
		t_gb REAL,
		t_speed INT
	)
	INSERT INTO #temp_tariffs 
	SELECT tar_name, tar_description, tar_restrictions, tar_minutes, tar_sms, tar_internet, tar_internet_speed FROM [Tariff] WHERE tar_archived = 0;
	UPDATE #temp_tariffs
	SET t_minutes = (SELECT TOP(1) tar_minutes FROM [Tariff] WHERE tar_archived = 0 ORDER BY tar_minutes DESC) + 1 WHERE t_minutes IS NULL;
	UPDATE #temp_tariffs
	SET t_sms = (SELECT TOP(1) tar_sms FROM [Tariff] WHERE tar_archived = 0 ORDER BY tar_sms DESC) + 1 WHERE t_sms IS NULL;
	UPDATE #temp_tariffs
	SET t_gb = (SELECT TOP(1) tar_internet FROM [Tariff] WHERE tar_archived = 0 ORDER BY tar_internet DESC) + 1 WHERE t_gb IS NULL;
	UPDATE #temp_tariffs
	SET t_speed = (SELECT TOP(1) tar_internet_speed FROM [Tariff] WHERE tar_archived = 0 ORDER BY tar_internet_speed DESC) + 1 WHERE t_speed IS NULL;
	SELECT t_name, t_description, t_restrictions, tar_minutes, tar_sms, tar_internet, tar_internet_speed
	FROM #temp_tariffs
	JOIN [Tariff] ON t_name = tar_name
	ORDER BY CAST(ABS(t_minutes - @w_minutes) AS REAL) / (SELECT SUM(t_minutes) FROM #temp_tariffs) + CAST(ABS(t_sms - @w_sms) AS REAL) / (SELECT SUM(t_sms) FROM #temp_tariffs) + CAST(ABS(t_gb - @w_gb) AS REAL) / (SELECT SUM(t_gb) FROM #temp_tariffs) + CAST(ABS(t_speed - @w_speed) AS REAL) / (SELECT SUM(t_speed) FROM #temp_tariffs) ASC;
END;
GO


CREATE OR ALTER FUNCTION getTariff (@sub PHONE, @date DATE)
RETURNS NVARCHAR(32)
BEGIN
	RETURN (SELECT TOP(1) sll_tariff
	FROM [Sellings]
	WHERE sll_subscriber = @sub AND sll_date <= @date
	ORDER BY sll_date DESC);
END;
GO

CREATE OR ALTER PROCEDURE SalesReportByCohorts
    @start_date DATE,
    @end_date DATE,
    @interval INT
AS
BEGIN
	DECLARE @current_date DATE = @start_date;
	DECLARE @cohort_table AS TABLE (
		coh_date DATE
	)
	DECLARE @tariffs_table AS TABLE (
		coh_date DATE,
		first_tar NVARCHAR(32),
		last_tar NVARCHAR(32),
		tar2 INT,
		tar3 INT,
		tar4 INT,
		tar5 INT,
		tar6 INT
	)
	WHILE (@current_date < @end_date)
	BEGIN
		INSERT INTO @cohort_table VALUES (@current_date);
		SET @current_date = DATEADD(day, @interval, @current_date);
	END;
	
	INSERT INTO @tariffs_table
	SELECT coh_date, sll_tariff, dbo.getTariff(sll_subscriber, DATEADD(day, @interval * 6, coh_date)), 
	(CASE (dbo.getTariff(sll_subscriber, DATEADD(day, @interval * 2, coh_date))) WHEN sll_tariff THEN 1 ELSE 0 END) AS tariff2,
	(CASE (dbo.getTariff(sll_subscriber, DATEADD(day, @interval * 3, coh_date))) WHEN sll_tariff THEN 1 ELSE 0 END) AS tariff3,
	(CASE (dbo.getTariff(sll_subscriber, DATEADD(day, @interval * 4, coh_date))) WHEN sll_tariff THEN 1 ELSE 0 END) AS tariff4,
	(CASE (dbo.getTariff(sll_subscriber, DATEADD(day, @interval * 5, coh_date))) WHEN sll_tariff THEN 1 ELSE 0 END) AS tariff5,
	(CASE (dbo.getTariff(sll_subscriber, DATEADD(day, @interval * 6, coh_date))) WHEN sll_tariff THEN 1 ELSE 0 END) AS tariff6
	FROM @cohort_table
	JOIN [Sellings]
	ON sll_date BETWEEN coh_date AND DATEADD(day, @interval, coh_date)
	
	SELECT coh_date, '100%' AS subs,
	pop_first AS [Tariff],
	CONCAT((coh2 * 100 / subs), '%') AS coh2,
	CONCAT((coh3 * 100 / subs), '%') AS coh3,
	CONCAT((coh4 * 100 / subs), '%') AS coh4,
	CONCAT((coh5 * 100 / subs), '%') AS coh5,
	CONCAT((coh6 * 100 / subs), '%') AS coh6,
	pop_last AS [TurnInto]
	FROM
	(SELECT coh_date, COUNT(*) AS subs, SUM(tar2) AS coh2, SUM(tar3) AS coh3, SUM(tar4) AS coh4, SUM(tar5) AS coh5, SUM(tar6) AS coh6, pop_first, pop_last
	FROM
	(SELECT *, (SELECT TOP(1) first_tar FROM @tariffs_table AS tai WHERE tai.coh_date = tao.coh_date GROUP BY first_tar ORDER BY COUNT(first_tar) DESC) AS pop_first,
	(SELECT TOP(1) last_tar FROM @tariffs_table AS tai WHERE tai.coh_date = tao.coh_date GROUP BY last_tar ORDER BY COUNT(last_tar) DESC) AS pop_last
	FROM @tariffs_table AS tao) AS qc
	GROUP BY coh_date, pop_first, pop_last) AS qs
END;
GO


CREATE OR ALTER TRIGGER trig_trafficInput ON [Traffic]
AFTER INSERT
AS
BEGIN
	DECLARE @ins_type VARCHAR(15); SET @ins_type = (SELECT trf_type FROM INSERTED);
	DECLARE @ins_subscriber PHONE; SET @ins_subscriber = (SELECT trf_subscriber FROM INSERTED);
	DECLARE @ins_amount DECIMAL; SET @ins_amount = (SELECT trf_amount FROM INSERTED);
	DECLARE @ins_tariff SMALLSTRING; SET @ins_tariff = (SELECT sub_tariff FROM [Subscriber] WHERE sub_phone_number = @ins_subscriber);
	IF (@ins_type = 'Outgoing call' AND (SELECT tar_minutes FROM [Tariff] WHERE tar_name = @ins_tariff) IS NOT NULL)
	BEGIN
		UPDATE [Package]
		SET pck_minutes = pck_minutes - @ins_amount WHERE pck_subscriber = @ins_subscriber;
		IF ((SELECT pck_minutes FROM [Package] WHERE pck_subscriber = @ins_subscriber) < 0 AND (SELECT tar_minute_cost FROM [Tariff] WHERE tar_name = @ins_tariff) IS NOT NULL)
		BEGIN
			UPDATE [Traffic]
			SET trf_pay = -(SELECT pck_minutes FROM [Package] WHERE pck_subscriber = @ins_subscriber)* (SELECT tar_minute_cost FROM [Tariff] WHERE tar_name = @ins_tariff) WHERE trf_id = (SELECT trf_id FROM INSERTED);
			UPDATE [Subscriber]
			SET sub_balance = sub_balance - (SELECT trf_pay FROM [Traffic] WHERE trf_id = (SELECT trf_id FROM INSERTED)) WHERE sub_phone_number = @ins_subscriber;
			UPDATE [Package]
			SET pck_minutes = 0 WHERE pck_subscriber = @ins_subscriber;
		END
	END

	ELSE IF (@ins_type = 'SMS' AND (SELECT tar_sms FROM [Tariff] WHERE tar_name = @ins_tariff) IS NOT NULL)
	BEGIN
		UPDATE [Package]
		SET pck_sms = pck_sms - @ins_amount WHERE pck_subscriber = @ins_subscriber;
		IF ((SELECT pck_sms FROM [Package] WHERE pck_subscriber = @ins_subscriber) < 0 AND (SELECT tar_sms_cost FROM [Tariff] WHERE tar_name = @ins_tariff) IS NOT NULL)
		BEGIN
			UPDATE [Traffic]
			SET trf_pay = -(SELECT pck_sms FROM [Package] WHERE pck_subscriber = @ins_subscriber)* (SELECT tar_sms_cost FROM [Tariff] WHERE tar_name = @ins_tariff) WHERE trf_id = (SELECT trf_id FROM INSERTED);
			UPDATE [Subscriber]
			SET sub_balance = sub_balance - (SELECT trf_pay FROM [Traffic] WHERE trf_id = (SELECT trf_id FROM INSERTED)) WHERE sub_phone_number = @ins_subscriber;
			UPDATE [Package]
			SET pck_sms = 0 WHERE pck_subscriber = @ins_subscriber;
		END
	END

	ELSE IF (@ins_type = 'Internet' AND (SELECT tar_internet FROM [Tariff] WHERE tar_name = @ins_tariff) IS NOT NULL AND NOT EXISTS (SELECT * FROM [UnlimitedServices] WHERE unl_tariff = @ins_tariff AND unl_service LIKE CONCAT('%', (SELECT trf_description FROM INSERTED), '%')))
	BEGIN
		UPDATE [Package]
		SET pck_internet = pck_internet - @ins_amount WHERE pck_subscriber = @ins_subscriber;
		IF ((SELECT pck_internet FROM [Package] WHERE pck_subscriber = @ins_subscriber) < 0 AND (SELECT tar_mb_cost FROM [Tariff] WHERE tar_name = @ins_tariff) IS NOT NULL)
		BEGIN
			UPDATE [Traffic]
			SET trf_pay = -(SELECT pck_internet FROM [Package] WHERE pck_subscriber = @ins_subscriber)* (SELECT tar_mb_cost FROM [Tariff] WHERE tar_name = @ins_tariff) WHERE trf_id = (SELECT trf_id FROM INSERTED);
			UPDATE [Subscriber]
			SET sub_balance = sub_balance - (SELECT trf_pay FROM [Traffic] WHERE trf_id = (SELECT trf_id FROM INSERTED)) WHERE sub_phone_number = @ins_subscriber;
			UPDATE [Package]
			SET pck_internet = 0 WHERE pck_subscriber = @ins_subscriber;
		END
	END
END;
GO

CREATE OR ALTER TRIGGER trig_tariffInput ON [Tariff]
AFTER INSERT, UPDATE
AS
BEGIN
	IF ((SELECT TOP(1) tar_minutes FROM INSERTED) IS NULL)
	BEGIN
		UPDATE [Tariff]
		SET tar_minute_cost = NULL WHERE tar_name = (SELECT TOP(1) tar_name FROM INSERTED);
	END;
	IF ((SELECT TOP(1) tar_minutes FROM INSERTED) IS NOT NULL AND (SELECT TOP(1) tar_minute_cost FROM INSERTED) IS NULL)
	BEGIN
		UPDATE [Tariff]
		SET tar_minute_cost = 0 WHERE tar_name = (SELECT TOP(1) tar_name FROM INSERTED);
	END;

	IF ((SELECT TOP(1) tar_sms FROM INSERTED) IS NULL)
	BEGIN
		UPDATE [Tariff]
		SET tar_sms_cost = NULL WHERE tar_name = (SELECT TOP(1) tar_name FROM INSERTED);
	END;
	IF ((SELECT TOP(1) tar_sms FROM INSERTED) IS NOT NULL AND (SELECT TOP(1) tar_sms_cost FROM INSERTED) IS NULL)
	BEGIN
		UPDATE [Tariff]
		SET tar_sms_cost = 0 WHERE tar_name = (SELECT TOP(1) tar_name FROM INSERTED);
	END;

	IF ((SELECT TOP(1) tar_internet FROM INSERTED) IS NULL)
	BEGIN
		UPDATE [Tariff]
		SET tar_mb_cost = NULL WHERE tar_name = (SELECT TOP(1) tar_name FROM INSERTED);
	END;
	IF ((SELECT TOP(1) tar_internet FROM INSERTED) IS NOT NULL AND (SELECT TOP(1) tar_mb_cost FROM INSERTED) IS NULL)
	BEGIN
		UPDATE [Tariff]
		SET tar_mb_cost = 0 WHERE tar_name = (SELECT TOP(1) tar_name FROM INSERTED);
	END;
END
GO


CREATE OR ALTER TRIGGER trig_sellingsInput ON [Sellings]
AFTER INSERT
AS
BEGIN
	UPDATE [Subscriber]
	SET sub_tariff = (SELECT sll_tariff FROM INSERTED) WHERE sub_phone_number = (SELECT sll_subscriber FROM INSERTED);
END
GO


CREATE OR ALTER TRIGGER trig_billingsInput ON [Billings]
AFTER INSERT
AS
BEGIN
	UPDATE [Subscriber]
	SET sub_balance = sub_balance + (SELECT bll_money FROM INSERTED) WHERE sub_phone_number = (SELECT bll_subscriber FROM INSERTED);
END
GO


/* Views */
CREATE VIEW SubscribersInfo
AS SELECT sub_phone_number, sub_name, sub_tariff, sub_joining_date, sub_email, sub_balance, sub_passport,
ppt_issued_by, ppt_issued_date, ppt_division_code, ppt_date_of_birth, ppt_gender,
adr_region, adr_city, adr_locality, adr_street, adr_home, adr_apartment
FROM [Subscriber]
JOIN [Passport] ON sub_passport = ppt_series_number
JOIN [HomeAddress] ON ppt_address = adr_id;
GO

CREATE VIEW AvaliableTariffs
AS SELECT *
FROM [Tariff]
WHERE tar_archived = 0;
GO

DROP VIEW AnonymousSubscribers;
GO
CREATE VIEW AnonymousSubscribers AS
SELECT
	SUBSTRING(sub_phone_number, 1, 2) + '********' AS sub_phone_number,
	SUBSTRING(sub_name,1,2) + '**********' AS sub_name,
	CONCAT('****', SUBSTRING(sub_passport,5, LEN(sub_passport) - 4), '***') AS sub_passport,
	sub_joining_date,
	sub_tariff,
	sub_balance,
	ppt_gender,
	adr_region,
	adr_city
FROM [Subscriber]
JOIN [Passport] ON sub_passport = ppt_series_number
JOIN [HomeAddress] ON ppt_address = adr_id;
GO


/* Logins */
CREATE LOGIN [emp_CEO]
	WITH PASSWORD = 'PassGeneralDirector548',
	DEFAULT_DATABASE = [MobileOperator_by_DmitryBalabanov];
CREATE LOGIN [emp_CEO_deputy]
	WITH PASSWORD = 'PassZamDirectorf611',
	DEFAULT_DATABASE = [MobileOperator_by_DmitryBalabanov];
CREATE LOGIN [emp_SalesDep_Senior1]
	WITH PASSWORD = 'PassStarshyKassir310',
	DEFAULT_DATABASE = [MobileOperator_by_DmitryBalabanov];
CREATE LOGIN [emp_SalesDep_Senior2]
	WITH PASSWORD = 'PassStarshyKassir310',
	DEFAULT_DATABASE = [MobileOperator_by_DmitryBalabanov];
CREATE LOGIN [emp_SalesDep_Cashier1]
	WITH PASSWORD = 'PassKassir995',
	DEFAULT_DATABASE = [MobileOperator_by_DmitryBalabanov];
CREATE LOGIN [emp_SalesDep_Cashier2]
	WITH PASSWORD = 'PassKassir995',
	DEFAULT_DATABASE = [MobileOperator_by_DmitryBalabanov];
CREATE LOGIN [emp_SalesDep_ShopAssistant1]
	WITH PASSWORD = 'PassKonsultant549',
	DEFAULT_DATABASE = [MobileOperator_by_DmitryBalabanov];
CREATE LOGIN [emp_SalesDep_ShopAssistant2]
	WITH PASSWORD = 'PassKonsultant549',
	DEFAULT_DATABASE = [MobileOperator_by_DmitryBalabanov];
CREATE LOGIN [emp_AnalyticDep_SalesAnalytic1]
	WITH PASSWORD = 'PassAnalitikProdazh712',
	DEFAULT_DATABASE = [MobileOperator_by_DmitryBalabanov];
CREATE LOGIN [emp_AnalyticDep_SalesAnalytic2]
	WITH PASSWORD = 'PassAnalitikProdazh712',
	DEFAULT_DATABASE = [MobileOperator_by_DmitryBalabanov];
CREATE LOGIN [emp_Management_Marketing1]
	WITH PASSWORD = 'PassMarketingMenedzher302',
	DEFAULT_DATABASE = [MobileOperator_by_DmitryBalabanov];
CREATE LOGIN [emp_Management_Marketing2]
	WITH PASSWORD = 'PassMarketingMenedzher302',
	DEFAULT_DATABASE = [MobileOperator_by_DmitryBalabanov];


/* Users */
CREATE USER [CEO_Vinogradov_PE] FOR LOGIN [emp_CEO];
CREATE USER [CEO_Gromovoy_IP] FOR LOGIN [emp_CEO_deputy];
CREATE USER [Sales_Kirillova_VA] FOR LOGIN [emp_SalesDep_Senior1];
CREATE USER [Sales_Vlasova_OP] FOR LOGIN [emp_SalesDep_Senior2];
CREATE USER [Sales_Goryunova_SI] FOR LOGIN [emp_SalesDep_Cashier1];
CREATE USER [Sales_Travin_OS] FOR LOGIN [emp_SalesDep_Cashier2];
CREATE USER [Sales_Dmitriev_DR] FOR LOGIN [emp_SalesDep_ShopAssistant1];
CREATE USER [Sales_Blinov_AA] FOR LOGIN [emp_SalesDep_ShopAssistant2];
CREATE USER [Analytic_Dronov_EK] FOR LOGIN [emp_AnalyticDep_SalesAnalytic1];
CREATE USER [Analytic_Petrov_DS] FOR LOGIN [emp_AnalyticDep_SalesAnalytic2];
CREATE USER [Analytic_Frolova_GE] FOR LOGIN [emp_Management_Marketing1];
CREATE USER [Analytic_Sviridov_AG] FOR LOGIN [emp_Management_Marketing2];


/* Roles */
DROP ROLE [CEO];
ALTER ROLE [CEO] ADD MEMBER [CEO_Vinogradov_PE];
ALTER ROLE [CEO] ADD MEMBER [CEO_Gromovoy_IP];

CREATE ROLE [Cashier];
ALTER ROLE [Cashier] ADD MEMBER [Sales_Goryunova_SI];
ALTER ROLE [Cashier] ADD MEMBER [Sales_Travin_OS];
ALTER ROLE [Cashier] ADD MEMBER [Sales_Kirillova_VA];
ALTER ROLE [Cashier] ADD MEMBER [Sales_Vlasova_OP];

CREATE ROLE [ShopAssistant];
ALTER ROLE [ShopAssistant] ADD MEMBER [Sales_Dmitriev_DR];
ALTER ROLE [ShopAssistant] ADD MEMBER [Sales_Blinov_AA];
ALTER ROLE [ShopAssistant] ADD MEMBER [Sales_Kirillova_VA];
ALTER ROLE [ShopAssistant] ADD MEMBER [Sales_Vlasova_OP];

CREATE ROLE [SalesAnalytic];
ALTER ROLE [SalesAnalytic] ADD MEMBER [Analytic_Dronov_EK];
ALTER ROLE [SalesAnalytic] ADD MEMBER [Analytic_Petrov_DS];

CREATE ROLE [MarketingManager];
ALTER ROLE [MarketingManager] ADD MEMBER [Analytic_Frolova_GE]; 
ALTER ROLE [MarketingManager] ADD MEMBER [Analytic_Sviridov_AG];


/* Privilege */
-- CEO
GRANT SELECT, UPDATE, INSERT, DELETE ON [Subscriber] TO [CEO] WITH GRANT OPTION;
GRANT SELECT, UPDATE, INSERT, DELETE ON [Passport] TO [CEO] WITH GRANT OPTION;
GRANT SELECT, UPDATE, INSERT, DELETE ON [HomeAddress] TO [CEO] WITH GRANT OPTION;
GRANT SELECT, UPDATE, INSERT, DELETE ON [Tariff] TO [CEO] WITH GRANT OPTION;
GRANT SELECT, UPDATE, INSERT, DELETE ON [Sellings] TO [CEO] WITH GRANT OPTION;
GRANT SELECT, UPDATE, INSERT, DELETE ON [Billings] TO [CEO] WITH GRANT OPTION;
GRANT SELECT, UPDATE, INSERT, DELETE ON [Traffic] TO [CEO] WITH GRANT OPTION;
GRANT SELECT, UPDATE, INSERT, DELETE ON [UnlimitedServices] TO [CEO] WITH GRANT OPTION;
GRANT SELECT, UPDATE, INSERT, DELETE ON [Package] TO [CEO] WITH GRANT OPTION;
GRANT SELECT ON [SubscribersInfo] TO [CEO] WITH GRANT OPTION;
GRANT EXECUTE ON [CreateDetailing] TO [CEO] WITH GRANT OPTION;
GRANT EXECUTE ON [CreateSellingsSummary] TO [CEO] WITH GRANT OPTION;
GRANT EXECUTE ON [UpdateTariffGrid] TO [CEO] WITH GRANT OPTION;
GRANT EXECUTE ON [ChooseTariff] TO [CEO] WITH GRANT OPTION;
GRANT EXECUTE ON [SalesReportByCohorts] TO [CEO] WITH GRANT OPTION;

-- Cashier
GRANT SELECT, UPDATE, INSERT, DELETE ON [Subscriber] TO [Cashier];
GRANT SELECT, UPDATE, INSERT, DELETE ON [Passport] TO [Cashier];
GRANT SELECT, UPDATE, INSERT, DELETE ON [HomeAddress] TO [Cashier];
GRANT SELECT ON [SubscribersInfo] TO [Cashier];
GRANT SELECT ON [AvaliableTariffs] TO [Cashier];
GRANT INSERT ON [Sellings] TO [Cashier];
GRANT INSERT ON [Billings] TO [Cashier];
GRANT EXECUTE ON [CreateDetailing] TO [Cashier];

-- ShopAssistant
GRANT SELECT ON [Subscriber] TO [ShopAssistant];
GRANT SELECT ON [Passport] TO [ShopAssistant];
GRANT SELECT ON [HomeAddress] TO [ShopAssistant];
GRANT SELECT ON [SubscribersInfo] TO [ShopAssistant]
GRANT SELECT ON [AvaliableTariffs] TO [ShopAssistant];
GRANT SELECT ON [UnlimitedServices] TO [ShopAssistant];
GRANT EXECUTE ON [ChooseTariff] TO [ShopAssistant];

-- SalesAnalytic
GRANT SELECT ON [AnonymousSubscribers] TO [SalesAnalytic];
GRANT SELECT ON [Tariff] TO [SalesAnalytic];
GRANT SELECT ON [Sellings] TO [SalesAnalytic];
GRANT SELECT ON [Billings] TO [SalesAnalytic];
GRANT SELECT ON [Traffic] TO [SalesAnalytic];
GRANT SELECT ON [UnlimitedServices] TO [SalesAnalytic];
GRANT SELECT ON [Package] TO [SalesAnalytic];
GRANT EXECUTE ON [CreateSellingsSummary] TO [SalesAnalytic];
GRANT EXECUTE ON [SalesReportByCohorts] TO [SalesAnalytic];

-- MarketingManager
GRANT SELECT ON [Subscriber] TO [MarketingManager];
GRANT SELECT ON [HomeAddress] TO [MarketingManager];
GRANT SELECT, UPDATE, INSERT, DELETE ON [Tariff] TO [MarketingManager];
GRANT SELECT ON [Sellings] TO [MarketingManager];
GRANT SELECT ON [Billings] TO [MarketingManager];
GRANT SELECT ON [Traffic] TO [MarketingManager];
GRANT SELECT, UPDATE, INSERT, DELETE ON [UnlimitedServices] TO [MarketingManager];
GRANT SELECT ON [Package] TO [MarketingManager];
GRANT EXECUTE ON [CreateSellingsSummary] TO [MarketingManager];
GRANT EXECUTE ON [UpdateTariffGrid] TO [MarketingManager];
GRANT EXECUTE ON [ChooseTariff] TO [MarketingManager];
GRANT EXECUTE ON [SalesReportByCohorts] TO [MarketingManager];



/* Transparent encryption */
USE [master];
DROP CERTIFICATE MyCertificate;
GO
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'StrongPassword123';
GO
BACKUP SERVICE MASTER KEY TO FILE = 'F:\\MasterKeyBackup.enc' ENCRYPTION BY PASSWORD = 'StrongPassword123';
GO
CREATE CERTIFICATE MobileOperatorCertificate WITH SUBJECT = 'CEO_Vinogradov_PE';
GO
BACKUP CERTIFICATE [MobileOperatorCertificate] TO FILE = 'F:\\CertificateBackup.enc' 
WITH PRIVATE KEY (FILE = 'F:\\PrivateKey.enc', ENCRYPTION BY PASSWORD = 'StrongPassword123');
GO

USE [MobileOperator_by_DmitryBalabanov]
GO
CREATE DATABASE ENCRYPTION KEY
WITH ALGORITHM = AES_256
ENCRYPTION BY SERVER CERTIFICATE MobileOperatorCertificate;
GO
ALTER DATABASE [MobileOperator_by_DmitryBalabanov]
SET ENCRYPTION ON;
GO

/* Symmetric encryption */
CREATE SYMMETRIC KEY SymKey_Encr_Address
WITH ALGORITHM = AES_256
ENCRYPTION BY PASSWORD = 'AddressSymmetricKeyPassword123';
GO
