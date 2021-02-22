CREATE OR ALTER PROCEDURE Zagros.CalTotalAmount
    @SomeOrderID  INT,
    @Total        MONEY OUTPUT
AS
/***************************************************************************************************
File: AddOrder.sql
----------------------------------------------------------------------------------------------------
Procedure:      Zagros.CalTotalAmount
Create Date:    2021-03-01 (yyyy-mm-dd)
Author:         Surush Cyrus
Description:    Calculates Total Amount for an Order 
Call by:        Zagros.UpdateOrder, TBD

Steps:          1- Create a table varaiable from Zagros.Orderdetail for needed OrderId
                2- Calcuates the output variable @TotalAmount 
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

        @RowsToProcess  INT,
        @CurrentRow     INT,

        @OrderID        INT,
        @UnitPrice      MONEY,
        @Quantity       TINYINT,

        @TotalAmount      MONEY,
        @TotalTotalAmount MONEY;

DECLARE @Orderdetail TABLE (
    RowID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    OrderID INT NOT NULL,
    UnitPrice MONEY NOT NULL,
    Quantity TINYINT NOT NULL);

BEGIN TRY;
SET @RowsToProcess = 0;
SET @CurrentRow = 0;
SET @TotalAmount = 0;
SET @TotalTotalAmount = 0;
SET @OrderID = 0;
SET @ErrorText = 'Unexpected ERROR in setting the variables!';
SET @UnitPrice = 0;
SET @Quantity = 0;
SET @ErrorText = 'Unexpected ERROR in setting the variables!';

SET @SP = OBJECT_NAME(@@PROCID);
SET @StartTime = GETDATE();

SET @Message = 'Started SP ' + @SP + ' at ' + FORMAT(@StartTime , 'MM/dd/yyyy HH:mm:ss');   
RAISERROR (@Message, 0,1) WITH NOWAIT;
EXEC Zagros.InsertHistory @SP = @SP,
   @Status = 'Start',
   @Message = @Message;

   -------------------------------------------------------------------------------
SET @ErrorText = 'Failed INSERT from CustomerOrder table.';

INSERT INTO @Orderdetail
    (OrderID, UnitPrice, Quantity)
SELECT OrderID, UnitPrice, Quantity
FROM Zagros.Orderdetail
WHERE OrderID = @SomeOrderID
SET @RowsToProcess=@@ROWCOUNT

IF @RowsToProcess = 0
BEGIN
    SET @ErrorText = 'Zagros.Orderdetail table is Empty! Rasing Error!';
    RAISERROR(@ErrorText, 16,1);
END;
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
SET @ErrorText = 'Failed SELECT from @Orderdetail table.';

-- https://stackoverflow.com/questions/1578198/can-i-loop-through-a-table-variable-in-t-sql
SET @CurrentRow = 0
WHILE @CurrentRow < @RowsToProcess
BEGIN
    SET @CurrentRow = @CurrentRow + 1

    SELECT @OrderID = OrderID,
        @UnitPrice = UnitPrice,
        @Quantity = Quantity
    FROM @Orderdetail
    WHERE RowID=@CurrentRow;

    SET @ErrorText = 'Failed check for variable @TotalAmount!';
    SET @TotalAmount =  (@Quantity * @UnitPrice);
    IF @TotalAmount <= 0
    BEGIN
        SET @ErrorText = 'TotalAmout = ' + CONVERT(VARCHAR(10), @TotalAmount) + ' This value is not acceptable. Rasing Error!';
        RAISERROR(@ErrorText, 16,1);
    END;

    SET @TotalTotalAmount = @TotalTotalAmount + @TotalAmount;
END

SET @Total =  @TotalTotalAmount;

SET @Message = '@Total = ' + CONVERT(VARCHAR(10), @Total) + ' calculated from @Orderdetail.';
RAISERROR (@Message, 0,1) WITH NOWAIT;
EXEC Zagros.InsertHistory @SP = @SP,
                        @Status = 'Run',
                        @Message = @Message;


SET @Message = 'Completed SP ' + @SP + '. Duration in minutes:  '    
      + CONVERT(VARCHAR(12), CONVERT(DECIMAL(6,2),datediff(mi, @StartTime, getdate())));    
RAISERROR (@Message, 0,1) WITH NOWAIT;    
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

