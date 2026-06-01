select * from dbo.products
--Query to categorise products based on their price

SELECT 
    ProductID,
    ProductName,
    Price,
    CASE 
        WHEN Price < 50 THEN 'Low'
        WHEN Price BETWEEN 50 AND 200 THEN 'Medium'
        ELSE 'High'
    END AS Price_Category
FROM dbo.products;
