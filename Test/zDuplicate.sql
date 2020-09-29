/***************************************************************************************************
File: zDuplicate.sql
----------------------------------------------------------------------------------------------------
Create Date:    2020-09-01 (yyyy-mm-dd)
Author:         Surush Cyrus
Description:    Testing for duplicates
Call by:        Add hoc
Steps:          N/A 
****************************************************************************************************
SUMMARY OF CHANGES
Date(yyyy-mm-dd)    Author              Comments
------------------- ------------------- ------------------------------------------------------------
****************************************************************************************************/

-- Check for duplicate emails.
SELECT Email
FROM Zagros.Customer WITH (NOLOCK)
Group BY Email
Having Count(*) > 1

-- To get the number of duplicate email
SELECT Email, COUNT(*) TotalEmailCount
FROM Zagros.Customer WITH (NOLOCK)
Group BY Email
Having Count(*) > 1