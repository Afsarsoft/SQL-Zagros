/***************************************************************************************************
File: TestLocation.sql
----------------------------------------------------------------------------------------------------
Create Date:    2020-09-01 (yyyy-mm-dd)
Author:         Surush Cyrus
Description:    Testing Zagros.Location table for INSERT, DELETE, UPDATE, ...
Call by:        Add hoc
Steps:          N/A 
****************************************************************************************************
SUMMARY OF CHANGES
Date(yyyy-mm-dd)    Author              Comments
------------------- ------------------- ------------------------------------------------------------
****************************************************************************************************/

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Testing INSERT Location
SELECT *
FROM Zagros.Location
ORDER BY LocationID DESC

EXEC Zagros.InsertLocation @Name = 'Test1'
EXEC Zagros.InsertLocation @Name = 'Test2'

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Testing DELETE Location
EXEC Zagros.DeleteLocation @LocationID = 19;
EXEC Zagros.DeleteLocation @LocationID = 20;

SELECT *
FROM Zagros.History
ORDER BY RowID DESC
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Testing UPDATE Location
SELECT *
FROM Zagros.Location
ORDER BY LocationID DESC

EXEC Zagros.UpdateLocation  @LocationID = 19,
    @Name = 'Some update test1'

EXEC Zagros.UpdateLocation  @LocationID = 19

-- Should error out
EXEC Zagros.UpdateLocation  @LocationID = 22
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

