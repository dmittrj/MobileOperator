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
	[sub_id] INT IDENTITY(1,1) PRIMARY KEY,

	[sub_name] NVARCHAR(64) NOT NULL,
	[sub_passport] VARCHAR(11) NULL DEFAULT NULL,
	
	[sub_phone_number] VARCHAR(16) NOT NULL UNIQUE,
	[sub_joining_date] DATE NULL DEFAULT NULL,
	[sub_billing_date] DATE NULL DEFAULT NULL,
	[sub_tariff] INT NULL DEFAULT NULL,
	[sub_balance] DECIMAL NOT NULL DEFAULT 0
);



/* Passport entity */
DROP TABLE IF EXISTS [Passport];
CREATE TABLE Passport (
	[ppt_series_number] VARCHAR(4) NOT NULL,
	[ppt_issued_by] NVARCHAR(64) NOT NULL,
	[ppt_issued_date] DATE NOT NULL,
	[ppt_division_code] VARCHAR(10) NOT NULL,
	[ppt_date_of_birth] DATE NOT NULL,
	[ppt_address] INT NOT NULL,

	[ppt_gender] CHAR NOT NULL,
	CONSTRAINT ppt_ser_num PRIMARY KEY ([ppt_series_number])
);
ALTER TABLE [Subscriber] ADD CONSTRAINT fk_sub_pptHolds FOREIGN KEY ([sub_passport]) REFERENCES Passport([ppt_series_number]);



/* Address entity */
DROP TABLE IF EXISTS [HomeAddress];
CREATE TABLE HomeAddress (
	[adr_id] INT PRIMARY KEY,

	[adr_region] NVARCHAR NOT NULL,
	[adr_city] NVARCHAR NOT NULL,
	[adr_locality] NVARCHAR NOT NULL,
	[adr_street] NVARCHAR NOT NULL,
	[adr_home] NVARCHAR NOT NULL,
	[adr_apartment] NVARCHAR NOT NULL,

	[add_post_index] VARCHAR(6) NOT NULL
);



/* Tariff entity */
DROP TABLE IF EXISTS [Tariff];
CREATE TABLE Tariff (
	[tar_id] INT IDENTITY(1,1) PRIMARY KEY,
	[tar_name] NVARCHAR(32) NOT NULL,

	[tar_minutes] INT NOT NULL,
	[tar_sms] INT NOT NULL,
	[tar_internet] REAL NOT NULL
);



/* Package entity */
DROP TABLE IF EXISTS [Package];
CREATE TABLE Package (
	[pak_id] INT IDENTITY(1,1) PRIMARY KEY,

	[pak_minutes] INT NOT NULL,
	[pak_sms] INT NOT NULL,
	[pak_internet] REAL NOT NULL
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
	[bll_money] DECIMAL NOT NULL DEFAULT 0,
	 
	[bll_date] DATETIME NULL
);