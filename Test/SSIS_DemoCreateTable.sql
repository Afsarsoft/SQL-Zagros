DECLARE @Message VARCHAR(255)

IF EXISTS (SELECT *
FROM sys.objects
WHERE object_id = OBJECT_ID(N'dbo.SSISDemo01') AND type in (N'U'))
BEGIN
    SET @Message = 'Table dbo.SSISDemo01 already exist, skipping....';
    RAISERROR(@Message, 0,1) WITH NOWAIT;
END
ELSE
BEGIN
    CREATE TABLE dbo.SSISDemo01
    (
        SSISDemo01ID TINYINT NOT NULL,
        Name NVARCHAR(50) NOT NULL,
        CONSTRAINT PK_SSISDemo01_SSISDemo01ID PRIMARY KEY CLUSTERED (SSISDemo01ID),
        CONSTRAINT UK_SSISDemo01_Name UNIQUE (Name)
    )
    SET @Message = 'Completed CREATE TABLE dbo.SSISDemo01.';
    RAISERROR(@Message, 0,1) WITH NOWAIT;
END