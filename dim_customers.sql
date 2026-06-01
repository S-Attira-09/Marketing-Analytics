select * from dbo.customers

select * from dbo.geography

SELECT
    c.CustomerID,
    c.CustomerName,
    c.Email,
    c.Gender,
    c.Age,
    g.Country,
    g.City
FROM dbo.customers AS c
LEFT JOIN dbo.geography AS g
    ON c.GeographyID = g.GeographyID;


--Write a SQL query to find the total number of customers in each country
--and display the country name along with the customer count in descending order.
SELECT 
    g.Country,
    COUNT(c.CustomerID) AS Customers
FROM dbo.customers AS c
LEFT JOIN dbo.geography AS g
    ON c.GeographyID = g.GeographyID
GROUP BY g.Country
ORDER BY Customers DESC;

--Write a SQL query to list the top 5 cities with the highest number of customers, including the city name and total customers.
SELECT Top 5
    g.City,
    COUNT(c.CustomerID) AS Customers
FROM dbo.customers AS c
LEFT JOIN dbo.geography AS g
    ON c.GeographyID = g.GeographyID
GROUP BY g.City
ORDER BY Customers DESC;