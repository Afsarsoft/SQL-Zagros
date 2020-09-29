/***************************************************************************************************
File: zTables.sql
----------------------------------------------------------------------------------------------------
Create Date:    2020-09-01 (yyyy-mm-dd)
Author:         Surush Cyrus
Description:    Testing for main tables 
Call by:        Add hoc
Steps:          N/A 
****************************************************************************************************
SUMMARY OF CHANGES
Date(yyyy-mm-dd)    Author              Comments
------------------- ------------------- ------------------------------------------------------------
****************************************************************************************************/
SELECT *
FROM Zagros.Country;

SELECT *
FROM Zagros.Customer;

SELECT *
FROM Zagros.Package;

SELECT *
FROM Zagros.OrderStatus;
-- 
SELECT *
FROM Zagros.[Order];

SELECT *
FROM Zagros.OrderDetail;

SELECT *
FROM Zagros.CustomerOrder;

SELECT *
FROM Zagros.Parameter;

-- 

SELECT *
FROM Zagros.History
ORDER BY RowID DESC;

-- 
-- 
DELETE FROM Zagros.Country
WHERE CountryID = 92

DELETE FROM Zagros.Country

DELETE FROM Zagros.Customer;

DELETE FROM Zagros.Package;

DELETE FROM Zagros.OrderStatus;
-- 
DELETE FROM Zagros.[Order];

DELETE FROM Zagros.OrderDetail;

DELETE FROM Zagros.CustomerOrder;

EXEC sp_help 'Zagros.Customer';
