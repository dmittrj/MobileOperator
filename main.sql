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


/* Own types */
DROP TYPE IF EXISTS PHONE
DROP TYPE IF EXISTS PASSPORTDATA
DROP TYPE IF EXISTS STRING
DROP TYPE IF EXISTS SMALLSTRING
DROP TYPE IF EXISTS BIGSTRING

CREATE TYPE PHONE FROM VARCHAR(16) NOT NULL;
CREATE TYPE PASSPORTDATA FROM CHAR(11) NOT NULL;
CREATE TYPE STRING FROM NVARCHAR(64);
CREATE TYPE SMALLSTRING FROM NVARCHAR(32);
CREATE TYPE BIGSTRING FROM NVARCHAR(100);

GO


/* Subscriber entity */
CREATE TABLE Subscriber (
	[sub_phone_number] PHONE PRIMARY KEY,

	[sub_name] STRING NOT NULL,
	[sub_passport] PASSPORTDATA NOT NULL,
	
	[sub_joining_date] DATE NULL DEFAULT NULL,

	[sub_tariff] SMALLSTRING NULL DEFAULT NULL,
	[sub_balance] SMALLMONEY NOT NULL DEFAULT 0,

	[sub_email] BIGSTRING NULL DEFAULT NULL
);



/* Passport entity */
CREATE TABLE Passport (
	[ppt_series_number] PASSPORTDATA PRIMARY KEY,
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

	[adr_region] STRING NOT NULL,
	[adr_city] STRING NOT NULL,
	[adr_locality] STRING NOT NULL,
	[adr_street] STRING NOT NULL,
	[adr_home] VARCHAR(10) NOT NULL,
	[adr_apartment] VARCHAR(5) NULL
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



/* Package entity */
CREATE TABLE Package (
	[pck_id] INT IDENTITY(1,1) PRIMARY KEY,
	[pck_subscriber] PHONE,

	[pck_minutes] INT NULL,
	[pck_sms] INT NULL,
	[pck_internet] REAL NULL,

	[pck_billing_date] INT NULL DEFAULT NULL CONSTRAINT ch_billDay CHECK([pck_billing_date] >= 1 AND [pck_billing_date] <= 31),
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


CREATE OR ALTER TRIGGER trig_trafficInput ON [Traffic]
AFTER INSERT
AS
BEGIN
	DECLARE @ins_type VARCHAR(15);
	SET @ins_type = (SELECT trf_type FROM INSERTED);
	IF (@ins_type = 'Outgoing call' AND (SELECT pck_minutes FROM [Package] WHERE pck_subscriber = (SELECT trf_subscriber FROM INSERTED)) IS NOT NULL)
	BEGIN
		UPDATE [Package]
		SET pck_minutes = pck_minutes - (SELECT trf_amount FROM INSERTED) WHERE pck_subscriber = (SELECT trf_subscriber FROM INSERTED);
		IF ((SELECT pck_minutes FROM [Package] WHERE pck_subscriber = (SELECT trf_subscriber FROM INSERTED)) < 0 )
		BEGIN
			UPDATE [Traffic]
			SET trf_pay = -(SELECT pck_minutes FROM [Package] WHERE pck_subscriber = (SELECT trf_subscriber FROM INSERTED)) WHERE trf_id = (SELECT trf_id FROM INSERTED);
			UPDATE [Subscriber]
			SET sub_balance = sub_balance - (SELECT trf_pay FROM [Traffic] WHERE trf_id = (SELECT trf_id FROM INSERTED)) WHERE sub_phone_number = (SELECT trf_subscriber FROM INSERTED);
			--UPDATE [Subscriber]
			--SET sub_balance = sub_balance + 5 WHERE sub_name = '+79123456789';--(SELECT trf_subscriber FROM INSERTED);
			UPDATE [Package]
			SET pck_minutes = 0 WHERE pck_subscriber = (SELECT trf_subscriber FROM INSERTED);
		END
	END
END;

GO
