CREATE OR ALTER VIEW Zagros.vCustomer
AS
    SELECT C.CustomerID, C.Email, C.FirstName, C.LastName, CO.Name AS Country
    FROM Zagros.Customer C
        INNER JOIN Zagros.Country CO
        ON C.CountryID = CO.CountryID;

