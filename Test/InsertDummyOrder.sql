TRUNCATE TABLE Zagros.CustomerOrder;
GO

INSERT INTO Zagros.CustomerOrder
    (Email, LocationID, PackageID, UnitPrice, Quantity, Note)
VALUES
    ('100000001@xyz.com', 01, 01, 500, 1, 'Test Note'),
    ('100000001@xyz.com', 02, 02, 600, 2, 'Test Note'),
    ('100000001@xyz.com', 03, 01, 620, 1, 'Test Note'),
    ('100000001@xyz.com', 04, 03, 320, 3, 'Test Note')
GO

EXEC Zagros.AddOrder;
GO


INSERT INTO Zagros.CustomerOrder
    (Email, LocationID, PackageID, UnitPrice, Quantity, Note)
VALUES
    ('100000002@xyz.com', 01, 01, 500, 1, 'Test Note'),
    ('100000002@xyz.com', 02, 02, 600, 2, 'Test Note')

EXEC Zagros.AddOrder;
GO

INSERT INTO Zagros.CustomerOrder
    (Email, LocationID, PackageID, UnitPrice, Quantity, Note)
VALUES
    ('100000003@xyz.com', 03, 03, 500, 1, 'Test Note'),
    ('100000003@xyz.com', 02, 02, 600, 2, 'Test Note')

EXEC Zagros.AddOrder;
GO

INSERT INTO Zagros.CustomerOrder
    (Email, LocationID, PackageID, UnitPrice, Quantity, Note)
VALUES
    ('100000004@xyz.com', 04, 03, 500, 1, 'Test Note'),
    ('100000004@xyz.com', 03, 02, 600, 2, 'Test Note')

EXEC Zagros.AddOrder;
GO


