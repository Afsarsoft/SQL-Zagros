/***************************************************************************************************
File: TestCustomer.sql
----------------------------------------------------------------------------------------------------
Create Date:    2020-09-01 (yyyy-mm-dd)
Author:         Surush Cyrus
Description:    Testing Zagros.Customer table for INSERT, DELETE, UPDATE, ...
Call by:        Add hoc
Steps:          N/A 
****************************************************************************************************
SUMMARY OF CHANGES
Date(yyyy-mm-dd)    Author              Comments
------------------- ------------------- ------------------------------------------------------------
****************************************************************************************************/
-- Testing INSERT Customer
SELECT *
FROM Zagros.Customer
ORDER BY CustomerID DESC

EXEC Zagros.InsertCustomer 
     @CustomerID = 100001051,
     @CountryID = 91,
     @Email = '100001051@xyz.com',
     @FirstName = 'FirstName51 100001051',
     @LastName = 'LastName51 100001051', 
     @ID = 'ID 100001051'

EXEC Zagros.InsertCustomer 
     @CustomerID = 100001052,
     @CountryID = 92,
     @Email = '100001052@xyz.com',
     @FirstName = 'FirstName52 100001052',
     @LastName = 'LastName52 100001052', 
     @ID = 'ID 100001052',
	@Tel1 = '22222222222',
	@Tel2 = '88888888888',
     @Website = 'www.test.com',
     @Address = 'Some Addrress ...',
     @Note = 'XYZ ?????? ??????'

-- Testing DELETE Customer
EXEC Zagros.DeleteCustomer @CustomerID = 100001051
EXEC Zagros.DeleteCustomer @CustomerID = 100001052

SELECT *
FROM Zagros.History
ORDER BY RowID DESC
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Testing UPDATE Customer
SELECT *
FROM Zagros.Customer
ORDER BY CustomerID DESC

EXEC Zagros.UpdateCustomer  @CustomerID = 100001051,
     @CountryID = 92

EXEC Zagros.UpdateCustomer  @CustomerID = 100001052,
     @CountryID = 92,
     @Email = 'xyz10000010@abc.com',
     @FirstName = 'FirstName stuff...',
     @LastName = 'LastName stuff', 
     @ID = 'skdjkdj11121221', 
     @Tel1 = '012345678799',
     @Tel2 = '01234567879999999',
     @Website = 'www.test.com',
     @Address = 'Some Addrress ...',
     @Note = 'STUFF STUU FOR NOTE ......'

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Testing Find
SELECT *
FROM Zagros.Customer
WHERE CustomerID = 10000010

SELECT *
FROM Zagros.Customer
WHERE FirstName LIKE 'FirstName1%';

SELECT *
FROM Zagros.Customer
WHERE LastName LIKE 'LastName2%';

SELECT *
FROM Zagros.Customer
WHERE Email LIKE '1000002%';

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
EXEC Zagros.FindCustomerByCustomerID @CustomerID = 10000010;
EXEC Zagros.FindCustomerByCustomerID @CustomerID = 10000019;

EXEC Zagros.FindCustomerByEmail @Email = '1000002';
EXEC Zagros.FindCustomerByEmail @Email = '1000003';

EXEC Zagros.FindCustomerByLastName @LastName = 'LastName2';
EXEC Zagros.FindCustomerByLastName @LastName = 'LastName3';

EXEC Zagros.FindCustomerByFirstName @FirstName = 'FirstName3';
EXEC Zagros.FindCustomerByFirstName @FirstName = 'FirstName4';