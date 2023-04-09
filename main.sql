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
	[sub_passport_id] INT NOT NULL, /* link to: PASSPORT */
	
	[sub_joining_date] DATE NULL, /* start date of using the operator's services */
	[sub_tariff] INT NULL /* current tariff */
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