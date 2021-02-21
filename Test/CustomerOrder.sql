/***************************************************************************************************
File: TestCustomerOrder.sql
----------------------------------------------------------------------------------------------------
Create Date:    2020-09-01 (yyyy-mm-dd)
Author:         Surush Cyrus
Description:    Testing Zagros.CustomerOrder table for INSERT, DELETE, UPDATE, ...
Call by:        Add hoc
Steps:          N/A 
****************************************************************************************************
SUMMARY OF CHANGES
Date(yyyy-mm-dd)    Author              Comments
------------------- ------------------- ------------------------------------------------------------
****************************************************************************************************/

INSERT INTO Zagros.CustomerOrder
    (Email, LocationID, PackageID, UnitPrice, Quantity, Note)
VALUES
    ('100000051@xyz.com', 01, 01, 500, 1, 'Test Note 1'),
    ('100000051@xyz.com', 02, 04, 60, 2, 'Test Note 2')

INSERT INTO Zagros.CustomerOrder
    (Email, LocationID, PackageID, UnitPrice, Quantity, Note)
VALUES
    ('100000050@xyz.com', 01, 01, 500, 1, 'Test Note 1'),
    ('100000050@xyz.com', 02, 04, 60, 2, 'Test Note 2')

SELECT *
FROM Zagros.Customer
ORDER BY CustomerID DESC;

SELECT *
FROM Zagros.CustomerOrder;

EXEC Zagros.AddOrder

SELECT *
FROM Zagros.History
ORDER BY RowID DESC;

SELECT *
FROM Zagros.[Order];

SELECT *
FROM Zagros.OrderDetail;

SELECT *
FROM Zagros.CustomerOrder;

DELETE FROM Zagros.[Order];

DELETE FROM Zagros.OrderDetail;


SELECT TOP 5
    *
FROM Zagros.Customer
-- 100001001@xyz.com

SELECT TOP 5
    *
FROM Zagros.Location
-- Ardal
-- Behbahan

SELECT TOP 5
    *
FROM Zagros.Package
-- 01 Day Package
-- Cabin


-- 
-- 
-- 
DELETE FROM Zagros.CustomerOrder;


