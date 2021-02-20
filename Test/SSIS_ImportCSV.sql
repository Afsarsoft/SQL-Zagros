EXEC Zagros.DropFKs;
GO
TRUNCATE TABLE Zagros.Country;
GO
TRUNCATE TABLE Zagros.Customer;
GO
TRUNCATE TABLE Zagros.CustomerOrder;
GO
TRUNCATE TABLE Zagros.Location;
GO
TRUNCATE TABLE Zagros.OrderStatus;
GO
TRUNCATE TABLE Zagros.Package;
GO

EXEC Zagros.CreateFKs;
GO



