		SELECT WorkerID, MokedName, A.*
		FROM (
		       SELECT logid 
			  ,split 
			  ,SUM(ISNULL(i_stafftime,0)) AS 'שעות לוגין'
	  		  ,SUM(ISNULL(acdcalls,0)) AS 'שיחות נענות'
			  ,SUM(ISNULL(acdtime,0)) acdtime
			  ,SUM(ISNULL(holdtime,0)) holdtime
			   FROM [RepGateDB].[CmsBTL].[hagent] HA
			   WHERE row_date between '2022-07-01' and '2022-07-03'
			   GROUP BY split, logid ) A
	    INNER JOIN (
		       SELECT *
			   FROM fn_GenericAgentsList('2022-07-03','2022-07-01')
			   WHERE MokedID in (3882,389)   
		) GAL ON A.logid = GAL.LoginID