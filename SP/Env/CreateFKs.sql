IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'Zagros'
  AND SPECIFIC_NAME = N'CreateFKs'
  AND ROUTINE_TYPE = N'PROCEDURE'
)
DROP PROCEDURE Zagros.CreateFKs
GO
CREATE PROCEDURE Zagros.CreateFKs
AS
/***************************************************************************************************
File: CreateFKs.sql
----------------------------------------------------------------------------------------------------
Procedure:      Zagros.CreateFKs
Create Date:    2020-09-01 (yyyy-mm-dd)
Author:         Surush Cyrus
Description:    Creates FKs for all needed Zagros tables  
Call by:        TBD, UI, Add hoc
Steps:          NA
Parameter(s):   None
Usage:          EXEC Zagros.CreateFKs
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

SET @SP = OBJECT_NAME(@@PROCID)
SET @StartTime = GETDATE();
   
SET @Message = 'Started SP ' + @SP + ' at ' + FORMAT(@StartTime , 'MM/dd/yyyy HH:mm:ss');   
RAISERROR (@Message, 0,1) WITH NOWAIT;
EXEC Zagros.InsertHistory @SP = @SP,
    @Status = 'Start',
    @Message = @Message;

-------------------------------------------------------------------------------
SET @ErrorText = 'Failed adding FOREIGN KEY for Table Zagros.Customer.';

IF EXISTS (SELECT *
FROM sys.foreign_keys
WHERE object_id = OBJECT_ID(N'Zagros.FK_Customer_Country_CountryID')
  AND parent_object_id = OBJECT_ID(N'Zagros.Customer')
)
BEGIN
  SET @Message = 'FOREIGN KEY for Table Zagros.Customer already exist, skipping....';
  RAISERROR(@Message, 0,1) WITH NOWAIT;
  EXEC Zagros.InsertHistory @SP = @SP,
        @Status = 'Run',
        @Message = @Message;
END
ELSE
BEGIN
  ALTER TABLE Zagros.Customer
   ADD CONSTRAINT FK_Customer_Country_CountryID FOREIGN KEY (CountryID)
      REFERENCES Zagros.Country (CountryID);

  SET @Message = 'Completed adding FOREIGN KEY for TABLE Zagros.Customer.';
  RAISERROR(@Message, 0,1) WITH NOWAIT;
  EXEC Zagros.InsertHistory @SP = @SP,
   @Status = 'Run',
   @Message = @Message;
END
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
SET @ErrorText = 'Failed adding FOREIGN KEY for Table Zagros.Order.';

IF EXISTS (SELECT *
FROM sys.foreign_keys
WHERE object_id = OBJECT_ID(N'Zagros.FK_Order_Customer_CustomerID')
  AND parent_object_id = OBJECT_ID(N'Zagros.Order')
)
BEGIN
  SET @Message = 'FOREIGN KEY for Table Zagros.Order already exist, skipping....';
  RAISERROR(@Message, 0,1) WITH NOWAIT;
  EXEC Zagros.InsertHistory @SP = @SP,
   @Status = 'Run',
   @Message = @Message;
END
ELSE
BEGIN
  ALTER TABLE Zagros.[Order]
   ADD CONSTRAINT FK_Order_Customer_CustomerID FOREIGN KEY (CustomerID)
      REFERENCES Zagros.Customer (CustomerID),
    CONSTRAINT FK_Order_OrderStatus_OrderStatusID FOREIGN KEY (OrderStatusID)
      REFERENCES Zagros.OrderStatus (OrderStatusID);

  SET @Message = 'Completed adding FOREIGN KEY for TABLE Zagros.Order.';
  RAISERROR(@Message, 0,1) WITH NOWAIT;
  EXEC Zagros.InsertHistory @SP = @SP,
   @Status = 'Run',
   @Message = @Message;
END
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
SET @ErrorText = 'Failed adding FOREIGN KEY for Table Zagros.OrderDetail.';

IF EXISTS (SELECT *
FROM sys.foreign_keys
WHERE object_id = OBJECT_ID(N'Zagros.FK_OrderDetail_Order_OrderID')
  AND parent_object_id = OBJECT_ID(N'Zagros.OrderDetail')
)
BEGIN
  SET @Message = 'FOREIGN KEY for Table Zagros.OrderDetail already exist, skipping....';
  RAISERROR(@Message, 0,1) WITH NOWAIT;
  EXEC Zagros.InsertHistory @SP = @SP,
   @Status = 'Run',
   @Message = @Message;
END
ELSE
BEGIN
  ALTER TABLE Zagros.OrderDetail
   ADD CONSTRAINT FK_OrderDetail_Order_OrderID FOREIGN KEY (OrderID)
      REFERENCES Zagros.[Order] (OrderID),
    CONSTRAINT FK_OrderDetail_Location_LocationID FOREIGN KEY (LocationID)
      REFERENCES Zagros.Location (LocationID),
    CONSTRAINT FK_OrderDetail_Package_PackageID FOREIGN KEY (PackageID)
      REFERENCES Zagros.Package (PackageID);

  SET @Message = 'Completed adding FOREIGN KEY for TABLE Zagros.OrderDetail.';
  RAISERROR(@Message, 0,1) WITH NOWAIT;
  EXEC Zagros.InsertHistory @SP = @SP,
   @Status = 'Run',
   @Message = @Message;
END
-------------------------------------------------------------------------------

SET @Message = 'Completed SP ' + @SP + '. Duration in minutes:  '   
   + CONVERT(VARCHAR(12), CONVERT(DECIMAL(6,2),datediff(mi, @StartTime, getdate())));    
RAISERROR(@Message, 0,1) WITH NOWAIT;
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

