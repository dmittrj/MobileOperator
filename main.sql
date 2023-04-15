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


/* Own types */
DROP TYPE IF EXISTS PHONE
DROP TYPE IF EXISTS PASSPORTDATA
DROP TYPE IF EXISTS STRING

CREATE TYPE PHONE FROM VARCHAR(16) NOT NULL;
CREATE TYPE PASSPORTDATA FROM VARCHAR(11) NOT NULL;
CREATE TYPE STRING FROM NVARCHAR(64);

GO


/* Subscriber entity */
CREATE TABLE Subscriber (
	[sub_phone_number] PHONE PRIMARY KEY,

	[sub_name] STRING NOT NULL,
	[sub_passport] PASSPORTDATA NOT NULL,
	
	[sub_joining_date] DATE NULL DEFAULT NULL,

	[sub_tariff] INT NULL DEFAULT NULL,
	[sub_balance] SMALLMONEY NOT NULL DEFAULT 0,
	[sub_package] INT NOT NULL,

	[sub_email] VARCHAR(255) NULL DEFAULT NULL
);



/* Passport entity */
CREATE TABLE Passport (
	[ppt_series_number] PASSPORTDATA PRIMARY KEY,
	[ppt_issued_by] STRING NOT NULL,
	[ppt_issued_date] DATE NOT NULL,
	[ppt_division_code] VARCHAR(7) NOT NULL,
	[ppt_date_of_birth] DATE NOT NULL,
	[ppt_address] INT NULL DEFAULT NULL,

	[ppt_gender] CHAR NOT NULL CONSTRAINT ch_gen CHECK([ppt_gender] IN ('M', 'F'))
);
ALTER TABLE [Subscriber] ADD CONSTRAINT fk_sub_pptHolds FOREIGN KEY ([sub_passport]) REFERENCES Passport([ppt_series_number]);



/* Address entity */
CREATE TABLE HomeAddress (
	[adr_id] INT PRIMARY KEY,

	[adr_region] STRING NOT NULL,
	[adr_city] STRING NOT NULL,
	[adr_locality] STRING NOT NULL,
	[adr_street] STRING NOT NULL,
	[adr_home] STRING NOT NULL,
	[adr_apartment] STRING NOT NULL,

	[add_post_index] VARCHAR(6) NOT NULL,
);
ALTER TABLE [Passport] ADD CONSTRAINT fk_ppt_adrLives FOREIGN KEY ([ppt_address]) REFERENCES HomeAddress([adr_id]);



/* Tariff entity */
DROP TABLE IF EXISTS [Tariff];
CREATE TABLE Tariff (
	[tar_id] INT IDENTITY(1,1) PRIMARY KEY,
	[tar_name] NVARCHAR(32) NOT NULL UNIQUE,
	[tar_creating_date] DATE NOT NULL,

	[tar_minutes] INT NOT NULL,
	[tar_sms] INT NOT NULL,
	[tar_internet] REAL NOT NULL,

	[tar_cost] SMALLMONEY NOT NULL DEFAULT 0
);



/* Package entity */
DROP TABLE IF EXISTS [Afford];
CREATE TABLE Afford (
	[aff_id] INT IDENTITY(1,1) PRIMARY KEY,
	 
	[aff_minutes] INT NOT NULL,
	[aff_sms] INT NOT NULL,
	[aff_internet] REAL NOT NULL,

	[aff_billing_date] DATE NULL DEFAULT NULL,
);



/* Sellings entity */
DROP TABLE IF EXISTS [Sellings];
CREATE TABLE Sellings (
	[sll_id] INT IDENTITY(1,1) PRIMARY KEY, /* id */

	[sll_sub_id] INT NOT NULL,
	[sll_tar_id] INT NOT NULL,
	
	[sll_date] DATETIME NULL,
);



/* Billings entity */
DROP TABLE IF EXISTS [Billings];
CREATE TABLE Billings (
	[bll_id] INT IDENTITY(1,1) PRIMARY KEY,
	 
	[bll_sub_id] INT NOT NULL,
	[bll_money] SMALLMONEY NOT NULL DEFAULT 0,
	 
	[bll_date] DATETIME NULL
);

GO

/* Checking balance */
CREATE OR ALTER PROCEDURE TariffSalesSummary (@sub_id INT)
AS
BEGIN
	SELECT *
	FROM [Subscriber];
END;

GO

/* Creating roles */
CREATE ROLE Cashier