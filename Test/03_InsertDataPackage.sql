/***************************************************************************************************
File: 03_InsertDataPackage.sql
----------------------------------------------------------------------------------------------------
Create Date:    2020-09-01 (yyyy-mm-dd)
Author:         Surush Cyrus
Description:    Inserts needed data to table Zagros.Package 
Call by:        TBD, Add hoc
Steps:          N/A 
****************************************************************************************************
SUMMARY OF CHANGES
Date(yyyy-mm-dd)    Author              Comments
------------------- ------------------- ------------------------------------------------------------
****************************************************************************************************/
SET NOCOUNT ON;

DECLARE @ErrorText VARCHAR(MAX),      
        @Message   VARCHAR(255),   
        @StartTime DATETIME,
        @SP        VARCHAR(50)

BEGIN TRY;   
SET @ErrorText = 'Unexpected ERROR in setting the variables!';

SET @SP = 'Script-03_InsertDataPackage';
SET @StartTime = GETDATE(); 
   
SET @Message = 'Started SP ' + @SP + ' at ' + FORMAT(@StartTime , 'MM/dd/yyyy HH:mm:ss');   
RAISERROR (@Message, 0,1) WITH NOWAIT;
EXEC Zagros.InsertHistory @SP = @SP,
   @Status = 'Start',
   @Message = @Message;

-------------------------------------------------------------------------------
SET @ErrorText = 'Failed INSERT table Package table.';

INSERT INTO Zagros.Package
    (PackageID, Name, UnitPrice, Note)
VALUES
    (01, '01 Day Package', 500, 'Pick Up, Guide, Transportation, Meals, Accommodation, Fees, Hiking, and Drop Off are included.'),
    (02, '03 Days Package', 1000, 'Pick Up, Guide, Transportation, Meals, Accommodation, Fees, Hiking, and Drop Off are included.'),
    (03, '07 Days Package', 1500, 'Pick Up, Guide, Transportation, Meals, Accommodation, Fees, Hiking, and Drop Off are included.'),
    (04, 'Cabin', 60, 'Nightly'),
    (05, 'Camp', 30, 'Nightly'),
    (06, 'Room, Shared', 20, 'Nightly'),
    (07, 'Room, Private', 10, 'Nightly'),
    (08, 'Guesthouse', 40, 'Nightly'),
    (09, 'Local House', 30, 'Nightly'),
    (10, 'Pick Up', 15, NULL),
    (11, 'Drop Of', 15, NULL),
    (12, 'Mountain Bike', 10, 'Hourly'),
    (13, 'Hybird Bike', 10, 'Hourly'),
    (14, 'Electric Bike', 20, 'Hourly'),
    (15, 'Transportation', 10, NULL),
    (16, 'Breakfast', 10, NULL),
    (17, 'Lunch', 20, NULL),
    (18, 'Dinner', 30, NULL),
    (19, 'Snacks', 5, NULL),
    (20, 'Guide', 5, 'Hourly'),
    (21, 'Donkey Ride', 3, 'Hourly'),
    (22, 'Mule Ride', 4, 'Hourly'),
    (23, 'Horse Ride', 5, 'Hourly'),
    (24, 'Camel Ride', 7, 'Hourly'),
    (25, 'Balloon Ride', 10, 'Hourly'),
    (26, 'Canoeing', 10, 'Hourly'),
    (27, 'Miscellaneous', 0, NULL)

SET @Message = CONVERT(VARCHAR(10), @@ROWCOUNT) + ' rows effected. Completed INSERT to table Package';   
RAISERROR (@Message, 0,1) WITH NOWAIT;
EXEC Zagros.InsertHistory @SP = @SP,
   @Status = 'Run',
   @Message = @Message;
-------------------------------------------------------------------------------

SET @Message = 'Completed SP ' + @SP + '. Duration in minutes:  '   
   + CONVERT(VARCHAR(12), CONVERT(DECIMAL(6,2),datediff(mi, @StartTime, getdate())));  
RAISERROR(@Message, 0,1) WITH NOWAIT;
EXEC Zagros.InsertHistory @SP = @SP,
   @Status = 'End',
   @Message = @Message;

END TRY

BEGIN CATCH;
IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;

SET @ErrorText = 'Error: '+CONVERT(VARCHAR,ISNULL(ERROR_NUMBER(),'NULL'))      
                  +', Severity = '+CONVERT(VARCHAR,ISNULL(ERROR_SEVERITY(),'NULL'))      
                  +', State = '+CONVERT(VARCHAR,ISNULL(ERROR_STATE(),'NULL'))      
                  +', Line = '+CONVERT(VARCHAR,ISNULL(ERROR_LINE(),'NULL'))      
                  +', Procedure = '+CONVERT(VARCHAR,ISNULL(ERROR_PROCEDURE(),'NULL'))      
                  +', Server Error Message = '+CONVERT(VARCHAR(100),ISNULL(ERROR_MESSAGE(),'NULL'))      
                  +', SP Defined Error Text = '+@ErrorText;

EXEC Zagros.InsertHistory @SP = @SP,
   @Status = 'Error',
   @Message = @ErrorText;

RAISERROR(@ErrorText,18,127) WITH NOWAIT;
END CATCH;      
