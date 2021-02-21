DECLARE @TotalAmount MONEY,
        @Message     VARCHAR(255);

SET @TotalAmount = 0;
SET @Message = '';

EXEC Zagros.CalTotalAmount @SomeOrderID = 100000002, @Total =  @TotalAmount OUTPUT;

SET @Message = '@TotalAmount = ' + CONVERT(VARCHAR(10), @TotalAmount) + ' is the return value from SP Zagros.CalTotalAmount.';
RAISERROR (@Message, 0,1) WITH NOWAIT;


SELECT *
FROM Zagros.History
ORDER BY RowID DESC;

SELECT *
FROM Zagros.[Order];

SELECT *
FROM Zagros.OrderDetail;

DELETE FROM Zagros.[Order];

DELETE FROM Zagros.OrderDetail;
