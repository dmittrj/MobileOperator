/* Creating db */
USE master;
IF DB_ID (N'MobileOperator_by_DmitryBalabanov') IS NOT NULL
	DROP DATABASE [MobileOperator_by_DmitryBalabanov];

CREATE DATABASE [MobileOperator_by_DmitryBalabanov]
GO


USE MobileOperator_by_DmitryBalabanov;



/* Subscriber entity */
DROP TABLE IF EXISTS [Subscriber];
CREATE TABLE Subscriber (
	[sub_id] INT IDENTITY(1,1) PRIMARY KEY, /* id */

	[sub_name] NVARCHAR(64) NOT NULL, /* surname, name, patronymic */
	[sub_passport_s] VARCHAR(4) NULL DEFAULT NULL, /* link to: PASSPORT */
	[sub_passport_n] VARCHAR(6) NULL DEFAULT NULL, /* link to: PASSPORT */
	
	[sub_phone_number] VARCHAR(16) NOT NULL,
	[sub_joining_date] DATE NULL, /* start date of using the operator's services */
	[sub_tariff] INT NULL, /* current tariff */
	[sub_balance] DECIMAL NOT NULL DEFAULT 0 /* Subscriber balance */
);



/* Passport entity */
DROP TABLE IF EXISTS [Passport];
CREATE TABLE Passport (
	[ppt_series] VARCHAR(4) NOT NULL, /* Passport series */
	[ppt_number] VARCHAR(6) NOT NULL, /* Passport number */
	[ppt_issued_by] NVARCHAR(64) NOT NULL, /* Who issued the passport */
	[ppt_issued_date] DATE NOT NULL, /* When the passport was issued */
	[ppt_division_code] VARCHAR(10) NOT NULL, /* The code of the organization that issued the passport */
	[ppt_date_of_birth] DATE NOT NULL, /* The date of birth of the passport holder */
	CONSTRAINT ppt_ser_num PRIMARY KEY CLUSTERED ([ppt_series], [ppt_number])
);
ALTER TABLE [Subscriber] ADD CONSTRAINT fk_sub_pptHolds FOREIGN KEY ([sub_passport_s], [sub_passport_n]) REFERENCES Passport([ppt_series], [ppt_number]);



/* Address entity */
DROP TABLE IF EXISTS [HomeAddress];
CREATE TABLE HomeAddress (
	[adr_id] INT NOT NULL,

	[adr_city] NVARCHAR NOT NULL,
	[adr_street] NVARCHAR NOT NULL,
	[adr_home] NVARCHAR NOT NULL,
	[adr_apartment] NVARCHAR NOT NULL,
);



/* Tariff entity */
DROP TABLE IF EXISTS [Tariff];
CREATE TABLE Tariff (
	[tar_id] INT IDENTITY(1,1) PRIMARY KEY, /* id */
	[tar_name] NVARCHAR(32) NOT NULL, /* tariff name */

	[tar_minutes] INT NOT NULL, /* Minutes to talk-talk */
	[tar_sms] INT NOT NULL, /* Number of SMS */
	[tar_internet] REAL NOT NULL /* Amount of Internet traffic, gb */
);



/* Package entity */
DROP TABLE IF EXISTS [Package];
CREATE TABLE Package (
	[pak_id] INT IDENTITY(1,1) PRIMARY KEY, /* id */

	[pak_minutes] INT NOT NULL, /* Minutes to talk-talk */
	[pak_sms] INT NOT NULL, /* Number of SMS */
	[pak_internet] REAL NOT NULL /* Amount of Internet traffic, gb */
);



/* Sellings entity */
DROP TABLE IF EXISTS [Sellings];
CREATE TABLE Sellings (
	[sll_id] INT IDENTITY(1,1) PRIMARY KEY, /* id */

	[sll_sub_id] INT NOT NULL, /* subscriber who purchased a tariff */
	[sll_tar_id] INT NOT NULL, /* tariff that was purchased */
	
	[sll_date] DATETIME NULL, /* date and time when tariff was purchased */
);



/* Billings entity */
DROP TABLE IF EXISTS [Billings];
CREATE TABLE Billings (
	[bll_id] INT IDENTITY(1,1) PRIMARY KEY, /* id */
	 
	[bll_sub_id] INT NOT NULL, /* subscriber who purchased a tariff */
	[bll_tar_id] INT NOT NULL, /* tariff that was purchased */
	 
	[bll_date] DATETIME NULL, /* date and time when tariff was purchased */
);