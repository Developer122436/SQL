            DECLARE @sDate AS DATE
	    DECLARE @eDate AS DATE
	    DECLARE @Moked AS VARCHAR(10)

	    SET @sDate = '2022-05-01'
	    SET @eDate = '2022-05-30'
	    SET @Moked = 'מושלם באר שבע'

            -- Show all dates from the first day on a month until the yesterday day of the month
	    WITH cte as   
            (   
               select CAST(@eDate  AS DATE) as n   
               union all   
               select dateadd(DAY,-1,n) from cte where dateadd(dd,-1,n)> DATEADD(MONTH, DATEDIFF(MONTH, 0,  @sDate )-1, 0)   
            )   
			
	    -- Creates a training hours of the relevent call center of the dates that was choosen
            SELECT CAST(n AS DATE) AS 'תאריך'   
            , ISNULL(SUM(ROUND(CAST(DATEDIFF(SECOND, TAL.login, TAL.logout) AS Float)/3600,2)),0) AS 'שעות הדרכה'   
            FROM (   
                 SELECT *    
                  FROM cte   
                  WHERE CAST(n AS DATE) BETWEEN @sDate AND @eDate) AllDates   
            LEFT JOIN ( SELECT *   
                       FROM [dbo].[TrainingAgentsLogin]   
                       WHERE ProjectX = @Moked ) TAL ON CAST(TAL.DateX AS DATE) = CAST(AllDates.n AS DATE)   
            GROUP BY CAST(AllDates.n AS DATE)   
            ORDER BY CAST(AllDates.n AS DATE) 
