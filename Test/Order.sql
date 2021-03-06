/***************************************************************************************************
File: TestOrder.sql
----------------------------------------------------------------------------------------------------
Create Date:    2020-09-01 (yyyy-mm-dd)
Author:         Surush Cyrus
Description:    Testing Zagros.[Order] and Zagros.OrderDetail tables for INSERT, DELETE, UPDATE, ...
Call by:        Add hoc
Steps:          N/A 
****************************************************************************************************
SUMMARY OF CHANGES
Date(yyyy-mm-dd)    Author              Comments
------------------- ------------------- ------------------------------------------------------------
****************************************************************************************************/

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- INSERT 
SELECT *
FROM Zagros.Customer
ORDER BY CustomerID DESC

SELECT *
FROM Zagros.History
ORDER BY RowID DESC;

-- Testing Insert Order
SELECT *
FROM Zagros.[Order]

SELECT *
FROM Zagros.OrderDetail

EXEC Zagros.InsertOrderV2 @OrderID = 100000001,
     @CustomerID =  100000001

EXEC Zagros.InsertOrderDetail @OrderID = 100000001,
     @LocationID = 01,
	@PackageID = 01,
	@UnitPrice = 300,
     @Quantity = 1

EXEC Zagros.InsertOrderDetail @OrderID = 100000001,
     @LocationID = 02,
	@PackageID = 04,
	@UnitPrice = 60,
     @Quantity = 2

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- DELETE 
EXEC Zagros.DeleteOrder @OrderID = 100001001;

DELETE 
FROM Zagros.OrderDetail

DELETE 
FROM Zagros.[Order]
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- UPDATE
SELECT *
FROM Zagros.Customer

SELECT *
FROM Zagros.[Order]

SELECT *
FROM Zagros.OrderDetail

EXEC Zagros.UpdateOrder  @OrderID = 100000001,
    @CustomerID = 100000002,
    @OrderStatusID = 1,
    @OrderDate     = '2019/08/25',
    @FinalDate     = NULL,
    @Note          = 'Some stuff';

-- We should not update OrderDetail
