select * from dbo.engagement_data


select
    EngagementID,
    ContentID,
	CampaignID,
	ProductID,
	UPPER(REPLACE(ContentType, 'Socialmedia', 'Social Media')) as ContentType,
	LEFT(ViewsClicksCombined, CHARINDEX('-', ViewsClicksCombined)-1) as Views,
	RIGHT(ViewsClicksCombined, Len(ViewsClicksCombined) - CHARINDEX('-', ViewsClicksCombined)) as Clicks,
	Likes,

	--Convert the Engagement Date to the dd.mm.yy format
	FORMAT(CONVERT(DATE, EngagementDate), 'dd.MM.yyyy') as EngagementDate

From dbo.engagement_data
where 
    ContentType != 'Newsletter';


   