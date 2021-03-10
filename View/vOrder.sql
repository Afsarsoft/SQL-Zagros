CREATE OR ALTER VIEW Zagros.vOrder
AS
    SELECT OD.OrderID, OD.LocationID, OD.PackageID, O.CustomerID, O.OrderStatusID, O.OrderDate, O.FinalDate, OD.UnitPrice, OD.Quantity
    FROM Zagros.OrderDetail OD
        INNER JOIN Zagros.[Order] O
        ON OD.OrderID = O.OrderID

