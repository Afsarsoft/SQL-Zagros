/***************************************************************************************************
File: TestPackage.sql
----------------------------------------------------------------------------------------------------
Create Date:    2020-09-01 (yyyy-mm-dd)
Author:         Surush Cyrus
Description:    Testing Zagros.Package table for INSERT, DELETE, UPDATE, ...
Call by:        Add hoc
Steps:          N/A 
****************************************************************************************************
SUMMARY OF CHANGES
Date(yyyy-mm-dd)    Author              Comments
------------------- ------------------- ------------------------------------------------------------
****************************************************************************************************/

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Testing INSERT Package
SELECT *
FROM Zagros.Package
ORDER BY PackageID DESC

EXEC Zagros.InsertPackage @Name = 'Test1',
    @UnitPrice = 500,
    @Note = NULL

EXEC Zagros.InsertPackage @Name = 'Test2',
    @UnitPrice = 200,
    @Note = 'Test2 stuff ...'

EXEC Zagros.DeletePackage @PackageID = 28;

EXEC Zagros.DeletePackage @PackageID = 29;

SELECT *
FROM Zagros.History
ORDER BY RowID DESC
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Testing UPDATE Package
SELECT *
FROM Zagros.Package
ORDER BY PackageID DESC

EXEC Zagros.UpdatePackage  @PackageID = 25,
     @Name = 'Some update test1'

EXEC Zagros.UpdatePackage  @PackageID = 26
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

