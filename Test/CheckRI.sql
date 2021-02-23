SELECT distinct CountryID
FROM Zagros.Customer

SELECT distinct CountryID
FROM Zagros.Country

SELECT *
FROM Zagros.Customer
WHERE CountryID
NOT IN (SELECT CountryID
FROM Zagros.Country);


