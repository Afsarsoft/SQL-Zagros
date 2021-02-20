DECLARE @Message VARCHAR(255)

IF EXISTS(SELECT 1
FROM dbo.SSISDemo01)
BEGIN
    TRUNCATE TABLE dbo.SSISDemo01;
    SET @Message = 'Completed TRUNCATE to table SSISDemo01.';
    RAISERROR(@Message, 0,1) WITH NOWAIT;
END
ELSE
BEGIN
    SET @Message = 'Skipping TRUNCATE, no rows in table SSISDemo01.';
    RAISERROR(@Message, 0,1) WITH NOWAIT;
END;
