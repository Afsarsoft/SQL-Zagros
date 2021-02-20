DECLARE @Message VARCHAR(255)

IF EXISTS(SELECT 1
FROM dbo.SSISDemo01)
BEGIN
    SET @Message = 'Skipping INSERT, table SSISDemo01 is already populated.';
    RAISERROR(@Message, 0,1) WITH NOWAIT;
END
ELSE
BEGIN
    INSERT INTO dbo.SSISDemo01
        (SSISDemo01ID, Name)
    VALUES
        (1, 'Test 1'),
        (2, 'Test 2')

    SET @Message = CONVERT(VARCHAR(10), @@ROWCOUNT) + ' rows effected. Completed INSERT to table SSISDemo01';
    RAISERROR (@Message, 0,1) WITH NOWAIT;
END;


