select * from dbo.customer_reviews

Select
    ReviewID,
	CustomerID,
	ProductID,
	ReviewDate,
	Rating,
	Replace(ReviewText,'  ', ' ') as ReviewText
from dbo.customer_reviews;