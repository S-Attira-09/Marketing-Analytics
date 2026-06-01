select * from dbo.customer_journey


With DuplicateRecords as (
     Select
	     JourneyID,
		 CustomerID,
		 ProductID,
		 VisitDate,
		 Stage,
		 Action,
		 Duration,
		 ROW_NUMBER() over(
		    PARTITION by CustomerID,ProductID, VisitDate,Stage, Action 
			ORDER by JourneyID
			) As Row_numb
	From 
	    dbo.customer_journey
)
Select * 
from DuplicateRecords
 Where Row_numb>1 
 Order by JourneyID

 --Remove Duplicates and Clean data 

 Select
     JourneyID,
	 CustomerID,
	 ProductID,
	 VisitDate,
	 Stage,
	 Action,
	 COALESCE( Duration, avg_duration) as Duration
From
    (
	   Select
	        JourneyID,
	        CustomerID,
	        ProductID,
	        VisitDate,
	        Upper(Stage) as STAGE,
	        Action,
			Duration,
			avg(Duration) OVER (PARTITION BY VisitDate) as avg_duration,
			ROW_NUMBER() OVER (
			    PARTITION BY CustomerID, ProductID,  VisitDate, Upper(Stage), Action
				ORDER BY JourneyID
			) as row_num
		From
		     dbo.customer_journey
      ) As Sub_que

Where
     row_num = 1;