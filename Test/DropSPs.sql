/***************************************************************************************************
File: DropSPs.sql
----------------------------------------------------------------------------------------------------
Create Date:    2020-09-01 (yyyy-mm-dd)
Author:         Surush Cyrus
Description:    Call SP Zagros.DropSPs to drop the all SPs as needed for cleanups.
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
        @StartTime DATETIME

BEGIN TRY;   
SET @ErrorText = 'Unexpected ERROR in setting the variables!';

SET @StartTime = GETDATE();
SET @Message = 'Started at ' + FORMAT(@StartTime , 'MM/dd/yyyy HH:mm:ss');   

-------------------------------------------------------------------------------
SET @ErrorText = 'Failed Calling SP DropSPs!';

EXEC Zagros.DropSPs;

SET @Message = 'Completed SP DropSPs';   
RAISERROR(@Message, 0,1) WITH NOWAIT;
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
SET @Message = 'Completed, duration in minutes:  '   
   + CONVERT(VARCHAR(12), CONVERT(DECIMAL(6,2),datediff(mi, @StartTime, getdate())));    

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

   RAISERROR(@ErrorText,18,127) WITH NOWAIT;      
END CATCH;      
