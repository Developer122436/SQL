            WITH cte as   
            (   
               select CAST(  '2022-06-08'   AS DATE) as n   
               union all   
               select dateadd(DAY,-1,n) from cte where dateadd(dd,-1,n)> DATEADD(MONTH, DATEDIFF(MONTH, 0,   '2022-06-01'  )-1, 0)   
            )   
             SELECT CAST(n AS DATE) AS 'תאריך'      
             ,split AS 'מספר סקיל'
             ,SkillNameHeb AS 'שם סקיל'
			 ,SkillGroup 
			,ISNULL(SUM(i_stafftime),0) AS 'i_stafftime' 
            FROM (   
                 SELECT *    
                  FROM cte   
                  WHERE CAST(n AS DATE) BETWEEN   '2022-06-01'    AND   '2022-06-08'  ) AllDates   
            LEFT JOIN [RepGateDB].[CmsBTL].[hsplit] HSP ON CAST(HSP.row_date AS DATE) = CAST(AllDates.n AS DATE)
			INNER JOIN CmsBTL.Skills SK ON HSP.split = SK.Skill
            GROUP BY CAST(AllDates.n AS DATE), split, SkillNameHeb, SkillGroup  
            ORDER BY CAST(AllDates.n AS DATE) 