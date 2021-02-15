CREATE OR ALTER PROCEDURE Zagros.CreateTables
AS
/***************************************************************************************************
File: CreateTables.sql
----------------------------------------------------------------------------------------------------
Procedure:      Zagros.CreateTables
Create Date:    2020-09-01 (yyyy-mm-dd)
Author:         Surush Cyrus
Description:    Creates all needed Zagros tables  
Call by:        TBD, UI, Add hoc
Steps:          NA
Parameter(s):   None
Usage:          EXEC Zagros.CreateTables
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
SET @ErrorText = 'Failed CREATE Table Zagros.Customer.';

IF EXISTS (SELECT *
FROM sys.objects
WHERE object_id = OBJECT_ID(N'Zagros.Customer') AND type in (N'U'))
BEGIN
    SET @Message = 'Table Zagros.Customer already exist, skipping....';
    RAISERROR(@Message, 0,1) WITH NOWAIT;
    EXEC Zagros.InsertHistory @SP = @SP,
        @Status = 'Run',
        @Message = @Message;
END
ELSE
BEGIN
    CREATE TABLE Zagros.Customer
    (
        CustomerID INT NOT NULL,
        CountryID TINYINT NOT NULL,
        Email NVARCHAR(50) NOT NULL,
        FirstName NVARCHAR(50) NOT NULL,
        LastName NVARCHAR(50) NOT NULL,
        ID NVARCHAR(20) NOT NULL,
        Tel1 NVARCHAR(20) NULL,
        Tel2 NVARCHAR(20) NULL,
        Website NVARCHAR(50) NULL,
        Address NVARCHAR(250) NULL,
        Note NVARCHAR(250) NULL,
        CONSTRAINT PK_Customer_CustomerID PRIMARY KEY CLUSTERED (CustomerID),
        CONSTRAINT UK_Customer_Email UNIQUE (Email)
    );

    SET @Message = 'Completed CREATE TABLE Zagros.Customer.';
    RAISERROR(@Message, 0,1) WITH NOWAIT;
    EXEC Zagros.InsertHistory @SP = @SP,
        @Status = 'Run',
        @Message = @Message
END
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
SET @ErrorText = 'Failed CREATE Table Zagros.Country.';

IF EXISTS (SELECT *
FROM sys.objects
WHERE object_id = OBJECT_ID(N'Zagros.Country') AND type in (N'U'))
BEGIN
    SET @Message = 'Table Zagros.Country already exist, skipping....';
    RAISERROR(@Message, 0,1) WITH NOWAIT;
    EXEC Zagros.InsertHistory @SP = @SP,
        @Status = 'Run',
        @Message = @Message;
END
ELSE
BEGIN
    CREATE TABLE Zagros.Country
    (
        CountryID TINYINT NOT NULL,
        Name NVARCHAR(50) NOT NULL,
        CONSTRAINT PK_CustomerCountry_CountryID PRIMARY KEY CLUSTERED (CountryID),
        CONSTRAINT UK_CustomerCountry_Name UNIQUE (Name)
    )
    SET @Message = 'Completed CREATE TABLE Zagros.Country.';
    RAISERROR(@Message, 0,1) WITH NOWAIT;
    EXEC Zagros.InsertHistory @SP = @SP,
        @Status = 'Run',
        @Message = @Message
END
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
SET @ErrorText = 'Failed CREATE Table Zagros.Order.';

IF EXISTS (SELECT *
FROM sys.objects
WHERE object_id = OBJECT_ID(N'Zagros.Order') AND type in (N'U'))
BEGIN
    SET @Message = 'Table Zagros.Order already exist, skipping....';
    RAISERROR(@Message, 0,1) WITH NOWAIT;
    EXEC Zagros.InsertHistory @SP = @SP,
        @Status = 'Run',
        @Message = @Message;
END
ELSE
BEGIN
    CREATE TABLE Zagros.[Order]
    (
        OrderID INT NOT NULL,
        CustomerID INT NOT NULL,
        OrderStatusID TINYINT NOT NULL,
        OrderDate DATETIME NOT NULL,
        FinalDate DATETIME NULL,
        TotalAmount MONEY NOT NULL,
        Note NVARCHAR(250) NULL,
        CONSTRAINT PK_Order_OrderID PRIMARY KEY CLUSTERED (OrderID),
        CONSTRAINT CK_Order_TotalAmount CHECK (TotalAmount >= 0)
    )
    SET @Message = 'Completed CREATE TABLE Zagros.Order.';
    RAISERROR(@Message, 0,1) WITH NOWAIT;
    EXEC Zagros.InsertHistory @SP = @SP,
        @Status = 'Run',
        @Message = @Message
END
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
SET @ErrorText = 'Failed CREATE Table Zagros.OrderDetail.';

IF EXISTS (SELECT *
FROM sys.objects
WHERE object_id = OBJECT_ID(N'Zagros.OrderDetail') AND type in (N'U'))
BEGIN
    SET @Message = 'Table Zagros.OrderDetail already exist, skipping....';
    RAISERROR(@Message, 0,1) WITH NOWAIT;
    EXEC Zagros.InsertHistory @SP = @SP,
        @Status = 'Run',
        @Message = @Message;
END
ELSE
BEGIN
    CREATE TABLE Zagros.OrderDetail
    (
        OrderID INT NOT NULL,
        LocationID TINYINT NOT NULL,
        PackageID TINYINT NOT NULL,
        UnitPrice MONEY NOT NULL,
        Quantity TINYINT NOT NULL,
        Note NVARCHAR(250) NULL,
        CONSTRAINT PK_OrderDetail_OrderIDLocationIDPackageID PRIMARY KEY CLUSTERED (OrderID, LocationID, PackageID),
        CONSTRAINT CK_OrderDetail_UnitPrice CHECK (UnitPrice >= 0),
        CONSTRAINT CK_OrderDetail_Quantity CHECK (Quantity >= 0)
    )
    SET @Message = 'Completed CREATE TABLE Zagros.OrderDetail.';
    RAISERROR(@Message, 0,1) WITH NOWAIT;
    EXEC Zagros.InsertHistory @SP = @SP,
   @Status = 'Run',
   @Message = @Message
END
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
SET @ErrorText = 'Failed CREATE Table Zagros.Package.';

IF EXISTS (SELECT *
FROM sys.objects
WHERE object_id = OBJECT_ID(N'Zagros.Package') AND type in (N'U'))
BEGIN
    SET @Message = 'Table Zagros.Package already exist, skipping....';
    RAISERROR(@Message, 0,1) WITH NOWAIT;
    EXEC Zagros.InsertHistory @SP = @SP,
        @Status = 'Run',
        @Message = @Message;
END
ELSE
BEGIN
    CREATE TABLE Zagros.Package
    (
        PackageID TINYINT NOT NULL,
        Name NVARCHAR(100) NOT NULL,
        UnitPrice MONEY NOT NULL,
        Note VARCHAR(250) NULL,
        CONSTRAINT PK_Package_PackageID PRIMARY KEY CLUSTERED (PackageID),
        CONSTRAINT UK_Package_Name UNIQUE (Name),
        CONSTRAINT CK_Package_UnitPrice CHECK (UnitPrice >= 0)
    )
    SET @Message = 'Completed CREATE TABLE Zagros.Package.';
    RAISERROR(@Message, 0,1) WITH NOWAIT;
    EXEC Zagros.InsertHistory @SP = @SP,
        @Status = 'Run',
        @Message = @Message
END
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
SET @ErrorText = 'Failed CREATE Table Zagros.OrderStatus.';

IF EXISTS (SELECT *
FROM sys.objects
WHERE object_id = OBJECT_ID(N'Zagros.OrderStatus') AND type in (N'U'))
BEGIN
    SET @Message = 'Table Zagros.OrderStatus already exist, skipping....';
    RAISERROR(@Message, 0,1) WITH NOWAIT;
    EXEC Zagros.InsertHistory @SP = @SP,
        @Status = 'Run',
        @Message = @Message;
END
ELSE
BEGIN
    CREATE TABLE Zagros.OrderStatus
    (
        OrderStatusID TINYINT NOT NULL,
        Name NVARCHAR(50) NOT NULL,
        CONSTRAINT PK_OrderStatus_OrderStatusID PRIMARY KEY CLUSTERED (OrderStatusID),
        CONSTRAINT UK_OrderStatus_Name UNIQUE (Name)
    )
    SET @Message = 'Completed CREATE TABLE Zagros.OrderStatus.';
    RAISERROR(@Message, 0,1) WITH NOWAIT;
    EXEC Zagros.InsertHistory @SP = @SP,
        @Status = 'Run',
        @Message = @Message
END
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
SET @ErrorText = 'Failed CREATE Table Zagros.Location.';

IF EXISTS (SELECT *
FROM sys.objects
WHERE object_id = OBJECT_ID(N'Zagros.Location') AND type in (N'U'))
BEGIN
    SET @Message = 'Table Zagros.Location already exist, skipping....';
    RAISERROR(@Message, 0,1) WITH NOWAIT;
    EXEC Zagros.InsertHistory @SP = @SP,
        @Status = 'Run',
        @Message = @Message;
END
ELSE
BEGIN
    CREATE TABLE Zagros.Location
    (
        LocationID TINYINT NOT NULL,
        Name NVARCHAR(50) NOT NULL,
        CONSTRAINT PK_Location_LocationID PRIMARY KEY CLUSTERED (LocationID),
        CONSTRAINT UK_Location_Name UNIQUE (Name)
    )
    SET @Message = 'Completed CREATE TABLE Zagros.Location.';
    RAISERROR(@Message, 0,1) WITH NOWAIT;
    EXEC Zagros.InsertHistory @SP = @SP,
        @Status = 'Run',
        @Message = @Message
END
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
SET @ErrorText = 'Failed CREATE Table Zagros.CustomerOrder.';

IF EXISTS (SELECT *
FROM sys.objects
WHERE object_id = OBJECT_ID(N'Zagros.CustomerOrder') AND type in (N'U'))
BEGIN
    SET @Message = 'Table Zagros.CustomerOrder already exist, skipping....';
    RAISERROR(@Message, 0,1) WITH NOWAIT;
    EXEC Zagros.InsertHistory @SP = @SP,
        @Status = 'Run',
        @Message = @Message;
END
ELSE
BEGIN
    CREATE TABLE Zagros.CustomerOrder
    (
        Email NVARCHAR(50) NOT NULL,
        LocationID TINYINT NOT NULL,
        PackageID TINYINT NOT NULL,
        UnitPrice MONEY NOT NULL,
        Quantity TINYINT NOT NULL,
        Note NVARCHAR(250) NULL
    )
    SET @Message = 'Completed CREATE TABLE Zagros.CustomerOrder.';
    RAISERROR(@Message, 0,1) WITH NOWAIT;
    EXEC Zagros.InsertHistory @SP = @SP,
        @Status = 'Run',
        @Message = @Message
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

