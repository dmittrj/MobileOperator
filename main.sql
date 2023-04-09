/* Creating db */
USE master;
IF DB_ID (N'MobileOperator_by_DmitryBalabanov') IS NOT NULL
	DROP DATABASE MobileOperator_by_DmitryBalabanov;

CREATE DATABASE MobileOperator_by_DmitryBalabanov
GO


USE MobileOperator_by_DmitryBalabanov;


/* Subscriber entity */
CREATE TABLE Subscriber (
	sub_id INT IDENTITY(1,1) PRIMARY KEY, /* id */

	sub_name NVARCHAR(64) NOT NULL, /* surname, name, patronymic */
	sub_passport_id INT NOT NULL, /* link to: PASSPORT */
	
	sub_joining_date DATE NULL, /* start date of using the operator's services */
	sub_tariff INT NULL /* current tariff */
);