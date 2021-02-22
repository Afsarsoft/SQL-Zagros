CREATE OR ALTER PROCEDURE Zagros.InsertOrderV2
    @OrderID     INT,
    @CustomerID  INT
AS
/***************************************************************************************************
File: InsertOrderV2.sql
----------------------------------------------------------------------------------------------------
Procedure:      Zagros.InsertOrderV2
Create Date:    2021-03-01 (yyyy-mm-dd)
Author:         Surush Cyrus
Description:    Insert an order
Call by:        Add Hoc
Note: SP Zagros.InsertOrder is design to work only with AddOrder SP. For add hoc use, only use SP Zagros.InsertOrderV2

Steps:          1- Check the @CustomerID for RI issue in Zagros.Customertable
                2- Call SP Zagros.CalTotalAmount to calculate @TotalAmount
                3- Insert to table Zagros.[Order]

Parameter(s):   @OrderID
                @CustomerID

Usage:          Zagros.InsertOrderV2 @OrderID = 100000003,
                                     @CustomerID = 100000001,
****************************************************************************************************
SUMMARY OF CHANGES
Date(yyyy-mm-dd)    Author              Comments
------------------- ------------------- ------------------------------------------------------------
****************************************************************************************************/
SET NOCOUNT ON;

DECLARE @ErrorText   VARCHAR(MAX),      
        @Message     VARCHAR(255),    
        @StartTime   DATETIME,
        @SP          VARCHAR(50),

        @TotalAmount MONEY;


BEGIN TRY;   
SET @ErrorText = 'Unexpected ERROR in setting the variables!';

SET @SP = OBJECT_NAME(@@PROCID);
SET @StartTime = GETDATE();

SET @TotalAmount = 0;

SET @Message = 'Started SP ' + @SP + ' at ' + FORMAT(@StartTime , 'MM/dd/yyyy HH:mm:ss');   
RAISERROR (@Message, 0,1) WITH NOWAIT;
EXEC Zagros.InsertHistory @SP = @SP,
   @Status = 'Start',
   @Message = @Message

-------------------------------------------------------------------------------
SET @ErrorText = 'Failed SELECT from table Customer!';
-- Check to give a friendly error for RI Issue.
IF NOT EXISTS(SELECT 1
FROM Zagros.Customer
WHERE CustomerID = @CustomerID)
BEGIN
    SET @ErrorText = 'CustomerID = ' + CONVERT(VARCHAR(10), @CustomerID) + ' not found in table Customer! This is not acceptable. Rasing Error!';
    RAISERROR(@ErrorText, 16,1);
END;

SET @ErrorText = 'Failed Calling SP CalTotalAmount!';
EXEC Zagros.CalTotalAmount @SomeOrderID = @OrderID, @Total =  @TotalAmount OUTPUT;

SET @Message = '@TotalAmount = ' + CONVERT(VARCHAR(10), @TotalAmount) + ' is the return value from SP Zagros.CalTotalAmount.';
RAISERROR (@Message, 0,1) WITH NOWAIT;
EXEC Zagros.InsertHistory @SP = @SP,
                            @Status = 'Run',
                            @Message = @Message;

SET @ErrorText = 'Failed INSERT to table Order!';
INSERT INTO Zagros.[Order]
    (OrderID, CustomerID, OrderStatusID, OrderDate, TotalAmount)
VALUES
    (@OrderID, @CustomerID, 1, GETDATE(), @TotalAmount)

SET @Message = CONVERT(VARCHAR(10), @@ROWCOUNT) + ' rows effected. Completed INSERT to table Order using OrderID = ' + CONVERT(VARCHAR(10), @OrderID) ;   
RAISERROR (@Message, 0,1) WITH NOWAIT;
EXEC Zagros.InsertHistory @SP = @SP,
   @Status = 'Run',
   @Message = @Message
-------------------------------------------------------------------------------

SET @Message = 'Completed SP ' + @SP + '. Duration in minutes:  '    
      + CONVERT(VARCHAR(12), CONVERT(DECIMAL(6,2),datediff(mi, @StartTime, getdate())));    
RAISERROR (@Message, 0,1) WITH NOWAIT;    
EXEC Zagros.InsertHistory @SP = @SP,
   @Status = 'End',
   @Message = @Message

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
   @Message = @ErrorText
     
   RAISERROR(@ErrorText,18,127) WITH NOWAIT;      
END CATCH;      

